#!/bin/sh
#SBATCH -A p32046
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 2:00:00
#SBATCH --mem=10
#SBATCH --job-name="concat"
#SBATCH --output=/projects/b1042/HartmannLab/Hauser-mice/logs/concat.out
#SBATCH --error=/projects/b1042/HartmannLab/Hauser-mice/logs/concat.err

file_path=/projects/b1042/HartmannLab/Hauser-mice/output/knead_out
output_path=/projects/b1042/HartmannLab/Hauser-mice/output/humann/cat


for sample_dir in ${file_path}/*/; do
    basename=$(basename $sample_dir)
    
    R1=$sample_dir/${basename}_R1_001_kneaddata_paired_1.fastq
    R2=$sample_dir/${basename}_R1_001_kneaddata_paired_2.fastq
    
    
    # Concatenate R1 and R2
    cat ${R1} ${R2} > ${output_path}/${basename}_combined.fastq
    
    echo "Created: ${output_path}/${basename}_combined.fastq"
done

echo "All samples processed!"