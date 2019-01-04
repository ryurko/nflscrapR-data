# This file initializes the datasets of games with final scores using the
# scrape_game_ids() function

# Install (or update) nflscrapR:
# Make sure devtools is installed with:
# install_packages("devtools")
devtools::install_github(repo = "maksimhorowitz/nflscrapR")

# Access nflscrapR:
library(nflscrapR)

# First scrape all pre-season games and save in the pre-season folder, 
# (this could be done in a loop but because of the weekly manual update it's
# just simpler to do this individually):
pre_games_09 <- scrape_game_ids(2009, type = "pre")
pre_games_10 <- scrape_game_ids(2010, type = "pre")
pre_games_11 <- scrape_game_ids(2011, type = "pre")
pre_games_12 <- scrape_game_ids(2012, type = "pre")
pre_games_13 <- scrape_game_ids(2013, type = "pre")
pre_games_14 <- scrape_game_ids(2014, type = "pre")
pre_games_15 <- scrape_game_ids(2015, type = "pre")
pre_games_16 <- scrape_game_ids(2016, type = "pre")
pre_games_17 <- scrape_game_ids(2017, type = "pre")
pre_games_18 <- scrape_game_ids(2018, type = "pre")

# Save the data using readr::write_csv()
readr::write_csv(pre_games_09,"games_data/pre_season/pre_games_2009.csv")
readr::write_csv(pre_games_10,"games_data/pre_season/pre_games_2010.csv")
readr::write_csv(pre_games_11,"games_data/pre_season/pre_games_2011.csv")
readr::write_csv(pre_games_12,"games_data/pre_season/pre_games_2012.csv")
readr::write_csv(pre_games_13,"games_data/pre_season/pre_games_2013.csv")
readr::write_csv(pre_games_14,"games_data/pre_season/pre_games_2014.csv")
readr::write_csv(pre_games_15,"games_data/pre_season/pre_games_2015.csv")
readr::write_csv(pre_games_16,"games_data/pre_season/pre_games_2016.csv")
readr::write_csv(pre_games_17,"games_data/pre_season/pre_games_2017.csv")
readr::write_csv(pre_games_18,"games_data/pre_season/pre_games_2018.csv")

# For regular season:
reg_games_09 <- scrape_game_ids(2009, type = "reg")
reg_games_10 <- scrape_game_ids(2010, type = "reg")
reg_games_11 <- scrape_game_ids(2011, type = "reg")
reg_games_12 <- scrape_game_ids(2012, type = "reg")
reg_games_13 <- scrape_game_ids(2013, type = "reg")
reg_games_14 <- scrape_game_ids(2014, type = "reg")
reg_games_15 <- scrape_game_ids(2015, type = "reg")
reg_games_16 <- scrape_game_ids(2016, type = "reg")
reg_games_17 <- scrape_game_ids(2017, type = "reg")
reg_games_18 <- scrape_game_ids(2018, type = "reg")


# Save the data using readr::write_csv()
readr::write_csv(reg_games_09,"games_data/regular_season/reg_games_2009.csv")
readr::write_csv(reg_games_10,"games_data/regular_season/reg_games_2010.csv")
readr::write_csv(reg_games_11,"games_data/regular_season/reg_games_2011.csv")
readr::write_csv(reg_games_12,"games_data/regular_season/reg_games_2012.csv")
readr::write_csv(reg_games_13,"games_data/regular_season/reg_games_2013.csv")
readr::write_csv(reg_games_14,"games_data/regular_season/reg_games_2014.csv")
readr::write_csv(reg_games_15,"games_data/regular_season/reg_games_2015.csv")
readr::write_csv(reg_games_16,"games_data/regular_season/reg_games_2016.csv")
readr::write_csv(reg_games_17,"games_data/regular_season/reg_games_2017.csv")
readr::write_csv(reg_games_18,"games_data/regular_season/reg_games_2018.csv")

# For post season:
post_games_09 <- scrape_game_ids(2009, type = "post")
post_games_10 <- scrape_game_ids(2010, type = "post")
post_games_11 <- scrape_game_ids(2011, type = "post")
post_games_12 <- scrape_game_ids(2012, type = "post")
post_games_13 <- scrape_game_ids(2013, type = "post")
post_games_14 <- scrape_game_ids(2014, type = "post")
post_games_15 <- scrape_game_ids(2015, type = "post")
post_games_16 <- scrape_game_ids(2016, type = "post")
post_games_17 <- scrape_game_ids(2017, type = "post")
post_games_18 <- scrape_game_ids(2018, type = "post")

# Save the data using readr::write_csv()
readr::write_csv(post_games_09,"games_data/post_season/post_games_2009.csv")
readr::write_csv(post_games_10,"games_data/post_season/post_games_2010.csv")
readr::write_csv(post_games_11,"games_data/post_season/post_games_2011.csv")
readr::write_csv(post_games_12,"games_data/post_season/post_games_2012.csv")
readr::write_csv(post_games_13,"games_data/post_season/post_games_2013.csv")
readr::write_csv(post_games_14,"games_data/post_season/post_games_2014.csv")
readr::write_csv(post_games_15,"games_data/post_season/post_games_2015.csv")
readr::write_csv(post_games_16,"games_data/post_season/post_games_2016.csv")
readr::write_csv(post_games_17,"games_data/post_season/post_games_2017.csv")
readr::write_csv(post_games_18,"games_data/post_season/post_games_2018.csv")



