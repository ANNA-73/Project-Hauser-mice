#!/bin/sh
#SBATCH -A b1042
#SBATCH -p genomics
#SBATCH -N 1
#SBATCH -n 24
#SBATCH -t 10:00:00
#SBATCH --mem=0
#SBATCH --array=1-69
#SBATCH --job-name="mpa4"
#SBATCH --output=/projects/b1042/HartmannLab/Hauser-mice/logs/mpa4_%a.out
#SBATCH --error=/projects/b1042/HartmannLab/Hauser-mice/logs/mpa4_%a.err

module purge all

file_path=/projects/b1042/HartmannLab/Hauser-mice/output/knead_out
output_path=/projects/b1042/HartmannLab/Hauser-mice/output/mpa4

samples=($(ls -d $file_path/*/))


sample_dir=${samples[$SLURM_ARRAY_TASK_ID-1]}
basename=$(basename $sample_dir)


R1=$sample_dir/${basename}_R1_001_kneaddata_paired_1.fastq
R2=$sample_dir/${basename}_R1_001_kneaddata_paired_2.fastq

touch ${output_path}/profiled_${basename}.txt

metaphlan $R1,$R2 \
  --input_type fastq \
  --bowtie2db /projects/b1180/db/metaphlan_db_vJan21 \
  --index mpa_vJan21_CHOCOPhlAnSGB_202103 \
  --nproc 24 \
  --bowtie2out ${output_path}/${basename}.bowtie2.bz2 \
  --output_file ${output_path}/profiled_${basename}.txt

echo "Completed processing sample: ${basename}"