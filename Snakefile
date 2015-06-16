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
     input: expand("simulation_parameters/digital_spike.{suffix}", suffix = ["gamma", "beta"]),
            expand("simulation_parameters/sim_ground_truth.{suffix}", suffix = ["beta", "gamma", "expr"]),
            expand("simulation_parameters/sim_ground_truth_{channel}.{suffix}", channel = ["minus", "plus"], suffix = ["theta", "read_model"]),
            "simulation_parameters/input_list_boxplot.txt"

