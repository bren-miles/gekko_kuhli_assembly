#!/bin/bash
#SBATCH --job-name=kuhli_HiFi
#SBATCH --cpus-per-task=8
#SBATCH --mem=32g
#SBATCH --gres=lscratch:500
#SBATCH --time=12:00:00
#SBATCH --output=kuhli_19_%j.out
#SBATCH --error=kuhli_19_%j.err
#SBATCH --mail-type=ALL

set -euo pipefail

module load sratoolkit/3.3.0

OUTDIR="/data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli"
TMPDIR="/lscratch/$SLURM_JOB_ID"

mkdir -p "$OUTDIR"

#Download SRA
prefetch --max-size 70g SRR15168719

#SRR15168719
fasterq-dump SRR15168719 \
        --threads "$SLURM_CPUS_PER_TASK" \
        --temp "$TMPDIR" \
        --outdir "$OUTDIR"

gzip -k /data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/SRR15168719.fastq
