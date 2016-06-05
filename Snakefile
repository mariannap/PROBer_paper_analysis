# Define variables 

## tools
tools_path = "tools"

Cutadapt, Samtools, Bowtie = expand("{path}/{program}", path = tools_path, 
	program = ["cutadapt-1.10/bin/cutadapt", "samtools-1.3.1/samtools", "bowtie-1.1.2/bowtie"])

RSEM_prepare, RSEM_calculate = expand("{path}/RSEM-1.2.31/{cmd}", path = tools_path, cmd = ["rsem-prepare-reference", "rsem-calculate-expression"])

PROBer, PROBer_single = expand("{path}/PROBer-0.2.0/build/src/{cmd}", path = tools_path, cmd = ["PROBer", "PROBer-single-batch-estimate"])

tools = [Cutadapt, Samtools, Bowtie, RSEM_prepare, RSEM_calculate, PROBer, PROBer_single]

# Import Snakemake modules
include: "tools/Snakefile"

rule all:
	input: tools
