#!/usr/bin/env bash
PATH=$PATH:/mnt/c/Users/mfisher5/Documents/sci_programs/ncbi-blast-2.13.0+/bin
export BLASTDB="/mnt/c/Users/mfisher5/Documents/sci_programs/ncbi-blast-2.13.0+/blastdb"
BLAST_DB='/mnt/c/Users/mfisher5/Documents/sci_programs/ncbi-blast-2.13.0+/blastdb/nt'
blast_output='/mnt/c/Users/mfisher5/Documents/EGC-Willapa-Bay/data/blast/run_2/hash_key_blast_2022-06-20.fasta'
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
./blastn -query "/mnt/c/Users/mfisher5/Documents/EGC-Willapa-Bay/data/dada2/run_2/hash_key.fasta" -db "${BLAST_DB}" -num_threads 16 -perc_identity "${PERCENT_IDENTITY}" -word_size "${WORD_SIZE}" -evalue "${EVALUE}" -max_target_seqs "${MAXIMUM_MATCHES}" -culling_limit="${CULLING}" -outfmt "6 qseqid sseqid sacc pident length mismatch gapopen qcovus qstart qend sstart send evalue bitscore staxids qlen sscinames sseq" -out "${blast_output}"