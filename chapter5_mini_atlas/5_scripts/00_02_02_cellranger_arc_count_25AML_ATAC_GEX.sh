#!/bin/bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=80G
#SBATCH --time=48:00:00
#SBATCH --job-name=aml_cellranger-arc_multiome
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

TEMP_DIR="${TEMP_DIR:-/vast/scratch/users/ghamsari.r/cellranger_inputs}"

#  Ensure the output directory exists; create it if it doesn't exist
if [ ! -d "$DATA_DIR" ]; then
  echo "Data directory does not exist: $DATA_DIR"
  exit 1
fi

# Ensure the output directory exists
mkdir -p ${TEMP_DIR}



           
WORK_PATH=/stornext/General/data/user_managed/grpu_mritchie_1/reza/projects/mat_seq/RaCHseq_AML/cellranger-arc_outputs/
module purge
module load bcl2fastq/2.20.0
module load cellranger-arc/2.0.2

#checking mkfastq_outputs sizes:
#du -sh /stornext/General/data/user_managed/grpu_mritchie_1/reza/projects/mat_seq/RaCHseq_AML/cellranger-arc_outputs/mkfastq_outputs/AML_ATAC   1017G
#du -sh /stornext/General/data/user_managed/grpu_mritchie_1/reza/projects/mat_seq/RaCHseq_AML/cellranger-arc_outputs/mkfastq_outputs/AML_gex 778G
cd $WORK_PATH/count_outputs
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   Cellranger-arc count      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#Cellranger-arc count should be run for each individual sample separately. I executed them in 7 batches of 3-4 samples on Slurm, as outlined below:

#The script is designed to handle multiple runs, each corresponding to a batch of samples. For each run, the sections of the script that are not relevant to that specific batch are commented out, leaving only the code relevant to the batch being executed.

# time limit set to 48:00:00

# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    Batch 1 : samples 1:4    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

for i in {1..4}
do
  SAMPLE=Sample_$i
  echo """fastqs,sample,library_type
  $WORK_PATH/mkfastq_outputs/AML_ATAC/outs/fastq_path,$SAMPLE,Chromatin Accessibility
  $WORK_PATH/mkfastq_outputs/AML_gex/outs/fastq_path/HW5GKDSX5,$SAMPLE,Gene Expression""" > $WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

  cellranger-arc count --id=$SAMPLE \
                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
                        --libraries=$WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

done

# Submitted batch job 10973045

# # #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    Batch 2 : samples 5:8    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# for i in {5..8}
# do
#   SAMPLE=Sample_$i
#   echo """fastqs,sample,library_type
#   $WORK_PATH/mkfastq_outputs/AML_ATAC/outs/fastq_path,$SAMPLE,Chromatin Accessibility
#   $WORK_PATH/mkfastq_outputs/AML_gex/outs/fastq_path/HW5GKDSX5,$SAMPLE,Gene Expression""" > $WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

#   cellranger-arc count --id=$SAMPLE \
#                         --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                         --libraries=$WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

# done
##Submitted batch job 10973160

# # #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    Batch 3 : samples 9:12    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# for i in {9..12}
# do
#   SAMPLE=Sample_$i
#   echo """fastqs,sample,library_type
#   $WORK_PATH/mkfastq_outputs/AML_ATAC/outs/fastq_path,$SAMPLE,Chromatin Accessibility
#   $WORK_PATH/mkfastq_outputs/AML_gex/outs/fastq_path/HW5GKDSX5,$SAMPLE,Gene Expression""" > $WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

#   cellranger-arc count --id=$SAMPLE \
#                         --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                         --libraries=$WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

# done
##Submitted batch job 10973161

# # #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    Batch 4 : samples 13:15    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# for i in {13..15}
# do
#   SAMPLE=Sample_$i
#   echo """fastqs,sample,library_type
#   $WORK_PATH/mkfastq_outputs/AML_ATAC/outs/fastq_path,$SAMPLE,Chromatin Accessibility
#   $WORK_PATH/mkfastq_outputs/AML_gex/outs/fastq_path/HW5GKDSX5,$SAMPLE,Gene Expression""" > $WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

#   cellranger-arc count --id=$SAMPLE \
#                         --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                         --libraries=$WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

# done
# #Submitted batch job 10973205
 # #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    Batch 5 : samples 16:18    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# for i in {16..18}
# do
#   SAMPLE=Sample_$i
#   echo """fastqs,sample,library_type
#   $WORK_PATH/mkfastq_outputs/AML_ATAC/outs/fastq_path,$SAMPLE,Chromatin Accessibility
#   $WORK_PATH/mkfastq_outputs/AML_gex/outs/fastq_path/HW5GKDSX5,$SAMPLE,Gene Expression""" > $WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

#   cellranger-arc count --id=$SAMPLE \
#                         --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                         --libraries=$WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

# done
# #Submitted batch job 10973207

# # #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    Batch 6 : samples 19:21    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# for i in {19..21}
# do
#   SAMPLE=Sample_$i
#   echo """fastqs,sample,library_type
#   $WORK_PATH/mkfastq_outputs/AML_ATAC/outs/fastq_path,$SAMPLE,Chromatin Accessibility
#   $WORK_PATH/mkfastq_outputs/AML_gex/outs/fastq_path/HW5GKDSX5,$SAMPLE,Gene Expression""" > $WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

#   cellranger-arc count --id=$SAMPLE \
#                         --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                         --libraries=$WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

# done

##Submitted batch job 10973209
# # #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    Batch 7 : samples 22:25    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# for i in {22..25}
# do
#   SAMPLE=Sample_$i
#   echo """fastqs,sample,library_type
#   $WORK_PATH/mkfastq_outputs/AML_ATAC/outs/fastq_path,$SAMPLE,Chromatin Accessibility
#   $WORK_PATH/mkfastq_outputs/AML_gex/outs/fastq_path/HW5GKDSX5,$SAMPLE,Gene Expression""" > $WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

#   cellranger-arc count --id=$SAMPLE \
#                         --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                         --libraries=$WORK_PATH/sheets/${SAMPLE}_csv_lib_count.csv

# done

#Submitted batch job 10973197



# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                            
# #@@@@@@@@@@@  Extracting all web_summary files into one directory 
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       

#Define source and destination directories
# OUT_DIR=$WORK_PATH/count_outputs
# ALL_WEB_SUMMARY_DIR=$WORK_PATH/count_outputs/all_web_summary_aml
# mkdir -p $ALL_WEB_SUMMARY_DIR

# # Loop through all subdirectories in the source directory
# for subdir in "$OUT_DIR"/*/; do
#     # Check if the current entry in the loop is a directory
#     if [ -d "$subdir" ]; then
#         # Get the subdirectory name
#         subdir=$(basename "$subdir")

#         # Find the sequencing_summary.txt file in the subdirectory
#         file="$OUT_DIR/$subdir/outs/web_summary.html"

#         # Copy the file to the destination directory with new name
#         if [ -f "$file" ]; then
#             newname="web_summary_${subdir}.html"
#             cp "$file" "${ALL_WEB_SUMMARY_DIR}/${newname}"
#             echo "Copied $file to ${ALL_WEB_SUMMARY_DIR}/${newname}"
#         else
#             echo "File not found in $OUT_DIR/$subdir"
#         fi
#     fi
# done



