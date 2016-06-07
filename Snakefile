## Define variables 

### scripts
script_path = "scripts"

### tools
tool_path = "tools"

Cutadapt, Samtools, Bowtie = expand("{path}/{program}", path = tool_path, 
	program = ["cutadapt-1.10/bin/cutadapt", "samtools-1.3.1/samtools", "bowtie-1.1.2/bowtie"])
bowtie_path = tool_path + "/bowtie-1.1.2"

RSEM_prepare, RSEM_calculate = expand("{path}/RSEM-1.2.31/{cmd}", path = tool_path, cmd = ["rsem-prepare-reference", "rsem-calculate-expression"])

PROBer, PROBer_single = expand("{path}/PROBer-0.2.0/build/src/{cmd}", path = tool_path, cmd = ["PROBer", "PROBer-single-batch-estimate"])

# tools = [Cutadapt, Samtools, Bowtie, RSEM_prepare, RSEM_calculate, PROBer, PROBer_single]

### ground truth
gt_path = "ground_truth"

# ground_truths = expand("{path}/{organism}_{rRNA}.{suffix}", path = gt_path, organism = ["arabidopsis", "yeast"], rRNA = ["18S", "25S"], suffix = ["structure", "isac"])
# ground_truths.extend(expand("{path}/mouse_{rRNA}.{suffix}", path = gt_path, rRNA = ["18S", "12S_Mt"], suffix = "structure"))
# ground_truths.extend(expand("{path}/{organism}_rRNAs.fa", path = gt_path, organism = ["arabidopsis", "mouse"]))
# ground_truths.extend(expand("{path}/{name}.{suffix}", path = gt_path, name = ["RNaseP_WT", "pT181_long", "pT181_short"], suffix = ["fa", "gamma", "beta"]))
# ground_truths.extend(expand("{path}/{file}", path = gt_path, file = ["SHAPE.t2g", "spikes_info.txt"]))

### references
ref_path = "references"

ref_arabidopsis = "{path}/arabidopsis".format(path = ref_path)
ref_yeast = "{path}/yeast".format(path = ref_path)
ref_mouse = "{path}/mouse".format(path = ref_path)
ref_human = "{path}/human".format(path = ref_path)

from snakemake.utils import makedirs
makedirs([ref_arabidopsis, ref_yeast, ref_mouse, ref_human])

arabidopsis_filt = "{path}/arabidopsis_filt".format(path = ref_arabidopsis)
arabidopsis_spike = "{path}/arabidopsis_spike".format(path = ref_arabidopsis)
yeast_filt = "{path}/yeast_filt".format(path = ref_yeast)
mouse_filt = "{path}/mouse_filt".format(path = ref_mouse)
human_ref = "{path}/human_ref".format(path = ref_human)

# references = expand("{ref_name}.done", ref_name = [arabidopsis_filt, arabidopsis_spike, yeast_filt, mouse_filt, human_ref, arabidopsis_filt + "_rsem"])


## Import Snakemake modules

include: "scripts/Snakefile"
include: "tools/Snakefile"
include: "ground_truth/Snakefile"
# include: "references/Snakefile"
include: "data/Snakefile"

rule all:
	input: 


