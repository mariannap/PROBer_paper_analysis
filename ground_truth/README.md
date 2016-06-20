#### Download rRNA secondary structures from RNA structure database

Following the steps below to download BSSeq files for rRNA secondary structures:

1. Click [RNA structure database](http://www.rna.icmb.utexas.edu/DAT/3B/Standard/index.php).
2. Type Organism name. The organism names for Arabidopsis, yeast and mouse are `Arabidopsis thaliana`, `Saccharomyces cerevisiae` and `Mus musculus` respectively. Please make sure that there is no extra space in organism names.
3. Click `Submit`.
4. Download related BPSeq files: `d.16.e`(18S) and `d.23.e`(5.8S+25S) for Arabidopsis and yeast, and `d.16.e`(18S) and `d.16.m`(12S_Mt) for mouse. We used BPSeq files with pseudo knots (+PK).

#### Post-process BPSeq files

1. `d.23.e` downloaded from RNA structure database contains structural information for the whole large subunit, which includes 5.8S and 25S. Because we only used 25S for evaluation purpose, we need to remove 5.8S, which corresponds to first 164 nt for Arabidopsis and first 158 nt for yeast, from `d.23.e`.
2. `d.16.m`'s sequence is not consistent with the mouse Ensembl annotation. Thus, the extra base at position 146 was removed.

#### Known pseudouridine sites in yeast rRNA and snoRNA	

To access the known pseudouridine sites in yeast, follow the below steps:

1. Go to [The yeast snoRNA database](http://people.biochem.umass.edu/sfournier/fournierlab/snornadb/mastertable.php).
2. Click `Target RNA` at the top sidebar. 
3. Click individual RNA to view its pseudouridine modifications.

    