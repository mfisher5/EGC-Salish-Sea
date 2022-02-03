## Blast ASV sequences

### Install blast

### Get blast database

The Kelly lab appears to use the preformatted 'nt' or nucleotide database. To download a preformatted NCBI BLAST database, run the update_blastdb.pl program followed by any relevant options and the name(s) of the BLAST databases to download. For example:

```
$ update_blastdb.pl --decompress nt
```

This command will download the compressed nr BLAST database from NCBI to the current working directory and decompress it. Any subsequent identical invocations of this script with the same parameters in that directory will only download any data if it has a different time stamp when compared to the data at NCBI.


### 

