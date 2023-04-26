#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=64000
#SBATCH --time=12:00:00
#SBATCH --job-name=analysis_part1
#SBATCH --partition=batch,guest
#SBATCH --error=/qiime2/err.out
#SBATCH --output=/qiime2/std.out
#SBATCH --open-mode=append

##########################################################################
# Import the data into QIIME2 
# Trim adapter sequences using cutadapt 
##########################################################################


module load qiime2/2022.2

cd /qiime2

# Make directories to store results
mkdir -p artifacts
mkdir -p exports

# Import data into QIIME2
qiime tools import \
	--type 'SampleData[PairedEndSequencesWithQuality]' \
	--input-path manifest \
	--input-format PairedEndFastqManifestPhred33V2 \
	--output-path artifacts/demuxed-paired-end.qza
	
# Run cutadapt
qiime cutadapt trim-paired \
    --i-demultiplexed-sequences artifacts/demuxed-paired-end.qza \
    --p-front-f GTGCCAGC MGCCGCGGTAA \
    --p-front-r GGACT ACHVGGGTWTCTAAT \
    --o-trimmed-sequences artifacts/paired-end-demux-trimmed.qza \
    --verbose > cutadapt_log.txt \

