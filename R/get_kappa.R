library(tidyverse)
library(irr)
library(readxl)
# data
dat_path = '~/Library/CloudStorage/OneDrive-DrexelUniversity/Social_NLP_Lab/Annotation/Personal Experiences-Drugs/annotated_spreadsheets/'
amui1 = read_excel(paste0(dat_path, 'completed_annotations1_amui.xlsx'))
linh1 = read_excel(paste0(dat_path, 'sample_posts1_code_linh.xlsx'))
medhavi1 = read_excel(paste0(dat_path, 'sample_posts1_code_medhavi.xlsx'))

# round 2
amui2 = read_csv(paste0(dat_path, 'Annotation2_amui.csv'))
medhavi2 = read_excel(paste0(dat_path, 'medhavi_annotated_sample_posts2.xls.xlsx'))
linh2 = read_excel(paste0(dat_path, 'sample_posts2_linh.xlsx'))

############################################################################
#join tables
round1_cat1 <- tibble(amui1[c("id",amui ="code")], linh = linh1["code"], med = medhavi1["code"])
kappam.fleiss(round1_cat1[2:4])

# Fleiss' Kappa for m Raters
# 
#  Subjects = 25 
#    Raters = 3 
#     Kappa = 0.224 
# 
#         z = 3.62 
#   p-value = 0.000289

round1_cat2 <- tibble(amui1[c("id",amui ="code_b")], linh = linh1["code_b"], med = medhavi1["code_b"])
kappam.fleiss(round1_cat2[2:4])
 
# Subjects = 25 
# Raters = 3 
# Kappa = 0.118 
# 
# z = 1.89 
# p-value = 0.0586
############################################################################
round2_cat1 <- bind_cols(amui2$id,amui2$code,linh2$code, medhavi2$code)
kappam.fleiss(round2_cat1[2:4])

# Subjects = 24 
# Raters = 3 
# Kappa = 0.116 
# 
# z = 2.1 
# p-value = 0.0354 

round2_cat2 <- tibble(amui2[c("id",amui ="code_b")], linh = linh2["code_b"], med = medhavi2["code_b"])
kappam.fleiss(round2_cat2[2:4])

# Subjects = 2 
# Raters = 3 
# Kappa = -0.2 
# 
# z = -1.1 
# p-value = 0.273 