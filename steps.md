1. Get samples for analysis
    - Use this SRA BioProject ID as the accession number: PRJNA858302
    - Select all the samples and download the accession list and metadata for the samples
    - Download sequences to workspace

2. Run Qiime2- files can be found in the [qiime2 folder](https://github.com/ereisher/Final_Project/tree/main/qiime2)
    - Make a directory called 'qiime2' and make sure QIIME2 version 2022.2 is installed with all of the plugins listed in [Plugins](https://github.com/ereisher/Final_Project/blob/main/plugins.md). 
    - Bulid the manifest file (sample format is provided)
    - Use Silva-138-99-nb-classifier as the reference database
    - Make sure these files are included in the 'qiime2' directory: metadata.tsv, manifest, and silva database.
    - Run demux.slurm
    - Run dada2.slurm
    - Run diversity.slurm
      
3. Run LEfSe- files can be found in the [LEfSe folder](https://github.com/ereisher/Final_Project/tree/main/LEfSe)
    - Install LEfSe version 1.0
    - Make a sub-directory to 'qiime2' called 'lefse'.
    - Make sure that 'format_rel_level.sh', 'rel_format.py' and 'header_clean.py' are included in the directory
    - Run 'format_rel_level.sh'
4. Plot using R- files can be found in the [R folder](https://github.com/ereisher/Final_Project/blob/main/R/r_analysis.R)
    - Make a directory called 'R'
    - Make sure the 'r_analysis.R', 'table.qza', 'metadata.tsv', 'taxonomy.qza', adn 'rooted-tree.qza' files are available in the directory
    - Run 'r_analysis.R'

