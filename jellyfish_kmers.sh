#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1          # Match node CPU cores
#SBATCH --cpus-per-task=8
#SBATCH --output=/data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/all_kmer_count.out
#SBATCH --mem=200G
#SBATCH --time=09-00:00
#SBATCH --job-name=jellyfish
#SBATCH --export=NONE
#SBATCH --mail-type=ALL

source myconda
mamba activate hifi_env
module load jellyfish

export currentDir=/data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/all_kmers
export jobdir=$currentDir/outdir_kmer

mkdir -p $jobdir
cd $jobdir
mkdir -p logs_%j

mkdir -p /data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/tmp_all_kmer

jellyfish count -m 21 -s 100M -t $SLURM_CPUS_PER_TASK -C \
/data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/SRR15168719.fastq

jellyfish histo mer_counts.jf
