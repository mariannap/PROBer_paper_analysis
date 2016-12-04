#### Ding *et al.* arabidopsis single-end data

Data locate at `AssmannLab`. Each run is explained in the table below.

Run | Meaning
--- | -------
SRR933551 | Biological replicate I, mock-treated
SRR933552 | Biological replicate I, modification-treated
SRR933556 | Biological replicate II, modification-treated
SRR933557 | Biological replicate II, mock-treated

Data were pre-processed according to Ding *et al.* as follows:

1. The first 3 bases of each read were removed, as they are part of the ssDNA linker.

2. The adapter sequence was stripped from the 3' end of each read using `cutadapt` (v1.10). Reads that are shorter than 21 nucleotides (nt) were discarded. The `cutadapt` options we used are:

    ```
    -u 3 -a GATCGGAAGAGCACACGTCTGAACTCCAGTCAC -m 21
    ```

#### Talkish *et al.* yeast single-end data

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

#### Hector *et al.* yeast paired-end data

Data locate at `GrannemanLab`. Each run is explained in the table below.

Run | Meaning
--- | -------
SRR1041324 | Control_averages_1
SRR1041325 | Control_averages_2
SRR1041326 | Control_averages_3
SRR1041327 | DMS_averages_1
SRR1041328 | DMS_averages_2
SRR1041329 | DMS_averages_3

Data were pre-processed according to Hector *et al.* as follows:

1. The 1st nucleotides at first mates were trimmed and unique molecule identifiers (UMIs) were integrated. Note that the reads stored in SRA missing the random barcode information. This information is added back according to `GrannemanLab_info.zip`.

2. Adapters were trimmed using `cutadapt` only reads no shorter than 18 nt were kept. See `rule trim_adapter_GrannemanLab` for `cutadapt` options.

3. PCR duplicates were removed according to the 7nt UMIs and sequence contents. Two paired-end reads are considered duplicate to each other if and only if their UMIs are identical, their sequences have the same length, and their sequences are matched (i.e. mismatch rate <= 0.1). To speed up the duplication removal process, we further request the 25nt snippets in their two mates are identical. See script `remove_PCR_dup_PE` for details.

#### Spitale *et al.* mouse single-end data

Data locate at `ChangLab`. Each run is explained in the table below.

Run | Meaning
--- | -------
SRR1534953 | v6.5 mouse ES cells polyA(+) icSHAPE DMSO Biological Replicate 2
SRR1534955 | v6.5 mouse ES cells polyA(+) icSHAPE in vitro NAI-N3 Biological Replicate 2
SRR1534957 | v6.5 mouse ES cells polyA(+) icSHAPE in vivo NAI-N3 Biological Replicate 2

Data were pre-processed as follows:

1. 3' adapters were trimmed using `cutadapt` and only reads no shorter than 33 nt were kept:

    ```
    -a AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG -m 33
    ```

2. PCR duplicates were removed according to the 13 nt UMIs and sequence contents. Only reads with the exact same sequences and UMIs were considered as duplicates.

#### Poulsen *et al.* E. coli paired-end data

Data locate at `VintherLab`. Each run is explained in the table below.

Run | Meaning
--- | -------
E.coli_DMSO_no-sel_R1 | Mate 1, SHAPE-Seq control
E.coli_DMSO_no-sel_R2 | Mate 2, SHAPE-Seq control
E.coli_NPIA_no-sel_R1 | Mate 1, SHAPE-Seq treatment
E.coli_NPIA_no-sel_R2 | Mate 2, SHAPE-Seq treatment
E.coli_NPIA_sel_R1 | Mate1, SHAPES
E.coli_NPIA_sel_R2 | Mate2, SHAPES

The above data were downloaded from [here](http://people.binf.ku.dk/~jvinther/data/SHAPES-Seq/). These data were pre-processed as follows:

1. 3' adapters were trimmed using `cutadapt` and only reads no shorter than 15 nt were kept:

    ```
    -q 17 -m 15 -a AGATCGGAAGAGCACACGTCT -A AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT
    ```

2. 5'-end untemplated nucleotides were trimmed.

#### Carlile *et al.* yeast single-end Pseudo-seq data

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

#### Zarnack *et al.* human hnRNP C iCLIP single-end data

Data locate at `UleLab`. Biological replicate 1 (ERR196175, ERR196174, ERR196187, and ERR196179) of hnRNP C iCLIP data was used.

Data were pre-processed as follows:

1. 3' adapters were trimmed using `cutadapt` and only reads no shorter than 27 nt were kept:

    ```
    -a AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG -m 27
    ```

2. PCR duplicates were removed according to the 9nt UMIs and sequence contents. Only reads with the exact same sequences and UMIs were considered as duplicates.
 
#### Nostrand *et al.* human RBFOX2 iCLIP single-end data

Data locate at `YeoLab/iCLIP`. Only one run (SRR3147675) of the RBFOX2 iCLIP data was used. 

Data were pre-processed as follows:

1. 3' adapters were trimmed using `cutadapt` and only reads no shorter than 27 nt were kept:

    ```
    -a AGATCGGAAGAGCGGTTCAGCAGGAATGCCGAGACCGATCTCGTATGCCGTCTTCTGCTTG -m 27
    ```

2. PCR duplicates were removed according to the 9nt UMIs and sequence contents. Only reads with the exact same sequences and UMIs were considered as duplicates.

#### Nostrand *et al.* human eCLIP paired-end data

Data locate at `YeoLab/eCLIP`. Each run is explained in the table below.

Run | Meaning
--- | -------
SRR3147598 | RBFOX2 293T rep1
SRR3147599 | RBFOX2 293T rep1
SRR3147600 | RBFOX2 293T rep1 input
ENCFF734UEC | ENCODE TARDBP K562 rep1 mate1  
ENCFF147JYD | ENCODE TARDBP K562 rep1 mate2
ENCFF558NTZ | ENCODE TARDBP K562 input mate1
ENCFF333DTJ | ENCODE TARDBP K562 input mate2
ENCFF956TOZ | ENCODE PUM2 K562 rep1 mate1
ENCFF133DNM | ENCODE PUM2 K562 rep1 mate2
ENCFF616FCF | ENCODE PUM2 K562 input mate1
ENCFF495ZPY | ENCODE PUM2 K562 input mate2
ENCFF917GQR | ENCODE TRA2A K562 rep1 mate1
ENCFF116QDH | ENCODE TRA2A K562 rep1 mate2
ENCFF057LEI | ENCODE TRA2A K562 input mate1
ENCFF169EQC | ENCODE TRA2A K562 input mate2


