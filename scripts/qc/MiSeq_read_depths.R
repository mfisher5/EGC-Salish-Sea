##################### Read Depths from MiSeq Output #####################
#
# 2022-01-04 Mary Fisher
#
# Description: Graph the distribution of read depths from MiSeq sequencing output.
#
#########################################################################



# Set up ------------------------------------------------------------------
library(here)
library(tidyverse)
library(magrittr)
library(ggplot2)


# Lane 1 ------------------------------------------------------------------

##--- read in data
dat <- read.csv(here::here("data","raw","qc","EGC-Salish-Sea_Lane-1_MiSeq-Stats.csv"))

##--- histogram of all read depths. mark minimum desirable (70,000)
fig1a <- ggplot(dat, aes(x=total_reads_per_lane/10000)) +
  geom_histogram() +
  geom_vline(aes(xintercept=7), lty=2) +
  labs(x="Reads per Sample (x10K)", y="No. Samples",
       title="MiSeq Lane 1") +
  theme_classic() + theme(axis.text.x=element_text(size=12),
                          axis.title=element_text(size=14),
                          title=element_text(size=16))
fig1a
png(here::here("data","raw","qc","Lane-1-read-depth.png"))
fig1a
dev.off()


##--- boxplot of read depths by sample group. mark minimum desirable (70,000)
### categorize samples by project / control type using the sample IDs
dat %<>% separate(col=sample, into=c("primer","group","year","id1","id2"), sep="_", remove=FALSE) %>%
  # clean up MARPT sample identifiers, which don't have a year
  mutate(id1=ifelse(group=="MARPT",year,id1)) %>%
  mutate(year=ifelse(group=="MARPT",2021,year))

dat$group <- factor(dat$group, 
                    levels=c("WACO","WASS","MARPT","Kangaroo","PCRNegative","SpeedVacNegative","NA"))

### plot
fig1b <- ggplot(dat, aes(x=primer, y=total_reads_per_lane/1000, fill=year)) +
  geom_boxplot(alpha=0.8) +
  geom_hline(aes(yintercept=70), lty=2, col="grey45") +
  geom_point(aes(fill=year), alpha=0.4) +
  facet_wrap(~group, ncol=3) + 
  labs(y="Reads per Sample (x1K)", x="Primer",
       title="MiSeq Lane 1 Samples") +
  theme_bw() + theme(axis.text.x=element_text(size=11),
                     axis.title=element_text(size=12),
                     strip.text=element_text(size=11),
                     title=element_text(size=14))
  
fig1b
png(here::here("data","raw","qc","Lane-1-read-depth-bySample.png"))
fig1b
dev.off()


##--- samples with read depths below 70,000

dat_lowRD <- dat %>%
  filter(total_reads_per_lane < 70000) %>%
  arrange(total_reads_per_lane) %>%
  dplyr::select(lane, sample,primer,group,year,barcode,total_reads_per_lane)

write.csv(dat_lowRD, here::here("data","raw","qc","EGC-Salish-Sea_Low-Read-Depths.csv"), row.names=FALSE)



