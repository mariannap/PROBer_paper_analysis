#### Ding *et al.* arabidopsis data

Data locate at `AssmannLab`. Each run is explained in the table below.

Run | Meaning
--- | -------
SRR933551 | Biological replicate I, mock-treated
SRR933552 | Biological replicate I, modification-treated
SRR933556 | Biological replicate II, modification-treated
SRR933557 |  Biological replicate II, mock-treated

Data were pre-processed according to Ding *et al.* as follows:

1. The first 3 bases of each read were removed, as they are part of the ssDNA linker.

2. The adapter sequence was stripped from the 3' end of each read using `cutadapt` (v1.10). Reads that are shorter than 21 nucleotides (nt) were discarded. The `cutadapt` options we used are:

```
-u 3 -a GATCGGAAGAGCACACGTCTGAACTCCAGTCAC -m 21
```

The pre-processed data contain 117,242,295 and 81,596,350 single-end reads in modification-treated and mock-treated experiments respectively. The read length variates between 21 nt and 37 nt.

#### Talkish *et al.* yeast data

Data locate at `McmanusLab`. Each run is explained in the table below.

Run | Meaning
--- | -------
SRR955862 | Scer_WT_Rep1_NoDMS
SRR955864 | Scer_WT_Rep1_100mM_DMS
SRR955865 | Scer_WT_Rep2_NoDMS
SRR955871 | Scer_WT_Rep2_100mM_DMS

Data were pre-processed according to Talkish *et al.* as follows:

1. 3' prime adapters were trimmed using `cutadapt` and only reads no shorter than 25 nt were kept. The `cutadapt` options are:

    ``` 
    -a CTGTAGGCACCATCAAT -m 25
    ```

2. 5' prime adapters were trimmed and untrimmed reads were kept:

```
-g ^ATCGTAGGCACCTGAAA --untrimmed-output output_name
```

3. Untrimmed reads from previous step were aligned to the yeast transcript sequences using `Bowtie` (v1.1.2) and then mismatches at the 5' end were trimmed using in-house script.

The pre-processed data contain 7,729,251 and 9,199,721 single-end reads in modification-treated and mock-treated experiments respectively. The read length variates between 23 nt and 50 nt.


