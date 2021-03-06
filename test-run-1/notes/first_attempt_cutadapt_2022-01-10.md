## Check read drop-out in Lane 1 FastQ files

After running cutadapt (script 1), I get a huge drop-out of reads, particularly from the BF3 and Leray primer sets. For a lot of my samples, this leaves me with <10 read depth. I've shown this at the end of the [2.lane1.html file](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-lane-1/scripts/2.split.primers.lane1.html), section "Check cutadapt output".

Looking back into the cutadapt log file, these are either dur to filtering for minimum length (esp. Leray), and some are because the "Read 1 with adapter" is super low (esp. BF3). I have summarized this in the excel file *first_try_misnamed_samples.xlsx*.


## BF3 Sample comparison 

PrimerF: CCHGAYATRGCHTTYCCHCG

PrimerR: TCDGGRTGNCCRAARAAYCA


### WACO_2021_001a (Sample #10)

=== Summary ===

Total read pairs processed:              8,570<br>
  Read 1 with adapter:                   8,535 (99.6%)<br>
  Read 2 with adapter:                   8,498 (99.2%)<br>
Pairs that were too short:                   1 (0.0%)<br>
Pairs written (passing filters):         8,467 (98.8%)

Total basepairs processed:     2,588,140 bp<br>
  Read 1:     1,294,070 bp<br>
  Read 2:     1,294,070 bp<br>
Total written (filtered):      2,219,013 bp (85.7%)<br>
  Read 1:     1,109,437 bp<br>
  Read 2:     1,109,576 bp
  
  
  
=== Start of sequences in raw R1 FastQ file ===

Out of 2636 sequences, there were 141 unique combinations and 2496 duplicates.
The most common were:

- CCTGATATGGCTTTT --121
- CCTGATATAGCTTTT --96
- CCAGATATGGCTTTT --82
- CCTGACATGGCTTTT --81

<br>
<br>

### WACO_2021_003a (Sample #16)

PrimerF: CCHGAYATRGCHTTYCCHCG

PrimerR: TCDGGRTGNCCRAARAAYCA

=== Summary ===

Total read pairs processed:             57,462<br>
  Read 1 with adapter:                       4 (0.0%)<br>
  Read 2 with adapter:                  56,810 (98.9%)<br>
Pairs that were too short:                   1 (0.0%)<br>
Pairs written (passing filters):             3 (0.0%)<br>

Total basepairs processed:    17,353,524 bp<br>
  Read 1:     8,676,762 bp<br>
  Read 2:     8,676,762 bp<br>
Total written (filtered):            804 bp (0.0%)<br>
  Read 1:           429 bp<br>
  Read 2:           375 bp<br>

  
  
=== Start of sequences in raw R1 FastQ file ===

Out of 1194 sequences, there were 79 unique combinations and 1115 duplicates.
The most common were:

- GGTACTGGTTGGACT --38
- GTACTAGTTGGACT --34
- GGTACAAGTTGAACT --33
- GGAACTGGTTGGACT --32
- GGTACTGGTTGAACT --31
- GGTACAGGTTGAACT --30
- GGAACTGGTTGAACT --30

Weirdly, that looks pretty similar to the Leray forward primer sequence...
*Leray PrimerF: GGWACWGGWTGAACWGTWTAYCCYCC*

## Leray Sample comparison

PrimerF: GGWACWGGWTGAACWGTWTAYCCYCC

PrimerR: TANACYTCNGGRTGNCCRAARAAYCA

### MARPT_01a (Sample 59)

This sample had more reads with primer 1 than the BF3 sample above, but still a low percentage. 

=== Summary ===

Total read pairs processed:             63,031<br>
  Read 1 with adapter:                  19,179 (30.4%)<br>
  Read 2 with adapter:                  62,336 (98.9%)<br>
Pairs that were too short:               3,447 (5.5%)<br>
Pairs written (passing filters):        15,560 (24.7%)<br>

Total basepairs processed:    19,035,362 bp<br>
  Read 1:     9,517,681 bp<br>
  Read 2:     9,517,681 bp<br>
Total written (filtered):      4,342,122 bp (22.8%)<br>
  Read 1:     2,302,815 bp<br>
  Read 2:     2,039,307 bp<br>

=== Start of sequences in raw R1 FastQ file ===

Out of 11270 sequences, there were 102 unique combinations and 1168 duplicates.
The most common were:
- CCTGATATAGCTTTT --51
- CCTGATATGGCTTTT --44
- CCTGATATGGCATTT --37
- CCTGATATAGCATTT --37
- CCAGATATGGCTTTT --37
- CCCGATATGGCTTTT --35
- CCTGACATAGCTTTT --35
- CCTGACATGGCTTTT --32

The second most common sequence here is the most common for BF3_WACO_001a, and the most common here is the second most common for BF3_WACO_001a. 


### Solution

... is very simple. I didn't correctly copy over the sample-index pairs from my lab notebook to the library submission spreadsheet. The BF3 samples are actually Leray samples, and vice versa. 

The target sequence for the BF3/BR2 primer pair includes the Leray / LerayXT forward primer sequence, while the reverse primers for both are in the same location on the Folmer fragment. This means that if a BF3 sample was marked as Leray, `cutadapt` would identify the forward primer but the read would be shorter than the actual target sequence ("Pairs that were too short" would be high). Whereas if a Leray sample was marked as BF3, `cutadapt` would be unable to find the forward primer ("Read 1 with adapter" would be low).

The only sample-index mismatch I can't find evidence of in my lab notebook is the WACO.2021.003 sequenced with BF3, and WACO.2021.001 sequenced with LerayXT. However, these were in the same column for the index PCR reaction, so I guess it's possible that I switched them while setting up the plate. I'll just flag them during downstream analysis. 

I've renamed the files appropriately, using [rename-demultiplexed-fastqs.sh](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-lane-1/scripts/rename-demultiplexed-fastqs.sh).

Completed on 2022-01-12.


![img-primers-in-folmer-region](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/doc/imgs/Elbrecht-Leese-2017_Fig2_primer-binding-sites-relative-to-COI-Folmer-region.png?raw=true)

