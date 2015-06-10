# Build tools that we use
include: "tools/Snakefile"

rule all:
     input: TOOLS

onsuccess:
        print("Success!")

onerror:
        print("Error!")
                                  