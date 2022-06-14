# Computes pairwise BCDs among all replicates from all samples.
#
# 2022-03-30 MCF
# Based on code by Helen Casendino, Joe Duprey, Kai Vennemann
#
# Returns a vector of those values and a histogram.
# Args:
#   df: A data frame with each row / column a replicate pair
#
##################################################################################

find_pairwise_BCDs <- function(df, seq_runs = unique(df$seq_run)) { # Includes all seq runs by default
  
  #--added 2022-01-28 MCF--#
  checkdat <- df %>% group_by(bio) %>% summarise(nPCR=length(unique(tech)))
  if(any(checkdat$nPCR < 2)){
    removedat <- filter(checkdat,nPCR<2)
    message("removing the following sample(s) without PCR replicates: ", paste0(removedat$bio,collapse=","))
    df <- df %>% filter(!(bio %in% removedat$bio))
  } else{message("all biological replicates have at least two or more PCR replicates. data ready for processing.")}
  #----#
  
  df <- cvt_to_PCR_props(df) %>%
    filter(seq_run %in% seq_runs) %>%
    mutate(bottle = paste(site, bio, sep = ""))
  
  df.names <- df %>% dplyr::select(site,bio,bottle) %>% distinct()   # added 2022-01-28 MCF
  
  df %<>% dplyr::select(bio, tech, hash, prop)
  
  df.wide <- pivot_wider(df, names_from=hash, values_from=prop, values_fill=0)
  df.wide.vals <- df.wide %>% mutate(sample=paste0(bio,"_",tech)) %>%
    dplyr::select(-bio,-tech)
  df.wide.vals <- as.data.frame(df.wide.vals)
  rownames(df.wide.vals) <- df.wide.vals$sample
  df.wide.vals <- df.wide.vals[,-c(which(colnames(df.wide.vals)=="sample"))]
  
  bcdist <- vegdist(df.wide.vals, method="bray",diag=FALSE,upper=TRUE)
  
  bcdist.mat <- as.matrix(bcdist)
  
  
  # Plot
  plotdat <- as.data.frame(bcdist.mat) %>% 
    rownames_to_column("sample1") %>%
    pivot_longer(cols=c(2:(dim(bcdist.mat)[1]+1)),names_to="sample2",values_to="BrayCurtisDistance")
  his <- ggplot(data=plotdat, aes(x=BrayCurtisDistance)) +
    geom_histogram(binwidth=0.2, boundary=-0.2) +
    scale_x_continuous(breaks=seq(-0.2,1.2,by=0.2)) +
    labs(x="Pairwise Bray-Curtis Dissimilarities", y="# Pairs", main="PCR Variation") +
    theme_bw()
  
  return(list(bcdist.mat, his, df.wide.vals))
}
