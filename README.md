[![Snakemake](https://img.shields.io/badge/snakemake-≥3.7.1-brightgreen.svg?style=flat-square)](http://snakemake.bitbucket.org)

# PROBer_paper_analysis

Reproduce PROBer paper analysis

### Prerequisites

This snakemake workflow is tested and intended to run under Ubuntu Linux 64 bit architecture. Please make sure that your server has at least 20 cores and 32G memory.

First, you need to install the latest version of [Snakemake](https://bitbucket.org/snakemake/snakemake/wiki/Home). 

Second, please make sure that you have `Perl`, `Python` and `R`(>= 3.3.0) installed. For `Python`, we additionally require the following packages: `Cython`, `numpy`, `scipy`, `pysam`, and `requests`. For `R`, please install packages `reshape2` and `PRROC`.

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

R
>install.packages("reshape2")
>install.packages("PRROC")
>q()
```

### Reproduce analyses

#### Clone the workflow

Type 

```
git clone git@github.com:pachterlab/PROBer_paper_analysis.git work_dir
```

to clone PROBer paper analysis workflow to your working directory. `work_dir` refers to the working directory you choose (e.g. 'PROBer_paper_analysis').

#### Run snakemake

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

#### Results

You can find all figures and tables under `results`.

##### Figures

Mappings between figure names in our draft and file names under `results` are shown in the table below:

Figure Name | File Name
----------- | ---------
Figure 2a | structure_seq_sim1_main_boxplot.pdf
Figure 2b | pseudoU_PR.pdf
Figure S6a | structure_seq_sim1_vs_full_boxplot.pdf
Figure S6b | structure_seq_sim1_vs_pipeline_boxplot.pdf
Figure S7a | structure_seq_sim2_vs_full_boxplot.pdf
Figure S7b | structure_seq_sim2_vs_pipeline_boxplot.pdf
Figure S7c | structure_seq_sim2_main_boxplot.pdf
Figure S8 | scatters.pdf
Figure S9a | structure_seq_roc_18S.pdf
Figure S9b | structure_seq_roc_25S.pdf
Figure S10a | mod_seq_roc_18S.pdf
Figure S10b | mod_seq_roc_25S.pdf
Figure S11a | icSHAPE_invitro_roc_18S.pdf
Figure S11b | icSHAPE_invitro_roc_12S_Mt.pdf
Figure S11c | icSHAPE_invivo_roc_18S.pdf
Figure S11d | icSHAPE_invivo_roc_12S_Mt.pdf
Figure S12 | pseudoU_18S.pdf
Figure S13 | pseudoU_ROC.pdf

##### Tables

Mappings between table names in our draft and file names under `results` are shown in the table below:

Table Name | File Name
---------- | ---------
Table S1 | mapping_statistics_table.txt
Table S2 | time_and_memory_table.txt
Table S4 | digital_spike_in.txt
Table S5 | iCLIP_mapping_statistics.txt

##### BedGraph files

`SRGAP2B.bedGraph` and `SRGAP2D.bedGraph` show the RBFOX2 iCLIP hits on pseudogenes `SRGAP2B` and `SRGAP2D`. To visualize them, following the instructions below:

1. Go to https://genome.ucsc.edu/cgi-bin/hgTracks?db=hg38
2. Click "add custom tracks"
3. Click "Choose file" at "Paste URLs or data:         Or upload:", and upload one bedGraph file
4. Click "Submit"
5. Click "go" at the right side of "view in Genome Browser".
