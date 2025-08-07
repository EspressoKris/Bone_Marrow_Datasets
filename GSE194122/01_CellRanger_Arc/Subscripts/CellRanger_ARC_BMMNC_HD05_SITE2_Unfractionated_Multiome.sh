#!/bin/bash
#SBATCH --job-name=CellRanger_arc_BMMNC_HD05_SITE2_Unfractionated_Multiome
#SBATCH --output=Reports/Report-%x.%j.out
#SBATCH --error=Reports/Report-%x.%j.err
#SBATCH --time=144:00:00
#SBATCH --ntasks=24
#SBATCH --mem=80G
#SBATCH --partition=long
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=kristian.gurashi@ndcls.ox.ac.uk

############################################################################## 
# Loading packages
############################################################################## 

module load cellranger-arc/2.0.2

############################################################################## 

# Go to output directory
cd /path/to/data/GSE194122_Healthy_BMMNCs_scMultiome/Data/Mapped_Data

cellranger-arc count --id=BMMNC_HD05_SITE2_Unfractionated_Multiome                      --reference=/databank/10x-rangers/refdata-cellranger-arc-GRCh38-2020-A-2.0.0                      --libraries=/path/to/data/GSE194122_Healthy_BMMNCs_scMultiome/Data/CellRanger_Libraries/BMMNC_HD05_SITE2_Unfractionated_Multiome.csv                      --localcores=24                      --localmem=80

# Report progress
echo "Successfully processed: BMMNC_HD05_SITE2_Unfractionated_Multiome";

