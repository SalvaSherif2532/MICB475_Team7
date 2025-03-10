library(phyloseq)
library(tidyverse)
library(ggplot2)
library(RColorBrewer)

## Load RDS objects
galeeva <- readRDS("~/MICB_475/galeeva_rare.rds")
almomani <- readRDS("~/MICB_475/almomani_rare.rds")

## Plot bar plot of taxonomy for each
galeeva_hosp <- subset_samples(galeeva, inpatient == "Hospitalized")
galeeva_amb <- subset_samples(galeeva, inpatient == "Ambulatory treatment")
plot_bar(galeeva_hosp, fill="Phylum") 
plot_bar(galeeva_amb, fill="Phylum") 

# Aggregate hospitalized vs ambulatory
galeeva_aggreg <- merge_samples(galeeva, "inpatient")
galeeva_aggreg_RA <- transform_sample_counts(galeeva_aggreg, function(x) x/sum(x))
sample_data(galeeva_aggreg_RA)$inpatient <- rownames(sample_data(galeeva_aggreg_RA))

# Convert to relative abundance
#galeeva_RA_hosp <- transform_sample_counts(galeeva_hosp, function(x) x/sum(x))
#galeeva_RA_amb <- transform_sample_counts(galeeva_amb, function(x) x/sum(x))

# Plotting mean abundance for clarity galeeva
galeeva_RA_long <- psmelt(galeeva_aggreg_RA) %>%
  group_by(inpatient, Phylum) %>%
  summarize(MeanAbundance = mean(Abundance, na.rm = TRUE), .groups = "drop") %>%
  filter(!is.na(MeanAbundance) & MeanAbundance > 0)

gg_taxa <- ggplot(galeeva_relab_long, aes(x = inpatient, y = MeanAbundance, fill = Phylum)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  ggtitle("Mean Taxonomic Composition by Inpatient Status") +
  scale_fill_viridis(discrete = TRUE)

ggsave("taxonomy_galeeva.png"
       , gg_taxa
       , height=8, width =12)

# Everything for almomani sputum vs swab
almomani_aggreg <- merge_samples(almomani, "env_medium")
almomani_aggreg_RA <- transform_sample_counts(galeeva_aggreg, function(x) x/sum(x))
sample_data(almomani_aggreg_RA)$env_medium <- rownames(sample_data(galeeva_aggreg_RA))

almomani_RA_long <- psmelt(almomani_aggreg_RA) %>%
  group_by(env_medium, Phylum) %>%
  summarize(MeanAbundance = mean(Abundance, na.rm = TRUE), .groups = "drop") %>%
  filter(!is.na(MeanAbundance) & MeanAbundance > 0)

gg_taxa_almomani <- ggplot(almomani_RA_long, aes(x = env_medium, y = MeanAbundance, fill = Phylum)) +
  geom_bar(stat = "identity") +
  theme_minimal() +
  ggtitle("Mean Taxonomic Composition for Swab vs Sputum") +
  scale_fill_viridis(discrete = TRUE)

ggsave("taxonomy_almomani.png"
       , gg_taxa
       , height=8, width =12)

