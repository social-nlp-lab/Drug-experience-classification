# read json files from onedrive
library(tidyverse)
library(jsonlite)
library(tokenizers)
od_path <- "~/OneDrive - Drexel University/Social_NLP_Lab/Datasets/Reddit Drug Data- RAW - DNT/Central/data Dec 1st 2022/data 2018_1_1 to 2022_7_30_"
subs <- c("opiates", "cocaine", "stims", "benzodiazepines")

posts <- subs |> map(\(x){
  df <- tibble(read_json(paste0(od_path, x, "_submission.json"),
                  simplifyVector = TRUE)[[2]])
  df <- df |> mutate(sub = x)
}
) |> list_rbind()

# posts with author is none or text that is [removed] is either deleted or removed 
posts <- posts |>
  filter(text != '[removed]',
         text != '') 

posts <- posts |>
  filter(str_count(text, "\n") > 3)
###############

# get a random sample of 3 posts

set.seed(2023)
# sample <- sample_n(posts, 25) |>
#   select(id, title, text) |>
#   # concatenate title and text
#   mutate(all_text = paste0(title, " ", text)) 

sample <- sample_n(posts, 25) |>
  select(id, text)
#################

# clean posts and tokenize for analysis

# sample_ls <- tokenize_sentences(sample$all_text)
# names(sample_ls) <- sample$id
# sample <- tibble(id = names(sample_ls), sentence = sample_ls)
# unlist sentence col
# sample <- sample |>
#   unnest(sentence)

# sample <- sample |> 
#   select(id, all_text)

# # export to csv
# write_csv(sample, "./data/sample_posts6.csv")
# write to json
jsonlite::write_json(sample, "./data/sample_posts8.json")
# jsonlite::write_json(sample, "./data/posts_round1.json")
jsonlite::write_json(sample, "./data/posts_round1_filtered_2.json")

# split data into 5 equal parts
n <- 500
nr <- nrow(sample)
blah <- split(sample, rep(1:ceiling(nr/n), each=n, length.out=nr))
list2env(setNames(blah,paste0("df",1:5)),environment())
jsonlite::write_json(df1, "./data/post_round1_500.json")
jsonlite::write_json(df2, "./data/post_round1_1000.json")
jsonlite::write_json(df3, "./data/post_round1_1500.json")
jsonlite::write_json(df4, "./data/post_round1_2000.json")
jsonlite::write_json(df5, "./data/post_round1_2500.json")
########################################################################

# STIGMA ANALYSIS TOY DATASET

key_words = c('junkie', 'addict', 'abuser', 'dirty', 'unmotivated', 'medication assisted therapy', 'noncompliant',
              'stigma')

# subset posts that contain key words
stigma_sample <- posts |>
  filter(str_detect(text, paste(key_words, collapse = '|'))) |>
  sample_n(25) |>
  select(id, text)

write_csv(stigma_sample, "./data/stigma_sample.csv")
# jsonlite::write_json(stigma_sample, "./drug_personal_exp/data/stigma_sample.json")


