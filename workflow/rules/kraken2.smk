rule kraken2_classify:
    input:
        fqs = get_fqs,
    output:
        kraken_out = "results/{sample}/kraken2/{sample}.kraken2.out",
        classified_1 = "results/{sample}/kraken2/{sample}_classified_1.fq",
        classified_2 = "results/{sample}/kraken2/{sample}_classified_2.fq",
        unclassified_1 = "results/{sample}/kraken2/{sample}_unclassified_1.fq",
        unclassified_2 = "results/{sample}/kraken2/{sample}_unclassified_2.fq",
    log:
        "results/logs/{sample}.kraken2.log"
    threads: 8
    conda:
        "../envs/kraken2.yaml"
    benchmark:
        "results/benchmarks/{sample}.kraken2.tsv"
    params:
        kraken_db = config["kraken2"]["index_dir"],
        classified_prefix = "results/{sample}/kraken2/{sample}_classified#.fq",
        uncassified_prefix =  "results/{sample}/kraken2/{sample}_unclassified#.fq"
    shell:
        "kraken2 --db {params.kraken_db} "
        "--threads {threads} "
        "--use-names "
        "--output {output.kraken_out} "
        "--paired "
        "--classified-out {params.classified_prefix} "
        "&>{log}"
