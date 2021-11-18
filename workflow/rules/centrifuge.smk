rule centrifuge_classify:
    input: 
        fqs = get_fqs,
    output:
        cf_out = "results/{sample}/centrifuge/{sample}.centrifuge.out",
        cf_report = "results/{sample}/centrifuge/{sample}.centrifuge_report.tsv"        
    log:
        "results/logs/{sample}_centrifuge.log"
    params:
        cf_index = config["centrifuge"]["index"]
    threads: 8
    conda:
        "../envs/centrifuge.yaml"
    benchmark:
        "results/benchmarks/{sample}.centrifuge.tsv"
    shell:
        "centrifuge -x {params.cf_index} "
        "-p {threads} "
        "-1 {input.fqs[0]} -2 {input.fqs[1]} "
        "-S {output.cf_out} "
        "--report-file {output.cf_report} "
        "&>{log}"
