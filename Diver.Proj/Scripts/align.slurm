#!/bin/sh
#SBATCH --ntasks-per-node=4
#SBATCH --nodes=1
#SBATCH --mem=56gb
#SBATCH --time=4:00:00
#SBATCH --job-name=align
#SBATCH --mail-user=esanchezbetancourt2@huskers.unl.edu
#SBATCH --mail-type=ALL
#SBATCH --error=/work/agro932/esanchezb/div.project932/plate1_bam/fastqfiles/output/align.%J.err
#SBATCH --output=/work/agro932/esanchezb/div.project932/plate1_bam/fastqfiles/output/align.%J.out

# ===================================
# How to submit:
# sbatch --array=1-96 align.slurm
# ===================================

echo $SLURM_JOB_ID
module load bwa samtools
# Get samples.txt line with the sample ID for this array task

cd /work/agro932/esanchezb/div.project932/

SAMPLE=`sed -n ${SLURM_ARRAY_TASK_ID}p samples.txt`
echo "Processing sample $SAMPLE"

bwa mem Ref_Pvulgaris/Ref_PhaVul_Chr9/PVulg1_0.fa\
                     plate1_bam/fastqfiles/${SAMPLE}_trimmed_R1.fastq \
                     plate1_bam/fastqfiles/${SAMPLE}_trimmed_R2.fastq\
                > plate1_bam/fastqfiles/output/sam/${SAMPLE}_align.sam

echo "Processing complete for sample $SAMPLE"


