# #!/bin/bash
# #SBATCH --cpus-per-task=20
# #SBATCH --mem=300G
# #SBATCH --partition=long
# #SBATCH --time=14-00:00:00
# #SBATCH --job-name=cellranger-arc_AML_aggr_long
# #SBATCH --mail-type=ALL
# #SBATCH --mail-user=ghamsari.r@wehi.edu.au

# Define output and error log directories
LOG_DIR="${TEMP_DIR}/cellranger-arc_outputs/run_history"

# Ensure the log directory exists
mkdir -p ${LOG_DIR}

# Define log file paths
OUTPUT_LOG="${LOG_DIR}/RaCHseq_AML_cellranger-arc_multiome_o.%j.%N.log"
ERROR_LOG="${LOG_DIR}/RaCHseq_AML_cellranger-arc_multiome_e.%j.%N.log"

#SBATCH --output=${OUTPUT_LOG}
#SBATCH --error=${ERROR_LOG}

           
WORK_PATH=/stornext/General/data/user_managed/grpu_mritchie_1/reza/projects/mat_seq/RaCHseq_AML/cellranger-arc_outputs/
module purge
module load bcl2fastq/2.20.0
module load cellranger-arc/2.0.2



cd $WORK_PATH/aggr_outputs
INPUTS_PATH=$WORK_PATH/count_outputs
INPUTS_PATH_BMMC=/stornext/General/data/user_managed/grpu_mritchie_1/reza/projects/mat_seq/BMMC_luecken/cellranger-arc_outputs/count_outputs

# All AML Samples integration with ALL BMMC healthy (no secondary analysis)

##################################
#################creating the csv file
##################################

sample_dirs=()

# Loop through each entry in the directory to save the dir or sample name
for sample_id in "$INPUTS_PATH_BMMC"/*; do
    # Check if entry is a directory
    if [ -d "$sample_id" ]; then
        subdir_name=$(basename "$sample_id")
        # Add directory to the sample_dirs array
        sample_dirs+=("$subdir_name")

    fi

done


echo "library_id,atac_fragments,per_barcode_metrics,gex_molecule_info" > $WORK_PATH/sheets/aggr_25_AML_13_BMMC_csv_lib.csv
# Loop through the subdirectories array

##AML
for i in {1..25}; do
SAMPLE=Sample_$i
echo "$SAMPLE,$INPUTS_PATH/$SAMPLE/outs/atac_fragments.tsv.gz,$INPUTS_PATH/$SAMPLE/outs/per_barcode_metrics.csv,$INPUTS_PATH/$SAMPLE/outs/gex_molecule_info.h5" >> $WORK_PATH/sheets/aggr_25_AML_13_BMMC_csv_lib.csv
    
done

##BMMC
for subdir in "${sample_dirs[@]}"; do
    # Use the subdir in your logic here
    DONOR=$subdir

    echo "$DONOR,$INPUTS_PATH_BMMC/$DONOR/outs/atac_fragments.tsv.gz,$INPUTS_PATH_BMMC/$DONOR/outs/per_barcode_metrics.csv,$INPUTS_PATH_BMMC/$DONOR/outs/gex_molecule_info.h5" >> $WORK_PATH/sheets/aggr_25_AML_13_BMMC_csv_lib.csv
    
done


#based on 10x suggestion I added --nosecondary to avoid secondary analysis
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   Cellranger-arc aggr       @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


cellranger-arc aggr --id=AML_BMMC_38_Samples_no_secondary_analysis \
                  --csv=$WORK_PATH/sheets/aggr_25_AML_13_BMMC_csv_lib.csv \
                  --normalize=none \
                  --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
                  --nosecondary


#Submitted batch job 12384043
