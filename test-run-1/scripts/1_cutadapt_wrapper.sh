#!/bin/bash

MAIN_DIR="$(dirname "$0")"
pwd
#mkdir "${OUTPUT_DIR}"
cat ${1}

# set params
METADATA=($(awk -F',' -v COLNUM=2 \
  'NR>1 {  print $COLNUM }' ${1} \
   ))
MINLENGTH=($(awk -F',' -v COLNUM=4 \
  'NR>1 {  print $COLNUM }' ${1} \ 
  ))

#Capture one value of the params file
FASTQFOLDER=($(awk -F',' -v COLNUM=1 \
  'NR>1 {  print $COLNUM }' ${1} \
   ))
echo "fastq files will be read in from this folder:"
echo  "${FASTQFOLDER}"
echo "---"

OUTPUTFOLDER=($(awk -F',' -v COLNUM=3 \
  'NR>1 {  print $COLNUM }' ${1} \
   ))
echo "and trimmed fastq files will be saved into this folder:"
echo  "${OUTPUTFOLDER}"
echo "---"
echo "---"
echo "now running cutadapt script... output will be saved to a log file."


bash /c/Users/mcf05/Documents/PhD/DNA_Metabarcoding/GreenCrab/EGC-Salish-Sea/test-lane-1/scripts/1.run.cutadapt.sh "${FASTQFOLDER}" "${METADATA}" "${OUTPUTFOLDER}" "${MINLENGTH}" >> /c/Users/mcf05/Documents/PhD/DNA_Metabarcoding/GreenCrab/EGC-Salish-Sea/test-lane-1/data/cutadapt/log_20220114.txt