#### Arabidopsis reference

1. There are two copies of 18S rRNA, `AT2G01010.1` and `AT3G41768.1`. `AT2G01010.1` is consistent with the ground truth 18S sequence from [RNA structure database](http://www.rna.icmb.utexas.edu/DAT/3B/Standard/index.php?xysub=1&organism=Arabidopsis%20thaliana&seq_size=&rna_type=&orf=&rna_class=&from_gene=&structure=ALL&cell_loc=&ord=&xyac_info=m&xybegin=0&xyrange=50&xyco=yes&query_type=results) and `AT3G41768.1` is not. Thus, `AT3G41768.1` is removed.

2. The large subunit sequence from [RNA structure database](http://www.rna.icmb.utexas.edu/DAT/3B/Standard/index.php?xysub=1&organism=Arabidopsis%20thaliana&seq_size=&rna_type=&orf=&rna_class=&from_gene=&structure=ALL&cell_loc=&ord=&xyac_info=m&xybegin=0&xyrange=50&xyco=yes&query_type=results) contains both 5.8S and 25S sequences. Because 5.8S (`AT2G01020.1`) existed in the reference, we splitted the large subunit sequence and only add the 25S part into the reference.

