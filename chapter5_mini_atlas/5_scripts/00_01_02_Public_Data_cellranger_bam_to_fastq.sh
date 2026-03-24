#!/bin/bash
#SBATCH --time=24:00:00
#SBATCH --cpus-per-task=32
#SBATCH --mem=124G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ghamsari.r@wehi.edu.au
# Define output and error log directories
LOG_DIR="${TEMP_DIR}/cellranger-arc_outputs/run_history"

# Ensure the log directory exists
mkdir -p ${LOG_DIR}

# Define log file paths
OUTPUT_LOG="${LOG_DIR}/RaCHseq_AML_cellranger-arc_multiome_o.%j.%N.log"
ERROR_LOG="${LOG_DIR}/RaCHseq_AML_cellranger-arc_multiome_e.%j.%N.log"

#SBATCH --output=${OUTPUT_LOG}
#SBATCH --error=${ERROR_LOG}

WORK_PATH=/vast/scratch/users/ghamsari.r/fastqfiles_bmmc


module purge

module load cellranger/7.1.0   
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   Cellranger bamtofastq      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Function to process BAM files
process_bam_file() {
  local BAM_FILE=$1
  local DIR_OUT=$2

  BAM_PATH="/vast/scratch/users/ghamsari.r/bamfiles_bmmc/$BAM_FILE"
  OUTPUT_DIR="$WORK_PATH/bamtofastq_outputs/$DIR_OUT"

  # Create output directory if it doesn't exist
  mkdir -p $OUTPUT_DIR

  # Run Cellranger bamtofastq
  cellranger bamtofastq \
    --nthreads=8 \
    $BAM_PATH \
    $OUTPUT_DIR
}





process_bam_file "site1_donor01_multiome_atac.possorted_genome_bam.bam.1" "site1_donor1_ATAC"
process_bam_file "site1_donor01_multiome_gex.possorted_genome_bam.bam.1" "site1_donor1_GEX"
process_bam_file "site1_donor01_cite.possorted_genome_bam.bam.1" "site1_donor1_cite"
process_bam_file "site1_donor02_cite.possorted_bam.bam.1" "site1_donor2_cite"
process_bam_file "site1_donor02_multiome_gex.possorted_bam.bam.1" "site1_donor2_GEX"
process_bam_file "site1_donor02_multiome_atac.possorted_bam.bam.1" "site1_donor2_ATAC"
process_bam_file "site1_donor03_cite.possorted_bam.bam.1" "site1_donor3_cite"
process_bam_file "site1_donor03_multiome_gex.possorted_bam.bam.1" "site1_donor3_GEX"
process_bam_file "site1_donor03_multiome_atac.possorted_bam.bam.1" "site1_donor3_ATAC"
process_bam_file "site2_donor01_cite.possorted_genome_bam.bam.1" "site2_donor1_cite"
process_bam_file "site2_donor01_multiome_gex.possorted_genome_bam.bam.1" "site2_donor1_GEX"
process_bam_file "site2_donor01_multiome_atac.possorted_genome_bam.bam.1" "site2_donor1_ATAC"
process_bam_file "site2_donor04_cite.possorted_genome_bam.bam.1" "site2_donor4_cite"
process_bam_file "site2_donor04_multiome_gex.possorted_genome_bam.bam.1" "site2_donor4_GEX"
process_bam_file "site2_donor04_multiome_atac.possorted_genome_bam.bam.1" "site2_donor4_ATAC"
process_bam_file "site2_donor05_cite.possorted_genome_bam.bam.1" "site2_donor5_cite"
process_bam_file "site2_donor05_multiome_gex.possorted_genome_bam.bam.1" "site2_donor5_GEX"
process_bam_file "site2_donor05_multiome_atac.possorted_genome_bam.bam.1" "site2_donor5_ATAC"
process_bam_file "site3_donor01_cite.possorted_genome_bam.bam.1" "site3_donor1_cite"
process_bam_file "site3_donor03_multiome_atac.possorted_genome_bam.bam.1" "site3_donor3_ATAC"
process_bam_file "site3_donor03_multiome_gex.possorted_genome_bam.bam.1" "site3_donor3_GEX"
process_bam_file "site3_donor06_cite.possorted_genome_bam.bam.1" "site3_donor6_cite"
process_bam_file "site3_donor06_multiome_atac.possorted_genome_bam.bam.1" "site3_donor6_ATAC"
process_bam_file "site3_donor06_multiome_gex.possorted_genome_bam.bam.1" "site3_donor6_GEX"
process_bam_file "site3_donor07_cite.possorted_genome_bam.bam.1" "site3_donor7_cite"
process_bam_file "site3_donor07_multiome_atac.possorted_genome_bam.bam.1" "site3_donor7_ATAC"
process_bam_file "site3_donor07_multiome_gex.possorted_genome_bam.bam.1" "site3_donor7_GEX"
process_bam_file "site3_donor10_multiome_atac.possorted_genome_bam.bam.1" "site3_donor10_ATAC"
process_bam_file "site3_donor10_multiome_gex.possorted_genome_bam.bam.1" "site3_donor10_GEX"
process_bam_file "site4_donor01_cite.possorted_genome_bam.bam.1" "site4_donor1_cite"
process_bam_file "site4_donor01_multiome_atac.possorted_genome_bam.bam.1" "site4_donor1_ATAC"
process_bam_file "site4_donor01_multiome_gex.possorted_genome_bam.bam.1" "site4_donor1_GEX"
process_bam_file "site4_donor08_cite.possorted_genome_bam.bam.1" "site4_donor8_cite"
process_bam_file "site4_donor08_multiome_atac.possorted_genome_bam.bam.1" "site4_donor8_ATAC"
process_bam_file "site4_donor08_multiome_gex.possorted_genome_bam.bam.1" "site4_donor8_GEX"
process_bam_file "site4_donor09_cite.possorted_genome_bam.bam.1" "site4_donor9_cite"
process_bam_file "site4_donor09_multiome_atac.possorted_genome_bam.bam.1" "site4_donor9_ATAC"
process_bam_file "site4_donor09_multiome_gex.possorted_genome_bam.bam.1" "site4_donor9_GEX"




