## Install DEseq2 package ##
BiocManager::install("DESeq2")

## Load in packages ##
library(tidyverse)
library(phyloseq)
library(DESeq2)

## Load data ##
galeeva_final <- readRDS("Datasets_RDS/galeeva_final.rds")

## glom ##
galeeva_glom <- tax_glom(galeeva_final, taxrank = "Genus")

## DESeq ##
# galeeva_deseq <- phyloseq_to_deseq2(galeeva_final, ~`inpatient`)
# DESEQ_galeeva <- DESeq(galeeva_deseq)

## DESeq code above gave an error, run this code to add '1' count to all reads ##
galeeva_plus1 <- transform_sample_counts(galeeva_glom, function(x) x+1)
galeeva_deseq <- phyloseq_to_deseq2(galeeva_plus1, ~`inpatient`)
DESEQ_galeeva <- DESeq(galeeva_deseq)
galeeva_res_deseq <- results(DESEQ_galeeva, tidy=TRUE, 
               # this will ensure that No is your reference group
               contrast = c("inpatient","Hospitalized","Ambulatory treatment"))

# Extract taxonomy table
taxtable <- tax_table(galeeva_final) %>% as.data.frame() %>% rownames_to_column(var="ASV")

# Merge taxonomy table with phyloseq object and filter by significant p-value
galeeva_res <- galeeva_res_deseq %>%
  dplyr::rename(ASV = row) %>%
  left_join(taxtable, by = "ASV")

## Look at results ##
View(galeeva_res)

## Volcano plot: effect size VS significance ##
ggplot(galeeva_res) +
  geom_point(aes(x=log2FoldChange, y=-log10(padj)))

## Make variable to color by whether it is significant + large change ##
galeeva_vol_plot <- galeeva_res %>%
  mutate(significant = padj<0.01 & abs(log2FoldChange)>1.5) %>%
  ggplot() +
  geom_point(aes(x=log2FoldChange, y=-log10(padj), col=significant)) +
  scale_color_manual(
    name = "Severity",
    values = c("TRUE" = "#f8766d", "FALSE" = "#00bfc4"),
    labels = c("TRUE" = "Severe", "FALSE" = "Less severe")
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 13),
        axis.text.y = element_text(size = 13),
        axis.title = element_text(size = 16),
        legend.text = element_text(size = 13),
        legend.title = element_text(size = 16))
galeeva_vol_plot

## Save volcano plot ##
ggsave(filename="DESeq2_Mar9/galeeva_vol_plot.png",galeeva_vol_plot, width = 9, height = 6, dpi = 300)

## Filter padj and rename 'row' to 'ASV' ##
galeeva_sigASVs <- galeeva_res %>% 
  filter(padj<0.01 & abs(log2FoldChange)>1.5)
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
highlighted_genera <- c("g__Prevotella", "g__Veillonella", "g__Granulicatella", "g__Atopobium", "g__Lawsonella", "g__Corynebacterium", "g__Staphylococcus")

## Modify the Genus column to reflect whether it is in the highlighted genera ##
galeeva_sigASVs_filtered$highlighted <- ifelse(galeeva_sigASVs_filtered$Genus %in% highlighted_genera, "TRUE", "FALSE")

# Remove "g__" prefix from Genus
galeeva_sigASVs_filtered$Genus <- gsub("g__", "", galeeva_sigASVs_filtered$Genus)

## Reorder by log2foldchange
galeeva_sigASVs_filtered$Genus <- reorder(galeeva_sigASVs_filtered$Genus, galeeva_sigASVs_filtered$log2FoldChange)

## Create the plot (flipped) ##
galeeva_sigASVs_plot_flip <- ggplot(galeeva_sigASVs_filtered, 
                               aes(x = Genus, y = log2FoldChange, fill = highlighted)) +
  geom_bar(stat = "identity", color = "black") +
  geom_errorbar(aes(ymin = log2FoldChange - lfcSE, ymax = log2FoldChange + lfcSE)) +
  scale_fill_manual(values = c("TRUE" = "#9d0e0d", "FALSE" = "gray")) +
  geom_hline(yintercept = 1.5, linetype = "dashed", color = "darkgreen", size = 1) +
  geom_hline(yintercept = -1.5, linetype = "dashed", color = "darkgreen", size = 1) +
  coord_flip() +
  theme_minimal() +
  theme(axis.text.x = element_text(hjust = 0.5, vjust = 0.5, size = 13),
        axis.text.y = element_text(size = 13),
        axis.title = element_text(size = 16),
        axis.title.y = element_text(angle = 0, vjust = 0.5),
        legend.position = "none")
galeeva_sigASVs_plot_flip

## Create the plot (not flipped)
galeeva_sigASVs_plot <- ggplot(galeeva_sigASVs_filtered, 
                               aes(x = Genus, y = log2FoldChange, fill = highlighted)) +
  geom_bar(stat = "identity", color = "black") +
  geom_errorbar(aes(ymin = log2FoldChange - lfcSE, ymax = log2FoldChange + lfcSE)) +
  scale_fill_manual(values = c("TRUE" = "#9d0e0d", "FALSE" = "gray")) +
  geom_hline(yintercept = 1.5, linetype = "dashed", color = "darkgreen", size = 1) +
  geom_hline(yintercept = -1.5, linetype = "dashed", color = "darkgreen", size = 1) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1, vjust = 0.5, size = 13),
        axis.text.y = element_text(size = 13),
        axis.title = element_text(size = 16),
        axis.title.y = element_text(angle = 90, vjust = 0.5),
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
ggsave(filename="DESeq2_Mar9/galeeva_sigASVs_filtered_plot_flip.png", galeeva_sigASVs_plot_flip, width = 10, height = 11, dpi = 300)
ggsave(filename="DESeq2_Mar9/galeeva_sigASVs_filtered_plot.png", galeeva_sigASVs_plot, width = 12, height = 9, dpi = 300)
