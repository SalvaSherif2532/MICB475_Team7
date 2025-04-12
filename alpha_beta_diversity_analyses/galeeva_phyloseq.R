#### Loading phyloseq, tidyverse, ape, vegan ####
library(phyloseq)
library(tidyverse)
library(ape)
library(vegan) #this was also loaded because rareify function is part of this package


#### Load in the project 2 metadata,  OTU table, taxonomy file, and phylogenetic tree ####
metafp <- "galeeva_export/galeeva_metadata.tsv"
meta <- read_delim(metafp, delim="\t")

otufp <- "galeeva_export/galeeva_table_export/galeeva_feature-table.txt"
otu <- read_delim(file = otufp, delim="\t", skip=1)

taxfp <- "galeeva_export/galeeva_taxonomy_export/taxonomy.tsv"
tax <- read_delim(taxfp, delim="\t")

phylotreefp <- "galeeva_export/galeeva_rooted-tree_export/tree.nwk"
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
galeeva_phyloseq <- phyloseq(OTU, SAMP, TAX, phylotree)


#### Filtering #####
# Remove non-bacterial sequences, if any
galeeva_filt <- subset_taxa(galeeva_phyloseq,  Domain == "d__Bacteria" & Class!="c__Chloroplast" & Family !="f__Mitochondria")
# Remove ASVs that have less than 5 counts total
galeeva_final_nlow <- filter_taxa(galeeva_filt, function(x) sum(x)>5, prune = TRUE)
galeeva_final <- subset_samples(galeeva_final_nlow, inpatient !="missing" ) 
sample_data(galeeva_final)#to confirm missing is removed
nsamples(galeeva_final) #number of the samples 
#### Rarefy samples to a depth of 26432 ####
rarecurve(t(as.data.frame(otu_table(galeeva_final))), cex=0.1)
galeeva_rare <- rarefy_even_depth(galeeva_final, rngseed = 1, sample.size = 4816)


##### Saving #####
save(galeeva_final, file="galeeva_final.RData")
save(galeeva_rare, file="galeeva_rare.RData")
