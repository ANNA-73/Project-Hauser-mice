#!/bin/bash
#SBATCH -A p32045
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 4:00:00
#SBATCH --mem=0
#SBATCH --array=1-69
#SBATCH --job-name="rgi"
#SBATCH --output=/projects/b1042/HartmannLab/Hauser-mice/rgi_%A_%a.out
#SBATCH --error=/projects/b1042/HartmannLab/Hauser-mice/rgi_%A_%a.err

module purge

source activate /projects/b1180/software/conda_envs/rgi6

cd /projects/b1042/HartmannLab/Hauser-mice/output

file_path=/projects/b1042/HartmannLab/Hauser-mice/output/spades
output_path=/projects/b1042/HartmannLab/Hauser-mice/rgi_out
CARD_db=/projects/b1180/db/CARD_2025-05_v4.0.1

mkdir -p ${output_path}
rgi clean --local
rgi load --card_json ${CARD_db}/card.json --local

# Create array of all sample directories
sample_dirs=($(ls -d *_assembled))

# Get the specific sample directory for this array task
sample_dir=${sample_dirs[$SLURM_ARRAY_TASK_ID-1]}

# Extract sample name by removing the _assembled suffix
sample_name=$(basename ${sample_dir} _assembled)

# Run RGI on the specific sample
rgi main -i ${file_path}/${sample_dir}/contigs.fasta \
    -o ${output_path}/${sample_name}_rgi_output \
    --input_type contig \
    --local \
    --clean \
    --num_threads 16
