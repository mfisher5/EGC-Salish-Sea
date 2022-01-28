# Computes pairwise BCDs among technical replicates from each biological sample.
#
# Helen Casendino, Joe Duprey, Kai Vennemann
# edited 2022-01-28 MCF
#
# Returns a vector of those values and a histogram.
# Args:
#   df: A data frame with columns for bio, tech, hash, prop, and seq_run.
#   seq_runs: A vector containing the numbers of the seq runs to be analyzed.
#
##################################################################################

find_PCR_BCDs <- function(df, seq_runs = unique(df$seq_run)) { # Includes all seq runs by default
  
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
  
  df %<>% dplyr::select(bottle, tech, hash, prop)
  
  bottles <- unique(df$bottle)
  bcds_upper_bound <- choose(max(df$tech), 2) * length(bottles)
  bcds <- rep(NA, bcds_upper_bound) # Vector to store BCDs
  i <- 1
  
  # empty dataframe to store metadata associated with bcds -- added 2022-01-28 MCF
  pairwise_comparisons_df <- data.frame(site=as.character(),
                                        bio=as.character(),
                                        bcd=as.numeric())
  
  
  # Iterate over each bottle and calculate BCDs among PCRs
  for (b in bottles) {
    # Data wrangling in preparation for the vegdist function
    bottle_data <- df %>%
      filter(bottle == b) %>%
      pivot_wider(names_from = tech, values_from = prop, values_fill = 0) %>%
      dplyr::select(matches("\\d{1, }")) # Columns that have numbers as names (i.e., represent PCRs)
    flipped_bottle_data <- t(bottle_data)
    num_PCR_pairs <- choose(nrow(flipped_bottle_data), 2)
    dis <- vegdist(flipped_bottle_data)
    bcds[i:(i + num_PCR_pairs - 1)] <- as.vector(dis)
    i <- i + num_PCR_pairs
    
    # Save into data frame  -- added 2022-01-28 MCF
    tmpdat <- filter(df.names, bottle==b) %>%
      uncount(num_PCR_pairs) %>%
      mutate(bcd=as.vector(dis)) %>%
      dplyr::select(site,bio,bcd)
    pairwise_comparisons_df %<>% bind_rows(tmpdat)
  }
  
  bcds <- as.numeric(na.omit(bcds))
  
  # Sanity check
  print("Bray-Curtis Dissimilarities:")
  print(bcds)
  print(paste("Mean BCD value:", mean(bcds), sep = " "))
  
  # Plot
  plotdat <- data.frame(x=bcds)
  his <- ggplot(data=plotdat, aes(x=x)) +
    geom_histogram(binwidth=0.2, boundary=-0.2) +
    scale_x_continuous(breaks=seq(-0.2,1.2,by=0.2)) +
    labs(x="Pairwise Bray-Curtis Dissimilarities", y="tech pairs", main="PCR Variation") +
    theme_bw()
  
  return(list(bcds, his, pairwise_comparisons_df))
}
