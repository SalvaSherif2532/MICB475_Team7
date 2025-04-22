
library(phyloseq)
library(ape)
library(tidyverse)
library(picante)
# load("almomani_final.RData")
# load("almomani_rare.RData")

almomani_final <- readRDS("Phyloseq_objects/almomani_final.RDS")
almomani_rare <- readRDS("Phyloseq_objects/almomani_rare.RDS")

####  Beta Diversities on Sample Types ####
bc_dm <- distance(almomani_rare, method="bray")
# check which methods you can specify
#?distance

pcoa_bray_bc <- ordinate(almomani_rare, method="PCoA", distance=bc_dm)

plot_ordination(almomani_rare, pcoa_bray_bc, color = "env_medium")

gg_bray_pcoa <- plot_ordination(almomani_rare,  pcoa_bray_bc, color = "env_medium") +
  labs(col="location")
gg_bray_pcoa

ggsave("plot_bray_pcoa_almomani.png"
       , gg_bray_pcoa
       , height=4, width=5)

#Jaccard 
jaccard_dm <- distance(almomani_rare, method="jaccard")
# check which methods you can specify
pcoa_jaccard_bc <- ordinate(almomani_rare, method="PCoA", distance=jaccard_dm)

plot_ordination(almomani_rare, pcoa_jaccard_bc, color = "env_medium")

gg_jaccard_pcoa <- plot_ordination(almomani_rare, pcoa_jaccard_bc, color = "env_medium") +
  labs(col="location")
gg_jaccard_pcoa

ggsave("plot_jaccard_almomani.png"
       , gg_jaccard_pcoa
       , height=4, width=5)
#wunifrac
wunifrac_dm <- distance(almomani_rare, method="wunifrac")
# check which methods you can specify
pcoa_wunifrac_bc <- ordinate(almomani_rare, method="PCoA", distance= wunifrac_dm)

plot_ordination(almomani_rare, pcoa_wunifrac_bc, color = "env_medium")

gg_wunifrac_pcoa <- plot_ordination(almomani_rare, pcoa_wunifrac_bc, color = "env_medium") +
  labs(col="location")
gg_wunifrac_pcoa

ggsave("plot_wunifrac_pcoa_almomani.png"
       , gg_wunifrac_pcoa
       , height=4, width=5)
#unifrac
unifrac_dm <- distance(almomani_rare, method="unifrac")
# check which methods you can specify
pcoa_unifrac_bc <- ordinate(almomani_rare, method="PCoA", distance= unifrac_dm)

plot_ordination(almomani_rare, pcoa_unifrac_bc, color = "env_mediumt")

gg_unifrac_pcoa <- plot_ordination(almomani_rare, pcoa_unifrac_bc, color = "env_medium") +
  labs(col="location")
gg_unifrac_pcoa

ggsave("plot_unifrac_pcoa_almomani.png"
       , gg_unifrac_pcoa
       , height=4, width=5)

#### BrayCurtis Severity ####

almomani_sputum <- subset_samples(almomani_rare, env_medium == "Sputum")
almomani_no_control <- subset_samples(almomani_sputum , Host_disease != "Control")
bc_dm <- distance(almomani_no_control , method="bray")
# check which methods you can specify
#?distance

pcoa_bray_bc <- ordinate(almomani_rare, method="PCoA", distance=bc_dm)
plot_ordination(almomani_no_control , pcoa_bray_bc, color = "Host_disease")

gg_bray_pcoa <- plot_ordination(almomani_no_control ,  pcoa_bray_bc, color = "Host_disease") +
  scale_color_manual(
    name = "COVID-19 PO 
(Jordanian Cohort)",
    values = c("Covid" = "#00BFC4", "ICU" = "#F8766D"),
    labels = c("Covid" = "Non-ICU",
               "ICU" = "ICU")
  ) +
  labs(col = "COVID-19 Patient Outcome") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.line.x = element_line(linewidth = 0.2),
    axis.line.y = element_line(linewidth = 0.2),
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 12),
    legend.text = element_text(size = 14),
    legend.title = element_text(size = 14)
  )

gg_bray_pcoa

ggsave("plot_bray_pcoa_almoman_severity.png"
       , gg_bray_pcoa
       , height=4, width=5)

## Repeat without colour legend ##
gg_bray_pcoa_no_legend <- plot_ordination(almomani_no_control ,  pcoa_bray_bc, color = "Host_disease") +
  scale_color_manual(
    name = "COVID-19 Patient Outcome
        (Jordanian Cohort)",
    values = c("Covid" = "#00BFC4", "ICU" = "#F8766D"),
    labels = c("Covid" = "Non-ICU",
               "ICU" = "ICU")
  ) +
  guides(colour = "none") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.line.x = element_line(linewidth = 0.2),
    axis.line.y = element_line(linewidth = 0.2),
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 12)
  )

gg_bray_pcoa_no_legend

ggsave("plot_bray_pcoa_almoman_severity_no_legend.png"
       , gg_bray_pcoa_no_legend
       , height=4, width=4)

#### unifrac Severity ####

almomani_sputum <- subset_samples(almomani_rare, env_medium == "Sputum")
almomani_no_control <- subset_samples(almomani_sputum , Host_disease != "Control")
unifrac_dm <- distance(almomani_no_control , method="unifrac")
# check which methods you can specify
?distance

pcoa_unifrac_bc <- ordinate(almomani_no_control , method="PCoA", distance=unifrac_dm)

plot_ordination(almomani_no_control , pcoa_unifrac_bc, color = "Host_disease")

gg_unifrac_pcoa <- plot_ordination(almomani_no_control ,  pcoa_unifrac_bc, color = "Host_disease") +
  scale_color_manual(
    name = "COVID-19 Patient Outcome
        (Jordanian Cohort)",
    values = c("Covid" = "#00BFC4", "ICU" = "#F8766D"),
    labels = c("Covid" = "Non-ICU",
               "ICU" = "ICU")
  ) +
  guides(colour = "none") +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    axis.line.x = element_line(linewidth = 0.2),
    axis.line.y = element_line(linewidth = 0.2),
    axis.text = element_text(size = 12),
    axis.title = element_text(size = 12)
  )

gg_unifrac_pcoa

ggsave("plot_unifrac_pcoa_almoman_severity.png"
       , gg_unifrac_pcoa
       , height=4, width=4)

###Permanova####
#Bray Curtis: 
# Extract metadata
metadata <- as(sample_data(almomani_rare), "data.frame")

# Define the group variable you want to test
group_column <- "env_medium"  # or another variable from metadata

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

#Unweighted Unifrac: 
permanova_result_unifrac <- adonis2(as.matrix(unifrac_dm) ~ Group, 
                                    data = metadata, 
                                    permutations = 999)

# View results
print(permanova_result_unifrac)

###Permanova####
#Bray Curtis: 
# Extract metadata
metadata <- as(sample_data(almomani_no_control), "data.frame")

# Define the group variable you want to test
group_column <- "Host_disease"  # or another variable from metadata

# Ensure the grouping variable is in the metadata data frame
metadata$Group <- metadata[[group_column]]

# Run PERMANOVA
permanova_result_bray <- adonis2(as.matrix(bc_dm) ~ Group, 
                                 data = metadata, 
                                 permutations = 999)

# View results
print(permanova_result_bray)



#unWeighted Unifrac: 
permanova_result_unifrac <- adonis2(as.matrix(unifrac_dm) ~ Group, 
                                    data = metadata, 
                                    permutations = 999)

# View results
print(permanova_result_unifrac)
