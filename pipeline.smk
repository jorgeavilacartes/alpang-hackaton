configfile: "params.yml"

from pathlib import Path
from os.path import join as pjoin

# parameters
PATH_DATA=config["PATH_DATA"]
PATH_OUTPUT=config["PATH_OUTPUT"]

TECHNOLOGY=config["TECHNOLOGY"]

NAMES_GFA=[p.stem for p in Path(PATH_DATA).rglob("*.gfa")] 
print(NAMES_GFA)

NAMES_READS=[p.stem for p in Path(PATH_DATA).joinpath(TECHNOLOGY).rglob("*.fastq") ]
print(NAMES_READS)

rule run:
    input: 
        expand(
            pjoin( PATH_OUTPUT,"{gfa}.{technology}.{reads}.json"),
            gfa=NAMES_GFA,
            technology=config["TECHNOLOGY"],
            reads=NAMES_READS
        )

rule graph_aligner:
    input:
        graph=pjoin( PATH_DATA, "{gfa}.gfa"),
        reads=pjoin( PATH_DATA, "{technology}", "{reads}.fastq")
    output:
        json=pjoin( PATH_OUTPUT,"{gfa}.{technology}.{reads}.json")
    threads:
        16
    conda:
        "envs/graphaligner.yml"
    shell:
        "GraphAligner -g {input.graph} -f {input.reads} -x vg -a {output.json} -t {threads}"