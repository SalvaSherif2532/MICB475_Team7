# Alpha Diversity on Al-Momani et al dataset #
# (Shannon’s diversity index, Faith’s phylogenetic diversity, richness, and Pielou’s evenness) #

# install.packages("ggpubr")

#### Load libraries ####
library(phyloseq)
library(tidyverse)
library(vegan)
library(ape)
library(picante)
library(ggsignif)
library(ggpubr)


#### Load in RData ####
load("almomani_rare.RData")
load("almomani_final.RData")

otu_table(almomani_rare)
sample_data(almomani_rare)
tax_table(almomani_rare)
phy_tree(almomani_rare)

# SELECT SPUTUM SAMPLES ONLY AND REMOVE CONTROL GROUP FROM AL-MOMANI RARE #
almomani_rare_sputum <- subset_samples(almomani_rare, env_medium == "Sputum")
almomani_rare_sputum_no_control <- subset_samples(almomani_rare_sputum, Host_disease != "Control")

# Convert to factor and set levels
almomani_rare_sputum_no_control@sam_data$Host_disease <- factor(almomani_rare_sputum_no_control@sam_data$Host_disease, 
                                          levels = c("Covid", "ICU"))

#### Shannon's Diversity Index ######

## Shannon Diversity ##
plot_richness(almomani_rare_sputum_no_control) 

plot_richness(almomani_rare_sputum_no_control, measures = "Shannon") 

almomani_shannon_diversity <- plot_richness(almomani_rare_sputum_no_control, x = "Host_disease", measures = "Shannon", color = "Host_disease") +
  xlab("Severity") + theme_minimal() +
  geom_boxplot() +
  stat_compare_means(method = "wilcox.test", label.y.npc = "top", label.x.npc = "centre", vjust = 1, hjust = 0.5, size = 3.5) + 
  scale_color_manual(
    values = c("Covid" = "#00BFC4",  # Blue
               "ICU" = "#F8766D"),         # Red
    labels = c("Covid" = "Less severe", 
               "ICU" = "Severe")) +
  guides(color = "none") +  # Remove color legend
  scale_x_discrete(labels = c("Ambulatory treatment" = "Less severe", 
                              "Hospitalized" = "Severe")) +  # Rename x-axis titles
  theme(
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    plot.title = element_text(size = 14),
    strip.text = element_text(size = 14),    # Change size of the measures text
  )

almomani_shannon_diversity

ggsave(filename = "almomani_severity_Shannon_diversity.png"
       , almomani_shannon_diversity
       , height=6, width=4)

## calculate stats for Shannon diversity ##

# adding estimate richness to sample_data #
alphadiv <- estimate_richness(almomani_rare_sputum_no_control)
samp_dat <- sample_data(almomani_rare_sputum_no_control)
samp_dat_wdiv <- data.frame(samp_dat, alphadiv)

# visualizing counts to determine if normally distributed #
allCounts <- as.vector(otu_table(almomani_rare_sputum_no_control))
allCounts <- allCounts[allCounts>0]
hist(allCounts)
hist(log(allCounts))

samp_dat_wdiv %>%
  filter(!is.na(Shannon)) %>%
  ggplot(aes(x=Host_disease, y=Shannon))+
  geom_point()

# Visualizing non-parametric distribution (with log as well) #
ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=Shannon), bins=5)

ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=log(Shannon)), bins=5)

# running wilcoxin test on non-parametric data #
wilcox.test(Shannon ~ Host_disease, data=samp_dat_wdiv, exact = FALSE)
# Notice that transformation does not affect significance
wilcox.test(log(Shannon) ~ Host_disease, data=samp_dat_wdiv, exact = FALSE)

#### Faith's phylogenetic diversity####

# calculate Faith's phylogenetic diversity as PD
phylo_dist <- pd(t(otu_table(almomani_rare_sputum_no_control)), phy_tree(almomani_rare_sputum_no_control),
                 include.root=F) 

# add PD to metadata table
sample_data(almomani_rare_sputum_no_control)$PD <- phylo_dist$PD

# plot any metadata category against the PD
plot.pd <- ggplot(sample_data(almomani_rare_sputum_no_control), aes(Host_disease, PD, fill = Host_disease)) + 
  geom_violin(colour = "black", trim = FALSE) +
  xlab("COVID-19 Severity") +
  ylab("Phylogenetic Diversity") + theme_minimal() + 
  stat_compare_means(method = "wilcox.test", label.y.npc = "top", label.x.npc = "centre", vjust = 0.2, hjust = 0.5, size = 3.5) + 
  scale_fill_manual(
    values = c("Covid" = "#00BFC4",  # Blue
               "ICU" = "#F8766D"),         # Red
    labels = c("Covid" = "Less severe", 
               "ICU" = "Severe")
  ) +
  guides(fill = "none") +  # Remove color legend
  scale_x_discrete(labels = c("Covid" = "Less severe", 
                              "ICU" = "Severe")) +  # Rename x-axis titles
  theme(
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    plot.title = element_text(size = 14)
  )


# view plot
plot.pd

ggsave(filename = "almomani_severity_phylogenetic_diversity.png"
       , plot.pd
       , height=6, width=4)

# Run Wilcoxon test to compare PD between levels of Host_disease

phylo_distance_df <- data.frame(sample_data(almomani_rare_sputum_no_control))

head(phylo_distance_df)

wilcox_test_result <- wilcox.test(PD ~ Host_disease, data = phylo_distance_df)

# Print the result of the test
print(wilcox_test_result)

#### Richness ####

plot_richness(almomani_rare_sputum_no_control, measures = "Observed") 

almomani_richness <- plot_richness(almomani_rare_sputum_no_control, x = "Host_disease", measures = "Observed") +
  xlab("COVID-19 Severity") +
  theme_minimal() + 
  geom_violin(aes(fill = Host_disease), trim = FALSE) + 
  stat_compare_means(method = "wilcox.test", label.y.npc = "top", label.x.npc = "centre", vjust = 0.5, hjust = 0.5, size = 3.5) + 
  scale_fill_manual(
    values = c("Covid" = "#00BFC4",  # Blue
               "ICU" = "#F8766D"),         # Red
    labels = c("Covid" = "Less severe", 
               "ICU" = "Severe")
  ) +
  guides(fill = "none") +  # Remove color legend
  scale_x_discrete(labels = c("Covid" = "Less severe", 
                              "ICU" = "Severe")) +  # Rename x-axis titles
  theme(
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    plot.title = element_text(size = 14),
    strip.text = element_text(size = 14)
  )

almomani_richness

ggsave(filename = "almomani_severity_richness.png"
       , almomani_richness
       , height=6, width=4)

## calculate stats for Richness ##

samp_dat_wdiv %>%
  filter(!is.na(Observed)) %>%
  ggplot(aes(x=Host_disease, y=Observed))+
  geom_point()

# Visualizing non-parametric distribution (with log as well) #
ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=Observed), bins=5)

ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=log(Observed)), bins=5)

# running wilcoxin test on non-parametric data #
wilcox.test(Observed ~ Host_disease, data=samp_dat_wdiv, exact = FALSE)
# Notice that transformation does not affect significance
wilcox.test(log(Observed) ~ Host_disease, data=samp_dat_wdiv, exact = FALSE)


#### Pielous's evenness ####

# Extract Shannon diversity and species richness from the 'alphadiv' object
shannon_diversity <- alphadiv$Shannon
species_richness <- alphadiv$Observed  # This is the number of taxa (S)

# Calculate Pielou's Evenness: J' = H' / ln(S)
pielou_evenness <- shannon_diversity / log(species_richness)

# Add Pielou's Evenness to the sample data
samp_dat <- sample_data(almomani_rare_sputum_no_control)
samp_dat_wdiv <- data.frame(samp_dat, alphadiv, PielouEvenness = pielou_evenness)

# Visualize Pielou's Evenness for different 'env_medium' categories
gg_pielou_evenness <- samp_dat_wdiv %>%
  filter(!is.na(PielouEvenness)) %>%
  ggplot(aes(x = Host_disease, y = PielouEvenness, fill = Host_disease)) +
  geom_violin(colour = "black", trim = FALSE) +
  xlab("COVID-19 Severity") +
  ylab("Pielou's Evenness") + 
  theme_minimal() + 
  stat_compare_means(method = "wilcox.test", label.y.npc = "top", label.x.npc = "centre", vjust = 0.05, hjust = 0.5, size = 3.5) + 
  scale_fill_manual(
    values = c("Covid" = "#00BFC4",  # Blue
               "ICU" = "#F8766D"),         # Red
    labels = c("Covid" = "Less severe", 
               "ICU" = "Severe")
  ) +
  guides(fill = "none") +  # Remove color legend
  scale_x_discrete(labels = c("Covid" = "Less severe", 
                              "ICU" = "Severe")) + 
  theme(
    axis.title.x = element_text(size = 14),
    axis.title.y = element_text(size = 14),
    plot.title = element_text(size = 14)
  )

# Print the plot
gg_pielou_evenness

# Save the plot if needed
ggsave(filename = "almomani_severity_pielou_evenness.png", gg_pielou_evenness, height = 6, width = 4)


## Calculate stats for Pielou evenness ##

samp_dat_wdiv %>%
  filter(!is.na(PielouEvenness)) %>%
  ggplot(aes(x=Host_disease, y=PielouEvenness))+
  geom_point()

# Visualizing non-parametric distribution (with log as well) #
ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=PielouEvenness), bins=5)

ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=log(PielouEvenness)), bins=5)

# running wilcoxin test on non-parametric data #
wilcox.test(PielouEvenness ~ Host_disease, data=samp_dat_wdiv, exact = FALSE)
# Notice that transformation does not affect significance
wilcox.test(log(PielouEvenness) ~ Host_disease, data=samp_dat_wdiv, exact = FALSE)