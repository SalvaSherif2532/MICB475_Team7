# Demographics table of Al-Momani et al before and after rarefaction #

#### Load libraries ####
library(phyloseq)
library(tidyverse)
library(vegan)
library(ape)
library(picante)
library(ggsignif)
library(ggpubr)

#### Load in RData ####
al_momani_final <- readRDS("almomani_final.rds")
al_momani_rare <- readRDS("almomani_rare.rds")

#### Demographics on Al-Momani (non-rarefied) ####

otu_table(al_momani_final)
sample_data(al_momani_final)
tax_table(al_momani_final)
phy_tree(al_momani_final)

data_table <- as(sample_data(al_momani_final), "data.frame") |>
  filter(env_medium == "Sputum") |>
  filter(Host_disease != "Control") |>
  glimpse()

# Get COVID-19 severity #
sum(!is.na(data_table$Host_disease))

number_severe = sum(data_table$Host_disease == "ICU")
number_severe

number_less_severe = sum(data_table$Host_disease == "Covid")
number_less_severe

# Get location info #
unique(data_table$geo_loc_name)
sum(!is.na(data_table$geo_loc_name)) # all 75 samples are from Amman 
#### Demographics on Al-Momani rarefied ####

otu_table(al_momani_rare)
sample_data(al_momani_rare)
tax_table(al_momani_rare)
phy_tree(al_momani_rare)

data_table_rare <- as(sample_data(al_momani_rare), "data.frame") |>
  filter(env_medium == "Sputum") |>
  filter(Host_disease != "Control") |>
  glimpse()

# Get COVID-19 severity #
sum(!is.na(data_table_rare$Host_disease))

number_severe_rare = sum(data_table_rare$Host_disease == "ICU")
number_severe_rare

number_less_severe_rare = sum(data_table_rare$Host_disease == "Covid")
number_less_severe_rare

# Get location info #
unique(data_table_rare$geo_loc_name)
sum(!is.na(data_table_rare$geo_loc_name)) # all 62 samples are from Amman 
