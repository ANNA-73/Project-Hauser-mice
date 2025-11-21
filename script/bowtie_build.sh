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
#SBATCH --output=/projects/b1042/HartmannLab/Hauser-mice/bowtie.out
#SBATCH --error=/projects/b1042/HartmannLab/Hauser-mice/bowtie.err


module purge all
module load bowtie2/2.4.5
module load perl/5.16
module load samtools/1.2

cd /projects/b1042/HartmannLab/Hauser-mice/decon-genome

bowtie2-build hg38.fna,mouse.fna  host_contam --threads 16 --large-index
    