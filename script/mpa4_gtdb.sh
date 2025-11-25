#!/bin/bash


path=/projects/b1042/HartmannLab/Hauser-mice/output/mpa4

for file in ${path}/profiled_*.txt ; do
    echo "Processing file: $file"
    sample_name=$(basename "$file" .txt | sed 's/profiled_//')
    output_file="${path}/gtdb_${sample_name}.txt"
    
    sgb_to_gtdb_profile.py -i $file \
     -o $output_file  \
     -d /projects/b1180/db/metaphlan_db_2024/mpa_vJun23_CHOCOPhlAnSGB_202403.pkl 
    
    echo "Created gtdb file: $output_file"
done