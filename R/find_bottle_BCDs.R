# Computes pairwise Bray-Curtis dissimilarities across different biological
# replicates (but not among PCRs from the same bottle). Returns a vector of
# those values and a histogram.
#
# Helen Casendino, Joe Duprey, Kai Vennemann
#
# Args:
#   df: A data frame with columns for bio, tech, hash, prop, and seq_run.
###########################################################################

find_bottle_BCDs <- function(df) {
  # Find a length for bcds that is certain to contain all calculated values. We
  # do this by finding the maximum number of replicates from any individual site.
  temp <- df %>%
    dplyr::select(site, bio, tech) %>%
    group_by(site) %>%
    unique() %>% # Get rid of duplicate rows bc we don't care about the number of hashes
    mutate(n = n()) # Number of replicates for that site
  
  max_replicates <- max(temp$n)
  
  # Nest data by site
  nested_df <- cvt_to_PCR_props(df) %>%
    dplyr::select(site, bio, tech, hash, prop) %>%
    unite(bio, tech, col = "bio.PCR", sep = ".") %>% # Combine to get A.1, A.2, etc.
    arrange(site, bio.PCR, hash) %>%
    nest(data = c(bio.PCR, hash, prop))
  
  for (i in 1:length(nested_df$data)) {
    nested_df$data[[i]] <- nested_df$data[[i]] %>%
      pivot_wider(names_from = bio.PCR, values_from = prop, values_fill = 0)
  }
  
  # Notes:
  # a) max_replicates ^ 2 is the max size of any BCD matrix generated from a
  # single site
  # b) We multiply by 0.5 bc at least half the values from each dis_mat matrix
  # will be removed (to eliminate duplicates and intra-bottle comparisons)
  bcds_upper_bound <- ceiling((max_replicates^2) * 0.5 * length(nested_df$site))
  bcds <- rep(NA, bcds_upper_bound)
  i <- 1
  
  for (j in 1:length(nested_df$site)) {
    event <- nested_df$data[[j]] # A data frame corresponding to one sampling event
    sub_tib <- event %>% dplyr::select(!c(hash))
    flip_tib <- t(sub_tib)
    dis <- vegdist(flip_tib)
    dis_mat <- as.matrix(dis)
    
    # Removes all cells corresponding to BCDs within the same bottle by using
    # row and column names. Also removes all the duplicates below the diagonal.
    for (col_num in 1:ncol(dis_mat)) {
      # Extracting the first letter (A, B, C, etc) from the column's name
      col_letter <- substr(colnames(dis_mat)[col_num], 1, 1)
      for (row_num in 1:nrow(dis_mat)) {
        # Extracting the first letter (A, B, C, etc) from the row's name
        row_letter <- substr(rownames(dis_mat)[row_num], 1, 1)
        if (!col_letter > row_letter) {
          dis_mat[row_num, col_num] <- NA
        }
      }
    }
    
    bcd_vector <- na.omit(as.vector(dis_mat)) # All BCDs for that sampling event as vector
    len <- length(bcd_vector)
    if (len > 0) {
      bcds[i:(i + len - 1)] <- bcd_vector # Add the BCD values to our long vector
      i <- i + len # Update index
    }
  }
  
  bcds <- as.numeric(na.omit(bcds))
  
  # Sanity check
  print("Bray-Curtis Dissimilarities:")
  print(bcds)
  print(paste("Mean BCD value:", mean(bcds), sep = " "))
  
  # Plot
  his <- hist(
    as.numeric(bcds[-1]),
    col = viridis::viridis(3, 0.4, 0.7),
    main = "Bottle Variation",
    xlab = "Bray-Curtis Pairwise Distances"
  )
  
  return(list(bcds, his))
}