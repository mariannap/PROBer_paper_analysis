# PROBer_paper_analysis

Reproduce PROBer paper analysis

### Prerequisites

This snakemake workflow is tested and intended to run under Ubuntu Linux 64 bit architecture. Please make sure that your server has at least 20 cores and 32G memory.

First, you need to install [Snakemake](https://bitbucket.org/snakemake/snakemake/wiki/Home)(>= 3.7.1). 

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

You can find all tables and figures under the `results` directory.

The mappings between figure names in our draft and file names under `results` are shown in the table below: 
<table>
        <tr>
                <th>Figure Name</th>
                <th>File Name</th>
        </tr>
        <tr>
                <td>Figure 3</td>
                <td>sim_boxplot.pdf</td>
        </tr>
        <tr>
                <td>Figure S6</td>
                <td>sim2_boxplot.pdf</td>
        </tr>
        <tr>
                <td>Figure S7a</td>
                <td>sim_SEvsPE_boxplot.pdf</td>
        </tr>
        <tr>
                <td>Figure S7b</td>
                <td>sim_SEvsPE_half_boxplot.pdf</td>
        </tr>
        <tr>
                <td>Figure S7c</td>
                <td>sim2_SEvsPE_boxplot.pdf</td>
        </tr>
        <tr>
                <td>Figure S7d</td>
                <td>sim2_SEvsPE_half_boxplot.pdf</td>
        </tr>
        <tr>
                <td>Figure S8a</td>
                <td>real_ROC_18S.pdf</td>
        </tr>
        <tr>
                <td>Figure S8b</td>
                <td>real_ROC_25S.pdf</td>
        </tr>
        <tr>
                <td>Figure S9a</td>
                <td>fake_ROC_18S.pdf</td>
        </tr>
        <tr>
                <td>Figure S9b</td>
                <td>fake_ROC_25S.pdf</td>
        </tr>
        <tr>
                <td>Figure S10</td>
                <td>scatters.pdf</td>
        </tr>
        <tr>
                <td>Figure S11a</td>
                <td>sim_modes_boxplot.pdf</td>
        </tr>
        <tr>
                <td>Figure S11b</td>
                <td>sim_modes_half_boxplot.pdf</td>
        </tr>
</table>

The mappings between table names in our draft and file names under `results` are shown in the table below:
<table>
        <tr>
                <th>Table Name</th>
                <th>File Name</th>
        </tr>
        <tr>
                <td>Table S1</td>
                <td>grid_search_for_prior.txt</td>
        </tr>
        <tr>
                <td>Table S2</td>
                <td>mapping_statistics_table.txt</td>
        </tr>
        <tr>
                <td>Table S3</td>
                <td>time_and_memory_table.txt</td>
        </tr>
        <tr>
                <td>Table S5</td>
                <td>digital_spike_in.txt</td>
        </tr>
        <tr>
                <td>Table S6</td>
                <td>fake_pearson_table.txt</td>
        </tr>
        <tr>
                <td>Table S7</td>
                <td>sim_modes_table.txt</td>
        </tr>
</table>
