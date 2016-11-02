
# PROBer paper analysis workflow
[![Snakemake](https://img.shields.io/badge/snakemake-≥3.7.1-brightgreen.svg?style=flat-square)](http://snakemake.bitbucket.org)

Reproduce PROBer paper analysis.

## Table of contents

* [Prerequisites](#pre)
* [Reproduce analyses](#reproduce)
    - [Clone the workflow](#clone)
    - [Run snakemake](#snakemake)
    - [Results](#results)
        + [Figures](#figures)
        + [Tables](#tables)
        + [BedGraph files](#bedgraph)
* [Experiment details](#details)

### <a name="pre" />Prerequisites

This snakemake workflow is tested and intended to run under Ubuntu Linux 64 bit architecture. Please make sure that your server has at least 20 cores and 32G memory.

First, you need to install the latest version of [Snakemake](https://bitbucket.org/snakemake/snakemake/wiki/Home). 

Second, please make sure that you have `Perl`, `Python` and `R`(>= 3.3.0) installed. For `Python`, we additionally require the following packages: `Cython`, `numpy`, `scipy`, `pysam`, `requests`, and `statsmodels`. For `R`, please install packages `reshape2`, `PRROC`, and `RNAprobR`.

The snippet below shows how to install `Snakemake` and required packages under `virtualenv`.

```
pip3 install virtualenv
virtualenv venv
source venv/bin/activate

pip3 install snakemake
pip3 install numpy
pip3 install scipy
pip3 install Cython
pip3 install pysam
pip3 install requests
pip3 install statsmodels

R
>install.packages("reshape2")
>install.packages("PRROC")
>source("https://bioconductor.org/biocLite.R")
>biocLite("RNAprobR")
>q()
```

### <a name="reproduce" />Reproduce analyses

#### <a name="clone" />Clone the workflow

Type 

```
git clone git@github.com:pachterlab/PROBer_paper_analysis.git work_dir
```

to clone PROBer paper analysis workflow to your working directory. `work_dir` refers to the working directory you choose (e.g. 'PROBer_paper_analysis').

#### <a name="snakemake" />Run snakemake

Activate your environment (if you use `virtualenv`) and go to `work_dir`:

```
source venv/bin/activate
cd work_dir
```

Then type 

```
snakemake -j <number_of_threads>
```

`<number_of_threads>` is the total number of threads you want to use. This number should be no less than 20. 

#### <a name="results" />Results

You can find all figures and tables under `results`.

##### <a name="figures" />Figures

Mappings between figure names in our draft and file names under `results` are shown in the table below:

Figure Name | File Name
----------- | ---------
Figure 2A | structure_seq_sim1_main_boxplot.pdf
Figure 2B | pseudoU_PR.pdf
Figure S2A | structure_seq_sim1_vs_full_boxplot.pdf
Figure S2B | structure_seq_sim1_vs_pipeline_boxplot.pdf
Figure S3A | structure_seq_sim2_vs_full_boxplot.pdf
Figure S3B | structure_seq_sim2_vs_pipeline_boxplot.pdf
Figure S3C | structure_seq_sim2_main_boxplot.pdf
Figure S4 | scatters.pdf
Figure S5A | structure_seq_roc_18S.pdf
Figure S5B | structure_seq_roc_25S.pdf
Figure S5C | mod_seq_roc_18S.pdf
Figure S5D| mod_seq_roc_25S.pdf
Figure S5E | icSHAPE_invitro_roc_18S.pdf
Figure S5F | icSHAPE_invitro_roc_12S_Mt.pdf
Figure S5G | icSHAPE_invivo_roc_18S.pdf
Figure S5H | icSHAPE_invivo_roc_12S_Mt.pdf
Figure S6 | pseudoU_18S.pdf
Figure S7 | pseudoU_ROC.pdf

##### <a name="tables" />Tables

Mappings between table names in our draft and file names under `results` are shown in the table below:

Table Name | File Name
---------- | ---------
Table S1 | mapping_statistics_table.txt
Table S2 | iCLIP_mapping_statistics.txt
Table S3 | digital_spike_in.txt

##### <a name="bedgraph" />BedGraph files

`NUP133.bedGraph` shows the RBFOX2 iCLIP hits on gene `NUP133`. To visualize it, following the instructions below:

1. Go to https://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38
2. Click "add custom tracks"
3. Click "Choose file" at "Paste URLs or data:         Or upload:", and upload one bedGraph file
4. Click "Submit"
5. Click "go" at the right side of "view in Genome Browser"

### <a name="details" />Experiment details

We have experiment details explained in subfolders: 

* Go to [tools](tools) for information about tools this workflow used
* Go to [references](references) for reference building details
* Go to [ground_truth](ground_truth) if you want to know how to download ground truth rRNA structures and pseudouridine sites
* Go to [data](data) to learn more about how data were downloaded and pre-processed
* Go to [exp](exp) to learn more about how PROBer options were set for different data sets