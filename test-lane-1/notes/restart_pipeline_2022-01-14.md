## Processing Pipeline for Lane 1 

#### Cutadapt
Re-ran cutadapt 7:09PM following the bash code at the end of `1.cutadapt.wrapper.lane1.Rmd`.

The only weird result is the Leray Kangaroo (+ control), which had the following output in the cutadapt log:

=== Summary ===

Total read pairs processed:          2,039,343<br>
  Read 1 with adapter:                 240,013 (11.8%)<br>
  Read 2 with adapter:                 320,658 (15.7%)<br>
Pairs that were too short:              31,206 (1.5%)<br>
Pairs written (passing filters):       154,067 (7.6%)<br>

#### DADA2

BF3/BR2: Jan 17-18

Lerays: Jan 21

#### Blast

Ryan ran the BF3 blast scripts for me on Jan 18


#### Troubleshooting with Eily, 2022-01-25

There are a number of hashes (or `qseqids`) in the BF3/BR2 ASV table which don't match to any of the processed blast results. For example: 

			> Hash: 6866b5f282b550432acb9cf521a44c8c66bb8db4

			> Sequence: TTTGAACAACTTGTCATACTGGATGTATGTTGCGGGTTCTTCGCTGGCTGTTCTTTCGCTCTTTGTGCCTGGTGGTGATAACCAGTTTGGTGCGGGAGTGGGCTGGGTGCTTTATGCGCCNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNTTGCTTTCATTGCCAGTTTTGGCCGGCGCGATCACGATGCTTTTGACTGACCGTAATTTTGGCACAGCGTTTTTCCAAGCGAGTGAGGGCGGCGATCCGTTGCTTTATCAACACTTGTTG

Samples 75,76,77 (WASS_2020_234a/b/c) have 211, 206, and 379 reads of this sequence. A quick search of the raw blast results in notepad++ shows that this hash is just entirely missing from the blast output. 

So I did an online blast search of the (1) full sequence, and (2) first 120bp. Both times, I received the error *"No significant similarity found"*. 
<br>


Another example: 

			> Hash: 71ba7919c0d97428f6555ad4e5a1c16f2724be7d
			> Sequence: GATGAATAATATTTCATTTTGGTTGTTGCCCGCTTCTTTCATTTTGTTGGTTATGTCTCTATTTCAAGGGCCTGAGGGCGCAAAGGGTGTTGGCGCTGGTTGGACGGTCTATGCACCGCTNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNCTCTTGTCATTGCCGGTTTTGGCTGGTGCGATCACTATGTTGCTAACGGATCGTAATTTTGGTACCTCATTCTTTAGTGCTGAAGGGGGCGGGGACCCGCTTTTATATCAACATTTGTTT

Samples 40,41,78,79 (WASS_2018_070a/b, WASS_2020_334b/c) have 12, 122, 2392, and 8148 reads of this sequence. Again, missing from the raw blast results and an online search returns the error *"No significant similarity found"*.


Some additional asks from Eily: 
- code to compare replicates
- other QC code?
- code to calculate eDNA Index




