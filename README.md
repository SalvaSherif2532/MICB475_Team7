# MICB475_Team7  

#### [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)
### March 6, 2025 Agenda - Rana
* Bring up feedback that Hans provided and say that it's not found in the rubric
  * Sample proposals are a bit hard to follow
* Talk about sample size - Galeeva et al only has over 200 samples
* How do we want to label the severity titles
* Clarify with Bessie - gantt chart feedback
* Ask Bessie for Random Forest package code
* Melika will show Salva push/pull github
* Save phyloseq object as rds instead of RData

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
