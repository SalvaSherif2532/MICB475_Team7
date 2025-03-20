#Rarefied Galeeva et al core microbiome
library(tidyverse)
library(phyloseq)
library(microbiome)
library(ggVennDiagram)

galeeva_rare_CM <- readRDS("galeeva_rare.rds")

#Glom to genus level
galeeva_genus <- tax_glom(galeeva_rare_CM, "Genus", NArm = FALSE)

# Convert to relative abundance
galeeva_rare_RA <- transform_sample_counts(galeeva_genus, fun=function(x) x/sum(x))

# Subset dataset into treatment and control groups
galeeva_rare_nonsevere <- subset_samples(galeeva_rare_RA, `inpatient`=="Ambulatory treatment")
galeeva_rare_severe <- subset_samples(galeeva_rare_RA, `inpatient`=="Hospitalized")

# Set a prevalence threshold and abundance threshold. Be prepared to justify
nonsevere_rare_ASVs <- core_members(galeeva_rare_nonsevere, detection=0.001, prevalence = 0.5)
severe_rare_ASVs <- core_members(galeeva_rare_severe, detection=0.001, prevalence = 0.5)
prune_taxa(nonsevere_rare_ASVs,galeeva_rare_CM) %>%
  tax_table()
prune_taxa(severe_rare_ASVs,galeeva_rare_CM) %>%
  tax_table()

# Make a Venn-diagram
ven_galeeva_rare <- ggVennDiagram(x=list(Severe = severe_rare_ASVs, Nonsevere = nonsevere_rare_ASVs))
ggsave("venn_galeeva_rare_glom.png", ven_galeeva_rare)
