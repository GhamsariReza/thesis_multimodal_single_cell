#!/bin/bash
#SBATCH --job-name=parallel_download
#SBATCH --time=10:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mem=12G
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

#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ Downloading BAM files
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#This script is designed for parallel downloading of BAM files associated with a specific  bioProject number (PRJNA799242). It leverages the SRA toolkit and GNU Parallel to efficiently download large datasets. 
# The edirect module is a set of command-line tools provided by the NCBI Entrez Programming Utilities (E-utilities) for querying and retrieving data from NCBI databases. 

WORK_PATH=/vast/scratch/users/ghamsari.r/bamfiles_bmmc
mkdir -p "$WORK_PATH"
BIOPROJECT_NUM="PRJNA799242"
cd $WORK_PATH
#We can look at it by letting it print some of the the esummary to the terminal:
module load edirect/ 

esearch -db sra -query ${BIOPROJECT_NUM} | esummary | xtract -pattern DocumentSummary -element Experiment@acc,Run@acc,Platform@instrument_model > ${BIOPROJECT_NUM}-info.tsv

head ${BIOPROJECT_NUM}-info.tsv

#@@@@@@@@@@@@@@@@@@@@@@@@@@@ finding bam files links
module load sra-toolkit/

for accession in $(cut -f 2 ${BIOPROJECT_NUM}-info.tsv)
do

    printf "\n  Working on: ${accession}\n\n"
    
    #downloading SRA object
    esearch -db sra -query ${accession} | efetch -format xml | xmllint --xpath '//SRAFile[@semantic_name="10X Genomics bam file"]/Alternatives/@url' - | grep -o 'https://[^ ]*' | sed 's/"$//' >> ${BIOPROJECT_NUM}-bam_download_link.tsv
    
done

##@@@@@@@@@@@@@@ downloading files
# Specify the input file name
input_file=${BIOPROJECT_NUM}-bam_download_link.tsv

# Function to download a URL using wget
download_url() {
  url=$1
  wget "$url"
}

# Export the function so it's accessible to parallel
export -f download_url

# Download URLs in parallel using GNU Parallel
module load parallel/20190722 
parallel -a "$input_file" -j 40 download_url


#Submitted batch job 11915644

# Job ID: 11915644
# Cluster: milton
# User/Group: ghamsari.r/allstaff
# State: COMPLETED (exit code 0)
# Nodes: 1
# Cores per node: 12
# CPU Utilized: 03:56:37
# CPU Efficiency: 6.97% of 2-08:36:12 core-walltime
# Job Wall-clock time: 04:43:01
# Memory Utilized: 86.37 MB
# Memory Efficiency: 0.70% of 12.00 GB





module purge

module load cellranger/7.1.0   
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  Converting bam file to fastq using @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        Cellranger bamtofastq        @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                                     @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# BAM_PATH=/vast/scratch/users/ghamsari.r/bamfiles_bmmc/$BAM_FILE
# mkdir -p $WORK_PATH/bamtofastq_outputs/
# cd $WORK_PATH/bamtofastq_outputs/
# cellranger bamtofastq \
# --nthreads=8 \
# $BAM_PATH \
# $WORK_PATH/bamtofastq_outputs/$DIR_OUT


