1. Get raw reads sequnces (fastq)-files can be found in the [Raw Reads folder](https://github.com/ereisher/Final_Project/tree/main/rawreads)
    - Navigate to the SRA Run Selector (https://www.ncbi.nlm.nih.gov/Traces/study/)
    - Use this SRA BioProject ID as the accession number: PRJNA858302
    - Select all the samples and download the accession list and metadata for the samples
    - Name the downloaded accession list file 'SRR_Acc_List.txt' and leave one new line in the end of the file. 
    - Run the 'bash get_fastq.sh' in the directory you wish to get the sequnces.
