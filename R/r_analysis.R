# Install and load necessary packages 
install.packages("microeco")
install.packages("tidyverse")
library(tidyverse)
if (!requireNamespace("devtools", quietly = TRUE)){install.packages("devtools")}
devtools::install_github("jbisanz/qiime2R", force = TRUE)
library(qiime2R)
library(microeco)
library(magrittr)
library(ggplot2)
if(!require("BiocManager", quietly = TRUE)) install.packages("BiocManager")
install.packages("file2meco", repos = BiocManager::repositories())
install.packages("ggpubr", repos = "https://cloud.r-project.org/", dependencies = TRUE)
library(file2meco)
library(ape)
install.packages("GUniFrac")

# Load and create dataset
dataset <- qiime2meco(feature_table = 'table.qza', sample_table = 'metadata.tsv', taxonomy_table = 'taxonomy.qza', phylo_tree = 'rooted-tree.qza')

# Filter and clean dataset
dataset$filter_pollution(taxa = c("mitochondria", "chloroplast"))
dataset$tidy_dataset()

# Calculate abdundance for alpha & beta diversity 
dataset$cal_abund()
dataset$save_abund(dirpath = "taxa_abund")
dataset$cal_alphadiv(PD = FALSE)
dataset$save_alphadiv(dirpath = "alpha_diversity")
dataset$cal_betadiv(unifrac = TRUE)
dataset$save_betadiv(dirpath = "beta_diversity")

# Create a backup dataset & filter the data
filter_data <- clone(dataset)
filter_data$filter_taxa(rel_abund = 0.0001, freq = 0.1)

# Create a backup dataset & summarize the taxa
backup <- clone(dataset)
backup$taxa_sums

# Calculate and plot diagrams for alpha & beta diversity 
# Shannon
t1 <- trans_alpha$new(dataset = filter_data, group = "Abx")
t1$cal_diff(method = "wilcox")
t1$res_diff
t1$plot_alpha(measure = "Shannon")

# Simpson 
t2 <- trans_alpha$new(dataset = filter_data, group = "Abx")
t2$cal_diff(method = "wilcox")
t2$res_diff
t2$plot_alpha(measure = "Simpson")

#Inverse Simpson
t3 <- trans_alpha$new(dataset = filter_data, group = "Abx")
t3$cal_diff(method = "wilcox")
t3$res_diff
t3$plot_alpha(measure = "InvSimpson")

# Jaccard
t4 <- trans_beta$new(dataset = filter_data, group = "Abx", measure = "jaccard")
t4$cal_manova(manova_all = TRUE)
t4$cal_ordination(ordination = "PCoA")
t4$plot_ordination(plot_color = "Abx", plot_shape = "Abx", plot_type = c("point", "ellipse"))

# Unweighted Unifrac
t5 <- trans_beta$new(dataset = filter_data, group = "Abx", measure = "unwei_unifrac")
t5$cal_manova(manova_all = TRUE)
t5$cal_ordination(ordination = "PCoA")
t5$plot_ordination(plot_color = "Abx", plot_shape = "Abx", plot_type = c("point", "ellipse"))

# Calculate and plot Phylum abundance
t6 <- trans_abund$new(dataset = filter_data, taxrank = "Phylum", ntaxa = 10, groupmean = "Abx")
g6 <- t6$plot_bar(others_color = "grey70", legend_text_italic = FALSE)
g6 + theme_classic() + theme(axis.title.y = element_text(size = 18))

t7 <- trans_abund$new(dataset = filter_data, taxrank = "Phylum", ntaxa = 4)
t7$plot_box(group = "Abx")
