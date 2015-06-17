# Build tools that we use
include: "tools/Snakefile"

# Prepare annotation
include: "annotation/Snakefile"

# Generate references
include: "references/Snakefile"

# Preprocess real data
include: "data/Snakefile"

# Run experiments to obtain results
include: "results/Snakefile"

# Generate simulation parameters
include: "simulation_parameters/Snakefile"

rule all:
     input: TOOLS,
            ANNOTATIONS,
            REF_FILT,
            REF_SPIKE,
            REAL_DATA,
            RESULTS

rule test:
     input: expand("{path}/sim_spike_{expr}TPM_{channel}_{num}.fq", path = DATA_PATH, expr = ["1e5", "1e4", "1e3", "1e2"], channel = CHANNELS, num = [1, 2])

