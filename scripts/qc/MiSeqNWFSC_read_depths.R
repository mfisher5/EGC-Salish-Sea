##################### Read Depths from MiSeq Output #####################
#
# 2022-9-21 Mary Fisher
#
# Description: Graph the distribution of read depths from MiSeq sequencing output.
#     To get read depths from fastq.gz files, use the script 00_get_fastq_read_depth.sh
#
#########################################################################



# Set up ------------------------------------------------------------------
library(here)
library(tidyverse)
library(readr)
library(magrittr)
library(ggplot2)


# Lane 1 ------------------------------------------------------------------

##--- read in data
dat <- read_delim(here::here("data","raw","run2","readcounts.txt"), delim=" , ", col_names=FALSE)
colnames(dat) <- c("sample_id","nreads")

dat %<>% mutate(sample_id=str_remove(sample_id,"_001.fastq.gz")) %>%
  separate(col=sample_id,into=c("sample_id","direction"),remove=TRUE, sep="_L001_")

##--- histogram of all read depths. mark minimum desirable (70,000)
fig1a <- ggplot(dat, aes(x=nreads, fill=direction),alpha=0.7) +
  geom_histogram() +
  scale_fill_manual(values=c("dodgerblue4","lightblue3")) +
  labs(x="Reads per Sample", y="No. Samples",
       title="MiSeq Lane 2") +
  theme_classic() + theme(axis.text.x=element_text(size=12),
                          axis.title=element_text(size=14),
                          title=element_text(size=16))
fig1a
png(here::here("data","raw","qc","Lane-2-read-depth-directional.png"))
fig1a
dev.off()

dat_totals <- dat %>% group_by(sample_id) %>% summarise(total_reads=sum(nreads))
fig1c <- ggplot(dat_totals, aes(x=total_reads/10000),alpha=0.7) +
  geom_histogram() +
  labs(x="Reads per Sample (x10K)", y="No. Samples",
       title="MiSeq Lane 2") +
  theme_classic() + theme(axis.text.x=element_text(size=12),
                          axis.title=element_text(size=14),
                          title=element_text(size=16))
fig1c
png(here::here("data","raw","qc","Lane-2-read-depth.png"))
fig1c
dev.off()


##--- boxplot of read depths by sample group. mark minimum desirable (70,000)
### categorize samples by project / control type using the sample IDs
dat_expand <- dat %>% separate(col=sample_id, into=c("year","sample","replicate_seqid"), sep="-", remove=FALSE) %>%
  # clean up control sample identifiers, which don't have a year
  mutate(sample=ifelse(grepl("Control",year), year,sample)) %>%
  mutate(replicate_seqid=ifelse(grepl("Control",year), year,replicate_seqid)) %>%
  mutate(year=ifelse(grepl("Control",sample),"Control",year)) %>%
  # identify vial samples
  mutate(year=ifelse(grepl("V",sample),paste(year,"-vial"),year))

dat_expand$year <- factor(dat_expand$year, 
                    levels=c("SS20","SS19","SS18","SS18 -vial","Control"))

### plot
fig1b <- ggplot(dat_expand, aes(x=year, y=nreads, fill=year)) +
  geom_boxplot(alpha=0.8) +
  geom_hline(aes(yintercept=35), lty=2, col="grey45") +
  geom_point(aes(fill=year), alpha=0.4) +
  facet_grid(cols=vars(direction)) +
  labs(y="Reads per Sample", x="Sample Year",
       title="MiSeq Lane 2 Samples") +
  theme_bw() + theme(axis.text.x=element_text(size=11),
                     axis.title=element_text(size=12),
                     strip.text=element_text(size=11),
                     title=element_text(size=14))
  
fig1b
png(here::here("data","raw","qc","Lane-2-read-depth-byYear.png"), width=800, height=600)
fig1b
dev.off()


##--- samples with read depths below 1,000

dat_lowRD <- dat_expand %>%
  filter(nreads < 1000) %>%
  arrange(year,nreads)

write.csv(dat_lowRD, here::here("data","raw","qc","EGC-Salish-Sea_Low-Read-Depths.csv"), row.names=FALSE)



