# alpang-hackaton
Workflow to use GraphAligner and PanAligner

### 1. Create an environment to run snakemake
```bash
mamba env create -n smk -f envs/snakemake.yml
mamba activate smk
```

### 2. Run the snakemake pipeline
```bash
snakemake -s pipeline.smk -c16 --use-conda
```