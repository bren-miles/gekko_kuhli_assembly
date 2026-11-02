#!/bin/bash
#SBATCH --job-name=kuhli_sra
#SBATCH --cpus-per-task=8
#SBATCH --mem=32g
#SBATCH --gres=lscratch:500
#SBATCH --time=12:00:00
#SBATCH --output=kuhli_18_%j.out
#SBATCH --error=kuhli_18_%j.err
#SBATCH --mail-type=ALL

set -euo pipefail

module load sratoolkit/3.3.0

OUTDIR="/data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli"
TMPDIR="/lscratch/$SLURM_JOB_ID"

mkdir -p "$OUTDIR"

#Download SRA
prefetch SRR15168718

#SRR15168718
fasterq-dump SRR15168718 \
        --split-files \
        --threads "$SLURM_CPUS_PER_TASK" \
        --temp "$TMPDIR" \
        --outdir "$OUTDIR"

gzip -k /data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/SRR15168718_1.fastq

gzip -k /data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/SRR15168718_2.fastq
