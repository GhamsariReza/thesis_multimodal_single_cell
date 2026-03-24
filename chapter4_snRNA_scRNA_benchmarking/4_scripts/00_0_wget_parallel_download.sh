#!/bin/bash
#SBATCH --job-name=parallel_download
#SBATCH --partition=long
#SBATCH --time=14-00:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mem=12G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=ghamsari.r@wehi.edu.au
#SBATCH --output /vast/scratch/users/ghamsari.r/bamfiles_bmmc/download_o.%j.%N.log
#SBATCH --error /vast/scratch/users/ghamsari.r/bamfiles_bmmc/download_e.%j.%N.log

#bash /stornext/General/data/user_managed/grpu_mritchie_1/reza/softwares/python_projects/scmix2/BMMC_public_multiome/wget_parallel_download.sh

##Script Description
###This script downloads BAM files from NCBI SRA for a specific bioproject (PRJNA799242) using parallel processing. It queries the SRA database, extracts download URLs for 10X Genomics BAM files, and downloads them concurrently using GNU Parallel.

#=============================================================================
# Setup and Configuration
#=============================================================================
# Define working directory and bioproject number
WORK_PATH="/vast/scratch/users/ghamsari.r/bamfiles_bmmc"
BIOPROJECT_NUM="PRJNA799242"

# Create working directory and navigate to it
mkdir -p "$WORK_PATH"
cd "$WORK_PATH"

#=============================================================================
# Extract SRA Metadata
#=============================================================================
# Load required modules for NCBI E-utilities
module load edirect/

# Query SRA database and extract experiment metadata
echo "Extracting SRA metadata for bioproject: ${BIOPROJECT_NUM}"
esearch -db sra -query "${BIOPROJECT_NUM}" | \
    esummary | \
    xtract -pattern DocumentSummary \
           -element Experiment@acc,Run@acc,Platform@instrument_model \
    > "${BIOPROJECT_NUM}-info.tsv"

# Display first few lines of metadata for verification
echo "Sample of extracted metadata:"
head "${BIOPROJECT_NUM}-info.tsv"

#=============================================================================
# Extract BAM File Download URLs
#=============================================================================
# Load SRA toolkit for data access
module load sra-toolkit/

echo "Extracting BAM file download URLs..."

# Process each accession to find BAM file URLs
for accession in $(cut -f 2 "${BIOPROJECT_NUM}-info.tsv"); do
    printf "\n  Working on: %s\n\n" "${accession}"
    
    # Query SRA for XML metadata and extract 10X Genomics BAM file URLs
    esearch -db sra -query "${accession}" | \
        efetch -format xml | \
        xmllint --xpath '//SRAFile[@semantic_name="10X Genomics bam file"]/Alternatives/@url' - | \
        grep -o 'https://[^ ]*' | \
        sed 's/"$//' >> "${BIOPROJECT_NUM}-bam_download_link.tsv"
done

#=============================================================================
# Parallel Download Implementation
#=============================================================================
# Define input file containing download URLs
input_file="${BIOPROJECT_NUM}-bam_download_link.tsv"

# Function to download a single URL using wget
download_url() {
    local url="$1"
    echo "Downloading: $url"
    wget "$url"
}

# Export function for use with GNU Parallel
export -f download_url

# Load GNU Parallel module
module load parallel/20190722

# Execute parallel downloads
echo "Starting parallel download of BAM files..."
parallel -a "$input_file" -j 40 download_url

echo "Download process completed."

#=============================================================================
# Job Performance Summary (from previous run)
#=============================================================================
# Submitted batch job 11915644
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





