## Test Sequencing Lane (L1)

I have separated the workflow for analyzing the test sequencing lane data because this lane was sequenced as PE150 instead of PE300; as a result, the target sequences are only partial sequences and there is a gap (13bp for Leray, 118bp for BF3) between the forward and reverse sequences. 

I'm going to try to make this work anyway, to see if I can still answer the following questions intended for the test lane:

1. Do the primers have differential affinity for green crab, and if so, which has the lowest affinity for green crab?
2. Does our current method of dissection let us capture potential prey DNA (as opposed to just predator / gut bacteria)?
2. What are some of the common diet items in these samples? Do these diet items align with what the WSG Crab Team expected to see? If not, are these true signals or potential contamination?


### Workflow

**Step 1**: Process the forward and reverse sequences using the Kelly Lab pipeline:

- 1.cutadapt.wrapper
- 2.split.primers
- 3.dada2

**Step 2:** Blast the ASV sequences

**Step 3:** Match up the Blasted ASV sequences for the forward and reverse reads. Filter for those which match each other



