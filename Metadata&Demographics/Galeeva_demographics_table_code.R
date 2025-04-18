# Demographics table of Galeeva et al before and after rarefaction #

#### Load libraries ####
library(phyloseq)
library(tidyverse)
library(vegan)
library(ape)
library(picante)
library(ggsignif)
library(ggpubr)

#### Load in RData ####
galeeva_final <- readRDS("galeeva_final.rds")
galeeva_rare <- readRDS("galeeva_rare.rds")

#### Demographics on Galeeva (non-rarefied) ####

otu_table(galeeva_final)
sample_data(galeeva_final)
tax_table(galeeva_final)
phy_tree(galeeva_final)

data_table <- as(sample_data(galeeva_final), "data.frame") |>
  mutate(across(where(~ is.character(.x) || is.factor(.x)),
                ~na_if(as.character(.x), "missing"))) |> #changing "missing" values to NAs
  mutate(AGE = as.numeric(AGE)) |>
  glimpse()

# Get COVID-19 severity #
sum(!is.na(data_table$inpatient))

number_severe = sum(data_table$inpatient == "Hospitalized")
number_severe

number_less_severe = sum(data_table$inpatient == "Ambulatory treatment")
number_less_severe

# Get age values #
nrow(data_table) # 331 samples total
sum(!is.na(data_table$AGE)) # 327 of 331 ppls age is reported 


mean_age_non = mean(data_table$AGE, na.rm = TRUE)
mean_age_non

sd_age_non = sd(data_table$AGE, na.rm = TRUE)
sd_age_non

# Get number in each age group #
unique(data_table$agegroup)

age_group_0_2_non = sum(data_table$agegroup == "0-2", na.rm = T)
age_group_0_2_non

age_group_18_25_non = sum(data_table$agegroup == "18-25", na.rm = T)
age_group_18_25_non

age_group_25_40_non = sum(data_table$agegroup == "25-40", na.rm = TRUE)
age_group_25_40_non

age_group_40_65_non = sum(data_table$agegroup == "40-65", na.rm = TRUE)
age_group_40_65_non

age_group_65_85_non = sum(data_table$agegroup == "65-85", na.rm = T)
age_group_65_85_non

age_group_85_non = sum(data_table$agegroup == "85", na.rm = T)
age_group_85_non

# Get number from each sex #
sum(!is.na(data_table$sex)) # only 329 of 331 have reported sex

number_male_non = sum(data_table$sex == "male", na.rm = T)
number_male_non

number_female_non = sum(data_table$sex == "female", na.rm = T)
number_female_non

# Get location info #
unique(data_table$geo_loc_name)
sum(!is.na(data_table$geo_loc_name)) # all 331 samples have geo location

number_irkutsk_non = sum(data_table$geo_loc_name == "Russia:Irkutsk")
number_irkutsk_non

number_moscow_non = sum(data_table$geo_loc_name == "Russia:Moscow")
number_moscow_non

number_nizhyn_non = sum(data_table$geo_loc_name == "Russia:Nizhny Novgorod")
number_nizhyn_non

number_kazan_non = sum(data_table$geo_loc_name == "Russia:Kazan")
number_kazan_non

# Current smokers #
sum(!is.na(data_table$Smoking)) #only 212 of 331 had reported yes/no smoking

number_smoking_non = sum(data_table$Smoking == "Yes", na.rm = T)
number_smoking_non

number_non_smokers_non = sum(data_table$Smoking == "No", na.rm = T)
number_non_smokers_non

# Get sample season collection date #
sum(!is.na(data_table$Season)) # 327 of 331 samples have season collection info
unique(data_table$Season)

number_summer_non = sum(data_table$Season == "summer", na.rm = T)
number_summer_non

number_spring_non = sum(data_table$Season == "spring", na.rm = T)
number_spring_non

number_fall_non = sum(data_table$Season == "fall", na.rm = T)
number_fall_non

number_winter_non = sum(data_table$Season == "winter", na.rm = T)
number_winter_non


# Current or previous medical history #
# Asthma 
sum(!is.na(data_table$asthma))

number_asthma_non = sum(data_table$asthma == "Yes", na.rm = T)
number_asthma_non

number_non_asthma_non = sum(data_table$asthma == "No", na.rm = T)
number_non_asthma_non

sum()

# Chronic Heart Failure
sum(!is.na(data_table$chronic_heart_failure))

number_chf_yes_non = sum(data_table$chronic_heart_failure == "Yes", na.rm = TRUE)
number_chf_yes_non

number_chf_no_non = sum(data_table$chronic_heart_failure == "No", na.rm = TRUE)
number_chf_no_non

# Cirrhosis
sum(!is.na(data_table$cirrhosis))

number_cirrhosis_yes_non = sum(data_table$cirrhosis == "Yes", na.rm = TRUE)
number_cirrhosis_yes_non

number_cirrhosis_no_non = sum(data_table$cirrhosis == "No", na.rm = TRUE)
number_cirrhosis_no_non

# Coronary Artery Disease
sum(!is.na(data_table$corono_datary_artery_disease))

number_cad_yes_non = sum(data_table$corono_datary_artery_disease == "Yes", na.rm = TRUE)
number_cad_yes_non

number_cad_no_non = sum(data_table$corono_datary_artery_disease == "No", na.rm = TRUE)
number_cad_no_non

# Diabetes
sum(!is.na(data_table$Diabetes))

number_diabetes_yes_non = sum(data_table$Diabetes == "Yes", na.rm = TRUE)
number_diabetes_yes_non

number_diabetes_no_non = sum(data_table$Diabetes == "No", na.rm = TRUE)
number_diabetes_no_non

# Hypertension
sum(!is.na(data_table$hypertension))

number_hypertension_yes_non = sum(data_table$hypertension == "Yes", na.rm = TRUE)
number_hypertension_yes_non

number_hypertension_no_non = sum(data_table$hypertension == "No", na.rm = TRUE)
number_hypertension_no_non

# IBD
sum(!is.na(data_table$ibd))

number_ibd_yes_non = sum(data_table$ibd == "Yes", na.rm = TRUE)
number_ibd_yes_non

number_ibd_no_non = sum(data_table$ibd == "No", na.rm = TRUE)
number_ibd_no_non

# Obesity
sum(!is.na(data_table$obesity))

number_obesity_yes_non = sum(data_table$obesity == "Yes", na.rm = TRUE)
number_obesity_yes_non

number_obesity_no_non = sum(data_table$obesity == "No", na.rm = TRUE)
number_obesity_no_non

# Smoking Before
sum(!is.na(data_table$smoking_before))

number_smoking_before_yes_non = sum(data_table$smoking_before == "Yes", na.rm = TRUE)
number_smoking_before_yes_non

number_smoking_before_no_non = sum(data_table$smoking_before == "No", na.rm = TRUE)
number_smoking_before_no_non

# Tuberculosis
sum(!is.na(data_table$tuberculosis))

number_tb_yes_non = sum(data_table$tuberculosis == "Yes", na.rm = TRUE)
number_tb_yes_non

number_tb_no_non = sum(data_table$tuberculosis == "No", na.rm = TRUE)
number_tb_no_non

#### Repeat demographics on Galeeva rarefied ####

otu_table(galeeva_rare)
sample_data(galeeva_rare)
tax_table(galeeva_rare)
phy_tree(galeeva_rare)

data_table_rare <- as(sample_data(galeeva_rare), "data.frame") |>
  mutate(across(where(~ is.character(.x) || is.factor(.x)),
                ~na_if(as.character(.x), "missing"))) |> #changing "missing" values to NAs
  mutate(AGE = as.numeric(AGE)) |>
  glimpse()

# Get COVID-19 severity #
sum(!is.na(data_table_rare$inpatient))

number_severe_rare = sum(data_table_rare$inpatient == "Hospitalized")
number_severe_rare

number_less_severe_rare = sum(data_table_rare$inpatient == "Ambulatory treatment")
number_less_severe_rare

# Get age values #
nrow(data_table_rare) # 226 samples total
sum(!is.na(data_table_rare$AGE)) # all 226 ppls age is reported 


mean_age_rare = mean(data_table_rare$AGE, na.rm = TRUE)
mean_age_rare

sd_age_rare = sd(data_table_rare$AGE, na.rm = TRUE)
sd_age_rare

# Get number in each age group #
unique(data_table_rare$agegroup)

age_group_0_2_rare = sum(data_table_rare$agegroup == "0-2", na.rm = T)
age_group_0_2_rare

age_group_18_25_rare = sum(data_table_rare$agegroup == "18-25", na.rm = T)
age_group_18_25_rare

age_group_25_40_rare = sum(data_table_rare$agegroup == "25-40", na.rm = TRUE)
age_group_25_40_rare

age_group_40_65_rare = sum(data_table_rare$agegroup == "40-65", na.rm = TRUE)
age_group_40_65_rare

age_group_65_85_rare = sum(data_table_rare$agegroup == "65-85", na.rm = T)
age_group_65_85_rare

age_group_85_rare = sum(data_table_rare$agegroup == "85", na.rm = T)
age_group_85_rare

# Get number from each sex #
sum(!is.na(data_table_rare$sex)) # all 226 have reported sex

number_male_rare = sum(data_table_rare$sex == "male", na.rm = T)
number_male_rare

number_female_rare = sum(data_table_rare$sex == "female", na.rm = T)
number_female_rare

# Get location info #
unique(data_table_rare$geo_loc_name)
sum(!is.na(data_table_rare$geo_loc_name)) # all 226 samples have geo location

number_irkutsk_rare = sum(data_table_rare$geo_loc_name == "Russia:Irkutsk")
number_irkutsk_rare

number_moscow_rare = sum(data_table_rare$geo_loc_name == "Russia:Moscow")
number_moscow_rare

number_nizhyn_rare = sum(data_table_rare$geo_loc_name == "Russia:Nizhny Novgorod")
number_nizhyn_rare

number_kazan_rare = sum(data_table_rare$geo_loc_name == "Russia:Kazan")
number_kazan_rare

# Current smokers #
sum(!is.na(data_table_rare$Smoking)) #only 141 of 226 had reported yes/no smoking

number_smoking_rare = sum(data_table_rare$Smoking == "Yes", na.rm = T)
number_smoking_rare

number_non_smokers_rare = sum(data_table_rare$Smoking == "No", na.rm = T)
number_non_smokers_rare

# Get sample season collection date #
sum(!is.na(data_table_rare$Season)) # all 226 samples have season collection info
unique(data_table_rare$Season)

number_summer_rare = sum(data_table_rare$Season == "summer", na.rm = T)
number_summer_rare

number_spring_rare = sum(data_table_rare$Season == "spring", na.rm = T)
number_spring_rare

number_fall_rare = sum(data_table_rare$Season == "fall", na.rm = T)
number_fall_rare

number_winter_rare = sum(data_table_rare$Season == "winter", na.rm = T)
number_winter_rare


# Current or previous medical history #
# Asthma 
sum(!is.na(data_table_rare$asthma)) 

number_asthma_rare = sum(data_table_rare$asthma == "Yes", na.rm = T)
number_asthma_rare

number_non_asthma_rare = sum(data_table_rare$asthma == "No", na.rm = T)
number_non_asthma_rare

# Chronic Heart Failure
sum(!is.na(data_table_rare$chronic_heart_failure))

number_chf_yes_rare = sum(data_table_rare$chronic_heart_failure == "Yes", na.rm = TRUE)
number_chf_yes_rare

number_chf_no_rare = sum(data_table_rare$chronic_heart_failure == "No", na.rm = TRUE)
number_chf_no_rare

# Cirrhosis
sum(!is.na(data_table_rare$cirrhosis))

number_cirrhosis_yes_rare = sum(data_table_rare$cirrhosis == "Yes", na.rm = TRUE)
number_cirrhosis_yes_rare

number_cirrhosis_no_rare = sum(data_table_rare$cirrhosis == "No", na.rm = TRUE)
number_cirrhosis_no_rare

# Coronary Artery Disease
sum(!is.na(data_table_rare$corono_datary_artery_disease))

number_cad_yes_rare = sum(data_table_rare$corono_datary_artery_disease == "Yes", na.rm = TRUE)
number_cad_yes_rare

number_cad_no_rare = sum(data_table_rare$corono_datary_artery_disease == "No", na.rm = TRUE)
number_cad_no_rare

# Diabetes
sum(!is.na(data_table_rare$Diabetes))

number_diabetes_yes_rare = sum(data_table_rare$Diabetes == "Yes", na.rm = TRUE)
number_diabetes_yes_rare

number_diabetes_no_rare = sum(data_table_rare$Diabetes == "No", na.rm = TRUE)
number_diabetes_no_rare

# Hypertension
sum(!is.na(data_table_rare$hypertension))

number_hypertension_yes_rare = sum(data_table_rare$hypertension == "Yes", na.rm = TRUE)
number_hypertension_yes_rare

number_hypertension_no_rare = sum(data_table_rare$hypertension == "No", na.rm = TRUE)
number_hypertension_no_rare

# IBD
sum(!is.na(data_table_rare$ibd))

number_ibd_yes_rare = sum(data_table_rare$ibd == "Yes", na.rm = TRUE)
number_ibd_yes_rare

number_ibd_no_rare = sum(data_table_rare$ibd == "No", na.rm = TRUE)
number_ibd_no_rare

# Obesity
sum(!is.na(data_table_rare$obesity))

number_obesity_yes_rare = sum(data_table_rare$obesity == "Yes", na.rm = TRUE)
number_obesity_yes_rare

number_obesity_no_rare = sum(data_table_rare$obesity == "No", na.rm = TRUE)
number_obesity_no_rare

# Smoking Before
sum(!is.na(data_table_rare$smoking_before))

number_smoking_before_yes_rare = sum(data_table_rare$smoking_before == "Yes", na.rm = TRUE)
number_smoking_before_yes_rare

number_smoking_before_no_rare = sum(data_table_rare$smoking_before == "No", na.rm = TRUE)
number_smoking_before_no_rare

# Tuberculosis
sum(!is.na(data_table_rare$tuberculosis))

number_tb_yes_rare = sum(data_table_rare$tuberculosis == "Yes", na.rm = TRUE)
number_tb_yes_rare

number_tb_no_rare = sum(data_table_rare$tuberculosis == "No", na.rm = TRUE)
number_tb_no_rare
#### Save as a word doc file ####
#install.packages("flextable")
#install.packages("officer")

library(flextable)
library(officer)
library(dplyr)

# Construct your demographics table as a data frame
demographics_table <- data.frame(
  Characteristic = c(
    "Age (mean ± SD)", "Age missing",
    "Age Group: 0–2", "Age Group: 18–25", "Age Group: 25–40", 
    "Age Group: 40–65", "Age Group: 65–85", "Age Group: 85", 
    "Sex: Female", "Sex: Male", "Sex missing",
    "Location: Irkutsk", "Moscow", "Nizhny Novgorod", "Kazan",
    "Smoking (Yes)", "Smoking (No)", "Smoking missing",
    "Season: Spring", "Summer", "Fall", "Winter", "Season missing",
    "Asthma (Yes)", "Asthma (No)",
    "Chronic Heart Failure (Yes)", "CHF (No)",
    "Cirrhosis (Yes)", "Cirrhosis (No)",
    "Coronary Artery Disease (Yes)", "CAD (No)",
    "Diabetes (Yes)", "Diabetes (No)",
    "Hypertension (Yes)", "Hypertension (No)",
    "IBD (Yes)", "IBD (No)",
    "Obesity (Yes)", "Obesity (No)",
    "Smoking Before (Yes)", "Smoking Before (No)",
    "Tuberculosis (Yes)", "Tuberculosis (No)"
  ),
  `Non-Rarefied (n = 331)` = c(
    sprintf("%.2f ± %.2f", mean_age_non, sd_age_non), 4,
    age_group_0_2_non, age_group_18_25_non, age_group_25_40_non,
    age_group_40_65_non, age_group_65_85_non, age_group_85_non,
    number_female_non, number_male_non, 2,
    number_irkutsk_non, number_moscow_non, number_nizhyn_non, number_kazan_non,
    number_smoking_non, number_non_smokers_non, 119,
    number_spring_non, number_summer_non, number_fall_non, number_winter_non, 4,
    number_asthma_non, number_non_asthma_non,
    number_chf_yes_non, number_chf_no_non,
    number_cirrhosis_yes_non, number_cirrhosis_no_non,
    number_cad_yes_non, number_cad_no_non,
    number_diabetes_yes_non, number_diabetes_no_non,
    number_hypertension_yes_non, number_hypertension_no_non,
    number_ibd_yes_non, number_ibd_no_non,
    number_obesity_yes_non, number_obesity_no_non,
    number_smoking_before_yes_non, number_smoking_before_no_non,
    number_tb_yes_non, number_tb_no_non
  ),
  `Rarefied (n = 226)` = c(
    sprintf("%.2f ± %.2f", mean_age_rare, sd_age_rare), 0,
    age_group_0_2_rare, age_group_18_25_rare, age_group_25_40_rare,
    age_group_40_65_rare, age_group_65_85_rare, age_group_85_rare,
    number_female_rare, number_male_rare, 0,
    number_irkutsk_rare, number_moscow_rare, number_nizhyn_rare, number_kazan_rare,
    number_smoking_rare, number_non_smokers_rare, 85,
    number_spring_rare, number_summer_rare, number_fall_rare, number_winter_rare, 0,
    number_asthma_rare, number_non_asthma_rare,
    number_chf_yes_rare, number_chf_no_rare,
    number_cirrhosis_yes_rare, number_cirrhosis_no_rare,
    number_cad_yes_rare, number_cad_no_rare,
    number_diabetes_yes_rare, number_diabetes_no_rare,
    number_hypertension_yes_rare, number_hypertension_no_rare,
    number_ibd_yes_rare, number_ibd_no_rare,
    number_obesity_yes_rare, number_obesity_no_rare,
    number_smoking_before_yes_rare, number_smoking_before_no_rare,
    number_tb_yes_rare, number_tb_no_rare
  )
)

# Create a flextable
ft <- flextable(demographics_table) %>%
  autofit()

# Write to Word
doc <- read_docx() %>%
  body_add_par("Demographics Summary Table", style = "heading 1") %>%
  body_add_flextable(ft)

print(doc, target = "Galeeva_Demographics_Summary.docx")