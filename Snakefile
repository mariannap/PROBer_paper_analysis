from snakemake.utils import min_version
from snakemake.utils import makedirs

min_version("3.7.1")
## Define variables 

### scripts
script_path = "scripts"

### tools
tool_path = "tools"

fastq_dump, Cutadapt, Samtools, Bowtie, Bowtie2 = expand("{path}/{program}", path = tool_path, 
	program = ["sratoolkit.2.6.3-ubuntu64/bin/fastq-dump", "cutadapt-1.10/bin/cutadapt", "samtools-1.3.1/samtools", "bowtie-1.1.2/bowtie", "bowtie2-2.2.9/bowtie2"])
bowtie_path = tool_path + "/bowtie-1.1.2"
bowtie2_path = tool_path + "/bowtie2-2.2.9"

rsem_path = tool_path + "/RSEM-1.2.31"
RSEM_prepare, RSEM_simulate, RSEM_calculate = expand("{path}/{cmd}", path = rsem_path, 
	cmd = ["rsem-prepare-reference", "rsem-simulate-reads", "rsem-calculate-expression"])

PROBer, PROBer_single, PROBer_sampler = expand("{path}/PROBer-0.3.0/build/src/{cmd}", path = tool_path, cmd = ["PROBer", "PROBer-single-batch-estimate", "PROBer-sample-iCLIP"])
PROBer_full_model = "{path}/PROBer_full_model/build/src/PROBer".format(path = tool_path)

Fold, scorer = expand("{path}/RNAstructure/exe/{cmd}", path = tool_path, cmd = ["Fold", "scorer"])
RNAstructure_data_path = "{path}/RNAstructure/data_tables".format(path = tool_path)

### ground truth
gt_path = "ground_truth"
# spike_ins = ["RNaseP_WT", "pT181_long", "pT181_short"]
spike_ins = ["16S", "23S", "5S", "Group_I", "Group_II", "HCV_IRES", "HIV-1", "TPP", "tRNAphe"]

### references
ref_path = "references"

ref_arabidopsis, ref_yeast, ref_ecoli, ref_mouse, ref_human = expand("{path}/{organism}", path = ref_path, 
	organism = ["arabidopsis", "yeast", "ecoli", "mouse", "human"])
makedirs([ref_arabidopsis, ref_yeast, ref_ecoli, ref_mouse, ref_human])

arabidopsis_filt = "{path}/arabidopsis_filt".format(path = ref_arabidopsis)
arabidopsis_filt_rsem = arabidopsis_filt + "_rsem"
arabidopsis_spike = "{path}/arabidopsis_spike".format(path = ref_arabidopsis)
yeast_filt = "{path}/yeast_filt".format(path = ref_yeast)
yeast_rRNAs = "{path}/yeast_rRNAs".format(path = ref_yeast)
ecoli_rRNA = "{path}/ecoli_rRNA".format(ref_ecoli)
mouse_filt = "{path}/mouse_filt".format(path = ref_mouse)
human_ref = "{path}/human_ref".format(path = ref_human)
rep_ref = "{path}/rep_ref".format(path = ref_human)

human_genome = "{path}/Homo_sapiens.GRCh38.dna.primary_assembly.fa".format(path = ref_human)

### data
data_path = "data"

AssmannLab, McmanusLab, ChangLab, GrannemanLab, VintherLab, GilbertLab, UleLab, YeoLab = expand("{path}/{lab}", path = data_path, 
	lab = ["AssmannLab", "McmanusLab", "ChangLab", "GrannemanLab", "VintherLab", "GilbertLab", "UleLab", "YeoLab"])
makedirs([AssmannLab, McmanusLab, ChangLab, GrannemanLab, VintherLab, GilbertLab, UleLab, YeoLab])

YeoLab_iCLIP, YeoLab_eCLIP = expand("{lab}/{type}", lab = YeoLab, type = ["iCLIP", "eCLIP"])
makedirs([YeoLab_iCLIP, YeoLab_eCLIP])


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
sample_name_to_data["ChemModSeq_minus"] = expand("{path}/{run}_cleaned_{mate}.fq", path = GrannemanLab, run = ["SRR1041324", "SRR1041325", "SRR1041326"], mate = ["1", "2"])
sample_name_to_data["ChemModSeq_plus"] = expand("{path}/{run}_cleaned_{mate}.fq", path = GrannemanLab, run = ["SRR1041327", "SRR1041328", "SRR1041329"], mate = ["1", "2"])

### exp
exp_path = "exp"

### simulation
sim_path = "simulation"

### results
result_path = "results"

results = expand("{path}/structure_seq_sim{digit}_{name}_{method}_boxplot.pdf", path = result_path, digit = ['1', '2'], name = ["vs_full", "vs_pipeline", "main"], method = ["pearson", "spearman"])
results.extend(expand("{path}/{exp}_{type}_{rRNA}.pdf", path = result_path, exp = ["mod_seq", "ChemModSeq"], type = ["pr", "roc"], rRNA = ["18S", "25S"]))
results.append("{path}/yeast_structure_prediction_table.txt".format(path = result_path))
results.extend(expand("{path}/pseudoU_{type}.pdf", path = result_path, type = ["pr", "roc"]))
results.append("{path}/pseudoU_18S.pdf".format(path = result_path))
results.extend(expand("{path}/structure_seq_spikes_{corr}_boxplot.pdf", path = result_path, corr = ["pearson", "spearman"]))
results.extend(expand("{path}/{type}_site_result_table.txt {path}/{type}_peak_result_table.txt".split(), path = result_path, type = ["iCLIP", "eCLIP"]))
results.extend(expand("{path}/time_and_memory_table.txt", path = result_path))
# results.extend(expand("{path}/{name}", path = result_path, name = ["digital_spike_in.txt", "scatters.pdf", "mapping_statistics_table.txt"]))#, ]))
# results.extend(expand("{path}/{name}_seq_roc_{rRNA}.pdf", path = result_path, name = ["structure", "mod"], rRNA = ["18S", "25S"]))
# results.extend(expand("{path}/icSHAPE_{condition}_roc_{rRNA}.pdf", path = result_path, condition = ["invitro", "invivo"], rRNA = ["18S", "12S_Mt"]))
# results.extend(expand("{path}/{name}.txt", path = result_path, name = ["RBFOX2_iCLIP_table", "iCLIP_mapping_statistics"]))
# #results.extend(expand("{path}/{name}.bedGraph", path = result_path, name = ["SRGAP2B", "SRGAP2D"]))
# results.extend(expand("{path}/{name}.bedGraph", path = result_path, name = "NUP133"))

## Import Snakemake modules

include: "scripts/Snakefile"
include: "tools/Snakefile"
include: "ground_truth/Snakefile"
include: "references/Snakefile"
include: "data/Snakefile"
include: "exp/Snakefile"
include: "simulation/Snakefile"

rule all:
	input: #results 
		expand("{path}/{name}_roc_auc.txt", path = exp_path, name = ["icSHAPE_invivo", "icSHAPE_invitro"])
		# expand("{path}/{name}.{suffix}", path = exp_path, name = ["RBFOX2_293T_YeoLab_rep1", "PUM2_K562_YeoLab_rep1"], suffix = ["alignments.bam", "site_info"])
		# expand("{path}/RBFOX2_293T_YeoLab_iCLIP_{ending}.iCLIP.mhr", path = exp_path, ending = ["unique", "all"])
		# expand("{path}/SRR3147{number}_reprm_{mate}.fq", path = YeoLab_eCLIP, number = ["598", "599", "600"], mate = ["1", "2"]),
		# expand("{path}/{protein}_K562_YeoLab_{rep}_reprm_{mate}.fq", path = YeoLab_eCLIP, protein = ["PUM2", "TARDBP", "TRA2A"], rep = ["rep1", "input"], mate = ["1", "2"])
	

	#"{path}/pseudoU_PR.pdf".format(path = result_path)
	
	 #results
