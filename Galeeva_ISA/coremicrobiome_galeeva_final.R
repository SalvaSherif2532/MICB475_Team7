library(tidyverse)
library(phyloseq)
library(microbiome)
library(ggVennDiagram)

galeeva_final_CM <- readRDS("galeeva_final.rds")

# Convert to relative abundance
galeeva_final_RA <- transform_sample_counts(galeeva_final_CM, fun=function(x) x/sum(x))

# Subset dataset into treatment and control groups
galeeva_final_nonsevere <- subset_samples(galeeva_final_RA, `inpatient`=="Ambulatory treatment")
galeeva_final_severe <- subset_samples(galeeva_final_RA, `inpatient`=="Hospitalized")

# Set a prevalence threshold and abundance threshold. Be prepared to justify
nonsevere_ASVs <- core_members(galeeva_final_nonsevere, detection=0.001, prevalence = 0.7)
severe_ASVs <- core_members(galeeva_final_severe, detection=0.001, prevalence = 0.7)
prune_taxa(nonsevere_ASVs,galeeva_final_CM) %>%
  tax_table()
prune_taxa(severe_ASVs,galeeva_final_CM) %>%
  tax_table()

# Make a Venn-diagram
ven_galeeva_final <- ggVennDiagram(x=list(Severe = severe_ASVs, Nonsevere = nonsevere_ASVs))
ggsave("venn_galeeva_final.png", ven_galeeva_final)

# Make sure that you have a line that saves the Venn diagram as a png and this file is present within your project folder