#!/bin/bash


cd /projects/b1042/HartmannLab/Hauser-mice/output/mpa4


merge_metaphlan_tables.py --gtdb_profiles gtdb_*.txt > merged_gtdb.txt