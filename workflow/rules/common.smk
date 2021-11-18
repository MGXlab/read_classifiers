import pandas as pd

samples_df = (
    pd.read_csv(config["samplesheet"], sep="\t", dtype={"sample_id" : "string"})
    .set_index("sample_id", drop=False)
    .sort_index()
)

def get_fqs(wildcards):
    r1 = samples_df.loc[wildcards.sample, "R1"]
    r2 = samples_df.loc[wildcards.sample, "R2"]
    return r1, r2

