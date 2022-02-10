## Test Sequencing Lane (L1)

I have separated the workflow for analyzing the test sequencing lane data because this lane was sequenced as PE150 instead of PE300; as a result, the target sequences are only partial sequences and there is a gap (13bp for Leray, 118bp for BF3) between the forward and reverse sequences. 

I'm going to try to make this work anyway, to see if I can still answer the following questions intended for the test lane:

1. Which of the three COI primers (BF3/BR2, Leray, LerayXT) should we use on the rest of the samples? 
2. Does our current method of dissection let us capture potential prey DNA (as opposed to just predator / gut bacteria)?
3. Did the WASS 2018 samples return usable data?
4. What are some of the common diet items in these samples? Do these diet items align with what the WSG Crab Team expected to see? If not, are these true signals or potential contamination?
<br>

***The contents of this document and folder are preliminary analyses only, and should not be used to identify green crab diet items***

<br>


### Workflow

**Step 1**: Process the forward and reverse sequences using the Kelly Lab pipeline:

- 1.cutadapt.wrapper
- 2.split.primers
- 3.dada2
<br>

From this step, there are three data sets for each primer: merged sequences (with gaps in the middle), forward sequences, and reverse sequences.

**Step 2:** Blast the ASV sequences

**Step 3:** Parse and clean up the Blast output 
<br>
<br>


### Which of the three COI primers (BF3/BR2, Leray, LerayXT) should we use on the rest of the samples? 

I broke this question down according to 4 metrics:

**1. How does primer affinity for green crab differ?**

All primers had a relatively strong affinity for green crab in the WASS samples, whereas there was much less green crab DNA from the WACO samples. Overall BF3/BR2 sequenced the greatest proportion of green crab DNA, followed by Leray, then LerayXT. 

![img-affinity](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/results/EGC_primer_affinity.png?raw=true)

<br>
De-noising the data (i.e., removing sequences that showed up in the controls) drastically lowered the proportion of green crab DNA in the data - particularly for Leray/LerayXT.

![img-affinity-denoised](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/results/EGC_primer_affinity_denoised.png?raw=true)
<br>

**2. Did primers pick up species of interest?**

Bivalves: BF3/BR2 picked up *Mya* (genus) and *Ruditapes* (genus); Leray picked up *Ruditapes philippinarum* and *Limecola*. However, all of these were a very small proportion of reads and showed up in only 1 or 2 technical replicates (not all 3; and samples were not consistent between primers). If this is a true pattern, it suggests that Manila clam / bivalve DNA is rare in the samples we sequenced. In cases of rare DNA, we can increase our observations of that DNA (and therefore increase confidence of it's presence / taxonomic assignment) by running fewer samples on a sequencing run. 

Eelgrass: None of the primer pairs picked up on Zostera spp. Using the program Geneious, I matched our primers to a reference genome for *Zostera marina*. From this matching exercise, I think it is unlikely we would pick up *Zostera marina* using Leray or LerayXT; there are too many mismatches between the (forward) primer sequences and the eelgrass sequence. BF3/BR2 only has one mismatch with the eelgrass sequence; but *Z. marina* DNA is in competition with invert DNA, which is what BF3/BR2 was designed to pick up. 

Dungeness crab: The WACO samples had a pretty high proportion of DNA identified as Dungeness crab! No Dungeness crab in the Salish Sea samples, but there was quite a bit of *Hemigrapsus oregonensis*.
<br>

**3. How much non-target DNA does each primer pick up?**

Bacterial DNA and amoeba DNA: While there was relatively low proportions of non-target DNA overall, BF3/BR2 tended to pick up the most by a mile. 

Algae, Diatoms, and Rotifers: 

<br>

**4. How did taxonomic specificity vary between primers?**

For this metric, I focused in on Arthropoda, Annelida, and Mollusca. BF3/BR2 tended to identify the highest proportion of unique sequences down to the species level, particularly in the WACO and WASS 2020 samples. However, BF3/BR2 did not do a great job picking up worm DNA. LerayXT was the second best, followed by Leray. This is not too unexpected -- BF3/BR2 targets a longer sequence, which leaves more room for the data to capture species-specific differences in DNA. 


![img-specificity](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/test-run-1/results/EGC_primer_specificity.png?raw=true)

<br>
<br>




### Does our current method of dissection let us capture potential prey DNA (as opposed to just predator / gut bacteria)?

Yes! See #2 above. 

BF3/BR2 common prey taxa: *Hemigrapsus oregonensis*, *Metacarcinus magister*, *Ampithoe lacertosa*; also found *Balanus spp*, the worm *Algaophenia tubulifera*, and the ostracod *Cyprideis torosa*... 

Leray common prey taxa: *Hemigrapsus oregonensis*, *Metacarcinus magister*, *Ampithoe lacertosa*; also found *Balanus spp*, the amphipod *Monocorophium acherusicum*, the worm *Rhynchospio arenincola*...
<br>
<br>


### Did the WASS 2018 samples return usable data?

Yes! They tended to have more non-target bacterial / amoeba DNA, but had an equivalent proportion of sequences able to be assigned taxonomic information. They also didn't have quite as much green crab DNA (proportionally) as the WASS 2020 samples. And the proportion of DNA sequences that were able to be resolved down to the species level was equivalent to, or higher than, the WASS 2020 samples.

The read depth (number of DNA sequences per sample) were a little lower for these samples than the others, across all primers. I will compare protocols with Zach, who worked with museum specimens in ethanol. 

![img-read-depth](https://github.com/mfisher5/EGC-Salish-Sea/blob/master/data/raw/qc/run-1-EGC-read-depth-by-primer.png?raw=true)
<br>
<br>

### What are some of the common diet items in these samples? Do these diet items align with what the WSG Crab Team expected to see?

There weren't any fish in this data set, which isn't unexpected for these primers. BF3/BR2 did pick up fish, down to genus, in the Cordone et al. (2021) data set - but at a very low frequency. We can explore fish presence / absence by using the *MiFish* primer on a few samples. 

There is some terrestrial insect DNA. I think it's worth waiting for future runs to determine if this is a true signal, or possible contamination from the SEFS lab (although it is not present in the controls).


