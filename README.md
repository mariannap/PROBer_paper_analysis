
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

Second, please make sure that you have `Perl`, `Python` (both `Python2` and `Python3`) and `R`(>= 3.3.1) installed. For `Python3`, we additionally require the following packages: `Cython`, `numpy`, `scipy`, `pysam`, `requests`, and `statsmodels`. For `Python2`, please install packages `pymol`, `Cython`, `pysam`, `pandas`, and `CLIPper`. For `R`, please install packages `reshape2`, `PRROC`, `RNAprobR`, `devtools`, and `BUMHMM`. For `Perl`, please install packages `libstatistics-basic-perl` and `libstatistics-distributions-perl`.

The snippet below shows how to install `Snakemake` and required packages using `virtualenv`.

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
>install.packages("devtools")
>library(devtools)
>install_github("alinaselega/BUMHMM", ref = "bf137ea")
>q()

// Install pymol
apt-get install pymol

// Install CLIPper
pip2 install Cython
pip2 install pysam
pip2 install pandas

git clone git://github.com/YeoLab/clipper.git
cd clipper
python2 setup.py install

// Install eCLIP input-normalization required perl libraries
apt-get install libstatistics-basic-perl
apt-get install libstatistics-distributions-perl

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
Figure 2A | structure_seq_sim1_main_pearson_boxplot.pdf
Figure 2B | ChemModSeq_pr_18S.pdf
Figure 2C | yeast_structure_prediction_table.txt
Figure 3A | pseudoU_pr.pdf
Figure 3B | eCLIP_peak_result_table.txt
Figure S2A | structure_seq_sim1_main_spearman_boxplot.pdf
Figure S2B | structure_seq_sim1_vs_full_pearson_boxplot.pdf
Figure S2C | structure_seq_sim1_vs_full_spearman_boxplot.pdf
Figure S2D | structure_seq_sim1_vs_pipeline_pearson_boxplot.pdf
Figure S2E | structure_seq_sim1_vs_pipeline_spearman_boxplot.pdf
Figure S3A | structure_seq_sim2_vs_full_pearson_boxplot.pdf
Figure S3B | structure_seq_sim2_vs_full_spearman_boxplot.pdf
Figure S3C | structure_seq_sim2_vs_pipeline_pearson_boxplot.pdf
Figure S3D | structure_seq_sim2_vs_pipeline_spearman_boxplot.pdf
Figure S3E | structure_seq_sim2_main_pearson_boxplot.pdf
Figure S3F | structure_seq_sim2_main_spearman_boxplot.pdf
Figure S4 | scatters.pdf
Figure S5A | structure_seq_spikes_pearson_boxplot.pdf
Figure S5B | structure_seq_spikes_spearman_boxplot.pdf
Figure S6A | ChemModSeq_roc_18S.pdf
Figure S6B | ChemModSeq_pr_25S.pdf
Figure S6C | ChemModSeq_roc_25S.pdf
Figure S6D | mod_seq_pr_18S.pdf
Figure S6E | mod_seq_roc_18S.pdf
Figure S6F | mod_seq_pr_25S.pdf
Figure S6G | mod_seq_roc_25S.pdf
Figure S7 | pseudoU_18S.pdf
Figure S8 | pseudoU_roc.pdf
Figure S9 | SHAPES_bias.pdf
Figure S10A | SHAPES_sel_roc.pdf
Figure S10B | SHAPES_sel_pr.pdf
Figure S10C | SHAPES_no_sel_roc.pdf
Figure S10D | SHAPES_no_sel_pr.pdf

##### <a name="tables" />Tables

Mappings between table names in our draft and file names under `results` are shown in the table below:

Table Name | File Name
---------- | ---------
Table S1 | mapping_statistics_table.txt
Table S2 | time_and_memory_table.txt
Table S3 | structure_probing_roc_auc_table.txt
Table S4 | comparing_with_BUMHMM_table.txt
Table S5 | eCLIP_site_result_table.txt
Table S6 | iCLIP_peak_result_table.txt
Table S7 | iCLIP_site_result_table.txt

### <a name="details" />Experiment details

We have experiment details explained in subfolders: 

* Go to [tools](tools) for information about tools included as part of the workflow
* Go to [references](references) for reference building details
* Go to [ground_truth](ground_truth) if you want to know how to download ground truth rRNA structures and pseudouridine sites, and how to calculate solvent accessible areas.
* Go to [data](data) to learn more about how data were downloaded and pre-processed
* Go to [exp](exp) to learn more about how PROBer's protocol-specific options were set for different data sets