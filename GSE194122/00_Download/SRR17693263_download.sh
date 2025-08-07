#!/bin/bash
#SBATCH --job-name=SRR17693263_download
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

sra='SRR17693263'
gsm='GSM5828483'

############################################################################## 
# Creating directories
############################################################################## 

output_dir="/path/to/data/GSE194122_Healthy_BMMNCs_scMultiome/Data/Raw_Data/ATAC/${sra}_${gsm}"
mkdir -p $output_dir

############################################################################## 
# Running SRAToolkit
##############################################################################

cd ${output_dir}

file_name="site1_donor03_multiome_atac.possorted_bam.bam.1"

wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/run/SRR176/SRR17693263/site1_donor03_multiome_atac.possorted_bam.bam.1 -O ${sra}_${gsm}_$file_name
wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/run/SRR176/SRR17693263/site1_donor03_multiome_atac.possorted_bam.bam.1.bai -O ${sra}_${gsm}_${file_name}.bai

md5=$(md5sum ${sra}_${gsm}_$file_name | cut -c -32)

if [ ${md5} == 'c8c7ef4439a3fbb5f00c033e0b9602e5' ]; then
    cellranger bamtofastq --nthreads=12 ${sra}_${gsm}_$file_name ${sra}_${gsm}
    rm -rf ${output_dir}/${sra}_${gsm}_${file_name}
    rm -rf ${output_dir}/${sra}_${gsm}_${file_name}.bai
fi


