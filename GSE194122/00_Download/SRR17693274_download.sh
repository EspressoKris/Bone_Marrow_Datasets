#!/bin/bash
#SBATCH --job-name=SRR17693274_download
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

sra='SRR17693274'
gsm='GSM5828472'

############################################################################## 
# Creating directories
############################################################################## 

output_dir="/path/to/data/GSE194122_Healthy_BMMNCs_scMultiome/Data/Raw_Data/GEX/${sra}_${gsm}"
mkdir -p $output_dir

############################################################################## 
# Running SRAToolkit
##############################################################################

cd ${output_dir}

file_name="site2_donor04_multiome_gex.possorted_genome_bam.bam.1"

# wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/run/SRR176/SRR17693274/site2_donor04_multiome_gex.possorted_genome_bam.bam.1 -O ${sra}_${gsm}_$file_name
# wget -nc ftp://ftp.sra.ebi.ac.uk/vol1/run/SRR176/SRR17693274/site2_donor04_multiome_gex.possorted_genome_bam.bam.1.bai -O ${sra}_${gsm}_${file_name}.bai

md5=$(md5sum ${sra}_${gsm}_$file_name | cut -c -32)

if [ ${md5} == '26260e586c229c0aeb84505f1325c72a' ]; then
    cellranger bamtofastq --nthreads=12 ${sra}_${gsm}_$file_name ${sra}_${gsm}
    rm -rf ${output_dir}/${sra}_${gsm}_${file_name}
    rm -rf ${output_dir}/${sra}_${gsm}_${file_name}.bai
fi


