# Build tools that we use
include: "tools/Snakefile"

# Generate filtered reference
include: "annotation/Snakefile"


rule all:
     input: TOOLS,
            ANNOTATIONS

