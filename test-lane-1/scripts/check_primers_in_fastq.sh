#!/bin/bash


FILE_LIST=("data/raw/lane_1/BF3_WACO_2021_003a_S16_L001_R1_001.fastq")

SUB="@M00"
SEQS=("")

for file in ${FILE_LIST}
do
	echo ${file} >> test-lane-1/data/cutadapt/first15inFASTQ.txt
	cat ${file} | while read LINE; 
	do
		if echo "${LINE}" |  grep -q "$SUB"; then
			do_read=1
			else	
				if (( $do_read == 1 )); then
					echo "${LINE}" |  cut -c-15 >> test-lane-1/data/cutadapt/first15inFASTQ.txt
					do_read=0
				fi
		fi
	done
	
done


#		if echo "${LINE}" |  grep -q "$SUB"; then
#			let do_read=1
#		else
#			if (( $do_read == 1 ))
#			then
#				echo "${LINE}" | cut -c-15  >> data/cutadapt/first15inFASTQ.txt
#				let do_read=0
#			fi   # if (( $do_read == 1 ))
#		fi       # if (($f=="@"))
#	done         # while read line
#done             # for file in FILE_LIST