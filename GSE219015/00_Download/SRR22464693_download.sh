#!/bin/bash
#SBATCH --job-name=SRR22464693_download
#SBATCH --output=Report-%x.%j.out
#SBATCH --error=Report-%x.%j.err
#SBATCH --time=24:00:00
#SBATCH --ntasks=12
#SBATCH --mem=50G
#SBATCH --partition=short

############################################################################## 
# Loading packages
############################################################################## 

source /path/to/user/kgurashi/miniconda3/etc/profile.d/conda.sh
conda activate sratoolkit

############################################################################## 
# Creating directories
############################################################################## 

output_dir="/path/to/data/GSE219015_Healthy_BMMNCs_and_CD34_enriched_BMMNCs_scMultiome/Data/Raw_Data/BMMNC_Aged_HD02/CD34_Enriched_Multiome/RNA"

############################################################################## 
# Running SRAToolkit
##############################################################################

sra="SRR22464693"

cd ${output_dir}

# prefetch ${sra} -O ${output_dir} --max-size 500g

# vdb-validate ${output_dir}/${sra}/${sra}.sra

parallel-fastq-dump --tmpdir ${output_dir} --threads 12 --gzip --split-files --sra-id ${sra}