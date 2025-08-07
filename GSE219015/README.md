# GSE219015 - Healthy BMMNCs and CD34+ enriched BMMNCs scMultiome

## Dataset Information

**GEO Accession:** GSE219015  
**Title:** Healthy bone marrow mononuclear cells and CD34+ enriched cells single-cell multiome  
**Technology:** 10x Genomics Multiome (scRNA-seq + scATAC-seq)  
**Organism:** Homo sapiens  
**Sample Types:** 
- Unfractionated bone marrow mononuclear cells
- CD34+ enriched bone marrow cells

## Study Design

- **Donors:** Young and aged healthy donors
- **Age Groups:** Young (HD01, HD02) and Aged (HD01, HD02)
- **Cell Types:** 
  - Unfractionated BMMNCs
  - CD34+ enriched cells (hematopoietic stem/progenitor cells)
- **Data Types:** Gene expression (GEX) and chromatin accessibility (ATAC)

## Files in this Directory

- `00_Download/` - Scripts for downloading raw data from SRA
- `CellRanger_Libraries/` - Library configuration files for each sample
- `01_CellRanger_Arc/` - CellRanger processing pipeline

## Processing Pipeline

1. **Download:** Use scripts in `00_Download/` to fetch raw data
2. **Configure:** Library files in `CellRanger_Libraries/` specify input paths
3. **Process:** Run CellRanger ARC pipeline in `01_CellRanger_Arc/`

## Sample Naming Convention

- Format: `BMMNC_{Age}_HD##_{CellType}_Multiome`
- Age: Young or Aged
- HD##: Healthy Donor number
- CellType: Unfractionated or CD34_Enriched

## Sample Overview

| Age Group | Donor | Unfractionated | CD34+ Enriched |
|-----------|-------|----------------|----------------|
| Young     | HD01  | ✓              | ✓              |
| Young     | HD02  | ✓              | ✓              |
| Aged      | HD01  | ✓              | ✓              |
| Aged      | HD02  | ✓              | ✓              |
