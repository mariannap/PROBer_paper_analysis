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

1. 3' adapters were trimmed using `cutadapt` and only reads no shorter than 25 nt were kept. The `cutadapt` options are:

    ``` 
    -a CTGTAGGCACCATCAAT -m 25
    ```

2. 5' adapters were trimmed and untrimmed reads were kept:

    ```
    -g ^ATCGTAGGCACCTGAAA --untrimmed-output output_name
    ```

3. Untrimmed reads from previous step were aligned to the yeast transcript sequences using `Bowtie` (v1.1.2) and then mismatches at the 5' end were trimmed using in-house script.

The pre-processed data contain 7,729,251 and 9,199,721 single-end reads in modification-treated and mock-treated experiments respectively. The read length variates between 23 nt and 50 nt.

#### Spitale *et al.* mouse data

Data locate at `ChangLab`. Each run is explained in the table below.

Run | Meaning
--- | -------
SRR1534953 | v6.5 mouse ES cells polyA(+) icSHAPE DMSO Biological Replicate 2
SRR1534955 | v6.5 mouse ES cells polyA(+) icSHAPE in vitro NAI-N3 Biological Replicate 2
SRR1534957 | v6.5 mouse ES cells polyA(+) icSHAPE in vivo NAI-N3 Biological Replicate 2

Data were pre-processed as follows:

1. The first 100 million reads of each conditions (DMSO, *in vitro*, and *in vivo*) were extracted.

2. 3' adapters were trimmed using `cutadapt` and only reads no shorter than 33 nt were kept:

    ```
    -a AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG -m 33
    ```

3. PCR duplicates were removed and then the unique molecule identifiers (UMI, first 13 nt of each read) were also trimmed. Only reads with the exact same sequences and UMIs were considered as duplicates.

The pre-preprocessed data contain 96,120,565 , 23,455,089 , and 78,180,398 single-end reads in DMSO, *in vitro* and *in vivo* conditions respectively. The read length variates between 20 nt and 87 nt. 

#### Carlile *et al.* yeast Pseudo-seq data

Data locate at `GilbertLab`. Each run is explained in the table below.

Run | Meaning
--- | -------
SRR1327186 | -CMC 115-130nt short RT fragments
SRR1327187 | -CMC 115-130nt long RT fragments
SRR1327188 | 0.2M CMC 115-130nt short RT fragments
SRR1327189 | 0.2M CMC 115-130nt long RT fragments

Data were pre-processed as follows:

3' adapters were trimmed using `cutadapt` and only reads no shorter than 18 nt were kept:

   ```
   -a TGGAATTCTCGGGTGCCAAGG -m 18
   ```

The pre-processed data contain 31,103,632 and 39,167,224 single-end reads in modification-treated and mock-treated experiments respectively. The read length variates between 18 nt and 41 nt. 

#### Nostrand *et al.* human iCLIP data

Data locate at `YeoLab`. Only one run (SRR3147675) of RBFOX2 iCLIP data was used. 

Data were pre-processed as follows:

1. 3' adapters were trimmed using `cutadapt` and only reads no shorter than 27 nt were kept:

    ```
    -a AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG -m 27
    ```

2. PCR duplicates were removed and then UMIs (first 9 nt of each reads) were trimmed. Only reads with the exact same sequences and UMIs were considered as duplicates.

The pre-processed data contain 18,724,388 single-end reads. The read length variates between 18 nt and 49 nt.

