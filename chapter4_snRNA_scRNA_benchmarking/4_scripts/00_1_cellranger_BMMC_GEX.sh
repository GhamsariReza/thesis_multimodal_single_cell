#!/bin/bash

#SBATCH --cpus-per-task=32
#SBATCH --mem=124G
#SBATCH --time=48:00:00
#SBATCH --job-name=cellranger_BMMC
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ghamsari.r@wehi.edu.au
#SBATCH --output /stornext/General/data/user_managed/grpu_mritchie_1/reza/projects/mat_seq/BMMC_luecken/cellranger_outputs/run_history/bmmc_cellranger-GEX_o.%j.%N.log
#SBATCH --error /stornext/General/data/user_managed/grpu_mritchie_1/reza/projects/mat_seq/BMMC_luecken/cellranger_outputs/run_history/bmmc_cellranger-GEX_e.%j.%N.log





#path to script:  sbatch /stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/python_projects/scmix2/BMMC_public_multiome/cellranger_BMMC_GEX.sh
#=============================================================================
# Sample Processing History and Job IDs
#=============================================================================
# This script processes multiple samples iteratively. Each execution processes
# a specific sample by uncommenting the relevant BAM_FILE and DIR_OUT variables.
# EXECUTION HISTORY:
# Site 1 Samples:
# - site1_donor01_multiome_gex.possorted_genome_bam.bam.1 -> site1_donor1_GEX (Job: 13257994)
# - site1_donor01_cite.possorted_genome_bam.bam.1 -> site1_donor1_cite (Job: 13258002)
# - site1_donor02_cite.possorted_bam.bam.1 -> site1_donor2_cite (Job: 13258008)
# - site1_donor02_multiome_gex.possorted_bam.bam.1 -> site1_donor2_GEX (Job: 13258020)
# - site1_donor03_cite.possorted_bam.bam.1 -> site1_donor3_cite (Job: 13258023)
# - site1_donor03_multiome_gex.possorted_bam.bam.1 -> site1_donor3_GEX (Job: 13258045)

# Site 2 Samples:
# - site2_donor01_cite.possorted_genome_bam.bam.1 -> site2_donor1_cite (Job: 13258049)
# - site2_donor01_multiome_gex.possorted_genome_bam.bam.1 -> site2_donor1_GEX (Job: 13258055)
# - site2_donor04_cite.possorted_genome_bam.bam.1 -> site2_donor4_cite (Job: 13258059)
# - site2_donor04_multiome_gex.possorted_genome_bam.bam.1 -> site2_donor4_GEX (Job: 13258080)
# - site2_donor05_cite.possorted_genome_bam.bam.1 -> site2_donor5_cite (Job: 13258087)
# - site2_donor05_multiome_gex.possorted_genome_bam.bam.1 -> site2_donor5_GEX (Job: 13258091)

# Site 3 Samples:
# - site3_donor01_cite.possorted_genome_bam.bam.1 -> site3_donor1_cite (Job: 13258102)
# - site3_donor03_multiome_gex.possorted_genome_bam.bam.1 -> site3_donor3_GEX (Job: 13258109)
# - site3_donor06_cite.possorted_genome_bam.bam.1 -> site3_donor6_cite (Job: 13258120)
# - site3_donor06_multiome_gex.possorted_genome_bam.bam.1 -> site3_donor6_GEX (Job: 13258132)
# - site3_donor07_cite.possorted_genome_bam.bam.1 -> site3_donor7_cite (Job: 13258140)
# - site3_donor07_multiome_gex.possorted_genome_bam.bam.1 -> site3_donor7_GEX (Job: 13258148)
# - site3_donor10_multiome_gex.possorted_genome_bam.bam.1 -> site3_donor10_GEX (Job: 13258154)

# Site 4 Samples:
# - site4_donor01_cite.possorted_genome_bam.bam.1 -> site4_donor1_cite (Job: 13258159)
# - site4_donor01_multiome_gex.possorted_genome_bam.bam.1 -> site4_donor1_GEX (Job: 13258165)
# - site4_donor08_cite.possorted_genome_bam.bam.1 -> site4_donor8_cite (Job: 13258173)
# - site4_donor08_multiome_gex.possorted_genome_bam.bam.1 -> site4_donor8_GEX (Job: 13258179)
# - site4_donor09_cite.possorted_genome_bam.bam.1 -> site4_donor9_cite (Job: 13258184)
# - site4_donor09_multiome_gex.possorted_genome_bam.bam.1 -> site4_donor9_GEX (Job: 13258194)


#=============================================================================
# Sample Configuration (Uncomment for current execution)
#=============================================================================
# Set these variables for the current sample to process:

# BAM_FILE=site1_donor01_multiome_gex.possorted_genome_bam.bam.1
# DIR_OUT=site1_donor1_GEX


#=============================================================================
# Environment Setup
#=============================================================================
module purge
module load cellranger/7.1.0

# Define paths
C_RANGER_PATH="/vast/scratch/users/ghamsari.r/BMMC_luecken/cellranger_outputs"
WORK_PATH="/vast/scratch/users/ghamsari.r/fastqfiles_bmmc/bamtofastq_outputs"

#=============================================================================
# PHASE 1: BAM to FASTQ Conversion (Uncomment when needed)
#=============================================================================
# Convert BAM files to FASTQ format using Cell Ranger bamtofastq

# BAM_PATH="/vast/scratch/users/ghamsari.r/bamfiles_bmmc/$BAM_FILE"
# mkdir -p "$WORK_PATH/"
# cd "$WORK_PATH/"
# 
# cellranger bamtofastq \
#     --nthreads=8 \
#     "$BAM_PATH" \
#     "$WORK_PATH/$DIR_OUT"
#=============================================================================
# PHASE 2: Gene Expression Quantification
#=============================================================================
# Perform gene expression quantification using Cell Ranger count

mkdir -p "$C_RANGER_PATH/count_outputs/"
cd "$C_RANGER_PATH/count_outputs"

# Reference genome path
TRANSCRIPTOME="/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0"


#-----------------------------------------------------------------------------
# Site 1 Sample Processing (Uncomment as needed)
#-----------------------------------------------------------------------------

# Site 1, Donor 1 - Cell surface proteins
# ID="S1_D1_Cell"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site1_donor1_cite/site1_donor1_0_1_HCW5FDRXY,$WORK_PATH/site1_donor1_cite/site1_donor1_1_1_HCW5FDRXY"
# Job ID: 13259677

# Site 1, Donor 1 - Gene expression (nuclei)
# ID="S1_D1_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site1_donor1_GEX/libraries_neurips_site1_donor1_0_1_HFMHTDRXY" \
#                  --chemistry=ARC-v1
# Job ID: 13260248

# Site 1, Donor 2 - Cell surface proteins
# ID="S1_D2_cell"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site1_donor2_cite/site1_donor2_0_1_HCW5FDRXY,$WORK_PATH/site1_donor2_cite/site1_donor2_1_1_HCW5FDRXY"
# Job ID: 13260352

# Site 1, Donor 2 - Gene expression (nuclei)
# ID="S1_D2_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site1_donor2_GEX/libraries_neurips_site1_donor2_0_1_HFMHTDRXY" \
#                  --chemistry=ARC-v1
# Job ID: 13260389

# Site 1, Donor 3 - Cell surface proteins
# ID="S1_D3_cell"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site1_donor3_cite/site1_donor3_0_1_HCW5FDRXY,$WORK_PATH/site1_donor3_cite/site1_donor3_1_1_HCW5FDRXY"
# Job ID: 13260453

# Site 1, Donor 3 - Gene expression (nuclei)
# ID="S1_D3_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site1_donor3_GEX/libraries_neurips_site1_donor3_0_1_HFMHTDRXY" \
#                  --chemistry=ARC-v1
# Job ID: 13260508

#-----------------------------------------------------------------------------
# Site 2 Sample Processing (Uncomment as needed)
#-----------------------------------------------------------------------------

# Site 2, Donor 1 - Cell surface proteins
# ID="S2_D1_cell"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site2_donor1_cite/site2_donor1_0_1_HFYF3DSX2,$WORK_PATH/site2_donor1_cite/site2_donor1_1_1_HFYF3DSX2"
# Job ID: 13260573

# Site 2, Donor 1 - Gene expression (nuclei)
# ID="S2_D1_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site2_donor1_GEX/libraries_neurips_site2_donor1_0_1_HG2YYDSX2" \
#                  --chemistry=ARC-v1
# Job ID: 13260618

# Site 2, Donor 4 - Cell surface proteins
# ID="S2_D4_cell"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site2_donor4_cite/site_0_1_HG2YYDSX2,$WORK_PATH/site2_donor4_cite/site_1_1_HG2YYDSX2"
# Job ID: 13260767

# Site 2, Donor 4 - Gene expression (nuclei)
# ID="S2_D4_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site2_donor4_GEX/libraries_neurips_site2_donor4_0_1_HG2YYDSX2" \
#                  --chemistry=ARC-v1
# Job ID: 13260798

# Site 2, Donor 5 - Cell surface proteins
# ID="S2_D5_cell"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site2_donor5_cite/site2_donor5_0_1_HFYF3DSX2,$WORK_PATH/site2_donor5_cite/site2_donor5_1_1_HFYF3DSX2"
# Job ID: 13260854

# Site 2, Donor 5 - Gene expression (nuclei)
# ID="S2_D5_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site2_donor5_GEX/site2_donor5_0_1_HG3FLDSX2" \
#                  --chemistry=ARC-v1
# Job ID: 13260884

#-----------------------------------------------------------------------------
# Site 3 Sample Processing (Uncomment as needed)
#-----------------------------------------------------------------------------

# Site 3, Donor 1 - Cell surface proteins
# ID="S3_D1_cell"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site3_donor1_cite/site3_donor1_0_1_AAAHK5JHV,$WORK_PATH/site3_donor1_cite/site3_donor1_1_1_AAAHK5JHV"
# Job ID: 13261045

# Site 3, Donor 3 - Gene expression (nuclei)
# ID="S3_D3_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site3_donor3_GEX/site3_donor3_new_and_old_combined_0_1_AAAHK5JHV,$WORK_PATH/site3_donor3_GEX/site3_donor3_new_and_old_combined_0_1_AAAHK7LHV" \
#                  --chemistry=ARC-v1
# Job ID: 13261131

# Site 3, Donor 6 - Cell surface proteins
# ID="S3_D6_cell"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site3_donor6_cite/site3_donor6_0_1_HJYW7BGXJ,$WORK_PATH/site3_donor6_cite/site3_donor6_1_1_HJYW7BGXJ"
# Job ID: 13261194

# Site 3, Donor 6 - Gene expression (nuclei)
# ID="S3_D6_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site3_donor6_GEX/site3_donor6_0_1_AAAH5N3HV" \
#                  --chemistry=ARC-v1
# Job ID: 13261298

# Site 3, Donor 7 - Cell surface proteins
# ID="S3_D7_cell"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site3_donor7_cite/site3_donor7_0_1_HJYW7BGXJ,$WORK_PATH/site3_donor7_cite/site3_donor7_1_1_HJYW7BGXJ"
# Job ID: 13261324

# Site 3, Donor 7 - Gene expression (nuclei)
# ID="S3_D7_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site3_donor7_GEX/site3_donor7_atac_and_gex_from_old_and_new_0_1_AAAHK5JHV,$WORK_PATH/site3_donor7_GEX/site3_donor7_atac_and_gex_from_old_and_new_0_1_AAAHK7LHV" \
#                  --chemistry=ARC-v1
# Job ID: 13261373

# Site 3, Donor 10 - Gene expression (nuclei)
# ID="S3_D10_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site3_donor10_GEX/site3_donor10_new_and_old_combined_0_1_AAAHK5JHV,$WORK_PATH/site3_donor10_GEX/site3_donor10_new_and_old_combined_0_1_AAAHK7LHV" \
#                  --chemistry=ARC-v1
# Job ID: 13260997

#-----------------------------------------------------------------------------
# Site 4 Sample Processing (Uncomment as needed)
#-----------------------------------------------------------------------------

# Site 4, Donor 1 - Cell surface proteins
# ID="S4_D1_cell"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site4_donor1_cite/site4_donor1_0_1_HTHL2BGXJ,$WORK_PATH/site4_donor1_cite/site4_donor1_1_1_AAAHJVCHV"
# Job ID: 13261422

# Site 4, Donor 1 - Gene expression (nuclei)
# ID="S4_D1_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site4_donor1_GEX/site4_donor1_0_1_AAAH7CNHV" \
#                  --chemistry=ARC-v1
# Job ID: 13261605

# Site 4, Donor 8 - Cell surface proteins
# ID="S4_D8_cell"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site4_donor8_cite/site4_donor8_0_1_HTHL2BGXJ,$WORK_PATH/site4_donor8_cite/site4_donor8_1_1_AAAHJVCHV"
# Job ID: 13262090

# Site 4, Donor 8 - Gene expression (nuclei)
# ID="S4_D8_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site4_donor8_GEX/site4_donor8_0_1_AAAHCHWHV,$WORK_PATH/site4_donor8_GEX/site4_donor8_0_1_HNV5LBGXJ" \
#                  --chemistry=ARC-v1
# Job ID: 13262313

# Site 4, Donor 9 - Cell surface proteins
# ID="S4_D9_cell"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site4_donor9_cite/site4_donor9_0_1_HTKMJBGXJ,$WORK_PATH/site4_donor9_cite/site4_donor9_1_1_HTGTNBGXJ"
# Job ID: 13262360

# Site 4, Donor 9 - Gene expression (nuclei)
# ID="S4_D9_Nuclei"
# cellranger count --id="$ID" \
#                  --transcriptome="$TRANSCRIPTOME" \
#                  --fastqs="$WORK_PATH/site4_donor9_GEX/site4_donor9_0_1_HTGWKBGXJ" \
#                  --chemistry=ARC-v1
# Job ID: 13262623


#=============================================================================
# PHASE 3: Web Summary Collection
#=============================================================================
# Collect all web summary reports in a centralized directory

# INPUTS_PATH="$C_RANGER_PATH/count_outputs"
# ALL_WEB_SUMMARY_DIR="$C_RANGER_PATH/count_outputs/all_web_summary_bmmc"
# mkdir -p "$ALL_WEB_SUMMARY_DIR"
# 
# # Copy web summary files with descriptive names
# for subdir in "$INPUTS_PATH"/*/; do
#     if [ -d "$subdir" ]; then
#         subdir_name=$(basename "$subdir")
#         web_summary_file="$INPUTS_PATH/$subdir_name/outs/web_summary.html"
#         
#         if [ -f "$web_summary_file" ]; then
#             new_filename="web_summary_${subdir_name}.html"
#             cp "$web_summary_file" "${ALL_WEB_SUMMARY_DIR}/${new_filename}"
#             echo "Copied $web_summary_file to ${ALL_WEB_SUMMARY_DIR}/${new_filename}"
#         else
#             echo "Web summary not found in $INPUTS_PATH/$subdir_name"
#         fi
#     fi
# done



#=============================================================================
# PHASE 4: Sample Aggregation
#=============================================================================
# Aggregate all processed samples using Cell Ranger Arc aggr

# mkdir -p "$C_RANGER_PATH/aggr_outputs"
# mkdir -p "$C_RANGER_PATH/sheets"
# cd "$C_RANGER_PATH/aggr_outputs"
# 
# INPUTS_PATH="$C_RANGER_PATH/count_outputs"
# 
# # Generate aggregation CSV file
# echo "library_id,atac_fragments,per_barcode_metrics,gex_molecule_info" > "$C_RANGER_PATH/sheets/aggr_all_samples_csv_lib.csv"
# 
# # Collect sample directories
# sample_dirs=()
# for sample_id in "$INPUTS_PATH"/*; do
#     if [ -d "$sample_id" ]; then
#         subdir_name=$(basename "$sample_id")
#         sample_dirs+=("$subdir_name")
#     fi
# done
# 
# # Generate aggregation entries
# for subdir in "${sample_dirs[@]}"; do
#     SAMPLE="$subdir"
#     echo "$SAMPLE,$INPUTS_PATH/$SAMPLE/outs/atac_fragments.tsv.gz,$INPUTS_PATH/$SAMPLE/outs/per_barcode_metrics.csv,$INPUTS_PATH/$SAMPLE/outs/gex_molecule_info.h5" >> "$C_RANGER_PATH/sheets/aggr_all_samples_csv_lib.csv"
# done
# 
# # Run aggregation
# cellranger-arc aggr --id=BMMC_All_Samples \
#                     --csv="$C_RANGER_PATH/sheets/aggr_all_samples_csv_lib.csv" \
#                     --normalize=none \
#                     --reference="$TRANSCRIPTOME"

#=============================================================================
# Performance Summary (Final Aggregation Job)
#=============================================================================
# Job ID: 11928851
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 25-13:20:02
# CPU Efficiency: 32.51% of 78-14:34:40 core-walltime
# Job Wall-clock time: 2-10:57:20
# Memory Utilized: 157.36 GB
# Memory Efficiency: 61.47% of 256.00 GB



