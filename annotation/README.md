Annotation
==========

### _Arabidopsis thaliana_ genome and GFF3 annotation

`TAIR10.zip` contains two files:
- `TAIR10_chr_all.fas`,  _Arabidopsis thaliana_ genome, is downloaded from [here](ftp://ftp.arabidopsis.org/home/tair/Genes/TAIR10_genome_release/TAIR10_chromosome_files/TAIR10_chr_all.fas).
- `TAIR10_GFF3_genes.gff`, the gene annotation, is downloaded from [here](ftp://ftp.arabidopsis.org/home/tair/Genes/TAIR10_genome_release/TAIR10_gff3/TAIR10_GFF3_genes.gff).

### 18S and 25S rRNAs structure 

`ground_truth.bpseq.zip` contains two files:
- `18S_rRNA.bpseq`, 18S rRNA's structure and sequence information, is downloaded from [here](http://www.rna.icmb.utexas.edu/RNA/Structures/d.16.e.A.thaliana.bpseq).
- `25S_rRNA.bpseq`, 25S rRNA's structure and sequence information, is downloaded from [here](http://www.rna.icmb.utexas.edu/RNA/Structures/d.23.e.A.thaliana.bpseq).

### SHAPE data used for digital spike-in experiments

`SHAPE_data.zip` contains four files:
- `RNaseP_WT.adducts`
- `pT181_long.adducts`
- `pT181_short.adducts`
- `SHAPE.t2g`
- `spikes_info.txt`
The first three files are experimentally measured SHAPE data for three short RNAs from [Lucks _et al._ PNAS2011](http://www.pnas.org/content/108/27/11063.long). We obtained them from [Sharon Aviran](http://bme.ucdavis.edu/aviranlab/). The next file defines the isoform - gene relationship. It says that pT181_long and pT181_short are isoforms of a same gene. The last file records each RNA's length.

### Text files

`remove_list.txt` contains four transcript ids:
- `AT2G01010.1`, one copy of 18S rRNA.
- `AT3G41768.1`, the other copy of 18S rRNA.
- `AT2G01020.1`, 5.8S rRNA, part of 25S rRNA.
- `AT2G01021.1`, unknown protien, part of 25S rRNA.

The above four transcripts will be removed from the reference since they are redundant. 

`rRNA_list.txt` contains transcript ids for all rRNAs contained in the resulting filtered reference.

### Scripts

`scripts` is a folder contains scripts required to generate a filtered _Arabidopsis thaliana_ transcript set. It contains the following scripts:

- `extractInfoFromBPSeq`, a python script to extract sequence and structure information from `*.bpseq` files.
- `convert`, a python script to replace chromosome names from '1' to 'Chr1' in the `TAIR10_chr_all.fas` file and write the results into the `TAIR10_chr_all.fa` file. 
- `gff3_to_gtf`, a python script that converts GFF3 format files into GTF format files for the purpose of building transcript reference.
- `genome_to_transcript_set`, a python script to extract transcript sequences based on the genome and annotation. It also removes redundant sequences.
- `processSHAPEdata`, a python script to extract RNA sequence and estimate ML estimates from `*.adducts` files.

### Generated reference

The generated filtered reference will contain three files:

- `arabidopsis_filtered.fa`, the filtered set of transcript sequences, which is used to build `PROBer` references and map reads.
- `arabidopsis_filtered.t2g`, transcript id to gene id mapping. Each line contains two fields. The first one gives the transcript id and the second one gives the gene id.
- `arabidopsis_filtered.dup`, a list of removed transcripts due to redundancy.

The generated spike-in reference will contain two files:

- `arabidopsis_spike.fa`, which contains the 3 digital spike-in sequences in the top.
- `arabidopsis_spike.t2g`, the transcript id to gene id mapping.
