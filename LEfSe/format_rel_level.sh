#!/bin/bash


module purge
module load lefse/1.0

# Get the phyla_table_rel_level files
cp ../exports/phyla_table_rel_level_6/phyla_table_rel_level_6.tsv .

# Generate the sample list with differences to study
cut ../metadata.tsv -f 1,2 > sample_list_type.tsv

# Remove Eukaryotes and unassigned
grep -v "Eukar" phyla_table_rel_level_6.tsv >tmp
grep -v "Unassigned" tmp >phyla_table_rel_level_6.tsv 

# Get the correct format to run LEfSe
python rel_format.py -i sample_list_type.tsv -r phyla_table_rel_level_6.tsv -o rel_level_6.tsv
sed 's/\t/\t/g' rel_level_6.tsv > rel_level_6.txt

# Clean the header to match paper
python header_clean.py

# Run LEfSe
lefse-format_input.py clean_rel_level_6.txt rel_level_6.in -c 1 -s -1 -u 2 -o 1000000
run_lefse.py rel_level_6.in rel_level_6.res
lefse-plot_res.py rel_level_6.res rel_level_6.png 


