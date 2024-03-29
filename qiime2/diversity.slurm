#!/bin/bash
#SBATCH --error=/qiime2/err3.out
#SBATCH --output=/qiime2/std3.out

module load qiime2/2022.2

cd /qiime2

############################################
# Declare variable
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

# Collect remaining diversity metrics as stated in paper (dominance and simpson)
qiime diversity alpha \
    --i-table artifacts/table.qza \
    --p-metric dominance \
    --output-dir dominance-results
    
qiime diversity alpha \
    --i-table artifacts/table.qza \
    --p-metric simpson \
    --output-dir simpson-results
    
# Generate pcoa plots (unweighted unifrac and jaccard)
qiime diversity pcoa \
       --i-distance-matrix core-metrics-results/unweighted_unifrac_distance_matrix.qza \
       --p-number-of-dimensions 2 \
       --o-pcoa artifacts/unweighted-unifrac-pcoa-matrix.qza

qiime diversity pcoa \
        --i-distance-matrix core-metrics-results/jaccard_distance_matrix.qza \
        --p-number-of-dimensions 2 \
        --o-pcoa artifacts/jaccard-pcoa-matrix.qza

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
