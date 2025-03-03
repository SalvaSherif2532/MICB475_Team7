# Alpha Diversity on Galeeva et al dataset #
# (Shannon’s diversity index, Faith’s phylogenetic diversity, richness, and Pielou’s evenness) #

#### Load libraries ####
library(phyloseq)
library(tidyverse)
library(vegan)
library(ape)
library(picante)
library(ggsignif)


#### Load in RData ####
load("galeeva_rare.RData")
load("galeeva_final.RData")

otu_table(galeeva_rare)
sample_data(galeeva_rare)
tax_table(galeeva_rare)
phy_tree(galeeva_rare)

#### Shannon's Diversity Index ######

## Shannon Diversity ##
plot_richness(galeeva_rare) 

plot_richness(galeeva_rare, measures = "Shannon") 

gg_shannon_diversity <- plot_richness(galeeva_rare, x = "inpatient", measures = "Shannon") +
  xlab("COVID-19 Severity") +
  geom_boxplot() 
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
  geom_boxplot() +
  xlab("COVID-19 Severity") +
  ylab("Phylogenetic Diversity")

# view plot
plot.pd

ggsave(filename = "galeeva_phylogenetic_diversity.png"
       , plot.pd
       , height=6, width=4)

#### Richness ####

plot_richness(galeeva_rare, measures = "Observed") 

gg_richness <- plot_richness(galeeva_rare, x = "inpatient", measures = "Observed") +
  xlab("COVID-19 Severity") +
  geom_boxplot() 
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

# Visualize Pielou's Evenness for different 'inpatient' categories
gg_pielou_evenness <- samp_dat_wdiv %>%
  filter(!is.na(PielouEvenness)) %>%
  ggplot(aes(x = inpatient, y = PielouEvenness)) +
  geom_boxplot() +
  xlab("COVID-19 Severity") +
  ylab("Pielou's Evenness")

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



