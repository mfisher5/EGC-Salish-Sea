## Scripts for Test Sequencing Run (1)

**Workflow**

1. Create cutadapt script using the Rmd wrapper [1.cutadapt.wrapper.lane1](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/scripts/1.cutadapt.wrapper.lane1.Rmd), and then run cutadapt shell script [1_cutadapt_wrapper](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/scripts/1_cutadapt_wrapper.sh). *Based on [Kelly lab script](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/scripts/1.cutadapt.wrapper.EA.FOR.MARY.Rmd)*

2. Split sequencing runs by marker so dada2, in the next step, is only using one marker at a time. Using Rmd script [2.split.primers.lane1](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/scripts/2.split.primers.lane1.Rmd)

3. Run dada2 with [3.dada2.lane1](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/scripts/3.dada2.lane1.Rmd). *Based on [Kelly lab script](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/scripts/3.dada2.EA.FOR.MARY.Rmd)

4. Create a blast script using the Rmd wrapper [4.generate.blast.shell.lane1](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/scripts/4.generate.blast.shell.lane1.Rmd), then have Ryan run the [BF3](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/scripts/4_blast_BF3_2022-01-17.sh), [LerayXT](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/scripts/4_blast_LerayXT_2022-01-24.), and [Leray](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/scripts/4_blast_Leray_2022-01-24.sh) dada2 sequences through Blast using Hyak.

5. *empty space because I didn't use the insect classifier script*

6. Organize the Blast output with [6.parse.blast.results.Rmd](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/scripts/6.parse.blast.results.Rmd)

7. explore the Blast results and check out what prey showed up, possible contamination, etc.

8. Evaluate technical replicate variability with [8.technical.replicate.variability.Rmc](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/scripts/8.technical.replicate.variability.Rmd)


