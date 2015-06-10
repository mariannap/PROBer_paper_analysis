# Build tools that we use
include: "tools/Snakefile"

# Prepare annotation
include: "annotation/Snakefile"

# Generate references
#include: "references/Snakefile"

rule all:
     input: TOOLS,
            ANNOTATIONS
#            REF_FILT
