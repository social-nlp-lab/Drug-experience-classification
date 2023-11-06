library(tidyverse)
library(irr)
library(readxl)
# data
dat_path <- '~/Library/CloudStorage/OneDrive-SharedLibraries-DrexelUniversity/SocialNLP - Documents/Social_NLP_Lab/Annotation/Personal Experiences-Drugs/annotated_spreadsheets/v2/'

lauren <- read_excel(paste0(dat_path, "LMiller_sample_posts_codebook2.xlsx")) %>% 
  select(id:objective_3) %>% 
  mutate(across(everything(), .fns = ~replace_na(., "OTHER/NA")))
donald <- read_excel(paste0(dat_path, "sample_posts_codebook2_dah358.xlsx")) %>% 
  select(id:objective_3) %>% 
  mutate(across(everything(), .fns = ~replace_na(., "OTHER/NA")))

# Connection
unique(donald$connection)
unique(lauren$connection)

connection <- tibble(lauren[c("id", "connection")], donald = donald["connection"])

irr::kappa2(connection[2:3])

# Subjects = 50 
# Raters = 2 
# Kappa = 0.725 
# 
# z = 5.15 
# p-value = 2.65e-07 

#########################

# subject

subject1 <- tibble(lauren[c("id", "subject_1")], donald = donald["subject_1"])

irr::kappa2(subject1[2:3])

# Subjects = 50 
# Raters = 2 
# Kappa = 0.11 
# 
# z = 1.79 
# p-value = 0.0736 

# objective 1

objective1 <- tibble(lauren[c("id", "objective_1")], donald = donald["objective_1"])
irr::kappa2(objective1[2:3])

# Subjects = 50 
# Raters = 2 
# Kappa = 0.389 
# 
# z = 7.13 
# p-value = 1e-12 
