#### Loading phyloseq, tidyverse, ape, vegan ####
library(phyloseq)
library(tidyverse)
library(ape)
library(vegan) #this was also loaded because rareify function is part of this package


#### Load in the project 2 metadata,  OTU table, taxonomy file, and phylogenetic tree ####
metafp <- "almomani_export/almomani_metadata.tsv"
meta <- read_delim(metafp, delim="\t")

otufp <- "almomani_export/almomani_table_export/almomani_feature-table.txt"
otu <- read_delim(file = otufp, delim="\t", skip=1)

taxfp <- "almomani_export/almomani_taxonomy_export/taxonomy.tsv"
tax <- read_delim(taxfp, delim="\t")

phylotreefp <- "almomani_export/almomani_rooted-tree_export/tree.nwk"
phylotree <- read.tree(phylotreefp)


#### Formatting files ####
otu_mat <- as.matrix(otu[,-1])
rownames(otu_mat) <- otu$`#OTU ID`
OTU <- otu_table(otu_mat, taxa_are_rows = TRUE)

samp_df <- as.data.frame(meta[,-1])
rownames(samp_df)<- meta$'sample-id'
SAMP <- sample_data(samp_df)

tax_mat <- tax %>% select(-Confidence)%>%
  separate(col=Taxon, sep="; "
           , into = c("Domain","Phylum","Class","Order","Family","Genus","Species")) %>%
  as.matrix()
tax_mat <- tax_mat[,-1]
rownames(tax_mat) <- tax$`Feature ID`
TAX <- tax_table(tax_mat)


#### Create phyloseq object ####
almomani_phyloseq <- phyloseq(OTU, SAMP, TAX, phylotree)


#### Filtering #####
# Remove non-bacterial sequences, if any
almomani_filt <- subset_taxa(almomani_phyloseq,  Domain == "d__Bacteria" & Class!="c__Chloroplast" & Family !="f__Mitochondria")
# Remove ASVs that have less than 5 counts total
almomani_final_nlow <- filter_taxa(almomani_filt, function(x) sum(x)>5, prune = TRUE)
almomani_final <- subset_samples(almomani_final_nlow, env_medium !="Stool" ) 
sample_data(almomani_final) #to confirm Stool is removed 
#### Rarefy samples to a depth of 26432 ####
rarecurve(t(as.data.frame(otu_table(almomani_final))), cex=0.1)
almomani_rare <- rarefy_even_depth(almomani_final, rngseed = 1, sample.size = 26432)


##### Saving #####
save(almomani_final, file="almomani_final.RData")
save(almomani_rare, file="almomani_rare.RData")
saveRDS(almomani_final, "almomani_final.rds")
saveRDS(almomani_rare, "almomani_rare.rds")
