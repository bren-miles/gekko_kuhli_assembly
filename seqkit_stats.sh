#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1          # Match node CPU cores
#SBATCH --cpus-per-task=8
#SBATCH --output=/data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/seqkit.out
#SBATCH --mem=100G
#SBATCH --time=09-00:00
#SBATCH --job-name=fastqc
#SBATCH --export=NONE
#SBATCH --mail-type=ALL

source myconda
mamba activate hifi_env

export currentDir=/data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/seqkit
export jobdir=$currentDir/outdir_seqkit

mkdir -p $jobdir
cd $jobdir
mkdir -p logs_%j

mkdir -p /data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/tmp_seqkit

seqkit stats /data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/*.fastq -o seqkit_results.tsv
