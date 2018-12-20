# This file gathers the play-by-play data for each season (pre-, post-,
# and regular season games), saving each in their respective folders.

# Install (or update) nflscrapR:
# Make sure devtools is installed with:
# install_packages("devtools")
devtools::install_github(repo = "maksimhorowitz/nflscrapR")

# Access nflscrapR:
library(nflscrapR)

# First scrape all pre-season games and save in the pre-season folder, 
# (this could be done in a loop but because of the weekly manual update it's
# just simpler to do this individually):
pre_pbp_09 <- scrape_season_play_by_play(2009, type = "pre")
pre_pbp_10 <- scrape_season_play_by_play(2010, type = "pre")
pre_pbp_11 <- scrape_season_play_by_play(2011, type = "pre")
pre_pbp_12 <- scrape_season_play_by_play(2012, type = "pre")
pre_pbp_13 <- scrape_season_play_by_play(2013, type = "pre")
pre_pbp_14 <- scrape_season_play_by_play(2014, type = "pre")
pre_pbp_15 <- scrape_season_play_by_play(2015, type = "pre")
pre_pbp_16 <- scrape_season_play_by_play(2016, type = "pre")
pre_pbp_17 <- scrape_season_play_by_play(2017, type = "pre")
pre_pbp_18 <- scrape_season_play_by_play(2018, type = "pre")

# Save the data using readr::write_csv()
readr::write_csv(pre_pbp_09,"play_by_play_data/pre_season/pre_pbp_2009.csv")
readr::write_csv(pre_pbp_10,"play_by_play_data/pre_season/pre_pbp_2010.csv")
readr::write_csv(pre_pbp_11,"play_by_play_data/pre_season/pre_pbp_2011.csv")
readr::write_csv(pre_pbp_12,"play_by_play_data/pre_season/pre_pbp_2012.csv")
readr::write_csv(pre_pbp_13,"play_by_play_data/pre_season/pre_pbp_2013.csv")
readr::write_csv(pre_pbp_14,"play_by_play_data/pre_season/pre_pbp_2014.csv")
readr::write_csv(pre_pbp_15,"play_by_play_data/pre_season/pre_pbp_2015.csv")
readr::write_csv(pre_pbp_16,"play_by_play_data/pre_season/pre_pbp_2016.csv")
readr::write_csv(pre_pbp_17,"play_by_play_data/pre_season/pre_pbp_2017.csv")
readr::write_csv(pre_pbp_18,"play_by_play_data/pre_season/pre_pbp_2018.csv")

# For regular season:
reg_pbp_09 <- scrape_season_play_by_play(2009, type = "reg")
reg_pbp_10 <- scrape_season_play_by_play(2010, type = "reg")
reg_pbp_11 <- scrape_season_play_by_play(2011, type = "reg")
reg_pbp_12 <- scrape_season_play_by_play(2012, type = "reg")
reg_pbp_13 <- scrape_season_play_by_play(2013, type = "reg")
reg_pbp_14 <- scrape_season_play_by_play(2014, type = "reg")
reg_pbp_15 <- scrape_season_play_by_play(2015, type = "reg")
reg_pbp_16 <- scrape_season_play_by_play(2016, type = "reg")
reg_pbp_17 <- scrape_season_play_by_play(2017, type = "reg")
# Update 2018 season as it progresses:
reg_pbp_18 <- readr::read_csv("play_by_play_data/regular_season/reg_pbp_2018.csv")
# Latest week - just modify the week number:
new_week_pbp_18 <- scrape_season_play_by_play(2018, type = "reg", weeks = c(12:15))
readr::write_csv(new_week_pbp_18,"play_by_play_data/regular_season/latest_week_pbp_2018.csv")
new_week_pbp_18 <- readr::read_csv("play_by_play_data/regular_season/latest_week_pbp_2018.csv")
# Append to the data and save:
reg_pbp_18 <- dplyr::bind_rows(reg_pbp_18, new_week_pbp_18)

# Save the data using readr::write_csv()
readr::write_csv(reg_pbp_09,"play_by_play_data/regular_season/reg_pbp_2009.csv")
readr::write_csv(reg_pbp_10,"play_by_play_data/regular_season/reg_pbp_2010.csv")
readr::write_csv(reg_pbp_11,"play_by_play_data/regular_season/reg_pbp_2011.csv")
readr::write_csv(reg_pbp_12,"play_by_play_data/regular_season/reg_pbp_2012.csv")
readr::write_csv(reg_pbp_13,"play_by_play_data/regular_season/reg_pbp_2013.csv")
readr::write_csv(reg_pbp_14,"play_by_play_data/regular_season/reg_pbp_2014.csv")
readr::write_csv(reg_pbp_15,"play_by_play_data/regular_season/reg_pbp_2015.csv")
readr::write_csv(reg_pbp_16,"play_by_play_data/regular_season/reg_pbp_2016.csv")
readr::write_csv(reg_pbp_17,"play_by_play_data/regular_season/reg_pbp_2017.csv")
readr::write_csv(reg_pbp_18,"play_by_play_data/regular_season/reg_pbp_2018.csv")

# For post season:
post_pbp_09 <- scrape_season_play_by_play(2009, type = "post")
post_pbp_10 <- scrape_season_play_by_play(2010, type = "post")
post_pbp_11 <- scrape_season_play_by_play(2011, type = "post")
post_pbp_12 <- scrape_season_play_by_play(2012, type = "post")
post_pbp_13 <- scrape_season_play_by_play(2013, type = "post")
post_pbp_14 <- scrape_season_play_by_play(2014, type = "post")
post_pbp_15 <- scrape_season_play_by_play(2015, type = "post")
post_pbp_16 <- scrape_season_play_by_play(2016, type = "post")
post_pbp_17 <- scrape_season_play_by_play(2017, type = "post")

# Save the data using readr::write_csv()
readr::write_csv(post_pbp_09,"play_by_play_data/post_season/post_pbp_2009.csv")
readr::write_csv(post_pbp_10,"play_by_play_data/post_season/post_pbp_2010.csv")
readr::write_csv(post_pbp_11,"play_by_play_data/post_season/post_pbp_2011.csv")
readr::write_csv(post_pbp_12,"play_by_play_data/post_season/post_pbp_2012.csv")
readr::write_csv(post_pbp_13,"play_by_play_data/post_season/post_pbp_2013.csv")
readr::write_csv(post_pbp_14,"play_by_play_data/post_season/post_pbp_2014.csv")
readr::write_csv(post_pbp_15,"play_by_play_data/post_season/post_pbp_2015.csv")
readr::write_csv(post_pbp_16,"play_by_play_data/post_season/post_pbp_2016.csv")
readr::write_csv(post_pbp_17,"play_by_play_data/post_season/post_pbp_2017.csv")


