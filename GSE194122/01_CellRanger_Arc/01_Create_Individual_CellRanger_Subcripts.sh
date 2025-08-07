#!/bin/bash
#SBATCH --job-name=Generate_CellRanger_ARC_scripts
#SBATCH --output=Reports/Report-%x.%j.out
#SBATCH --error=Reports/Report-%x.%j.err
#SBATCH --time=08:00:00
#SBATCH --ntasks=1
#SBATCH --mem=1G
#SBATCH --partition=long
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=YOUR_EMAIL@INSTITUTION.EDU

##############################################################################
# Code to create CellRanger scripts iterations
############################################################################## 

# CONFIGURE THESE PATHS FOR YOUR ENVIRONMENT
input_dir="CELLRANGER_LIBRARIES_PATH"
script_dir="SCRIPTS_OUTPUT_PATH" 
output_dir="MAPPED_DATA_OUTPUT_PATH"
mkdir -p "$script_dir"
mkdir -p "$output_dir"

##############################################################################
# Code to create CellRanger scripts iterations
############################################################################## 

# Create a script for running cellranger
generate_cellranger_arc_script() {
    local sample="$1"
    local library="$2"
    local script_title="$3"

    cat <<EOF > "$script_title"
#!/bin/bash
#SBATCH --job-name=CellRanger_arc_${sample}
#SBATCH --output=Reports/Report-%x.%j.out
#SBATCH --error=Reports/Report-%x.%j.err
#SBATCH --time=144:00:00
#SBATCH --ntasks=24
#SBATCH --mem=80G
#SBATCH --partition=long
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --mail-user=YOUR_EMAIL@INSTITUTION.EDU

############################################################################## 
# Loading packages
############################################################################## 

module load cellranger-arc/2.0.2

############################################################################## 

# Go to output directory
cd $output_dir

cellranger-arc count --id=${sample} \
                     --reference='/databank/10x-rangers/refdata-cellranger-arc-GRCh38-2020-A-2.0.0' \
                     --libraries=${library} \
                     --localcores=24 \
                     --localmem=80

# Report progress
echo "Successfully processed: $sample";

EOF
}

##############################################################################
# Running Souporcell scripts iterations
############################################################################## 

# rm -r ${script_dir}/*
mkdir -p "${script_dir}/Reports"

# Array to store job IDs
declare -a job_ids

folder="${input_dir}"

for file in $folder/*; do
        sample_name=$(basename "$file")
        sample_part=$(echo "$sample_name" | sed 's/Sample_\(.*\)_libraries/\1/' | sed 's/\.csv$//')
        
        echo "$sample_part"
        echo $file
        
        # Generate and run CellRanger script
        generate_cellranger_arc_script "$sample_part" "$file" "${script_dir}/CellRanger_ARC_${sample_part}.sh"

        echo "# Generated script for ${sample_part}!"
done