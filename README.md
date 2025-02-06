# MICB475_Team7  

#### [Markdown Cheatsheet](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet)

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
