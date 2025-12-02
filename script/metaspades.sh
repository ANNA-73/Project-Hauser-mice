#!/bin/sh
#SBATCH -A p32045
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 4:00:00
#SBATCH --array=1-69
#SBATCH --mem=0
#SBATCH --job-name="spades"
#SBATCH --output=/projects/b1042/HartmannLab/Hauser-mice/logs/spades_%A_%a.out
#SBATCH --error=/projects/b1042/HartmannLab/Hauser-mice/logs/spades_%A_%a.err

module purge all

file_path=/projects/b1042/HartmannLab/Hauser-mice/output/knead_out
out_path=/projects/b1042/HartmannLab/Hauser-mice/output/spades
mkdir -p $out_path

samples=($(ls -d $file_path/*/))
sample_dir=${samples[$SLURM_ARRAY_TASK_ID-1]}

basename=$(basename $sample_dir)

R1=$sample_dir/${basename}_R1_001_kneaddata_paired_1.fastq
R2=$sample_dir/${basename}_R1_001_kneaddata_paired_2.fastq



spades.py --meta -1 $R1 -2 $R2 -o ${out_path}/${basename}_assembled -t 16