#!/bin/bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=80G
#SBATCH --time=10:00:00
#SBATCH --job-name=cellranger-arc_BMMC
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

# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   Cellranger-arc count      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#The script is designed to handle multiple runs, each corresponding to one. For each run, the sections of the script that are not relevant to that specific batch are commented out, leaving only the code relevant to the batch being executed.

WORK_PATH=/vast/scratch/users/ghamsari.r/fastqfiles_bmmc/
module purge
module load cellranger-arc/2.0.2

C_RANGER_PATH=/stornext/General/data/user_managed/grpu_mritchie_1/reza/projects/mat_seq/BMMC_luecken/cellranger-arc_outputs
mkdir -p $C_RANGER_PATH/sheets/
mkdir -p $C_RANGER_PATH/count_outputs/
cd $C_RANGER_PATH/count_outputs


# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
ID=BMMC_S1_D1

echo """fastqs,sample,library_type
$WORK_PATH/bamtofastq_outputs/site1_donor1_ATAC/libraries_neurips_site1_donor1_MissingLibrary_1_HFNCFDRXY,bamtofastq,Chromatin Accessibility
$WORK_PATH/bamtofastq_outputs/site1_donor1_GEX/libraries_neurips_site1_donor1_0_1_HFMHTDRXY,bamtofastq, Gene Expression""" > \
$C_RANGER_PATH/sheets/csv_lib_${ID}.csv

cellranger-arc count --id=$ID \
                       --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
                       --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \
                       
# # Submitted batch job 11926407
# Job ID: 11926407
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 5-20:34:53
# CPU Efficiency: 70.16% of 8-08:21:52 core-walltime
# Job Wall-clock time: 06:15:41
# Memory Utilized: 86.42 GB
# Memory Efficiency: 69.70% of 124.00 GB

# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ 
# ID=BMMC_S1_D2
# DIR_ATAC=libraries_neurips_site1_donor2_MissingLibrary_1_HFNCFDRXY
# DIR_GEX=libraries_neurips_site1_donor2_0_1_HFMHTDRXY

# echo """fastqs,sample,library_type
# $WORK_PATH/bamtofastq_outputs/site1_donor2_ATAC/$DIR_ATAC,bamtofastq,Chromatin Accessibility
# $WORK_PATH/bamtofastq_outputs/site1_donor2_GEX/$DIR_GEX,bamtofastq, Gene Expression""" > \
# $C_RANGER_PATH/sheets/csv_lib_${ID}.csv

# cellranger-arc count --id=$ID \
#                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                        --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \
                       

# Submitted batch job 11926429
# Job ID: 11926429
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 3-23:18:39
# CPU Efficiency: 69.09% of 5-17:56:48 core-walltime
# Job Wall-clock time: 04:18:39
# Memory Utilized: 85.47 GB
# Memory Efficiency: 68.93% of 124.00 GB
# ##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     
# ID=BMMC_S1_D3
# DIR_ATAC=libraries_neurips_site1_donor3_MissingLibrary_1_HFNCFDRXY
# DIR_GEX=libraries_neurips_site1_donor3_0_1_HFMHTDRXY

# echo """fastqs,sample,library_type
# $WORK_PATH/bamtofastq_outputs/site1_donor3_ATAC/$DIR_ATAC,bamtofastq,Chromatin Accessibility
# $WORK_PATH/bamtofastq_outputs/site1_donor3_GEX/$DIR_GEX,bamtofastq, Gene Expression""" > \
# $C_RANGER_PATH/sheets/csv_lib_${ID}.csv

# cellranger-arc count --id=$ID \
#                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                        --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \
# Submitted batch job 11926435
# Job ID: 11926435
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 3-05:20:08
# CPU Efficiency: 67.08% of 4-19:17:20 core-walltime
# Job Wall-clock time: 03:36:10
# Memory Utilized: 87.80 GB
# Memory Efficiency: 70.81% of 124.00 GB

# ##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     
# ID=BMMC_S2_D1
# DIR_ATAC=libraries_neurips_site2_donor1_MissingLibrary_1_HG2YYDSX2
# DIR_GEX=libraries_neurips_site2_donor1_0_1_HG2YYDSX2

# echo """fastqs,sample,library_type
# $WORK_PATH/bamtofastq_outputs/site2_donor1_ATAC/$DIR_ATAC,bamtofastq,Chromatin Accessibility
# $WORK_PATH/bamtofastq_outputs/site2_donor1_GEX/$DIR_GEX,bamtofastq, Gene Expression""" > \
# $C_RANGER_PATH/sheets/csv_lib_${ID}.csv

# cellranger-arc count --id=$ID \
#                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                        --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \

# Submitted batch job 11926440
# Job ID: 11926440
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 4-22:59:23
# CPU Efficiency: 72.10% of 6-21:01:52 core-walltime
# Job Wall-clock time: 05:09:26
# Memory Utilized: 81.91 GB
# Memory Efficiency: 66.06% of 124.00 GB
#
##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     
# ID=BMMC_S2_D4
# DIR_ATAC=libraries_neurips_site2_donor4_MissingLibrary_1_HG2YYDSX2
# DIR_GEX=libraries_neurips_site2_donor4_0_1_HG2YYDSX2

# echo """fastqs,sample,library_type
# $WORK_PATH/bamtofastq_outputs/site2_donor4_ATAC/$DIR_ATAC,bamtofastq,Chromatin Accessibility
# $WORK_PATH/bamtofastq_outputs/site2_donor4_GEX/$DIR_GEX,bamtofastq, Gene Expression""" > \
# $C_RANGER_PATH/sheets/csv_lib_${ID}.csv

# cellranger-arc count --id=$ID \
#                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                        --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \
# Submitted batch job 11926447

# #Job ID: 11926447
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 5-03:45:28
# CPU Efficiency: 69.31% of 7-10:33:04 core-walltime
# Job Wall-clock time: 05:34:47
# Memory Utilized: 78.27 GB
# Memory Efficiency: 63.12% of 124.00 GB
# ##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                     
# ID=BMMC_S2_D5
# DIR_ATAC=site2_donor5_MissingLibrary_1_HG3FLDSX2
# DIR_GEX=site2_donor5_0_1_HG3FLDSX2

# echo """fastqs,sample,library_type
# $WORK_PATH/bamtofastq_outputs/site2_donor5_ATAC/$DIR_ATAC,bamtofastq,Chromatin Accessibility
# $WORK_PATH/bamtofastq_outputs/site2_donor5_GEX/$DIR_GEX,bamtofastq, Gene Expression""" > \
# $C_RANGER_PATH/sheets/csv_lib_${ID}.csv

# cellranger-arc count --id=$ID \
#                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                        --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \

# # Submitted batch job 11926463
# Job ID: 11926463
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 4-12:40:45
# CPU Efficiency: 69.44% of 6-12:30:24 core-walltime
# Job Wall-clock time: 04:53:27
# Memory Utilized: 79.22 GB
# Memory Efficiency: 63.89% of 124.00 GB
# #
# ##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  ????  has two gex fastq file  , used both                      
# ID=BMMC_S3_D10
# DIR_ATAC=site3_donor10_new_and_old_combined_MissingLibrary_1_H3N2GDMXY
# DIR_GEX=site3_donor10_new_and_old_combined_0_1_AAAHK5JHV
# # site3_donor10_new_and_old_combined_0_1_AAAHK7LHV

# echo """fastqs,sample,library_type
# $WORK_PATH/bamtofastq_outputs/site3_donor10_ATAC/$DIR_ATAC,bamtofastq,Chromatin Accessibility
# $WORK_PATH/bamtofastq_outputs/site3_donor10_GEX/site3_donor10_new_and_old_combined_0_1_AAAHK7LHV,bamtofastq, Gene Expression
# $WORK_PATH/bamtofastq_outputs/site3_donor10_GEX/$DIR_GEX,bamtofastq, Gene Expression""" > \
# $C_RANGER_PATH/sheets/csv_lib_${ID}.csv

# cellranger-arc count --id=$ID \
#                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                        --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \
# Submitted batch job 11926474
# Job ID: 11926474
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 10-18:38:56
# CPU Efficiency: 75.80% of 14-05:13:36 core-walltime
# Job Wall-clock time: 10:39:48
# Memory Utilized: 85.06 GB
# Memory Efficiency: 68.60% of 124.00 GB

# ##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       ????  has two gex fastq file  , used both                 
# ID=BMMC_S3_D3
# DIR_ATAC=site3_donor3_new_and_old_combined_MissingLibrary_1_H3N2GDMXY
# DIR_GEX=site3_donor3_new_and_old_combined_0_1_AAAHK5JHV
# # site3_donor3_new_and_old_combined_0_1_AAAHK7LHV


# echo """fastqs,sample,library_type
# $WORK_PATH/bamtofastq_outputs/site3_donor3_ATAC/$DIR_ATAC,bamtofastq,Chromatin Accessibility
# $WORK_PATH/bamtofastq_outputs/site3_donor3_GEX/site3_donor3_new_and_old_combined_0_1_AAAHK7LHV,bamtofastq, Gene Expression
# $WORK_PATH/bamtofastq_outputs/site3_donor3_GEX/$DIR_GEX,bamtofastq, Gene Expression""" > \
# $C_RANGER_PATH/sheets/csv_lib_${ID}.csv

# cellranger-arc count --id=$ID \
#                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                        --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \

# #Submitted batch job 11926476 
# Job ID: 11926476
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 9-00:07:32
# CPU Efficiency: 73.41% of 12-06:24:00 core-walltime
# Job Wall-clock time: 09:12:00
# Memory Utilized: 81.83 GB
# Memory Efficiency: 65.99% of 124.00 GB
# ##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                
# ID=BMMC_S3_D6
# DIR_ATAC=site3_donor6_MissingLibrary_1_HGJCFBGXJ
# DIR_GEX=site3_donor6_0_1_AAAH5N3HV



# echo """fastqs,sample,library_type
# $WORK_PATH/bamtofastq_outputs/site3_donor6_ATAC/$DIR_ATAC,bamtofastq,Chromatin Accessibility
# $WORK_PATH/bamtofastq_outputs/site3_donor6_GEX/$DIR_GEX,bamtofastq, Gene Expression""" > \
# $C_RANGER_PATH/sheets/csv_lib_${ID}.csv

# cellranger-arc count --id=$ID \
#                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                        --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \
# Submitted batch job 11926493
# Job ID: 11926493
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 3-17:16:21
# CPU Efficiency: 58.49% of 6-08:37:52 core-walltime
# Job Wall-clock time: 04:46:11
# Memory Utilized: 84.23 GB
# Memory Efficiency: 67.93% of 124.00 GB

# ##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   ????  has two gex fastq file  , used both                
# ID=BMMC_S3_D7
# DIR_ATAC=site3_donor7_atac_and_gex_from_old_and_new_MissingLibrary_1_H3N2GDMXY
# DIR_GEX=site3_donor7_atac_and_gex_from_old_and_new_0_1_AAAHK5JHV
# # site3_donor7_atac_and_gex_from_old_and_new_0_1_AAAHK7LHV


# echo """fastqs,sample,library_type
# $WORK_PATH/bamtofastq_outputs/site3_donor7_ATAC/$DIR_ATAC,bamtofastq,Chromatin Accessibility
# $WORK_PATH/bamtofastq_outputs/site3_donor7_GEX/site3_donor7_atac_and_gex_from_old_and_new_0_1_AAAHK7LHV,bamtofastq, Gene Expression
# $WORK_PATH/bamtofastq_outputs/site3_donor7_GEX/$DIR_GEX,bamtofastq, Gene Expression""" > \
# $C_RANGER_PATH/sheets/csv_lib_${ID}.csv

# cellranger-arc count --id=$ID \
#                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                        --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \
# Submitted batch job 11926494
# Job ID: 11926494
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 7-23:10:02
# CPU Efficiency: 76.55% of 10-09:43:28 core-walltime
# Job Wall-clock time: 07:48:14
# Memory Utilized: 77.02 GB
# Memory Efficiency: 62.11% of 124.00 GB

# ##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            
# ID=BMMC_S4_D1
# DIR_ATAC=site4_donor1_MissingLibrary_1_H3YNTBGXK
# DIR_GEX=site4_donor1_0_1_AAAH7CNHV



# echo """fastqs,sample,library_type
# $WORK_PATH/bamtofastq_outputs/site4_donor1_ATAC/$DIR_ATAC,bamtofastq,Chromatin Accessibility
# $WORK_PATH/bamtofastq_outputs/site4_donor1_GEX/$DIR_GEX,bamtofastq, Gene Expression""" > \
# $C_RANGER_PATH/sheets/csv_lib_${ID}.csv

# cellranger-arc count --id=$ID \
#                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                        --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \
# Submitted batch job 11926495
# Job ID: 11926495
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 8-01:03:23
# CPU Efficiency: 63.84% of 12-14:24:00 core-walltime
# Job Wall-clock time: 09:27:00
# Memory Utilized: 94.55 GB
# Memory Efficiency: 76.25% of 124.00 GB
##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    ????  has two gex fastq file  , used both    
# ID=BMMC_S4_D8
# DIR_ATAC=site4_donor8_MissingLibrary_1_H3YNFBGXK
# DIR_GEX=site4_donor8_0_1_HNV5LBGXJ
# #site4_donor8_0_1_AAAHCHWHV

# echo """fastqs,sample,library_type
# $WORK_PATH/bamtofastq_outputs/site4_donor8_ATAC/$DIR_ATAC,bamtofastq,Chromatin Accessibility
# $WORK_PATH/bamtofastq_outputs/site4_donor8_GEX/site4_donor8_0_1_AAAHCHWHV,bamtofastq, Gene Expression
# $WORK_PATH/bamtofastq_outputs/site4_donor8_GEX/$DIR_GEX,bamtofastq, Gene Expression""" > \
# $C_RANGER_PATH/sheets/csv_lib_${ID}.csv

# cellranger-arc count --id=$ID \
#                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                        --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \

# # Submitted batch job 11926496    
# Job ID: 11926496
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 6-19:36:22
# CPU Efficiency: 63.05% of 10-19:29:04 core-walltime
# Job Wall-clock time: 08:06:32
# Memory Utilized: 94.51 GB
# Memory Efficiency: 76.22% of 124.00 GB             
##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@            
# ID=BMMC_S4_D9
# DIR_ATAC=site4_donor9_MissingLibrary_1_H52FWBGXK
# DIR_GEX=site4_donor9_0_1_HTGWKBGXJ



# echo """fastqs,sample,library_type
# $WORK_PATH/bamtofastq_outputs/site4_donor9_ATAC/$DIR_ATAC,bamtofastq,Chromatin Accessibility
# $WORK_PATH/bamtofastq_outputs/site4_donor9_GEX/$DIR_GEX,bamtofastq, Gene Expression""" > \
# $C_RANGER_PATH/sheets/csv_lib_${ID}.csv

# cellranger-arc count --id=$ID \
#                        --reference=/stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/cellranger/refdata-cellranger-arc-GRCh38-2020-A-2.0.0 \
#                        --libraries=$C_RANGER_PATH/sheets/csv_lib_${ID}.csv \

# #Submitted batch job 11926497
# Job ID: 11926497
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 32
# CPU Utilized: 2-17:16:24
# CPU Efficiency: 60.12% of 4-12:34:08 core-walltime
# Job Wall-clock time: 03:23:34
# Memory Utilized: 87.22 GB
# Memory Efficiency: 70.34% of 124.00 GB