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
