library(tidyverse)
library(irr)
library(readxl)
library(jsonlite)
# data
dat_path <- "data/zooni/sud-project-classifications.csv"
lauren <- read_csv(dat_path) %>% 
  select(user_name,subject_data, annotations) %>% 
  filter(user_name == "laurenmiller324") %>% 
  arrange(desc(subject_data))
donald <- read_csv(dat_path) %>% 
  select(user_name, subject_data, annotations) %>% 
  filter(user_name == "dhattier") %>% 
  arrange(desc(subject_data))

# Connection

# parse annotation var
get_annotation <- function(annotation){
  # Parse the JSON data
  data <- fromJSON(annotation)
  
  # Create a dataframe using tidyverse
  df <- data.frame(
    task = data$task,
    task_label = data$task_label,
    value = data$value[[1]]
  )
  
  # Rename columns for consistency
  df <- df %>%
    rename(
      task = task,
      task_label = task_label,
      value = value
    )
  return(df)
}

lauren2 <- map_df(lauren$annotations, get_annotation)
donald2 <- map_df(donald$annotations, get_annotation)

lauren_filtered <- lauren %>% filter(task == "T0")
donald_filtered <- donald %>% filter(task == "T0")

connection <- tibble(lauren_filtered[c("value")], donald = donald_filtered["value"])

irr::kappa2(connection)

# Subjects = 25 
# Raters = 2 
# Kappa = 0.429 
# 
# z = 2.28 
# p-value = 0.0224 

#########################

# subject
lauren_filtered <- lauren %>% filter(task == "T1")
donald_filtered <- donald %>% filter(task == "T1")
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
