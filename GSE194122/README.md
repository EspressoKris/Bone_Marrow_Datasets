# GSE194122 - Healthy BMMNCs scMultiome

## Dataset Information

**GEO Accession:** GSE194122  
**Title:** Healthy bone marrow mononuclear cells single-cell multiome  
**Technology:** 10x Genomics Multiome (scRNA-seq + scATAC-seq)  
**Organism:** Homo sapiens  
**Sample Type:** Primary bone marrow mononuclear cells  

## Study Design

- **Donors:** Multiple healthy donors
- **Sites:** 4 different collection sites  
- **Sample Processing:** Frozen bone marrow mononuclear cells
- **Data Types:** Gene expression (GEX) and chromatin accessibility (ATAC)

## Files in this Directory

- `Donors_metadata.txt` - Detailed sample metadata
- `Study_metadata.txt` - Study-level information
- `00_Download/` - Scripts for downloading raw data (BAM) from SRA and convert them back to fastq for re-alignment
- `CellRanger_Libraries/` - Library configuration files for each sample
- `01_CellRanger_Arc/` - CellRanger processing pipeline

## Processing Pipeline

1. **Download:** Use scripts in `00_Download/` to fetch raw data
2. **Configure:** Library files in `CellRanger_Libraries/` specify input paths
3. **Process:** Run CellRanger ARC pipeline in `01_CellRanger_Arc/`

## Sample Naming Convention

- Format: `BMMNC_HD##_SITE#_Unfractionated_Multiome`
- HD## = Healthy Donor number
- SITE# = Collection site number
