#### PROBer protocol-specific option settings

For protocols using random hexamer priming, `--primer-length` is set to 6. Otherwise, `--primer-length` is set to 0. Note that for random hexamer priming protocols, `--primer-length` option can be omitted since its default value is 6. `--size-selection-max` is set to the maximum cDNA fragment size described in each protocol's size selection step. `--size-selection-min` is set to the smaller value between minimum trimmed read length and minimum cDNA fragment size described in each protocol. Normally, the minimum trimmed read length is smaller than the minimum cDNA fragment size because size selection is not 100% perfect. `--read-length` is set to each protocol's single-end read length after trimming linker and UMI sequences.

The option values used for each data set are described below:

1. Ding *et al.* Arabidopsis data 

    ```
    --primer-length 6 --size-selection-min 21 --size-selection-max 526 --read-length 37
    ```

2. Talkish *et al.* yeast data

    ```
    --primer-length 0 --size-selection-min 23 --size-selection-max 220 --read-length 50
    ```

3. Spitale *et al.* mouse data

    ```
    --primer-length 0 --size-selection-min 20 --size-selection-max 120 --read-length 87
    ```

4. Carlile *et al.* yeast Pseudo-seq data

    ```
    --primer-length 0 --size-selection-min 18 --size-selection-max 130 --read-length 41
    ```
