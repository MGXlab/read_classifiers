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

rule bracken:
    input:
        kraken_report = rules.kraken2_classify.output.kraken_report,
    output:
        domain_kreport = "results/{sample}/kraken2/{sample}.D.bracken.kreport.txt",
        phylum_kreport = "results/{sample}/kraken2/{sample}.P.bracken.kreport.txt",
        order_kreport = "results/{sample}/kraken2/{sample}.O.bracken.kreport.txt",
        class_kreport = "results/{sample}/kraken2/{sample}.C.bracken.kreport.txt",
        family_kreport = "results/{sample}/kraken2/{sample}.F.bracken.kreport.txt",
        genus_kreport = "results/{sample}/kraken2/{sample}.G.bracken.kreport.txt",
        species_kreport = "results/{sample}/kraken2/{sample}.S.bracken.kreport.txt",
    log:
        "results/logs/{sample}.bracken.log"
    threads: 8
    conda:
        "../envs/kraken2.yaml"
    benchmark:
        "results/benchmarks/{sample}.bracken.tsv"
    params:
        kraken_db = config["kraken2"]["index_dir"],
        ranks="D P O C F G S",
        out_prefix="results/{sample}/kraken2/{sample}",
        out_suffix="bracken.kreport.txt"
    shell:
       "for rank in {params.ranks};do "
       "bracken "
       "-d {params.kraken_db} "
       "-i {input.kraken_report} "
       "-o {params.out_prefix}.$rank.{params.out_suffix} "
       "-l $rank "
       ";done "
       "&>{log}"
