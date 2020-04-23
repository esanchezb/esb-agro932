#!/bin/sh
#SBATCH --ntasks-per-node=4
#SBATCH --nodes=1
#SBATCH --mem=50gb
#SBATCH --time=10:00:00
#SBATCH --job-name=bam
#SBATCH --mail-user=esanchezbetancourt2@huskers.unl.edu
#SBATCH --mail-type=ALL
#SBATCH --error=/work/agro932/esanchezb/div.project932/plate1_bam/fastqfiles/output/bam.%J.err
#SBATCH --output=/work/agro932/esanchezb/div.project932/plate1_bam/fastqfiles/output/bam.%J.out

# ===================================
# How to submit:
# sbatch --array=1-96 bam.slurm
# ===================================

echo $SLURM_JOB_ID
module load samtools/0.1

# Get samples.txt line with the sample ID for this array task

cd /work/agro932/esanchezb/div.project932/

SAMPLE=`sed -n ${SLURM_ARRAY_TASK_ID}p samples.txt`
echo "Processing sample $SAMPLE"

samtools view -bT Ref_Pvulgaris/Ref_PhaVul_Chr9/PVulg1_0 plate1_bam/fastqfiles/output/sam/${SAMPLE}_align.sam >plate1_bam/fastqfiles/output/bam/${SAMPLE}.bam
samtools sort plate1_bam/fastqfiles/output/bam/${SAMPLE}.bam plate1_bam/fastqfiles/output/bam/${SAMPLE}_sorted
samtools index plate1_bam/fastqfiles/output/bam/${SAMPLE}_sorted.bam plate1_bam/fastqfiles/output/bam/${SAMPLE}_sorted.bai
samtools idxstats plate1_bam/fastqfiles/output/bam/${SAMPLE}_sorted.bam >plate1_bam/fastqfiles/output/bam/${SAMPLE}_sorted.stats

echo "Processing complete for sample $SAMPLE"


