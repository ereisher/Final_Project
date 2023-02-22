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
