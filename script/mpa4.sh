#!/bin/sh
#SBATCH -A p32046
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 4:00:00
#SBATCH --mem=0
#SBATCH --array=1-69
#SBATCH --job-name="mpa4"
#SBATCH --output=/projects/b1042/HartmannLab/Hauser-mice/logs/mpa4_%a.out
#SBATCH --error=/projects/b1042/HartmannLab/Hauser-mice/logs/mpa4_%a.err

module purge all
module load metaphlan/4.0.1

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
  --bowtie2db /projects/b1180/db/metaphlan_db_2024/ \
  --nproc 16 \
  --bowtie2out ${output_path}/${basename}.bowtie2.bz2 \
  --output_file ${output_path}/profiled_${basename}.txt

echo "Completed processing sample: ${basename}"