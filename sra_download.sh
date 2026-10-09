#!/bin/bash
#SBATCH --job-name=kuhli_HiFi
#SBATCH --cpus-per-task=8
#SBATCH --mem=32g
#SBATCH --gres=lscratch:500
#SBATCH --time=12:00:00
#SBATCH --output=kuhli_sra_%j.out
#SBATCH --error=kuhli_sra_%j.err
#SBATCH --mail-type=ALL

set -euo pipefail

module load sratoolkit
module load pigz

OUTDIR="/data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli"
TMPDIR="/lscratch/$SLURM_JOB_ID"

mkdir -p "$OUTDIR"

#Download SRAs
prefetch --max-size 70g SRR15168718
prefetch --max-size 70g SRR15168719
prefetch --max-size 70g SRR15168720

#SRR15168718
fasterq-dump SRR15168718 \
        --split-files \
        --threads "$SLURM_CPUS_PER_TASK" \
        --temp "$TMPDIR" \
        --outdir "$OUTDIR"

#SRR15168719
fasterq-dump SRR15168719 \
        --split-files \
        --threads "$SLURM_CPUS_PER_TASK" \
        --temp "$TMPDIR" \
        --outdir "$OUTDIR"

#SRR15168720
fasterq-dump SRR15168720 \
        --split-files \
        --threads "$SLURM_CPUS_PER_TASK" \
        --temp "$TMPDIR" \
        --outdir "$OUTDIR"

#Compress FASTQ files
pigz -p "$SLURM_CPUS_PER_TASK" \
    "$OUTDIR"/SRR15168718.fastq \
    "$OUTDIR"/SRR15168719.fastq \
    "$OUTDIR"/SRR15168720.fastq

echo
echo "Final files:"
ls -lh "$outdir"/SRR151687*.fastq.gz

echo
echo "Job finished: $(date)"
