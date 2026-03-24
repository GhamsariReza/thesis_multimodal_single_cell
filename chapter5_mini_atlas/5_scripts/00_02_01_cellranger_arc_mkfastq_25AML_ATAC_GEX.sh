/Users/ghamsari.r/Library/CloudStorage/OneDrive-UNSW/OneDriveUNSW/GitHub_Repositories/MiniAtlas-Multiome-BMMCs-AML/scripts/00_02_01_cellranger_arc_mkfastq_25AML_ATAC_GEX.sh#!/bin/bash
#SBATCH --cpus-per-task=16
#SBATCH --mem=80G
#SBATCH --time=10:00:00
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

# Define paths to data and output directories (now configurable)
DATA_DIR="${DATA_DIR:-/stornext/Projects/promethion/promethion_data/long_term/lab_ritchie/20230228_Rachel_AML_CLL/CAGRF230213515}"
TEMP_DIR="${TEMP_DIR:-/vast/scratch/users/ghamsari.r/cellranger_inputs}"

#  Ensure the output directory exists; create it if it doesn't exist
if [ ! -d "$DATA_DIR" ]; then
  echo "Data directory does not exist: $DATA_DIR"
  exit 1
fi

# Ensure the output directory exists
mkdir -p ${TEMP_DIR}

# Unpack the GEX data (Gene Expression)
echo "Extracting GEX data..."  # Print a message indicating the extraction of GEX data
tar -xpvf ${DATA_DIR}/GEX/AGRF_CAGRF230213515_HW5GKDSX5.tar -C ${TEMP_DIR}/RaCHseq_AML_GEX/  # Extract GEX data from the tar file

# Unpack the ATAC data (Chromatin Accessibility)
echo "Extracting ATAC data..."  # Print a message indicating the extraction of ATAC data
tar -xpvf ${DATA_DIR}/ATAC/AGRF_CAGRF230213515_HTYLFDSX5.tar -C ${TEMP_DIR}/RaCHseq_AML_ATAC/  # Extract ATAC data from the tar file


# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@   Cellranger-arc            @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                             @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Since there are two flow cells—one for ATAC samples and one for GEX samples—I ran mkfastq separately for each flow cell. Each was submitted as a separate SLURM job, as shown below:
           
WORK_PATH=/stornext/General/data/user_managed/grpu_mritchie_1/reza/projects/mat_seq/RaCHseq_AML/cellranger-arc_outputs/
module purge
module load bcl2fastq/2.20.0
module load cellranger-arc/2.0.2
cd $WORK_PATH/mkfastq_outputs
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Job  1: Cellranger-arc mkfastq GEX 
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo """Lane,Sample,Index
1,Sample_1,SI-TT-B11
1,Sample_2,SI-TT-B1 
1,Sample_3,SI-TT-C6
1,Sample_4,SI-TT-C7
1,Sample_5,SI-TT-B2
1,Sample_6,SI-TT-B3
1,Sample_7,SI-TT-A5
1,Sample_8,SI-TT-A6
1,Sample_9,SI-TT-A7
1,Sample_10,SI-TT-B6
1,Sample_11,SI-TT-B7
1,Sample_12,SI-TT-B8
1,Sample_13,SI-TT-C1
1,Sample_14,SI-TT-C2
1,Sample_15,SI-TT-C3
1,Sample_16,SI-TT-B4
1,Sample_17,SI-TT-B5
1,Sample_18,SI-TT-B9
1,Sample_19,SI-TT-B10
1,Sample_20,SI-TT-A8
1,Sample_21,SI-TT-A9
1,Sample_22,SI-TT-C4
1,Sample_23,SI-TT-C5
1,Sample_24,SI-TT-C8
1,Sample_25,SI-TT-C9
2,Sample_1,SI-TT-B11
2,Sample_2,SI-TT-B1 
2,Sample_3,SI-TT-C6
2,Sample_4,SI-TT-C7
2,Sample_5,SI-TT-B2
2,Sample_6,SI-TT-B3
2,Sample_7,SI-TT-A5
2,Sample_8,SI-TT-A6
2,Sample_9,SI-TT-A7
2,Sample_10,SI-TT-B6
2,Sample_11,SI-TT-B7
2,Sample_12,SI-TT-B8
2,Sample_13,SI-TT-C1
2,Sample_14,SI-TT-C2
2,Sample_15,SI-TT-C3
2,Sample_16,SI-TT-B4
2,Sample_17,SI-TT-B5
2,Sample_18,SI-TT-B9
2,Sample_19,SI-TT-B10
2,Sample_20,SI-TT-A8
2,Sample_21,SI-TT-A9
2,Sample_22,SI-TT-C4
2,Sample_23,SI-TT-C5
2,Sample_24,SI-TT-C8
2,Sample_25,SI-TT-C9
3,Sample_1,SI-TT-B11
3,Sample_2,SI-TT-B1 
3,Sample_3,SI-TT-C6
3,Sample_4,SI-TT-C7
3,Sample_5,SI-TT-B2
3,Sample_6,SI-TT-B3
3,Sample_7,SI-TT-A5
3,Sample_8,SI-TT-A6
3,Sample_9,SI-TT-A7
3,Sample_10,SI-TT-B6
3,Sample_11,SI-TT-B7
3,Sample_12,SI-TT-B8
3,Sample_13,SI-TT-C1
3,Sample_14,SI-TT-C2
3,Sample_15,SI-TT-C3
3,Sample_16,SI-TT-B4
3,Sample_17,SI-TT-B5
3,Sample_18,SI-TT-B9
3,Sample_19,SI-TT-B10
3,Sample_20,SI-TT-A8
3,Sample_21,SI-TT-A9
3,Sample_22,SI-TT-C4
3,Sample_23,SI-TT-C5
3,Sample_24,SI-TT-C8
3,Sample_25,SI-TT-C9""" > $WORK_PATH/sheets/simple_sheet_gex.csv

#somehow it is not work with * for all lanes so I specified each lane separatly. 25 samples and for each one 3 lanes. The sample index adabted from AML_samples_single_cell_ multiome study.xlsx that Rachel emailed us.
#it also works with modified version of the samplesheet that AGRF sent us which I saved in /sheets/SampleSheet_simple_GEX_test_worked.csv.



cellranger-arc mkfastq --id=AML_gex \
                     --run=${TEMP_DIR}/RaCHseq_AML_GEX/AGRF_CAGRF230213515_HW5GKDSX5 \
                     --csv=$WORK_PATH/sheets/simple_sheet_gex.csv \

#Dir size:                    
#du -sh HW5GKDSX5/ 689G  
#checking mkfastq_outputs size:
#du -sh /stornext/General/data/user_managed/grpu_mritchie_1/reza/projects/mat_seq/RaCHseq_AML/cellranger-arc_outputs/mkfastq_outputs/AML_gex 778G

#Submitted batch job 10969141   
# Job ID: 10969141
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 20
# CPU Utilized: 1-11:21:45
# CPU Efficiency: 30.10% of 4-21:29:40 core-walltime
# Job Wall-clock time: 05:52:29
# Memory Utilized: 9.18 GB
# Memory Efficiency: 11.47% of 80.00 GB                


#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
###@@@@@@@@@@@@@@@@@@@@@ Job 2: Cellranger-arc mkfastq ATAC 
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo """Lane,Sample,Index
*,Sample_1,SI-NA-C6
*,Sample_2,SI-NA-B6
*,Sample_3,SI-NA-D1
*,Sample_4,SI-NA-D2
*,Sample_5,SI-NA-B7
*,Sample_6,SI-NA-B8
*,Sample_7,SI-NA-B1 
*,Sample_8,SI-NA-B2
*,Sample_9,SI-NA-B3
*,Sample_10,SI-NA-C1
*,Sample_11,SI-NA-C2
*,Sample_12,SI-NA-C3
*,Sample_13,SI-NA-C7
*,Sample_14,SI-NA-C8
*,Sample_15,SI-NA-C9
*,Sample_16,SI-NA-B9
*,Sample_17,SI-NA-B10
*,Sample_18,SI-NA-C4
*,Sample_19,SI-NA-C5
*,Sample_20,SI-NA-B4
*,Sample_21,SI-NA-B5
*,Sample_22,SI-NA-C10
*,Sample_23,SI-NA-C11
*,Sample_24,SI-NA-D3
*,Sample_25,SI-NA-D4""" > $WORK_PATH/sheets/simple_sheet_atac.csv



cellranger-arc mkfastq --id=AML_ATAC \
                     --run=${TEMP_DIR}/RaCHseq_AML_ATAC/AGRF_CAGRF230213515_HTYLFDSX5 \
                     --samplesheet=$WORK_PATH/sheets/simple_sheet_atac.csv
                     


#Dir size:
#du -sh HTYLFDSX5/ 960G
#checking mkfastq_outputs size:
#du -sh /stornext/General/data/user_managed/grpu_mritchie_1/reza/projects/mat_seq/RaCHseq_AML/cellranger-arc_outputs/mkfastq_outputs/AML_ATAC   1017G

#Submitted batch job 10969137
# Job ID: 10969137
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 20
# CPU Utilized: 1-21:25:15
# CPU Efficiency: 28.60% of 6-14:49:00 core-walltime
# Job Wall-clock time: 07:56:27
# Memory Utilized: 20.51 GB
# Memory Efficiency: 25.64% of 80.00 GB
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️⚠️ errors and notes ⚠️⚠️⚠️⚠️⚠️⚠️
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# During this run, I encountered several errors due to the design of the sample sheet. The issue was resolved by changing the column name "sample_ID" to "sample" in the sample sheet.
# I modified the original sample sheets and retained only the necessary columns. Additionally, I replaced "GEX" and "ATAC" with "Sample_XX" for clarity.

# error:

# 2023-03-18 00:05:43 [d75880] WARNING: No cbcl files found for cycle 1. Attempt 1 of 3. Retry with cycle 2.
# 2023-03-18 00:05:43 [d75880] WARNING: No cbcl files found for cycle 2. Attempt 2 of 3. Retry with cycle 3.
# 2023-03-18 00:05:43 [d75880] ERROR: bcl2fastq::common::Exception: 2023-Mar-18 00:05:43: Success (0): /TeamCityBuildAgent/work/556afd631a5b66d8/src/cxx/lib/layout/Layout.cpp(1028): Throw in function static void bcl2fastq::layout::TileLayoutDetector::readTilesFromCbclHeaders(const boost::filesystem::path&, const bcl2fastq::config::SampleSheetCsv&, const std::vector<boost::basic_regex<char, boost::regex_traits<char> > >&, const string&, std::vector<bcl2fastq::layout::LaneInfo>&, bcl2fastq::common::TileFileMap&, bcl2fastq::common::NumBasesPerByte&, bcl2fastq::common::CycleNumber, bcl2fastq::common::CycleNumber, bool)
# Dynamic exception type: boost::exception_detail::clone_impl<bcl2fastq::common::InputDataError>
# std::exception::what: 
# No cbcl files found for cycle 3. Attempt 3 of 3.
# Corrupt or missing .cbcl files were found for 3 consecutive cycles, verify the source of the data.




