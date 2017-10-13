library(tidyverse)
library(tm)
library(wordcloud)
library(stringr)


# Load and stack the play-by-play data:
pbp_data <- rbind(readr::read_csv("~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2009.csv"),
                  readr::read_csv("~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2010.csv"),
                  readr::read_csv("~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2011.csv"),
                  readr::read_csv("~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2012.csv"),
                  readr::read_csv("~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2013.csv"),
                  readr::read_csv("~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2014.csv"),
                  readr::read_csv("~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2015.csv"),
                  readr::read_csv("~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2016.csv"),
                  readr::read_csv("~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2017.csv"))

play_text <- paste(pbp_data$desc[which(pbp_data$Season==2017)],collapse = " ") 

extract_words <- function(parsed_text, stopwords) {
  # Use the helper functions to return the vector words
  parsed_text %>% tokenize %>% filter_stopwords(stopwords) %>% 
    return
}

# Define the tokenize() function:
# INPUT:  - parsed_text = single string of text from parse_text()
# OUTPUT: - vector of tokens in parsed_text

tokenize <- function(parsed_text) {
  # Replace punctuation with a space (EDIT LATER)
  # and change numbers to be # symbol
  parsed_text %>% str_replace_all(c('[[:punct:]]' = ' ',
                                    '[0-9]+' = '#')) %>%
    # Return the remaining words as a vector in lowercase
    #str_split('[:space:]+') %>% unlist %>% 
    str_extract_all("([A-Za-z][-A-Za-z]+)") %>% unlist %>%
    sapply(tolower) %>% as.character %>% return
}

# Define the filter_stopwords() function:
# INPUT:  - tokens = vector tokens
#         - stopwords = vector of stopwords to remove
# OUTPUT: - vector of tokens with stopwords removed

filter_stopwords <- function(tokens, stopwords) {
  # Find the stopword indices in tokens
  stopwords_i <- which(tokens %in% stopwords)
  # Remove the stopwords
  return(tokens[-stopwords_i])
}


play_text_words <- play_text %>% extract_words(stopwords())
play_text_table <- table(play_text_words)
wordcloud(words = names(play_text_table), freq = as.numeric(play_text_table), min.freq = 3,
          max.words = 500,
          random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

pass_plays_2017 <- filter(pbp_data, Season==2017,PassAttempt==1)
pass_text <- paste(pass_plays_2017$desc,collapse = " ") 
pass_text_words <- pass_text %>% extract_words(stopwords())
pass_text_table <- table(pass_text_words)
wordcloud(words = names(pass_text_table), freq = as.numeric(pass_text_table), min.freq = 3,
          max.words = 500,
          random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))

rush_plays_2017 <- filter(pbp_data, Season==2017,RushAttempt==1)
rush_text <- paste(rush_plays_2017$desc,collapse = " ") 
rush_text_words <- rush_text %>% extract_words(stopwords())
rush_text_table <- table(rush_text_words)
wordcloud(words = names(rush_text_table), freq = as.numeric(rush_text_table), min.freq = 3,
          max.words = 500,
          random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(8, "Dark2"))



