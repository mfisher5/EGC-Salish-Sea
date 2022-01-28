###### convert reads into proportions, by PCR replicate
#
# Helen Casendino, Joe Duprey, Kai Vennemann
#
#######################################################

cvt_to_PCR_props <- function(df) {
  PCR_props <- df %>%
    group_by(site, bio, tech) %>%
    mutate(prop = reads / sum(reads)) %>%
    ungroup() %>%
    dplyr::select(-(reads))
  return(PCR_props)
}