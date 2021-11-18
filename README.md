# read classifiers

Run some read taxonomic classifiers on multiple samples


## Requirements

- conda and/or mamba
- snakemake > 6.0


## Indices

Manually downloaded using the information below.

| Tool       |  Name  | Description                                                      | Date created |                              Direct Link                             |                     Ref                    |
|:-----------|:------:|:-----------------------------------------------------------------|:------------:|:--------------------------------------------------------------------:|:------------------------------------------:|
| centrifuge |   nt   | NCBI: nucleotide non-redundant sequences                         | March 3 2018 |   https://genome-idx.s3.amazonaws.com/centrifuge/nt_2018_3_3.tar.gz  | https://benlangmead.github.io/aws-indexes/ |
| kraken2    | PlusPf | archea,bacteria,viral,plasmid,human,UniVec_core, protozoa, fungi |  May 5 2017  | https://genome-idx.s3.amazonaws.com/kraken/k2_pluspf_20210517.tar.gz | https://benlangmead.github.io/aws-indexes/ |
| kaiju      | nr_euk | arahaea, bacteria, viruses, fungi, microbial eukaryotes          |  May 20 2020 |   https://kaiju.binf.ku.dk/database/kaiju_db_nr_euk_2021-02-24.tgz   |       https://kaiju.binf.ku.dk/server      |


For mgx users these are on mgx/programs/`tool_name`

## Configuration

Fill in the values of the config file as appropriate for your setup.

The `samplesheet` should point to a 3-column tsv file with columns

- `sample_id`: A unique sample identifier
- `R1` : Path to R1 for that sample
- `R2`: Path to R2 for that sample

Only paired-end data are supported for now.

## Running

```
$ snakemake -p -j24 --use-conda --conda-frontend mamba
```

