## Install DEseq2 package ##
BiocManager::install("DESeq2")

## Load in packages ##
library(tidyverse)
library(phyloseq)
library(DESeq2)

## Load data ##
load("alpha_beta_diversity_analyses_Mar2/galeeva_final.RData")

## DESeq ##
# galeeva_deseq <- phyloseq_to_deseq2(galeeva_final, ~`inpatient`)
# DESEQ_galeeva <- DESeq(galeeva_deseq)

## DESeq code above gave an error, run this code to add '1' count to all reads ##
galeeva_plus1 <- transform_sample_counts(galeeva_final, function(x) x+1)
galeeva_deseq <- phyloseq_to_deseq2(galeeva_plus1, ~`inpatient`)
DESEQ_galeeva <- DESeq(galeeva_deseq)
res <- results(DESEQ_galeeva, tidy=TRUE, 
               # this will ensure that No is your reference group
               contrast = c("inpatient","Hospitalized","Ambulatory treatment"))

## Look at results ##
View(res)

## Volcano plot: effect size VS significance ##
ggplot(res) +
  geom_point(aes(x=log2FoldChange, y=-log10(padj)))

## Make variable to color by whether it is significant + large change ##
vol_plot <- res %>%
  mutate(significant = padj<0.01 & abs(log2FoldChange)>2) %>%
  ggplot() +
  geom_point(aes(x=log2FoldChange, y=-log10(padj), col=significant))
vol_plot

## Save volcano plot ##
ggsave(filename="DESeq2_Mar9/galeeva_vol_plot.png",vol_plot)

## Filter padj and rename 'row' to 'ASV' ##
sigASVs <- res %>% 
  filter(padj<0.01 & abs(log2FoldChange)>2) %>%
  dplyr::rename(ASV=row)
View(sigASVs)

## Get only ASV names ##
sigASVs_vec <- sigASVs %>%
  pull(ASV)

## Prune phyloseq file ##
galeeva_DESeq <- prune_taxa(sigASVs_vec, galeeva_final)
sigASVs <- tax_table(galeeva_DESeq) %>% as.data.frame() %>%
  rownames_to_column(var="ASV") %>%
  right_join(sigASVs) %>%
  arrange(log2FoldChange) %>%
  mutate(Genus = make.unique(Genus)) %>%
  mutate(Genus = factor(Genus, levels=unique(Genus)))

## Make plot of sigASVs ##
sigASVs_plot <- ggplot(sigASVs) +
  geom_bar(aes(x=Genus, y=log2FoldChange), stat="identity")+
  geom_errorbar(aes(x=Genus, ymin=log2FoldChange-lfcSE, ymax=log2FoldChange+lfcSE)) +
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5, size = 3),
        axis.text.y = element_text(size = 5),
        axis.title = element_text(size = 8))
sigASVs_plot

## Save sigASVs plot ##
ggsave(filename="DESeq2_Mar9/galeeva_sigASVs_plot.png", sigASVs_plot)