# Reproducing Methodology and Results in a Study on the Disruption of Gut Microbiome Due to Oral Antibiotics in Patients Post Prostate Biopsy
This reproducibility project utilizes a publicly available dataset to reproduce results shown in: 

Li, J. K. M., Wang, L. L., Lau, B. S. Y., Tse, R. T. H., Cheng, C. K. L., Leung, S. C. H., Wong, C. Y. P., Tsui, S. K. W., Teoh, J. Y. C., Chiu, P. K. F., & Ng, C. F. (2022). Oral antibiotics perturbation on gut microbiota after prostate biopsy. Frontiers in cellular and infection microbiology, 12, 959903. https://doi.org/10.3389/fcimb.2022.959903

Bioproject Accession Number: PRJNA858302 
No code for this project was developed by the authors of this paper. 

## Purpose:
The purpose of this project was to test the reproducibility of a published gut microbiome study by developing code and generating results based on the information provided in the paper. This project aims to discover best practices of reproducilbility by reproducing methods and results as presented in the paper. In this project, I was able to develop a pipeline to generate similar results to those presented in the paper as well as generate "10 Simple Rules for Reproducible Research" from lessons learned and challenges encountered during this project.  

## Project Objectives: 
1. Reproduce methodology and results presented in a paper that studied the disruption of gut microbiome due to oral antibiotics in patients post prostate biopsy.
 - Deliverable- Pipeline for analysis consisting of slurm files, python files, and a R file to run the pipeline and visualize results. 
2. Create a Github repository for the project.
 - Deliverable- A fully functional and readable Github for the project. 
3. Determine best practices for ensuring projects can be reproduced via delivering a write-up post project. 
 - Deliverable- Paper discussing best practices based on challenges I encounted a long the way and potential requirements to ensure that projects are reproducible.

## Background:

## Project Components:
1. A reproducible bash shell script
 - All QIIME2 and LEfSe scripts are bash and reproducible across datasets
2. Python script for data analysis or visualization
 - Python script developed to visualize the title the same as the paper
 - R scripts developed for data visualization
3. 10 Simple Rules for Conducting Reproducible Research

## Users:
I would anticipate individuals who are looking to conduct simple microbiome analysis to use this project. I would also anticipate individuals who wanted to generate R plots from QIIME2 files to utilize the R script for the visualization.

## Implementation Constraints:
- The paper utilized the Galaxy instance of LEfSe, which proved to be challenging for implementation since it is not reproducible nor was the specific values required to run LEfSe on Galaxy provided in the paper. 
- The R packages needed to generate the results require many packages and libraries that were not stated in the paper. If someone was not familiar with R when conducting a similar project, generating the results would be difficult due to the knowledge required to find and install the different dependencies. Additionally, the main R package used is poorly documented, requiring many attempts before getting the package to work properly. 

## The project follows the following pipeline: 
![pipeline-overview](https://github.com/ereisher/Final_Project/blob/main/pipeline(1).png)

Detailed steps can be found in the [Steps File](https://github.com/ereisher/Final_Project/blob/main/steps.md)

This repository uses the MIT License 
### References:
-Baker, M. (2016). Why scientists must share their research code. Nature. https://doi.org/10.1038/nature.2016.20504
-FAIR Principles. (n.d.). GO FAIR. Retrieved April 27, 2023, from https://www.go-fair.org/fair-principles/
-Pineau, J., Vincent-Lamarre, P., Sinha, K., Larivière, V., Beygelzimer, A., d’Alché-Buc, F., Fox, E., & Larochelle, H. (2021). Improving reproducibility in machine learning research (a report from the NeurIPS 2019 reproducibility program). The Journal of Machine Learning Research, 22(1), 164:7459-164:7478.
-Plain Language. (n.d.). National Institutes of Health (NIH). Retrieved May 3, 2023, from https://www.nih.gov/institutes-nih/nih-office-director/office-communications-public-liaison/clear-communication/plain-language
-Sabot, F. (2022). On the importance of metadata when sharing and opening data. BMC Genomic Data, 23(1), 79. https://doi.org/10.1186/s12863-022-01095-1
-Yang, B., Liping, Z., & Fengrong, Z. (2019). A Survey on Research of Code Comment. Proceedings of the 2019 3rd International Conference on Management Engineering, Software Engineering and Service Sciences, 45–51. https://doi.org/10.1145/3312662.3312710

