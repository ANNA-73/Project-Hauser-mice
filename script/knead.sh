#!/bin/sh
#SBATCH -A p32045
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 4:00:00
#SBATCH --mem=0
#SBATCH --array=0-68  
#SBATCH --job-name="knead"
#SBATCH --output=/projects/b1042/HartmannLab/Hauser-mice/knead_%A_%a.out
#SBATCH --error=/projects/b1042/HartmannLab/Hauser-mice/knead_%A_%a.err

module purge all

file_path=/projects/p32045/raw-seq
output_path=/projects/b1042/HartmannLab/Hauser-mice/knead_out
ref_db=/projects/b1042/HartmannLab/Hauser-mice/decon-genome

cd ${file_path}

# Create array of all samples
samples=($(ls *_R1_*.fastq.gz | sed 's/_R1_.*//g' | sort -u))


sample=${samples[$SLURM_ARRAY_TASK_ID]}

echo "Processing sample: ${sample}"
echo "Array task ID: ${SLURM_ARRAY_TASK_ID}"


r1_file=$(ls ${file_path}/${sample}_R1_*.fastq.gz)
r2_file=$(ls ${file_path}/${sample}_R2_*.fastq.gz)


sample_output=${output_path}/${sample}
mkdir -p ${sample_output}

kneaddata \
    --input ${r1_file} \
    --input ${r2_file} \
    --reference-db ${ref_db} \
    --output ${sample_output} \
    --threads 16