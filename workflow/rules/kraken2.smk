rule kraken2_classify:
    input:
        fqs = get_fqs,
    output:
        kraken_out = "results/{sample}/kraken2/{sample}.kraken2.out",
        kraken_report = "results/{sample}/kraken2/{sample}.kraken2_report.out",
        classified_1 = "results/{sample}/kraken2/{sample}_classified_1.fq",
        classified_2 = "results/{sample}/kraken2/{sample}_classified_2.fq",
    log:
        "results/logs/{sample}.kraken2.log"
    threads: 16 
    conda:
        "../envs/kraken2.yaml"
    benchmark:
        "results/benchmarks/{sample}.kraken2.tsv"
    params:
        kraken_db = config["kraken2"]["index_dir"],
        classified_prefix = "results/{sample}/kraken2/{sample}_classified#.fq",
    shell:
        "kraken2 --db {params.kraken_db} "
        "--threads {threads} "
        "--use-names "
        "--output {output.kraken_out} "
        "--report {output.kraken_report} "
        "--paired "
        "--classified-out {params.classified_prefix} "
        "{input.fqs[0]} {input.fqs[1]} "
        "&>{log}"
