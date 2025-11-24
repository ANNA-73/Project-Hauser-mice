#!/bin/sh
#SBATCH -A p32045
#SBATCH -p short
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -t 4:00:00
#SBATCH --mem=30G
#SBATCH --job-name="bowtie"
#SBATCH --mail-user=anahid.moghadam@northwestern.edu
#SBATCH --mail-type=FAIL
#SBATCH --output=/projects/b1042/HartmannLab/Hauser-mice/logs/bowtie.out
#SBATCH --error=/projects/b1042/HartmannLab/Hauser-mice/logs/bowtie.err


module purge all
module load bowtie2/2.4.5


file_path=/projects/b1042/HartmannLab/Hauser-mice/input/references/

bowtie2-build ${file_path}Z4160.fasta,${file_path}KPN46.fasta ${file_path}/KZ/KZ --threads 16 
    