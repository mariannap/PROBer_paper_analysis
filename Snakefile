## Define variables 

### scripts
script_path = "scripts"

### tools
tool_path = "tools"

Cutadapt, Samtools, Bowtie = expand("{path}/{program}", path = tool_path, 
	program = ["cutadapt-1.10/bin/cutadapt", "samtools-1.3.1/samtools", "bowtie-1.1.2/bowtie"])

RSEM_prepare, RSEM_calculate = expand("{path}/RSEM-1.2.31/{cmd}", path = tool_path, cmd = ["rsem-prepare-reference", "rsem-calculate-expression"])

PROBer, PROBer_single = expand("{path}/PROBer-0.2.0/build/src/{cmd}", path = tool_path, cmd = ["PROBer", "PROBer-single-batch-estimate"])

# tools = [Cutadapt, Samtools, Bowtie, RSEM_prepare, RSEM_calculate, PROBer, PROBer_single]

### ground truth
gt_path = "ground_truth"

ground_truths = expand("{path}/{organism}_{rRNA}.{suffix}", path = gt_path, organism = ["arabidopsis", "yeast"], rRNA = ["18S", "25S"], suffix = ["structure", "fa", "isac"])
ground_truths.extend(expand("{path}/mouse_{rRNA}.{suffix}", path = gt_path, rRNA = ["18S", "12S_Mt"], suffix = ["structure", "fa", "isac"]))
ground_truths.extend(expand("{path}/{organism}_rRNAs.fa", path = gt_path, organism = ["arabidopsis", "mouse"]))
ground_truths.extend(expand("{path}/{name}.{suffix}", path = gt_path, name = ["RNaseP_WT", "pT181_long", "pT181_short"], suffix = ["fa", "gamma", "beta"]))
ground_truths.extend(expand("{path}/{file}", path = gt_path, file = ["SHAPE.t2g", "spikes_info.txt"]))

## Import Snakemake modules

include: "tools/Snakefile"
include: "ground_truth/Snakefile"

rule all:
	input: ground_truths

