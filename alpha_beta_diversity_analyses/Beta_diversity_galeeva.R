
library(phyloseq)
library(ape)
library(tidyverse)
library(picante)
galeeva_final <- readRDS("galeeva_final.RDS")
galeeva_rare <- readRDS("galeeva_rare.RDS")

bc_dm <- distance(gal_df, method="bray")
# check which methods you can specify
?distance

pcoa_bray_bc <- ordinate(galeeva_rare, method="PCoA", distance=bc_dm)

plot_ordination(galeeva_rare, pcoa_bray_bc, color = "inpatient")

gg_bray_pcoa <- plot_ordination(galeeva_rare, pcoa_bray_bc, color = "inpatient") +
  scale_color_manual(
    name = "Severity",
    values = c("Ambulatory treatment" = "#00BFC4", "Hospitalized" = "#F8766D"),
    labels = c("Ambulatory treatment" = "Moderate", "Hospitalized" = "Severe")
  ) +
  labs(col = "Severity")

gg_bray_pcoa
ggsave("plot_bray_pcoa_galeeva_final.png"
       , gg_bray_pcoa
       , height=4, width=5)

#Jaccard 
jaccard_dm <- distance(galeeva_rare, method="jaccard")
# check which methods you can specify
pcoa_jaccard_bc <- ordinate(galeeva_rare, method="PCoA", distance=jaccard_dm)

plot_ordination(galeeva_rare, pcoa_jaccard_bc, color = "inpatient")

gg_jaccard_pcoa <- plot_ordination(galeeva_rare, pcoa_jaccard_bc, color = "inpatient") +
  labs(col="Severity")
gg_jaccard_pcoa

ggsave("plot_jaccard_galeeva.png"
       , gg_jaccard_pcoa
       , height=4, width=5)
#wunifrac
wunifrac_dm <- distance(galeeva_rare, method="wunifrac")
# check which methods you can specify
pcoa_wunifrac_bc <- ordinate(galeeva_rare, method="PCoA", distance= wunifrac_dm)

plot_ordination(galeeva_rare, pcoa_wunifrac_bc, color = "inpatient")

gg_wunifrac_pcoa <- plot_ordination(galeeva_rare, pcoa_wunifrac_bc, color = "inpatient") +
  scale_color_manual(
    name = "Severity",
    values = c("Ambulatory treatment" = "#00BFC4",  # switch to blue
               "Hospitalized" = "#F8766D"),         # switch to red
    labels = c("Ambulatory treatment" = "Moderate", 
               "Hospitalized" = "Severe")
  )
gg_wunifrac_pcoa

ggsave("plot_wunifrac_pcoa_galeeva_final.png"
       , gg_wunifrac_pcoa
       , height=4, width=5)
#unifrac
unifrac_dm <- distance(galeeva_rare, method="unifrac")
# check which methods you can specify
pcoa_unifrac_bc <- ordinate(galeeva_rare, method="PCoA", distance= unifrac_dm)

plot_ordination(galeeva_rare, pcoa_unifrac_bc, color = "inpatient")

gg_unifrac_pcoa <- plot_ordination(galeeva_rare, pcoa_unifrac_bc, color = "inpatient") +
  labs(col="Severity")
gg_unifrac_pcoa

ggsave("plot_unifrac_pcoa_galeeva.png"
       , gg_unifrac_pcoa
       , height=4, width=5)
###Permanova####
#Bray Curtis: 
# Extract metadata
metadata <- as(sample_data(galeeva_rare), "data.frame")

# Define the group variable you want to test
group_column <- "inpatient"  # or another variable from metadata

# Ensure the grouping variable is in the metadata data frame
metadata$Group <- metadata[[group_column]]

# Run PERMANOVA
permanova_result_bray <- adonis2(as.matrix(bc_dm) ~ Group, 
                                 data = metadata, 
                                 permutations = 999)

# View results
print(permanova_result_bray)

#Jaccard: 
# Run PERMANOVA
permanova_result_jaccard <- adonis2(as.matrix(jaccard_dm) ~ Group, 
                                    data = metadata, 
                                    permutations = 999)

# View results
print(permanova_result_jaccard)

#Weighted Unifrac: 
# Run PERMANOVA
permanova_result_wunifrac <- adonis2(as.matrix(wunifrac_dm) ~ Group, 
                                     data = metadata, 
                                     permutations = 999)

# View results
print(permanova_result_wunifrac)

#unWeighted Unifrac: 
permanova_result_unifrac <- adonis2(as.matrix(unifrac_dm) ~ Group, 
                                    data = metadata, 
                                    permutations = 999)

# View results
print(permanova_result_unifrac)

# Filter out samples with NA in the variable of interest
galeeva_clean <- subset_samples(galeeva_rare, !is.na(ibd))

# Recompute the distance matrix and PCoA (since the data has changed)
bc_dm_clean <- phyloseq::distance(galeeva_clean, method = "bray")
pcoa_bray_bc <- ordinate(galeeva_clean, method = "PCoA", distance = bc_dm_clean)

# Plot
gg_bray_pcoa <- plot_ordination(galeeva_clean, pcoa_bray_bc, color = "ibd")

# View the plot
gg_bray_pcoa