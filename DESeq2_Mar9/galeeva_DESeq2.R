## Install DEseq2 package ##
BiocManager::install("DESeq2")

## Load in packages ##
library(tidyverse)
library(phyloseq)
library(DESeq2)

## Load data ##
readRDS("Datasets_RDS/galeeva_final.rds")

## glom ##
 galeeva_glom <- tax_glom(galeeva_final, taxrank = "Genus")

## DESeq ##
# galeeva_deseq <- phyloseq_to_deseq2(galeeva_final, ~`inpatient`)
# DESEQ_galeeva <- DESeq(galeeva_deseq)

## DESeq code above gave an error, run this code to add '1' count to all reads ##
galeeva_plus1 <- transform_sample_counts(galeeva_glom, function(x) x+1)
galeeva_deseq <- phyloseq_to_deseq2(galeeva_plus1, ~`inpatient`)
DESEQ_galeeva <- DESeq(galeeva_deseq)
galeeva_res <- results(DESEQ_galeeva, tidy=TRUE, 
               # this will ensure that No is your reference group
               contrast = c("inpatient","Hospitalized","Ambulatory treatment"))

## Look at results ##
View(galeeva_res)

## Volcano plot: effect size VS significance ##
ggplot(galeeva_res) +
  geom_point(aes(x=log2FoldChange, y=-log10(padj)))

## Make variable to color by whether it is significant + large change ##
galeeva_vol_plot <- galeeva_res %>%
  mutate(significant = padj<0.01 & abs(log2FoldChange)>1.5) %>%
  ggplot() +
  geom_point(aes(x=log2FoldChange, y=-log10(padj), col=significant))
galeeva_vol_plot

## Save volcano plot ##
# ggsave(filename="DESeq2_Mar9/galeeva_vol_plot.png",galeeva_vol_plot)

## Filter padj and rename 'row' to 'ASV' ##
galeeva_sigASVs <- galeeva_res %>% 
  filter(padj<0.01 & abs(log2FoldChange)>1.5) %>%
  dplyr::rename(ASV=row)
View(galeeva_sigASVs)

## Filter Genus ##
galeeva_sigASVs_filtered <- galeeva_sigASVs %>%
  filter(!Genus %in% c("g__uncultured",
                       "g__Allorhizobium-Neorhizobium-Pararhizobium-Rhizobium",
                       "g__TM7x",
                       "g__F0058",
                       "g__Escherichia-Shigella"))
view(galeeva_sigASVs_filtered)

## Get only ASV names ##
galeeva_sigASVs_vec <- galeeva_sigASVs_filtered %>%
  pull(ASV)

## Prune phyloseq file ##
galeeva_DESeq <- prune_taxa(galeeva_sigASVs_vec, galeeva_glom)
galeeva_sigASVs <- tax_table(galeeva_DESeq) %>% as.data.frame() %>%
  rownames_to_column(var="ASV") %>%
  right_join(galeeva_sigASVs_filtered) %>%
  arrange(log2FoldChange) %>%
  mutate(Genus = make.unique(Genus)) %>%
  mutate(Genus = factor(Genus, levels=unique(Genus)))

## Define the genera to highlight ##
highlighted_genera <- c("g__Prevotella", "g__Veillonella", "g__Streptococcus", "g__Actinomyces", "g__Dolosigranulum", "g__Lawsonella", "g__Corynebacterium")

## Modify the Genus column to reflect whether it is in the highlighted genera ##
galeeva_sigASVs_filtered$highlighted <- ifelse(galeeva_sigASVs_filtered$Genus %in% highlighted_genera, "TRUE", "FALSE")

## Create the plot ##
galeeva_sigASVs_plot <- ggplot(galeeva_sigASVs_filtered, 
                               aes(x = Genus, y = log2FoldChange, fill = highlighted)) +
  geom_bar(stat = "identity", color = "black") +
  geom_errorbar(aes(ymin = log2FoldChange - lfcSE, ymax = log2FoldChange + lfcSE)) +
  scale_fill_manual(values = c("TRUE" = "#F8766D", "FALSE" = "gray")) +
  geom_hline(yintercept = 1.5, linetype = "dashed", color = "darkgreen", size = 2) +
  geom_hline(yintercept = -1.5, linetype = "dashed", color = "darkgreen", size = 2) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 12),
        axis.title = element_text(size = 16),
        legend.position = "none")
galeeva_sigASVs_plot

## Create the plot (for presentation) ##
galeeva_sigASVs_plot <- ggplot(galeeva_sigASVs_filtered) +
  geom_bar(aes(x=Genus, y=log2FoldChange), stat="identity", fill = "gray", color = "black") +
  geom_errorbar(aes(x=Genus, ymin=log2FoldChange-lfcSE, ymax=log2FoldChange+lfcSE)) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "darkgreen", size = 1) +   # First dashed line at y = 1
  geom_hline(yintercept = -1, linetype = "dashed", color = "darkgreen", size = 1) +  # Second dashed line at y = -1
  theme(axis.text.x = element_text(angle=90, hjust=1, vjust=0.5, size = 12),
        axis.text.y = element_text(size = 12),
        axis.title = element_text(size = 16))
galeeva_sigASVs_plot

## Save sigASVs plot ##
ggsave(filename="DESeq2_Mar9/galeeva_sigASVs_filtered_plot.png", galeeva_sigASVs_plot, width = 12, height = 9, dpi = 300)
