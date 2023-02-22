1. Get raw reads sequnces (fastq)-files can be found in the [Raw Reads folder](https://github.com/ereisher/Final_Project/tree/main/rawreads)
    - Navigate to the SRA Run Selector (https://www.ncbi.nlm.nih.gov/Traces/study/)
    - Use this SRA BioProject ID as the accession number: PRJNA858302
    - Select all the samples and download the accession list and metadata for the samples
    - Name the downloaded accession list file 'SRR_Acc_List.txt' and leave one new line in the end of the file. 
    - Run 'bash get_fastq.sh' in the directory you wish to get the sequnces.

2. Pre-process the data using FastQC and MultiQC- files can be found in the [Pre-Process folder](https://github.com/ereisher/Final_Project/tree/main/Pre-Process)
    - Run 'bash get_sample_name_dic.sh > sample_dic.txt' to get the sample list in the format where each accession number separated by space
    - Copy sample_dic.txt file to qc.slurm for the 'sample_name' variable 
    - Make a directory called 'qc' and make a sub-directory called 'script_output'
    - Edit the paths in line 8, 9, and 20 to match your own file organization 
    - Run qc.slurm

3. Run Qiime2- files can be found in the [qiime2 folder](https://github.com/ereisher/Final_Project/tree/main/qiime2)
    - Make a directory called 'qiime2' and make sure QIIME2 version 2022.2 is installed with all of the plugins listed in [Plugins]. 
    - Bulid the manifest file using 'manifest_builder.py' and specifiying -i SRR_Acc_List.txt -p path_to_the_raw_reads
    - Use Silva-138-99-nb-classifier as the reference database
    - Make sure these files are included in the 'qiime2' directory: metadata.tsv, manifest, and silva database.
    - Edit the path in line 10, 11, and 22 to match your own file organization 
    - Run qiime2.slurm
      
4. Normalization using SRS (scaling with ranked subsampling) method:
        * First, download the amplicon sequence variant (ASV) or the operational taxonomic unit (OTU) found in the artifacts directory 'table.qza'. 
        * Second, upload the 'table.qza' to the SRS Shiny app (https://vitorheidrich.shinyapps.io/srsshinyapp/) in order to choose a sampling depth (Cmin) or the normalization cut-off value.
        * It is best to choose a Cmin which doesn’t result in eliminating so many samples.
        * Once a Cmin value was chosen add it to line 7 in the 'normalized_srs.sh' script.
        * Finally, run the 'bash normalized_srs.sh' from the 'qiime2' directory.

