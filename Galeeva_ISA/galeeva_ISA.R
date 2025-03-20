library(tidyverse)
library(phyloseq)
library(indicspecies)

#Indicator Species Analysis on galeeva final
galeeva_final_ISA <- readRDS("galeeva_final.rds")
isa_galeeva_final <- multipatt(t(otu_table(galeeva_final_ISA)), cluster = sample_data(galeeva_final_ISA)$'inpatient')
# Look at results
summary(isa_galeeva_final)

# Extract taxonomy table
galeeva_final_taxtable <- tax_table(galeeva_final_ISA) %>% as.data.frame() %>% rownames_to_column(var="ASV")

# Merge taxonomy table with phyloseq object and filter by significant p-value
galeeva_final_res <- isa_galeeva_final$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(galeeva_final_taxtable) %>%
  filter(p.value<0.05) 

# View results
View(galeeva_final_res)
write_tsv(galeeva_final_res, "galeeva_final_res.tsv")

#Indicator Species Analysis on galeeva rare
galeeva_rare_ISA <- readRDS("galeeva_rare.rds")
galeeva_glom <- tax_glom(galeeva_rare_ISA, "Genus", NArm = FALSE)
galeeva_genus_RA_ISA <- transform_sample_counts(galeeva_glom, fun=function(x) x/sum(x))
isa_galeeva_rare <- multipatt(t(otu_table(galeeva_genus_RA_ISA)), cluster = sample_data(galeeva_genus_RA_ISA)$'inpatient')
# Look at results
summary(isa_galeeva_rare)

# Extract taxonomy table
galeeva_rare_taxtable <- tax_table(galeeva_genus_RA_ISA) %>% as.data.frame() %>% rownames_to_column(var="ASV")

# Merge taxonomy table with phyloseq object and filter by significant p-value
galeeva_rare_res <- isa_galeeva_rare$sign %>%
  rownames_to_column(var="ASV") %>%
  left_join(galeeva_rare_taxtable) %>%
  filter(p.value<0.05) 

# View results
View(galeeva_rare_res)
write_tsv(galeeva_rare_res, "galeeva_rare_res.tsv")
