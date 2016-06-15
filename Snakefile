from snakemake.utils import makedirs

## Define variables 

### scripts
script_path = "scripts"

### tools
tool_path = "tools"

fastq_dump, Cutadapt, Samtools, Bowtie = expand("{path}/{program}", path = tool_path, 
	program = ["sratoolkit.2.6.3-ubuntu64/bin/fastq-dump", "cutadapt-1.10/bin/cutadapt", "samtools-1.3.1/samtools", "bowtie-1.1.2/bowtie"])
bowtie_path = tool_path + "/bowtie-1.1.2"

rsem_path = tool_path + "/RSEM-1.2.31"
RSEM_prepare, RSEM_simulate, RSEM_calculate = expand("{path}/{cmd}", path = rsem_path, 
	cmd = ["rsem-prepare-reference", "rsem-simulate-reads", "rsem-calculate-expression"])

PROBer, PROBer_single = expand("{path}/PROBer-0.2.0/build/src/{cmd}", path = tool_path, cmd = ["PROBer", "PROBer-single-batch-estimate"])
PROBer_full_model = "{path}/PROBer_full_model/build/src/PROBer".format(path = tool_path)

# tools = [fastq_dump, Cutadapt, Samtools, Bowtie, RSEM_prepare, RSEM_calculate, PROBer, PROBer_single]

### ground truth
gt_path = "ground_truth"
spike_ins = ["RNaseP_WT", "pT181_long", "pT181_short"]

# ground_truths = expand("{path}/{organism}_{rRNA}.{suffix}", path = gt_path, organism = ["arabidopsis", "yeast"], rRNA = ["18S", "25S"], suffix = ["structure", "isac"])
# ground_truths.extend(expand("{path}/mouse_{rRNA}.{suffix}", path = gt_path, rRNA = ["18S", "12S_Mt"], suffix = "structure"))
# ground_truths.extend(expand("{path}/{organism}_rRNAs.fa", path = gt_path, organism = ["arabidopsis", "mouse"]))
# ground_truths.extend(expand("{path}/{name}.{suffix}", path = gt_path, name = ["RNaseP_WT", "pT181_long", "pT181_short"], suffix = ["fa", "gamma", "beta"]))
# ground_truths.extend(expand("{path}/{file}", path = gt_path, file = ["SHAPE.t2g", "spikes_info.txt"]))

### references
ref_path = "references"

ref_arabidopsis, ref_yeast, ref_mouse, ref_human = expand("{path}/{organism}", path = ref_path, 
	organism = ["arabidopsis", "yeast", "mouse", "human"])
makedirs([ref_arabidopsis, ref_yeast, ref_mouse, ref_human])

arabidopsis_filt = "{path}/arabidopsis_filt".format(path = ref_arabidopsis)
arabidopsis_filt_rsem = arabidopsis_filt + "_rsem"
arabidopsis_spike = "{path}/arabidopsis_spike".format(path = ref_arabidopsis)
yeast_filt = "{path}/yeast_filt".format(path = ref_yeast)
mouse_filt = "{path}/mouse_filt".format(path = ref_mouse)
human_ref = "{path}/human_ref".format(path = ref_human)

# references = expand("{ref_name}.done", ref_name = [arabidopsis_filt, arabidopsis_spike, yeast_filt, mouse_filt, human_ref, arabidopsis_filt + "_rsem"])

### data
data_path = "data"

AssmannLab, McmanusLab, ChangLab, GilbertLab, YeoLab = expand("{path}/{lab}", path = data_path, 
	lab = ["AssmannLab", "McmanusLab", "ChangLab", "GilbertLab", "YeoLab"])
makedirs([AssmannLab, McmanusLab, ChangLab, GilbertLab, YeoLab])

sample_name_to_data = {}
sample_name_to_data["structure_seq_minus"] = expand("{path}/{run}_trimmed.fq", path = AssmannLab, run = ["SRR933551", "SRR933557"])
sample_name_to_data["structure_seq_plus"] = expand("{path}/{run}_trimmed.fq", path = AssmannLab, run = ["SRR933552", "SRR933556"])
sample_name_to_data["mod_seq_minus"] = expand("{path}/{run}_corrected.fq", path = McmanusLab, run = ["SRR955862", "SRR955865"])
sample_name_to_data["mod_seq_plus"] = expand("{path}/{run}_corrected.fq", path = McmanusLab, run = ["SRR955864", "SRR955871"])
sample_name_to_data["icSHAPE_dmso"] = ["{path}/SRR1534953_cleaned.fq".format(path = ChangLab)]
sample_name_to_data["icSHAPE_invitro"] = ["{path}/SRR1534955_cleaned.fq".format(path = ChangLab)]
sample_name_to_data["icSHAPE_invivo"] = ["{path}/SRR1534957_cleaned.fq".format(path = ChangLab)]
sample_name_to_data["pseudo_seq_minus"] = expand("{path}/{run}_trimmed.fq", path = GilbertLab, run = ["SRR1327186", "SRR1327187"])
sample_name_to_data["pseudo_seq_plus"] = expand("{path}/{run}_trimmed.fq", path = GilbertLab, run = ["SRR1327188", "SRR1327189"])

# sample_name_to_data["RBFOX2_iCLIP"] = ["{path}/SRR3147675_cleaned.fq".format(path = YeoLab)]
# data = []
# for data_vec in sample_name_to_data.values():
# 	data.extend(data_vec)


### exp
exp_path = "exp"

### simulation
sim_path = "simulation"

### results
result_path = "results"

results = expand("{path}/structure_seq_sim{digit}_{name}_boxplot.pdf", path = result_path, digit = ['1', '2'], name = ["vs_full", "vs_pipeline", "main"])
results.extend(expand("{path}/{name}", path = result_path, name = ["digital_spike_in.txt", "scatters.pdf", "mapping_statistics_table.txt", "time_and_memory_table.txt"]))
results.extend(expand("{path}/{name}_seq_roc_{rRNA}.pdf", path = result_path, name = ["structure", "mod"], rRNA = ["18S", "25S"]))
results.extend(expand("{path}/icSHAPE_{condition}_roc_{rRNA}.pdf", path = result_path, condition = ["invitro", "invivo"], rRNA = ["18S", "12S_Mt"]))
results.extend(expand("{path}/pseudoU_{type}.pdf", path = result_path, type = ["PR", "ROC"]))

## Import Snakemake modules

include: "scripts/Snakefile"
include: "tools/Snakefile"
include: "ground_truth/Snakefile"
include: "references/Snakefile"
include: "data/Snakefile"
include: "exp/Snakefile"
include: "simulation/Snakefile"

rule all:
	input: results
