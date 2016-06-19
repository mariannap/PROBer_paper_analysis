1. To learn simulation parameters from real data, `PROBer` must take alignments sorted by read names as inputs. This is to avoid slightly different simulation parameters are learned for each run.
2. In simulation, if a simulated cDNA fragment is less than 37nt, the whole fragment will be outputed as a single-end read.
