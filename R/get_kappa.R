library(tidyverse)
library(irr)
library(readxl)
# data
dat_path = '~/Library/CloudStorage/OneDrive-DrexelUniversity/Social_NLP_Lab/Annotation/Personal Experiences-Drugs/annotated_spreadsheets/'
amui1 = read_excel(paste0(dat_path, 'completed_annotations1_amui.xlsx'))
linh1 = read_excel(paste0(dat_path, 'sample_posts1_code_linh.xlsx'))
medhavi1 = read_excel(paste0(dat_path, 'sample_posts1_code_medhavi.xlsx'))

# round 2
amui2 = read_csv(paste0(dat_path, 'Annotation2_amui.csv')) %>% 
  mutate(across(everything(), .fns = ~replace(., . ==  "disclosure" , "Disclosure"))) %>% 
  mutate(across(everything(), .fns = ~replace(., . ==  "recovery" , "Recovery"))) %>% 
  mutate(across(everything(), .fns = ~replace_na(., "Not Applicable")))

medhavi2 = read_excel(paste0(dat_path, 'medhavi_annotated_sample_posts2.xls.xlsx')) %>% 
  mutate(across(everything(), .fns = ~replace(., . ==  "recovery" , "Recovery"))) %>% 
  mutate(across(everything(), .fns = ~replace(., . ==  "Not applicable" , "Not Applicable"))) %>% 
  mutate(across(everything(), .fns = ~replace_na(., "Not Applicable")))

linh2 = read_excel(paste0(dat_path, 'sample_posts2_linh.xlsx')) %>%
  mutate(across(everything(), .fns = ~replace(., . ==  "N/A" , "Not Applicable")))

# round 3
amui3 = read_excel(paste0(dat_path, 'sample_annotations3_amui.xls')) #corrupt file
medhavi3 = read_excel(paste0(dat_path, 'sample_posts3_medhavi.xlsx'))
linh3 = read_excel(paste0(dat_path, "sample_posts3_linh.xlsx"))
############################################################################

unique(amui1$code_b)
unique(linh1$code_b)
unique(medhavi1$code_b)

#join tables
round1_cat1 <- tibble(amui1[c("id",amui ="code")], linh = linh1["code"], med = medhavi1["code"]) %>%
  replace_na(list("not applicable"))

kappam.fleiss(round1_cat1[2:4])

# Fleiss' Kappa for m Raters
# 
# Subjects = 25 
# Raters = 3 
# Kappa = 0.222 
# 
# z = 3.54 
# p-value = 0.000405 

round1_cat2 <- tibble(amui1[c("id",amui ="code_b")], linh = linh1["code_b"], med = medhavi1["code_b"]) %>%
  replace_na(list("Not Applicable"))

kappam.fleiss(round1_cat2[2:4])
 
# Subjects = 25 
# Raters = 3 
# Kappa = 0.117 
# 
# z = 1.83 
# p-value = 0.0672
############################################################################
unique(amui2$code)
unique(linh2$code)
unique(medhavi2$code)


round2_cat1 <- tibble(id = linh2$id, linh = linh2$code, med = medhavi2$code, amui = amui2$code) %>% 
  mutate(across(everything(), .fns = ~replace(., . ==  NA , "Not Applicable")))


kappam.fleiss(round2_cat1[2:4])

# Subjects = 25 
# Raters = 3 
# Kappa = 0.276 
# 
# z = 4.24 
# p-value = 2.21e-05

unique(amui2$code_b)
unique(linh2$code_b)
unique(medhavi2$code_b)

round2_cat2 <- tibble(amui2[c("id",amui ="code_b")], linh = linh2["code_b"], med = medhavi2["code_b"]) %>% 
  mutate(across(everything(), .fns = ~replace(., . ==  NA , "Not Applicable")))

kappam.fleiss(round2_cat2[2:4])

# Subjects = 25 
# Raters = 3 
# Kappa = -0.0831 
# 
# z = -1.2 
# p-value = 0.232

disagreement2 <- round2_cat1 %>% 
  filter(amui != linh & amui != med)

############################################################################
# amuis round3 is corrupt so kappa just for medhavi and linh

unique(linh3$code)
unique(medhavi3$code)

round3_cat1 <- tibble(id = linh3$id, linh = linh3$code, med = medhavi3$code) %>% 
  mutate(across(everything(), .fns = ~replace(., . ==  NA , "Not Applicable")))

kappa2(round3_cat1[2:3])

# 
# Cohen's Kappa for 2 Raters (Weights: unweighted)
# 
#  Subjects = 25 
#    Raters = 2 
#     Kappa = 0.0946 
# 
#         z = 1.31 
#   p-value = 0.189 

# what posts DID they AGREE on

agreement = round3_cat1 %>% 
  filter(linh == med)
# 7/25 agreement, instruction and banter must be confusing

disagreement3 = round3_cat1 %>% 
  filter(linh != med)
# codeb

unique(linh3$code_b)
unique(medhavi3$code_b)

round3_cat2 <-  tibble(id = linh3$id, linh = linh3$code_b, med = medhavi3$code_b) %>% 
  mutate(across(everything(), .fns = ~replace(., . ==  NA , "Not Applicable")))

kappa2(round3_cat2[2:3])

# Cohen's Kappa for 2 Raters (Weights: unweighted)
# 
#  Subjects = 25 
#    Raters = 2 
#     Kappa = 0.272 
# 
#         z = 3.15 
#   p-value = 0.00163
