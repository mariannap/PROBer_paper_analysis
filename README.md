# PROBer_paper_analysis

Reproduce PROBer paper analysis

### Prerequisites

First, you need to install [Snakemake](https://bitbucket.org/johanneskoester/snakemake/wiki/Home). 

Then, please make sure that you have `Perl`, `Python` and `R`(>= 3.1.0) installed. For `Python`, we additionally require the following packages installed: [numpy](http://www.numpy.org), [scipy](http://www.scipy.org/), and [pysam](https://github.com/pysam-developers/pysam). For `R`, please install the [pROC](http://cran.r-project.org/web/packages/pROC) and [reshape2](http://cran.r-project.org/web/packages/reshape2) packages.

You also need to install [SRA Toolkit](http://www.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software) in order to use [fastq-dump](http://www.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=toolkit_doc&f=fastq-dump).

### Reproduce analyses

#### Download Ding et al. read data from SRA 

You should put FASTQ files into `data/`.

Suppose you have `wget`, run the following commands:

```
cd data
wget ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRR933/SRR933551/SRR933551.sra
wget ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRR933/SRR933552/SRR933552.sra
wget ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRR933/SRR933556/SRR933556.sra
wget ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRR933/SRR933557/SRR933557.sra
```

Then run `fastq-dump` from SRA Toolkit to get FASTQ files:

```
fastq-dump SRR933551.sra 
fastq-dump SRR933552.sra 
fastq-dump SRR933556.sra 
fastq-dump SRR933557.sra 
```

The meaning of each data is listed in the table below:

<table>
        <tr>
                <th>Accession</th>
                <th>Meaning</th>
        </tr>
        <tr>
                <td>SRR933551</td>
                <td>Biological replicate I, (-) channel</td>
        </tr>
        <tr>
                <td>SRR933552</td>
                <td>Biological replicate I, (+) channel</td>
        </tr>
        <tr>
                <td>SRR933556</td>
                <td>Biological replicate II, (+) channel</td>
        </tr>
        <tr>
                <td>SRR933557</td>
                <td>Biological replicate II, (-) channel</td>
        </tr>
</table>

#### Run snakemake

Type

```
snakemake -j <number_of_threads>
```

in the top directory. `<number_of_threads>` is the total number of threads you want to use. 

##### Running time and memory usage measurement

Please make sure that your server has at least 40 cores in order to make sure the time measurement is comparable to what we reported in our paper.

#### Results

You can find all tables and figures under the `results` directory.

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

 
### Notes

1. Each run of the snakemake may provide slightly different results (although qualitatively the same). In our Snakemake pipeline, we first run PROBer on the real data set with 40 threads. In this multi-threading setting, the results PROBer generates are not exactly the same each time due to floating point errors. Then our Snakemake pipeline generates simulated data sets based on these real data results and thus produces different simulated data sets. Lastly, the different simulated data sets will produce slightly different final results.

2. In our pipeline, we use PROBer to simulate paired-end reads and then pick the first mates as the simulated single-end reads. In this way, when we compare the effects of single-end vs paired-end reads on estimation accuracy, we can make sure these data sets are generated in the same batch.
