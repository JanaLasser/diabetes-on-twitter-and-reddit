data_path <- "data/" # set data path
sentiment_data <- list.files(data_path, patter = "sentiment", full.names = TRUE) # Assuming you have sentiment data files in data/
diagnosis_data <- list.files(data_path, patter = "diagnosis_date", full.names = TRUE) ## Assuming you have diagnosis date files in data/


# Reddit data
reddit_data <- read.csv(sentiment_data[[1]], stringsAsFactors = FALSE)
reddit_diagnosis_dates <- read.csv(diagnosis_data[[1]], stringsAsFactors = FALSE)

library(tidyverse)

get_reddit_diagnosis_date <- function(name, df = reddit_diagnosis_dates){
  diag_date <- df %>%
    filter(author == name) %>%
    select(created_utc) %>%
    as.numeric()
  
  return(diag_date)
}

reddit_classified <- reddit_data %>%
  mutate(diag_utc = lapply(author, get_reddit_diagnosis_date, df = reddit_diagnosis_dates)) %>%
  mutate(group = ifelse(created_utc < diag_utc, "before", "after"))

table(reddit_classified$group)

# Export data
## First coerce the data.frame to all-character
reddit_classified_all_char = data.frame(lapply(reddit_classified, as.character), stringsAsFactors=FALSE)
write.csv(reddit_classified_all_char,paste(data_path, "reddit_sentiment_analysis_classified.csv", sep = "/"), row.names = FALSE)


## Twitter data
twitter_data <- read.csv(sentiment_data[[2]], stringsAsFactors = FALSE)
twitter_diagnosis_dates <- read.csv(diagnosis_data[[2]], stringsAsFactors = FALSE) %>%
  mutate(create_at = readr::parse_datetime(create_at))

get_twitter_diagnosis_date <- function(name, df = twitter_diagnosis_dates){
  diag_date <- df %>%
    filter(author.username == name) %>%
    select(created_at) 
  
  return(as.numeric(diag_date))
}

twitter_classified <- twitter_data %>%
  mutate(diag_utc = lapply(author_username, get_twitter_diagnosis_date, df = twitter_diagnosis_dates)) %>%
  mutate(tweet_created = as.numeric(readr::parse_datetime(tweet_created))) %>%
  mutate(group = ifelse(tweet_created < diag_date, "before", "after"))

table(twitter_classified$group)

# Export data
## First coerce the data.frame to all-character
twitter_classified_all_char = data.frame(lapply(twitter_classified, as.character), stringsAsFactors=FALSE)
write.csv(twitter_classified_all_char,paste(data_path, "twitter_sentiment_analysis_classified.csv", sep = "/"), row.names = FALSE)sis