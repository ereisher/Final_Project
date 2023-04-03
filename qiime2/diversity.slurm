#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=16
#SBATCH --mem=64000
#SBATCH --time=12:00:00
#SBATCH --job-name=analysis_part3
#SBATCH --partition=batch,guest
#SBATCH --error=/home/claytonlab/ereisher/final_project/qiime2/err3.out
#SBATCH --output=/home/claytonlab/ereisher/final_project/qiime2/std3.out
#SBATCH --open-mode=append


module load qiime2/2022.2

cd /home/claytonlab/ereisher/final_project/qiime2

############################################
# Declare local variables
############################################

# For diversity core-metrics-phylogenetic, the value was determined from 
# what was provided in the paper
p_sampling_depth=29000


# Collect core diversity metrics
qiime diversity core-metrics-phylogenetic \
    --i-phylogeny artifacts/rooted-tree.qza \
    --i-table artifacts/table.qza \
    --p-sampling-depth $p_sampling_depth \
    --m-metadata-file metadata.tsv \
    --output-dir core-metrics-results

# Collect remaining diversity metrics 
qiime diversity alpha \
    --i-table artifacts/table.qza \
    --p-metric dominance \
    --output-dir dominance-results
    
qiime diversity alpha \
    --i-table artifacts/table.qza \
    --p-metric simpson \
    --output-dir simpson-results
    
# pcoa plots
qiime diversity pcoa \
       --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
       --p-number-of-dimensions 2 \
       --o-pcoa artifacts/unweighted-unifrac-pcoa-matrix.qza

qiime diversity pcoa \
        --i-distance-matrix core-metrics-results/jaccard_distance_matrix.qza \
        --p-number-of-dimensions 2 \
        --o-pcoa artifacts/jaccard-pcoa-matrix.qza


# Export only files that are less than 100M
for file in artifacts/*; do
    output_path=$(echo $file | sed -E 's#^.*/(.*)\.qz[av]$#exports/\1#')
	size=$(du -s $file | sed -E 's#^(.*)\s.*$#\1#')
	if [[ !( -e $output_path )  &&  $( echo "$size<100000" | bc  -l ) == 1 ]]
        then
                qiime tools export \
                        --input-path $file \
                        --output-path $output_path
        fi
done

for file in core-metrics-results/*; do
    output_path=$(echo $file | sed -E 's#^.*/(.*)\.qz[av]$#exports/\1#')
    size=$(du -s $file | sed -E 's#^(.*)\s.*$#\1#')
    if [[ !( -e $output_path )  &&  $( echo "$size<100000" | bc  -l ) == 1 ]]
        then
                qiime tools export \
                        --input-path $file \
                        --output-path $output_path
        fi
done

# Prepare file for Lefse analysis at genus level

declare -a taxa_levels=("6")
qza=".qza"

for taxa_level in "${taxa_levels[@]}"; do
    out_collapsed_path="artifacts/phyla_table_level_$taxa_level$qza"
    out_rel_path="artifacts/phyla_table_rel_level_$taxa_level$qza"
    
    qiime taxa collapse \
        --i-table artifacts/table.qza \
        --i-taxonomy artifacts/taxonomy.qza \
        --p-level $taxa_level \
        --o-collapsed-table $out_collapsed_path

    qiime feature-table relative-frequency \
        --i-table $out_collapsed_path \
        --o-relative-frequency-table $out_rel_path
    
    for file in artifacts/*; do
        output_path=$(echo $file | sed -E 's#^.*/(.*)\.qz[av]$#exports/\1#')
        size=$(du -s $file | sed -E 's#^(.*)\s.*$#\1#')
        if [[ !( -e $output_path )  &&  $( echo "$size<100000" | bc  -l ) == 1 ]]
            then
                    qiime tools export \
                            --input-path $file \
                            --output-path $output_path
            fi
    done
    
    biom_path="exports/phyla_table_rel_level_$taxa_level/feature-table.biom"
    tsv_path="exports/phyla_table_rel_level_$taxa_level/phyla_table_rel_level_$taxa_level.tsv"
    biom convert \
        -i $biom_path \
        -o $tsv_path \
        --to-tsv 
done
