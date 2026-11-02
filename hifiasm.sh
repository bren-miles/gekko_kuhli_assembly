#!/bin/bash
#SBATCH --cpus-per-task=64
#SBATCH --mem=400g
#SBATCH --gres=lscratch:900
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --time=48:00:00
#SBATCH --job-name=hifiasm

source myconda

mamba activate hifi_env

PREFIX="gekko_kuhli_11-01-26"
HiFi='/data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/SRR15168719.fastq.gz'
HiC1='/data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/SRR15168718_1.fastq.gz'
HiC2='/data/Wilson_Lab/projects/Group_Genome_Assembly/Gekko_kuhli/SRR15168718_2.fastq.gz'

#HiFi + HiC
hifiasm -o $PREFIX\.asm -t64 --h1 ${HiC1} --h2 ${HiC2} ${HiFi}

#convert to FASTA
gfatools gfa2fa $PREFIX\.asm.hic.hap1.p_ctg.gfa | seqkit sort -l -r > $PREFIX\.asm.hic.hap1.p_ctg.fa
gfatools gfa2fa $PREFIX\.asm.hic.hap2.p_ctg.gfa | seqkit sort -l -r > $PREFIX\.asm.hic.hap2.p_ctg.fa
