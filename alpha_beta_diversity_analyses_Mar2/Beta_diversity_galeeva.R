
library(phyloseq)
library(ape)
library(tidyverse)
library(picante)
load("galeeva_rare.RData")
load("galeeva_final.RData")
bc_dm <- distance(galeeva_rare, method="bray")
# check which methods you can specify
?distance

pcoa_bray_bc <- ordinate(galeeva_rare, method="PCoA", distance=bc_dm)

plot_ordination(galeeva_rare, pcoa_bray_bc, color = "inpatient")

gg_bray_pcoa <- plot_ordination(galeeva_rare,  pcoa_bray_bc, color = "inpatient") +
  labs(col="Severity")
gg_bray_pcoa

ggsave("plot_bray_pcoa_galeeva.png"
       , gg_bray_pcoa
       , height=4, width=5)

#Jaccrad 
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
  labs(col="Severity")
gg_wunifrac_pcoa

ggsave("plot_wunifrac_pcoa_galeeva.png"
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
