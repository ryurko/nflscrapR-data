# First install the devtools package you do not have it already:
# install.packages("devtools")

# Next using the devtools package, install `nflscrapR` from GitHub:
# devtools::install_github(repo = "maksimhorowitz/nflscrapR")

# Load the package:
library(nflscrapR)

# Access the Steelers games from this season:
pit_games <- scrape_game_ids(2018, teams = "PIT")

# Let's just pull the play-by-play data from this week's win against the Bengals:
pit_cin_pbp <- scrape_json_play_by_play(2018101401)

# Print out the first so many rows:

# Let's use the tidyverse suite of packages to handle this data:
# install.packages("tidyverse")
library(tidyverse)

# We're now going to 'select' a subset of the columns, just to begin to 
# understand how to handle this data:

easy_pit_cin_pbp <- pit_cin_pbp 







# We can make this better, let's take advantage of the provided team colors
# with the dataset available in nflscrapR (courtesy of the `teamcolors` package):
data("nflteams")
pit_color <- nflteams %>%
  filter(abbr == "PIT") %>%
  pull(primary)
cin_color <- nflteams %>%
  filter(abbr == "CIN") %>%
  pull(secondary)









# Access the ggbeeswarm package:
# install.packages('ggbeeswarm')
library(ggbeeswarm)





# What's the problem with only looking at yards gained???






# ----------------------------------------------------------------------------
# Use the nflteams data set to find your team's abbreviation then use
# the function below to scrape a dataset of their games:
# team_games_18 <- scrape_game_ids(2018, teams = "PIT")
# Pick a game_id and use the following to get the game X's play-by-play:
# game_pbp <- scrape_json_play_by_play(X)
