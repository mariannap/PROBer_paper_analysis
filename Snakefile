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

rule all:
     input: TOOLS,
            ANNOTATIONS,
            REF_FILT,
            REF_SPIKE,
            REAL_DATA,
            RESULTS


