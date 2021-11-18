rule kaiju_classify:
    input:
        fqs = get_fqs,
        nodes_dmp = config["kaiju"]["nodes_dmp"],
        fmi = config["kaiju"]["index"]
    output:
        kaiju_out = "results/{sample}/kaiju/{sample}.kaiju.out"
    threads: 8
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
        "-o {output.kaiju_out} "
        "&>{log}"

