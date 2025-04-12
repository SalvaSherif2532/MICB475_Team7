
library(phyloseq)
library(ape)
library(tidyverse)
library(picante)
load("almomani_final.RData")
load("almomani_rare.RData")
bc_dm <- distance(almomani_rare, method="bray")
# check which methods you can specify
?distance

pcoa_bray_bc <- ordinate(almomani_rare, method="PCoA", distance=bc_dm)

plot_ordination(almomani_rare, pcoa_bray_bc, color = "env_medium")

gg_bray_pcoa <- plot_ordination(almomani_rare,  pcoa_bray_bc, color = "env_medium") +
  labs(col="location")
gg_bray_pcoa

ggsave("plot_bray_pcoa_almomani.png"
       , gg_bray_pcoa
       , height=4, width=5)

#Jaccrad 
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
