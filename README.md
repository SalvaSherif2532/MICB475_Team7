# MICB475_Team7  

#### [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
### April 3, 2025 - Salva
* Salva will run the model on Al-Momani dataset
* Group will schedule a meeting with Bessie next week to discuss
* Use the checklist for the manuscript
* Teaching evaluations will be filled out
* Feedback formatting can be provided by Bessie
* Hans recommended to use violin plots for alpha diversity to see better dispersion

### March 27, 2025 Agenda
* Manuscript Planning
  *  Table 1 (RANA) --> demographics for Methods section (before and after rarefy)
  *  Fig 1 (RANA) --> Panel A: Galeeva Faith's ADD SIGNIFICANCE, B: Galeeva Pielou's, C: Galeeva observed
     * Panel D|E|F same thing on Al-Momani severity
  * Fig 2 (MELIKA) --> Panel A: Galeeva Bray-Curtis, B: Galeeva Unweighted (regular unifrac)
     * Panel C|D same thing Al-Momani severity
  * Table 2 (JOSH) --> Indicator taxa (hopefully ~10) Galeeva UNRAREFIED --> what the model will be built on
  * Fig 3 (NORMAN) --> Panel A: Volcano DESeq2 NO COLOUR CODE VOLCANO< COLOUR CODE HISTOGRAM (if overlap, colour-coded ISA) UNRAREFIED
  * Fig 4 (JOSH) --> Core microbiome UNRAREFIED --> can overlap name of taxa on ven diagram still colour code or asterik for ISA, don't bother for shared
  * Fig 5 (SALVA) --> Panel A: AUC, B: importance histogram
  * Testing Al-Momani will just print out a precentage that we will put in results - also put information about the model
  * SUPPLEMENTAL
     * Sup Fig 1 (um 3 ppl later): a: swab sputum 1 of alpha, b: beta, c: taxa bar plot
     * Sup Fig 2 (Melika later):  all the beta diversities for Galeeva we didn't show
* METHODS
  * data set overview (this is where we got dataset...)
  * include parameters of rarefy, core microbiome, etc. --> base off previous UJEMI papaers
* Talk about beta diversity permanova
     * change "non-severe" to "less severe"
     * Keep colours red for "severe"
  * All are significant for galeeva
  * Weighted unifrac wasn't significant for sputum vs swab
  * Don't include Al-Momani at all in presentation
  * For permanova we can still trust the p-value --> totally fine because we are only comparing 2 groups
* Will not put the model in the presentation because it wasn't talked about in Evelyn's modules
* Last thing to do - use predictive model on al momani
* Permanova will be incorporated into the beta diversity plot
* NOTE: WE SHOULD RUN THE SAME ALPHA AND BETA ON SEVERITY ON AL-MOMANI (JUST DO PIELOUS AND ALL THE BETA DIVERSITIES) --> DISCLUDE HEALTHY CONTROLS
* Slides
  * Alpha diversity - Pielou's Evenness and Richness
  * Beta diversity - Bray-Curtis and Weighted Unifrac (to show phylogenetic diversity)
  * One slide for biological interpretation - Rana
  * Intro slide - Josh
  * DESeq slide (histogram) - Norman will glom it and we will add colour to it. We will add a line for the threshold and box the genera we care about.
     * less stringent is a bit weird but hopefully with glom it'll decrease
     * Colour code the overlapping genus so we can tell a story
        * colour code the same on DESeq2 & Core Microbiome
  * Future Direction slide (PUT RF MODEL IN ONGOING DIRECTIONS/WORK BUT STILL HAVE SEPARATE IDEAS FOR FUTURE TEAMS)
  * Limitations slide **(NO DO NOT INCLUDE NOT ON RUBRIC)**
  * Will meet on friday to make the slides
* Ask Bessie how to edit colour palette
* Salva will rerun random forest model
  * yes run model on 10 that are ISA (non-rarefied, not glommed, keep higher than 0.7 stat on ISA)

### March 20, 2025 - Norman
* Conclusions about alpha and beta diversity
* Glom to genus level for the rarefied core microbiome and ISA
* Lessened prevalence to 0.5 because we don't want to be more stringent
  * We want to train the model more
* Can do a histogram for ISA
  * Multiple histograms: X-axis is severe and nonsevere then counts for the indicator species analysis
  * Keep Y-axis consistent
* Random forest model
  * Definitely not overfitting the model
  * Bessie will ask around if it's normal
  * Veillonella and Prevotella are top 2 predictor variables that are also unique to the core microbiome of severe patients
* Have some slides prepared for Bessie
* To Do: Glom DESeq2, choose aesthetics, histograms for ISA

### March 13, 2025 Agenda - Melika
* Determine threshold/cutoff for the DESeq analysis
* Taxa bar plots and DESeq analysis both show that there is a difference in abundance between swab and sputum - might not combine
* Sputum should be used moving forward
* Should we do an Indicator Species Analysis - there might be species that are very distinctive - or should we just use the highest threshold of the DESeq plot
* Ask Bessie how to generate the random forest classification model
  * Clarify how many samples we want the model to train on
 
### March 13, 2025
* Threshold depends on us. Compare the two datasets.
  * 1.5 is used by a lot of different literature. 2.5 can be used to minimize variation.
* Just gonna go with the sputum moving forward - based on taxa bar plot and DESeq2 analysis
* Can always fix them in illustrator
* Galeeva et al taxa bar plot
  * Significant increase in navy blue colour in the hospitalized treatment - we can look into it
  * Look further into chloroflexi (presumably)
  * Lack of the darkest colour in the hospitalized group
* Taxa bar plot can be part of the supplement
* Perform indicator species analyses and do the core microbiome analysis
* Annotate significance on the figures for alpha and beta diversity
  * For the beta diversity, we would need another table to list all P values or a box plot that shows the signifcant P values
* Bessie will walk through the script for the random forest model today
  * Traditionally, it's trained 70/30 - our sample size is good enough
  * for a smaller dataset, you want more training proportions so 80/20

* Random forest script
  * two files - creating a dataset and
  * we can use the existing phyloseq object
  * create dataset: we will only be keeping taxa that has the highest level
    * OTC table - first column (clade), it will count the number of separators and the resolution it resolves to
    * only uses the highest resolution ones - filters OTU table
  * change Select() input towards the end
  * generates an importance plot - shows which one has the strongest predictor, but it has nothing to do with how good the model is
  * can't select too much annotations because it might overfit the model
  * what we need to change in this code:
    * path to metadata
    * meta = read_excel change to read_csv
    * keep number of folds to 10

* To do list:
  * Perform indicator species analysis and core microbiome analysis
  * Add a table to list all P values or a box plot that shows significant P values
  * Make sure the DESeq2 analysis is resolved in the same level

#### Proposal Feedback & Resubmission
* Feedback on proposal:
  * In future, if Evelyn can confirm what aspects of provided examples are no longer relevant/needed, it would help us a lot!
  * What should we change on our proposal (in your opinion)
    * Makes it seem like our intro is focusing on the lack of good treatments --> focus more on severity (symptom ranges, hospitalization range) --> focus on disease heterogeneity --> difficult to predict this
    * Then introduce the argument of why the nasopharyngeal microbiome can be used as a predictor (provide more evidence on this) --> can come from other respiratory illnesses or COVID-specific (we have evidence already here)
    * Also mention why nasopharyngeal microbiome is a better predictor than other microbiome locations
    * But then highlight here what info is still missing to actually use this as a predictor
    * need to define dysbiosis
    * when we talk about which pathogens are associated with severe disease, try to explain the biology/mechanism for why
    * Remove anything about geographical locations
    * For hypothesis and prediction focus just on how accurate we think our predictive model will be based on what's been highighted in previous research
  * What needs to be hashed out in more detail on the proposal
    * not much, focus less on geographical location/patient cohort difference, focus more on will this predictive model work and why and how will it be better than gut microbiome
  * Clarification on gantt chart feedback
    * Just explicitly add Aim 2 and Aim 3 on the table, but not major at all
    * Also don't need to cite every package
  * Ask Bessie if we need to separate Experimental Aim 1 into 2 aims
    * yes definitely! (Sorry guys lots to change!)

#### Data Analysis & Technical Questions
* Our analyses so far: [Alpha Diversity slideshow](https://docs.google.com/presentation/d/1QYmrx55R0sf_luTHFyXFm0kVte5Vt1xLI5hQf_85aw0/edit?usp=sharing)
   * taxa bar plot on both and then decided about merging the 2 sample types
* Talk about sample size - Galeeva et al only has over 200 samples after rarefaction
   * this is fine!
* How do we want to label the severity titles
   * up to us, but best to keep consistent going forward
* Save phyloseq object as rds instead of RData - function is not found in R when Josh ran it
  * Yes, perfect Melika please send .Rdata to Bessie because Evelyn wants to use and going forward everyone use .rds (Josh uploaded this onto github)
* Ask Bessie for Random Forest package code (I think I actually have this)
   * yes, we have it, Bessie hasn't tested it yet 

* SIDE NOTE:
  * Salva will show Melika push/pull github
 
### March 6, 2025 Agenda - Rana
* Introduction feedback
  * Scrap last two paragraphs of intro and move it to discussion
  * Don't talk about geographical locations
* Gantt feedback - Salva changed it
* Citations - reference main packages only
* Experimental Aims - split the first aim into two
* Sample size is only gonna be a concern if it's less than 100
* Labeling severity legends - change to severe and non-severe so it's easier to write
* For swab and sputum samples, maybe do a taxa bar plot
  * more severe COVID-19 has a more even distribution
  * maybe less severe COVID-19 has a more dominant specieces that can be shown through a taxa bar plot
  * if we merge them, then we say upper respiratory tract
* Send zip files to Bessie

### February 27, 2025 Agenda
* Perform beta and alpha diversity analyses this week - Melika and Rana
  * Do it in R
  * Write one script
  * Do the whole github commit thing
  * Create a new branch, run three lines of code - add github repository, pull the branch, and add to the branch
    * Better practice to do this
* Upload proposal to github
* To Do:
  * Perform beta and alpha diversity between the two datasets (Galeeva and Al Momani)
  * Do the same thing for Al-Momani but with swab and sputum
    * If we see two distinct clusters in the PCoA plot, then we can't combine them
   
### February 27, 2025
* Housekeeping for proposal:
  * Research Objectives and Flow Chart wasn't part of the rubric even though it was part of the examples
* Predictive model - hinting at machine learning (random forest modeling, KNN) - should we still do this?
  * no need for two datasets
  * once you confirm that it's going well, then you can apply it to the other datasets
  * if we're not predictive modeling, we can just do all the analysis and find similar effects between the two independent cohorts
* Bessie will confirm if we can do predictive modeling on n=300 (Galeeva) - sample size might be too small
  * we cannot merge the two datasets because the batch effect might be significant
  * if they say it's too small, then we're going to be doing a comparative analysis
  * if they say yes, then we have to specify what kind of predictive model in the proposal for the proposal revision
* Bessie will also send manuscript from previous team that did random forest model, and script should be in the Github
* Big dataset has poor read quality and the small dataset has good read quality
  * use the reverse reads? It's better than forward reads
  * datasets used paired-end sequencing rather than single-read sequencing
* Bessie will ask during the meeting what the next steps are

### February 13, 2025 Agenda
* Talk about how to make a proposal
* General outline or timeline of the proposal
* Update on the metadata files from last week
* Create our question
  * Which microbiome sampling site is the most alpha and beta diversity amongst COVID-19 patients?
  * Which microbial phyla are the most common across all microbiome sampling sites in COVID-19 patients?
  * Are there specific microbial phyla that are associated with specific sampling sites in COVID-19 patients? Is this associated with RSI_d levels?
 
### February 13, 2025
* Mammalia et al doesn't have many categories or usable metadata variables
  * RSI can be used as a metric of severity
  * host disease - ICU, control, and COVID (COVID patients that didn't go to the ICU)
 * The papers look at different countries
  * Initial plan is to merge the two datasets but this can be a confounding factor, and we might have to look at them separately down the line
* Potential hypothesis: location may affect the sample types
  * Is location sample type-specific?
  * First we look at the overall microbiome diversity of each location and see if they're sample type-specific. If they're not, then we can merge the dataset
* Need to tie in location and sample type
  * Have people already looked at different locations and different sample types? - for the proposal
  * Same inidividual and different sample types
* Look at sample types, but we wanted to increase sample number so we merged two datasets
  * If they are different (two locations), we decided to just do one dataset but if it's the same, then we can just merge them and look at sample type
* Do machine learning on disease severity
* Look at primers used to identify the region that's amplified but there's a script in qiime to just merge them together
* Predictive modeling
  * Do functional analysis between more sever and less severe, then predict the information that doesn't have severity
  * Do a beta diversity test
  * Do analysis on one dataset, and based on these results, what would the severity look like for the other dataset
  * Not very clear what the severity or host disease column looks like - future directions
  * Decide one location or test whether they're different, and if they're different, then it would be treated on only one
  * Look at two different clusters - sample type location and severity - 
  * Cannot conclude accuracy of the predictive model but we can reason out that they are two different geographical locations if severity doesn't align
  * Look at how similar the swab and naseopharyngeal are
  * Use the 300 sample dataset to predict severity

Proposal
* Look at similarity between swab and sputum first
* Run the predictive modeling on nasopharyngeal to predict if the severity in the Galeeva et al dataset coincides with the severity seen in the Al-Momani et al dataset
  * We can keep the control and see if it gets defined as less severe
  * In our paper, we can say limitation as we have a low sample size
  * If swab and sputum are different from each other, then we can only run it against the swab samples (n = ~50)
* For now, we won't touch it geographical location
  * If the predictive model isn't good, then we can say that it may be because of the different geographical locations
* Future Directions: Look at more datasets

Proposal Information
* Proposed title: shouldn't be conclusive but also not very broad
  * You don't want to say the effect of SARS-COV-2 on patient
  * Mention severity
  * Generating a predictive model... (specific)
* Background: Define everything
  * Don't say that no one has ever looked at this before
  * Other people have looked at the same broad topic but they looked at e.g. different sample types
  * why are these sample types more important to look like - easier to obtain and more relevant, viral replication occurs more
* Research gap: should all be based on literature
* Hypothesis: should have a direction
  * From the literature research, you will create a hypothesis (ie more severe disease will have more specific phyla?)
  * hypothesis or prediction
* Aim/Rationale: how can testing this help with answering your research question
  * You want to compare alpha diversity because it will provide community richness, for example
  * Be very specific
* Proposed approach: have a table that has steps 1, 2, 3, 4...
  * Step 1: you do the qiime to create an output a file
  * Step 2: we use this output file to do analysis
* We can schedule a zoom meeting with Bessie during the reading break

### February 6, 2025 Agenda
* Review studies identified as usable
* Nail down the broad questions we would potentially like to explore and ask
* Set goals for proposal formulation and main analyses we would like to conduct
* Determine the distribution of tasks going forward as well as a rough timeline
* Should we look for more studies for influenza in humans?

  * Is there value in considering a parallel analysis with the mouse data we have managed to potentially identify?
  * Is there any value in looking for more datasets with different diseases?

### February 6, 2025 Minutes
Should we merge the two usable datasets or stick with the initial idea of comparing two different diseases?  
We can find one dataset of human influenza by the end of the day  
Merge both datasets and compare diverisities  
Initial site of infection: throat, secondary site of infection: lung, and site of infection that isn't seen as much: gut  

Look at the abundance of the microbes from one place to another - can do that from the throat to the lung to the gut  
 - but we don't have longitudinal data

Look at the subsetted severity amongst the different sample types (stool, sputum, and swab)
- make sure the severity is annotated the same way between the two datasets (e.g. hospitalization) - reannotate them as high, low, and medium
- annotate them somewhat similarly as best as possible
- sufficient to do it within one dataset but two datasets would be better for increased sample size
- novel in a sense that no one has ever compared these two datasets before; can be cool to compare with different datasets to see if it matches during the research proposal draft
- keep one column that says source then determine if it's data 1 or data 2

Two datasets:
- Batch effect and correct can be added in the aim

Housekeeping things:
2 ways to merge: 
- if the same dataset uses two same variable regions and same type of sequencing (if they match, then we can merge them right from the beginning). Create a new manifest file
- if they're very different from each other, qiime can merge the tables (different variable regions, different sequencing) - Evelyn can send the code
Write a summary of all the data wrangling activities as an alternative rubric

Machine learning:
- if time permits
- cannot be done if nothing is significant
- can be the last aim of the proposal and it will be contingent on finding significance

Remember to back up qza and qzv files
- at least from the qza file, you can continue with your processing steps
- back up everything in github

To do:
- read through the proposal
- build up the proposal outline with Bessie next week


### January 30, 2025 Minutes  
Going forward please use github repository  
Make sure we put team agenda & meeting minutes in a read me file on the repository  
Night before each meeting try to put on the agenda:  
1. What you’ve worked on this past week
2. Any questions we have for Bessie


Ideas:  
COVID in comparison to other respiratory illnesses (mostly looking at gut microbiome)  
Try to find datasets from similar regions  
Try to find 5-10 resp disease datasets   
Note: try to pick pre-vaccination or post-vaccination  
Try to keep the model the same (either mouse or humanized mouse)  
* NOTE: if not going to compare different resp diseases, do a machine learning portion on COVID to create a predictive model  
  
Zoo animals vs wild animals & weaning age  
Try to find one more to increase in numbers 


Caveats:
We have to do a lot of research into the background to understand what’s going on
N numbers is pretty little
Oral microbiome related to disease?
