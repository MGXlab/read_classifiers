rule kaiju_classify:
    input:
        fqs = get_fqs,
        nodes_dmp = config["kaiju"]["nodes_dmp"],
        fmi = config["kaiju"]["index"]
    output:
        kaiju_out = "results/{sample}/kaiju/{sample}.kaiju.out"
    threads: 16
    log:
        "results/logs/{sample}.kaiju.log"
    conda:
        "../envs/kaiju.yaml"
    benchmark:
        "results/benchmarks/{sample}.kaiju.tsv"
    shell:
        "kaiju "
        "-t {input.nodes_dmp} "
        "-f {input.fmi} "
        "-i {input.fqs[0]} "
        "-j {input.fqs[1]} "
        "-z {threads} "
        "-v "
        "-o {output.kaiju_out} "
        "&>{log}"

rule kaiju2table:
    input:
        kaiju_out = rules.kaiju_classify.output.kaiju_out,
        nodes_dmp = config["kaiju"]["nodes_dmp"],
        names_dmp = config["kaiju"]["names_dmp"],
    output:
        species_table = "results/{sample}/kaiju/{sample}.species.kaiju_table.tsv",
        genus_table = "results/{sample}/kaiju/{sample}.genus.kaiju_table.tsv",
        family_table = "results/{sample}/kaiju/{sample}.family.kaiju_table.tsv",
        order_table = "results/{sample}/kaiju/{sample}.order.kaiju_table.tsv",
        class_table = "results/{sample}/kaiju/{sample}.class.kaiju_table.tsv",
        phylum_table = "results/{sample}/kaiju/{sample}.phylum.kaiju_table.tsv",
    threads: 1
    log:
        "results/logs/{sample}.kaiju2table.log"
    conda:
        "../envs/kaiju.yaml"
    params:
        ranks="phylum order class family genus species",
        out_prefix = "results/{sample}/kaiju/{sample}",
        out_suffix = "kaiju_table.tsv"
    shell:
        "for rank in {params.ranks};do "
        "kaiju2table "
        "-t {input.nodes_dmp} "
        "-n {input.names_dmp} "
        "-r $rank "
        "-o {params.out_prefix}.$rank.{params.out_suffix} "
        "{input.kaiju_out};done "
        "&>{log}"

rule kaiju_names:
    input:
        kaiju_out = rules.kaiju_classify.output.kaiju_out,
        nodes_dmp = config["kaiju"]["nodes_dmp"],
        names_dmp = config["kaiju"]["names_dmp"],
    output:
        kaiju_names = "results/{sample}/kaiju/{sample}.kaiju.names.out"
    threads: 1
    log:
        "results/logs/{sample}.kaiju_names.log"
    conda:
        "../envs/kaiju.yaml"
    shell:
        "kaiju-addTaxonNames "
        "-t {input.nodes_dmp} "
        "-n {input.names_dmp} "
        "-i {input.kaiju_out} "
        "-o {output.kaiju_names} "
        "&>{log}"

