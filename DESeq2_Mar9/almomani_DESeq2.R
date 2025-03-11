## Install DEseq2 package ##
BiocManager::install("DESeq2")

## Load in packages ##
library(tidyverse)
library(phyloseq)
library(DESeq2)

## Load data ##
load("alpha_beta_diversity_analyses_Mar2/almomani_final.RData")

## DESeq ##
# almomani_deseq <- phyloseq_to_deseq2(almomani_final, ~`env_medium`)
# DESEQ_almomani <- DESeq(almomani_deseq)

## DESeq code above gave an error, run this code to add '1' count to all reads ##
almomani_plus1 <- transform_sample_counts(almomani_final, function(x) x+1)
almomani_deseq <- phyloseq_to_deseq2(almomani_plus1, ~`env_medium`)
DESEQ_almomani <- DESeq(almomani_deseq)
almomani_res <- results(DESEQ_almomani, tidy=TRUE, 
               # this will ensure that No is your reference group
               contrast = c("env_medium","Sputum","Swab"))

## Look at results ##
View(almomani_res)

## Volcano plot: effect size VS significance ##
ggplot(almomani_res) +
  geom_point(aes(x=log2FoldChange, y=-log10(padj)))

## Make variable to color by whether it is significant + large change ##
almomani_vol_plot <- almomani_res %>%
  mutate(significant = padj<0.01 & abs(log2FoldChange)>2) %>%
  ggplot() +
  geom_point(aes(x=log2FoldChange, y=-log10(padj), col=significant))
almomani_vol_plot

## Save volcano plot ##
ggsave(filename="DESeq2_Mar9/almomani_vol_plot.png", almomani_vol_plot)

## Filter padj and rename 'row' to 'ASV' ##
almomani_sigASVs <- almomani_res %>% 
  filter(padj<0.01 & abs(log2FoldChange)>2) %>%
  dplyr::rename(ASV=row)
View(almomani_sigASVs)

## Get only ASV names ##
almomani_sigASVs_vec <- almomani_sigASVs %>%
  pull(ASV)

## Prune phyloseq file ##
almomani_DESeq <- prune_taxa(almomani_sigASVs_vec, almomani_final)
almomani_sigASVs <- tax_table(almomani_DESeq) %>% as.data.frame() %>%
  rownames_to_column(var="ASV") %>%
  right_join(almomani_sigASVs) %>%
  arrange(log2FoldChange) %>%
  mutate(Genus = make.unique(Genus)) %>%
  mutate(Genus = factor(Genus, levels=unique(Genus)))

## Make plot of sigASVs ##
almomani_sigASVs_plot <- ggplot(almomani_sigASVs) +
  geom_bar(aes(x=Genus, y=log2FoldChange), stat="identity")+
  geom_errorbar(aes(x=Genus, ymin=log2FoldChange-lfcSE, ymax=log2FoldChange+lfcSE)) +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5, size = 3),
        axis.text.y = element_text(size = 5),
        axis.title = element_text(size = 8))
almomani_sigASVs_plot

## Save sigASVs plot ##
ggsave(filename="DESeq2_Mar9/almomani_sigASVs_plot.png", almomani_sigASVs_plot)