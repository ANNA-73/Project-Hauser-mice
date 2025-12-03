#!/bin/sh
#SBATCH -A p32045
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 4:00:00
#SBATCH --array=1-69
#SBATCH --mem=0
#SBATCH --job-name="bowtie"
#SBATCH --output=/projects/b1042/HartmannLab/Hauser-mice/logs/bowtie%A_%a.out
#SBATCH --error=/projects/b1042/HartmannLab/Hauser-mice/logs/bowtie_%A_%a.err

module purge all
module load bowtie2/2.4.5
module load perl/5.16
module load samtools/1.2

file_path=/projects/b1042/HartmannLab/Hauser-mice/output/spades
out_path=/projects/b1042/HartmannLab/Hauser-mice/output/bowtie
reads_path=/projects/b1042/HartmannLab/Hauser-mice/output/knead_out

mkdir -p $out_path

sample_dirs=($(ls -d ${file_path}/*/))

sample_dir=${sample_dirs[$SLURM_ARRAY_TASK_ID-1]}

full_basename=$(basename $sample_dir)

sample_name=${full_basename%_assembled}

contigs=${sample_dir}/contigs.fasta
R1=${reads_path}/${sample_name}/${sample_name}_R1_001_kneaddata_paired_1.fastq
R2=${reads_path}/${sample_name}/${sample_name}_R1_001_kneaddata_paired_2.fastq

bowtie2-build $contigs ${out_path}/${sample_name}

bowtie2 --threads 16 -q \
    -x ${out_path}/${sample_name} \
    -1 ${R1} \
    -2 ${R2} \
    -S ${out_path}/${sample_name}.bowtie2.sam

samtools view -bS ${out_path}/${sample_name}.bowtie2.sam > ${out_path}/${sample_name}.bowtie2.bam
samtools sort ${out_path}/${sample_name}.bowtie2.bam ${out_path}/${sample_name}.bowtie2.sorted
