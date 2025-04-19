# Alpha Diversity on Galeeva et al dataset #
# (Shannon’s diversity index, Faith’s phylogenetic diversity, richness, and Pielou’s evenness) #

#### Load libraries ####
library(phyloseq)
library(tidyverse)
library(vegan)
library(ape)
library(picante)
library(ggsignif)
library(ggpubr)

#### Load in RData ####
galeeva_rare <- readRDS("Phyloseq_objects/galeeva_rare.rds")
  
otu_table(galeeva_rare)
sample_data(galeeva_rare)
tax_table(galeeva_rare)
phy_tree(galeeva_rare)

# Convert to factor and set levels
galeeva_rare@sam_data$inpatient <- factor(galeeva_rare@sam_data$inpatient, 
                                          levels = c("Ambulatory treatment", "Hospitalized"))

#### Shannon's Diversity Index ######

## Shannon Diversity ##
plot_richness(galeeva_rare) 

plot_richness(galeeva_rare, measures = "Shannon") 

gg_shannon_diversity <- plot_richness(galeeva_rare, x = "inpatient", measures = "Shannon", color = "inpatient") +
  xlab("COVID-19 Severity") + theme_minimal() + 
  geom_boxplot() + 
  stat_compare_means(method = "wilcox.test", label.y.npc = "top", label.x.npc = "centre", vjust = 1, hjust = 0.5, size = 3.5) + 
  scale_color_manual(
    values = c("Ambulatory treatment" = "#00BFC4",  # Blue
               "Hospitalized" = "#F8766D"),         # Red
    labels = c("Ambulatory treatment" = "Less severe", 
               "Hospitalized" = "Severe")
  ) +
  guides(color = "none") +  # Remove color legend
  scale_x_discrete(labels = c("Ambulatory treatment" = "Less severe", 
                              "Hospitalized" = "Severe")) +  # Rename x-axis titles
  theme(
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    plot.title = element_text(size = 14),
    strip.text = element_text(size = 14),    # Change size of the measures text
  )

gg_shannon_diversity

ggsave(filename = "galeeva_Shannon_diversity.png"
       , gg_shannon_diversity
       , height=6, width=4)

## calculate stats for Shannon diversity ##

# adding estimate richness to sample_data #
alphadiv <- estimate_richness(galeeva_rare)
samp_dat <- sample_data(galeeva_rare)
samp_dat_wdiv <- data.frame(samp_dat, alphadiv)

# visualizing counts to determine if normally distributed #
allCounts <- as.vector(otu_table(galeeva_rare))
allCounts <- allCounts[allCounts>0]
hist(allCounts)
hist(log(allCounts))

samp_dat_wdiv %>%
  filter(!is.na(Shannon)) %>%
  ggplot(aes(x=inpatient, y=Shannon))+
  geom_point()

# Visualizing non-parametric distribution (with log as well) #
ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=Shannon), bins=5)

ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=log(Shannon)), bins=5)

# running wilcoxin test on non-parametric data #
wilcox.test(Shannon ~ inpatient, data=samp_dat_wdiv, exact = FALSE)
# Notice that transformation does not affect significance
wilcox.test(log(Shannon) ~ inpatient, data=samp_dat_wdiv, exact = FALSE)

#### Faith's phylogenetic diversity####

# calculate Faith's phylogenetic diversity as PD
phylo_dist <- pd(t(otu_table(galeeva_rare)), phy_tree(galeeva_rare),
                 include.root=F) 

# add PD to metadata table
sample_data(galeeva_rare)$PD <- phylo_dist$PD

# plot any metadata category against the PD
plot.pd <- ggplot(sample_data(galeeva_rare), aes(inpatient, PD)) + 
  geom_violin(aes(colour = inpatient)) +
  geom_boxplot(aes(fill = inpatient), width = 0.5) +
  ylab("Phylogenetic Diversity") + theme_minimal() + 
  #stat_compare_means(method = "wilcox.test", label.y.npc = "top", label.x.npc = "centre", vjust = 1, hjust = 0.5, size = 3.5) + 
  scale_colour_manual(
    values = c("Ambulatory treatment" = "#00BFC4",  # Blue
               "Hospitalized" = "#F8766D"),         # Red
    labels = c("Ambulatory treatment" = "Less severe", 
               "Hospitalized" = "Severe")
  ) +
  scale_fill_manual(
    values = c("Ambulatory treatment" = "#00BFC4",  # Blue
               "Hospitalized" = "#F8766D"),         # Red
    labels = c("Ambulatory treatment" = "Less severe", 
               "Hospitalized" = "Severe")
  ) +
  guides(colour = "none", fill = "none") +  # Remove color legend
  scale_x_discrete(labels = c("Ambulatory treatment" = "Less severe", 
                              "Hospitalized" = "Severe")) +  # Rename x-axis titles
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_text(size = 16),
    axis.text.x = element_text(size = 16),
    axis.text.y = element_text(size = 14),
    plot.title = element_text(size = 14)
  )

# view plot
plot.pd

ggsave(filename = "galeeva_phylogenetic_diversity.png"
       , plot.pd
       , height=6, width=4)

# Run Wilcoxon test to compare PD between levels of Host_disease

phylo_distance_df <- data.frame(sample_data(galeeva_rare))

head(phylo_distance_df)

wilcox_test_result <- wilcox.test(PD ~ inpatient, data = phylo_distance_df)

# Print the result of the test
print(wilcox_test_result)


#### Richness ####

plot_richness(galeeva_rare, measures = "Observed") 

gg_richness <- plot_richness(galeeva_rare, x = "inpatient", measures = "Observed") +
  xlab("COVID-19 Severity") + theme_minimal() + 
  geom_violin(aes(fill = inpatient)) + 
  stat_compare_means(method = "wilcox.test", label.y.npc = "top", label.x.npc = "centre", vjust = 0.5, hjust = 0.5, size = 3.5) + 
  scale_fill_manual(
    values = c("Ambulatory treatment" = "#00BFC4",  # Blue
               "Hospitalized" = "#F8766D"),         # Red
    labels = c("Ambulatory treatment" = "Less severe", 
               "Hospitalized" = "Severe")
  ) +
  guides(fill = "none") +  # Remove color legend
  scale_x_discrete(labels = c("Ambulatory treatment" = "Less severe", 
                              "Hospitalized" = "Severe")) +  # Rename x-axis titles
  theme(
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    plot.title = element_text(size = 14),
    strip.text = element_text(size = 14),    # Change size of the measures text
  )
gg_richness

ggsave(filename = "galeeva_richness.png"
       , gg_richness
       , height=6, width=4)

## calculate stats for Richness ##

samp_dat_wdiv %>%
  filter(!is.na(Observed)) %>%
  ggplot(aes(x=inpatient, y=Observed))+
  geom_point()

# Visualizing non-parametric distribution (with log as well) #
ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=Observed), bins=5)

ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=log(Observed)), bins=5)

# running wilcoxin test on non-parametric data #
wilcox.test(Observed ~ inpatient, data=samp_dat_wdiv, exact = FALSE)
# Notice that transformation does not affect significance
wilcox.test(log(Observed) ~ inpatient, data=samp_dat_wdiv, exact = FALSE)


#### Pielous's evenness ####

# Extract Shannon diversity and species richness from the 'alphadiv' object
shannon_diversity <- alphadiv$Shannon
species_richness <- alphadiv$Observed  # This is the number of taxa (S)

# Calculate Pielou's Evenness: J' = H' / ln(S)
pielou_evenness <- shannon_diversity / log(species_richness)

# Add Pielou's Evenness to the sample data
samp_dat <- sample_data(galeeva_rare)
samp_dat_wdiv <- data.frame(samp_dat, alphadiv, PielouEvenness = pielou_evenness)
samp_dat_wdiv$inpatient <- factor(samp_dat_wdiv$inpatient, 
                                          levels = c("Ambulatory treatment", "Hospitalized"))
# Visualize Pielou's Evenness for different 'inpatient' categories
gg_pielou_evenness <- samp_dat_wdiv %>%
  filter(!is.na(PielouEvenness)) %>%
  ggplot(aes(x = inpatient, y = PielouEvenness, fill = inpatient)) +
  geom_violin(colour = "black") +
  xlab("COVID-19 Severity") +
  ylab("Pielou's Evenness") + 
  theme_minimal() + 
  stat_compare_means(method = "wilcox.test", label.y.npc = "top", label.x.npc = "centre", vjust = 0.2, hjust = 0.5, size = 3.5) + 
  scale_fill_manual(
    values = c("Ambulatory treatment" = "#00BFC4",  # Blue
               "Hospitalized" = "#F8766D"),         # Red
    labels = c("Ambulatory treatment" = "Less severe", 
               "Hospitalized" = "Severe")
  ) +
  guides(fill = "none") +  # Remove color legend
  scale_x_discrete(labels = c("Ambulatory treatment" = "Less severe", 
                              "Hospitalized" = "Severe")) + 
  theme(
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    plot.title = element_text(size = 14)
  )

# Print the plot
gg_pielou_evenness

# Save the plot if needed
ggsave(filename = "galeeva_pielou_evenness.png", gg_pielou_evenness, height = 6, width = 4)

## Calculate stats for Pielou evenness ##

samp_dat_wdiv %>%
  filter(!is.na(PielouEvenness)) %>%
  ggplot(aes(x=inpatient, y=PielouEvenness))+
  geom_point()

# Visualizing non-parametric distribution (with log as well) #
ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=PielouEvenness), bins=5)

ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=log(PielouEvenness)), bins=5)

# running wilcoxin test on non-parametric data #
wilcox.test(PielouEvenness ~ inpatient, data=samp_dat_wdiv, exact = FALSE)
# Notice that transformation does not affect significance
wilcox.test(log(PielouEvenness) ~ inpatient, data=samp_dat_wdiv, exact = FALSE)



