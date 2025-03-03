# Alpha Diversity on Al-Momani et al dataset #
# (Shannon’s diversity index, Faith’s phylogenetic diversity, richness, and Pielou’s evenness) #

#### Load libraries ####
library(phyloseq)
library(tidyverse)
library(vegan)
library(ape)
library(picante)
library(ggsignif)


#### Load in RData ####
load("almomani_rare.RData")
load("almomani_final.RData")

otu_table(almomani_rare)
sample_data(almomani_rare)
tax_table(almomani_rare)
phy_tree(almomani_rare)

#### Shannon's Diversity Index ######

## Shannon Diversity ##
plot_richness(almomani_rare) 

plot_richness(almomani_rare, measures = "Shannon") 

almomani_shannon_diversity <- plot_richness(almomani_rare, x = "env_medium", measures = "Shannon") +
  xlab("Sample Collection Site") +
  geom_boxplot() 
almomani_shannon_diversity

ggsave(filename = "almomani_Shannon_diversity.png"
       , almomani_shannon_diversity
       , height=6, width=4)

## calculate stats for Shannon diversity ##

# adding estimate richness to sample_data #
alphadiv <- estimate_richness(almomani_rare)
samp_dat <- sample_data(almomani_rare)
samp_dat_wdiv <- data.frame(samp_dat, alphadiv)

# visualizing counts to determine if normally distributed #
allCounts <- as.vector(otu_table(almomani_rare))
allCounts <- allCounts[allCounts>0]
hist(allCounts)
hist(log(allCounts))

samp_dat_wdiv %>%
  filter(!is.na(Shannon)) %>%
  ggplot(aes(x=env_medium, y=Shannon))+
  geom_point()

# Visualizing non-parametric distribution (with log as well) #
ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=Shannon), bins=5)

ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=log(Shannon)), bins=5)

# running wilcoxin test on non-parametric data #
wilcox.test(Shannon ~ env_medium, data=samp_dat_wdiv, exact = FALSE)
# Notice that transformation does not affect significance
wilcox.test(log(Shannon) ~ env_medium, data=samp_dat_wdiv, exact = FALSE)

#### Faith's phylogenetic diversity####

# calculate Faith's phylogenetic diversity as PD
phylo_dist <- pd(t(otu_table(almomani_rare)), phy_tree(almomani_rare),
                 include.root=F) 

# add PD to metadata table
sample_data(almomani_rare)$PD <- phylo_dist$PD

# plot any metadata category against the PD
plot.pd <- ggplot(sample_data(almomani_rare), aes(env_medium, PD)) + 
  geom_boxplot() +
  xlab("Sample Collection Site") +
  ylab("Phylogenetic Diversity")

# view plot
plot.pd

ggsave(filename = "almomani_phylogenetic_diversity.png"
       , plot.pd
       , height=6, width=4)

#### Richness ####

plot_richness(almomani_rare, measures = "Observed") 

almomani_richness <- plot_richness(almomani_rare, x = "env_medium", measures = "Observed") +
  xlab("Sample Collection Site") +
  geom_boxplot() 
almomani_richness

ggsave(filename = "almomani_richness.png"
       , almomani_richness
       , height=6, width=4)

## calculate stats for Richness ##

samp_dat_wdiv %>%
  filter(!is.na(Observed)) %>%
  ggplot(aes(x=env_medium, y=Observed))+
  geom_point()

# Visualizing non-parametric distribution (with log as well) #
ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=Observed), bins=5)

ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=log(Observed)), bins=5)

# running wilcoxin test on non-parametric data #
wilcox.test(Observed ~ env_medium, data=samp_dat_wdiv, exact = FALSE)
# Notice that transformation does not affect significance
wilcox.test(log(Observed) ~ env_medium, data=samp_dat_wdiv, exact = FALSE)


#### Pielous's evenness ####

# Extract Shannon diversity and species richness from the 'alphadiv' object
shannon_diversity <- alphadiv$Shannon
species_richness <- alphadiv$Observed  # This is the number of taxa (S)

# Calculate Pielou's Evenness: J' = H' / ln(S)
pielou_evenness <- shannon_diversity / log(species_richness)

# Add Pielou's Evenness to the sample data
samp_dat <- sample_data(almomani_rare)
samp_dat_wdiv <- data.frame(samp_dat, alphadiv, PielouEvenness = pielou_evenness)

# Visualize Pielou's Evenness for different 'env_medium' categories
gg_pielou_evenness <- samp_dat_wdiv %>%
  filter(!is.na(PielouEvenness)) %>%
  ggplot(aes(x = env_medium, y = PielouEvenness)) +
  geom_boxplot() +
  xlab("Sample Collection Site") +
  ylab("Pielou's Evenness")

# Print the plot
gg_pielou_evenness

# Save the plot if needed
ggsave(filename = "almomani_pielou_evenness.png", gg_pielou_evenness, height = 6, width = 4)

## Calculate stats for Pielou evenness ##

samp_dat_wdiv %>%
  filter(!is.na(PielouEvenness)) %>%
  ggplot(aes(x=env_medium, y=PielouEvenness))+
  geom_point()

# Visualizing non-parametric distribution (with log as well) #
ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=PielouEvenness), bins=5)

ggplot(samp_dat_wdiv) +
  geom_histogram(aes(x=log(PielouEvenness)), bins=5)

# running wilcoxin test on non-parametric data #
wilcox.test(PielouEvenness ~ env_medium, data=samp_dat_wdiv, exact = FALSE)
# Notice that transformation does not affect significance
wilcox.test(log(PielouEvenness) ~ env_medium, data=samp_dat_wdiv, exact = FALSE)



