#!/bin/bash

# name variables: directory with fastq files, and the file name to store the read counts
fastq_dir=~/Documents/EGC-Salish-Sea/data/raw/run2/
fastq_counts=readcounts.txt

# get a list of the fastq.gz files in the given directory
cd "$fastq_dir"
FILES=$(ls *.fastq.gz)

# count the number of lines in each fastq file and divide by 4, to get read counts.
echo "${fastq_dir}${fastq_counts}"
for F in $FILES; do 
	LINES=$(cat $F|wc -l)
	echo $F "," $(( $LINES / 4 ))
	echo $F "," $(( $LINES / 4 )) >> "${fastq_dir}${fastq_counts}"
done 