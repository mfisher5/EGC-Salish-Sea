#!/bin/bash

PATH=$PATH:/mnt/nfs/home/rpkelly/ncbi-blast-2.8.1+/bin
export BLASTDB="/mnt/nfs/home/rpkelly/blastdb"

BLAST_DB='/mnt/nfs/home/rpkelly/blastdb/nt'
# BLAST PARAMETERS
PERCENT_IDENTITY="85"
WORD_SIZE="30"
EVALUE="1e-30"
# number of matches recorded in the alignment:
MAXIMUM_MATCHES="50"
CULLING="5"

	################################################################################
	# BLAST CLUSTERS
	################################################################################
	echo $(date +%H:%M) "BLASTing..."

	blast_output="/mnt/nfs/home/rpkelly/processed/run2.COI.hashes.to.blast.txt" 
	blastn \
		-query "/mnt/nfs/home/rpkelly/raw/run2.COI.hashes.to.blast.fasta" \
		-db "${BLAST_DB}" \
		-num_threads 16 \
		-perc_identity "${PERCENT_IDENTITY}" \
		-word_size "${WORD_SIZE}" \
		-evalue "${EVALUE}" \
		-max_target_seqs "${MAXIMUM_MATCHES}" \
		-culling_limit="${CULLING}" \
		-outfmt "6 qseqid sseqid sacc pident length mismatch gapopen qcovus qstart qend sstart send evalue bitscore staxids qlen sscinames sseq" \
		-out "${blast_output}"


	echo $(date +%H:%M) "BLASTing second batch..."

	blast_output="/mnt/nfs/home/rpkelly/processed/run2.COI.hashes.to.blast2.txt" 
	blastn \
		-query "/mnt/nfs/home/rpkelly/raw/run2.COI.hashes.to.blast2.fasta" \
		-db "${BLAST_DB}" \
		-num_threads 16 \
		-perc_identity "${PERCENT_IDENTITY}" \
		-word_size "${WORD_SIZE}" \
		-evalue "${EVALUE}" \
		-max_target_seqs "${MAXIMUM_MATCHES}" \
		-culling_limit="${CULLING}" \
		-outfmt "6 qseqid sseqid sacc pident length mismatch gapopen qcovus qstart qend sstart send evalue bitscore staxids qlen sscinames sseq" \
		-out "${blast_output}"
