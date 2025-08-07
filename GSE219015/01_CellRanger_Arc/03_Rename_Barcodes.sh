#!/bin/bash
#SBATCH --job-name=GSE219015_Rename_CellRanger_Bams
#SBATCH --output=Report-%x.%j.out
#SBATCH --error=Report-%x.%j.err
#SBATCH --time=24:00:00
#SBATCH --ntasks=1
#SBATCH --mem=20G
#SBATCH --partition=long
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=kristian.gurashi@ndcls.ox.ac.uk

############################################################################## 
# Loading packages
############################################################################## 

module load samtools/1.17

############################################################################## 

cd /path/to/data/GSE219015_Healthy_BMMNCs_and_CD34_enriched_BMMNCs_scMultiome/Scripts/01_CellRanger_Arc

# Rename GEX

# Read the CSV file, skipping the first row
tail -n +2 Sample_sheet.csv | while IFS=',' read -r Sample GEX_bam ATAC_bam
do
    # Print the current line for debugging
    echo "Read line: Sample=$Sample, GEX_bam=$GEX_bam, ATAC_bam=$ATAC_bam"

    # Get output folder path
    input_bam="${GEX_bam}/gex_possorted_bam.bam"
    output_bam="${GEX_bam}/Renamed_gex_possorted_bam.bam"

    echo "Processing sample: $Sample"
    echo "Input GEX BAM file: $input_bam"
    echo "Output BAM file: $output_bam"
done

    # Process the BAM file and measure time
    start_time=$(date +%s)
    samtools view -h "$input_bam" | \
    awk -v sample="$Sample" 'BEGIN {OFS="\t"} {if ($0 ~ /^@/) {print $0} else {for (i=1; i<=NF; i++) {if ($i ~ /^CB:Z:/) {$i=substr($i, 1, 19)"_"sample"_GEX"}} print $0}}' | \
    samtools view -b -o "$output_bam"
    end_time=$(date +%s)

    # Calculate and print the completion time
    elapsed_time=$((end_time - start_time))
    echo "Elapsed time: $elapsed_time seconds"

    # Print completion message for the current sample
    echo "Completed processing for sample: $Sample"
    echo "----------------------------------------"
done