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
#SBATCH --output=/projects/b1042/HartmannLab/Howler/bowtie.out
#SBATCH --error=/projects/b1042/HartmannLab/Howler/bowtie.err


module purge all
module load bowtie2/2.4.5
module load perl/5.16
module load samtools/1.2

cd /projects/b1042/HartmannLab/Howler/

export list=(KM-26)


for i in "${list[@]}" ; do
    cd /projects/b1042/HartmannLab/Howler/megahit/${i}-assembled
    bowtie2-build final.contigs.fa  /projects/b1042/HartmannLab/Howler/bowtie/${i}
    cd /projects/b1042/HartmannLab/Howler/bowtie
    bowtie2 --threads 16 -q -x /projects/b1042/HartmannLab/Howler/bowtie/${i}  -1 /projects/b1042/HartmannLab/Howler/fastp-out/${i}_paired_1.fastq -2 /projects/b1042/HartmannLab/Howler/fastp-out/${i}_paired_2.fastq -S ${i}.bowtie2.sam

    samtools  view -bS ${i}.bowtie2.sam > ${i}.bowtie2.bam
    samtools  sort ${i}.bowtie2.bam ${i}.bowtie2.sorted
done
