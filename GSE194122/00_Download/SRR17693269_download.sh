#!/bin/bash
#SBATCH --job-name=SRR17693269_download
#SBATCH --output=Report-%x.%j.out
#SBATCH --error=Report-%x.%j.err
#SBATCH --time=24:00:00
#SBATCH --ntasks=12
#SBATCH --mem=50G
#SBATCH --partition=short

############################################################################## 
# Loading packages
############################################################################## 

module load cellranger/8.0.1

sra='SRR17693269'
gsm='GSM5828477'

############################################################################## 
# Creating directories
############################################################################## 

output_dir="/path/to/data/GSE194122_Healthy_BMMNCs_scMultiome/Data/Raw_Data/GEX/${sra}_${gsm}"
mkdir -p $output_dir

############################################################################## 
# Running SRAToolkit
##############################################################################

cd ${output_dir}

file_name="site3_donor07_multiome_gex.possorted_genome_bam.bam"

wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/run/SRR176/SRR17693269/site3_donor07_multiome_gex.possorted_genome_bam.bam -O ${sra}_${gsm}_$file_name
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/run/SRR176/SRR17693269/site3_donor07_multiome_gex.possorted_genome_bam.bam.bai -O ${sra}_${gsm}_${file_name}.bai

md5=$(md5sum ${sra}_${gsm}_$file_name | cut -c -32)

if [ ${md5} == '6e1217af07c21a58de69dbf6112a8f9d' ]; then
    cellranger bamtofastq --nthreads=12 ${sra}_${gsm}_$file_name ${sra}_${gsm}
    rm -rf ${output_dir}/${sra}_${gsm}_${file_name}
    rm -rf ${output_dir}/${sra}_${gsm}_${file_name}.bai
fi


