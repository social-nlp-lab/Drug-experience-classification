# read json files from onedrive
library(tidyverse)
library(jsonlite)
library(tokenizers)
od_path <- "~/OneDrive - Drexel University/Social_NLP_Lab/Data/Central/data Dec 1st 2022/data 2018_1_1 to 2022_7_30_"
subs <- c("opiates", "cocaine", "stims", "benzodiazepines", "ambien")

posts <- subs |> map(\(x){
  df <- tibble(read_json(paste0(od_path, x, "_submission.json"),
                  simplifyVector = TRUE)[[2]])
  df <- df |> mutate(sub = x)
}
) |> list_rbind()

# posts with author is none or text that is [removed] is either deleted or removed 
posts <- posts |>
  filter(text != '[removed]')
###############

# get a random sample of 3 posts

set.seed(2023)
sample <- sample_n(posts, 25) |>
  select(id, title, text) |>
  # concatenate title and text
  mutate(all_text = paste0(title, " ", text)) 

#################

# clean posts and tokenize for analysis

sample_ls <- tokenize_sentences(sample$all_text)
names(sample_ls) <- sample$id
sample <- tibble(id = names(sample_ls), sentence = sample_ls)
# unlist sentence col
sample <- sample |>
  unnest(sentence)

# # export to csv
write_csv(sample, "./data/sample_posts1.csv")


