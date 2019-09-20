# This file initializes the datasets team rosters for offensive skill position
# players using the get_season_rosters function

# Install (or update) nflscrapR:
# Make sure devtools is installed with:
# install_packages("devtools")
# devtools::install_github(repo = "maksimhorowitz/nflscrapR")

# Access nflscrapR:
library(nflscrapR)

# Now read in all of the play-by-play data just to get the team abbreviations
# that were used for each season, making a dataset where each row is a team abbreviation
# for each year:
team_pbp_data <- purrr::map_dfr(c(2009:2019),
                             function(x) {
                               readr::read_csv(paste0("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_",
                                               x, ".csv")) %>%
                                 dplyr::mutate(pbp_season = x) %>%
                                 dplyr::select(posteam, pbp_season) %>%
                                 dplyr::filter(!is.na(posteam)) %>%
                                 dplyr::mutate(posteam = ifelse(pbp_season == 2016 & posteam == "JAC",
                                                                "JAX", posteam)) %>%
                                 dplyr::distinct()
                             })

# ------------------------------------------------------------------------------

# Scrape the pre-season rosters (that are available) and save to respective folder:
teams_2009 <- team_pbp_data %>%
  dplyr::filter(pbp_season == 2009) %>%
  dplyr::pull(posteam)
pre_season_09_rosters <- get_season_rosters(2009,
                                            teams = teams_2009,
                                            type = "pre")
readr::write_csv(pre_season_09_rosters,
                 "roster_data/pre_season/pre_roster_2009.csv")

teams_2010 <- team_pbp_data %>%
  dplyr::filter(pbp_season == 2010) %>%
  dplyr::pull(posteam)
pre_season_10_rosters <- get_season_rosters(2010,
                                            teams = teams_2010,
                                            type = "pre")
readr::write_csv(pre_season_10_rosters,
                 "roster_data/pre_season/pre_roster_2010.csv")

teams_2011 <- team_pbp_data %>%
  dplyr::filter(pbp_season == 2011) %>%
  dplyr::pull(posteam)
pre_season_11_rosters <- get_season_rosters(2011,
                                            teams = teams_2011,
                                            type = "pre")
readr::write_csv(pre_season_11_rosters,
                 "roster_data/pre_season/pre_roster_2011.csv")

teams_2012 <- team_pbp_data %>%
  dplyr::filter(pbp_season == 2012) %>%
  dplyr::pull(posteam)
pre_season_12_rosters <- get_season_rosters(2012,
                                            teams = teams_2012,
                                            type = "pre")
readr::write_csv(pre_season_12_rosters,
                 "roster_data/pre_season/pre_roster_2012.csv")

teams_2013 <- team_pbp_data %>%
  dplyr::filter(pbp_season == 2013) %>%
  dplyr::pull(posteam)
pre_season_13_rosters <- get_season_rosters(2013,
                                            teams = teams_2013,
                                            type = "pre")
readr::write_csv(pre_season_13_rosters,
                 "roster_data/pre_season/pre_roster_2013.csv")

teams_2014 <- team_pbp_data %>%
  dplyr::filter(pbp_season == 2014) %>%
  dplyr::pull(posteam)
pre_season_14_rosters <- get_season_rosters(2014,
                                            teams = teams_2014,
                                            type = "pre")
readr::write_csv(pre_season_14_rosters,
                 "roster_data/pre_season/pre_roster_2014.csv")

teams_2015 <- team_pbp_data %>%
  dplyr::filter(pbp_season == 2015) %>%
  dplyr::pull(posteam)
pre_season_15_rosters <- get_season_rosters(2015,
                                            teams = teams_2015,
                                            type = "pre")
readr::write_csv(pre_season_15_rosters,
                 "roster_data/pre_season/pre_roster_2015.csv")

teams_2016 <- team_pbp_data %>%
  dplyr::filter(pbp_season == 2016) %>%
  dplyr::pull(posteam)
pre_season_16_rosters <- get_season_rosters(2016,
                                            teams = teams_2016,
                                            type = "pre")
readr::write_csv(pre_season_16_rosters,
                 "roster_data/pre_season/pre_roster_2016.csv")

teams_2017 <- team_pbp_data %>%
  dplyr::filter(pbp_season == 2017) %>%
  dplyr::pull(posteam)
pre_season_17_rosters <- get_season_rosters(2017,
                                            teams = teams_2017,
                                            type = "pre")
readr::write_csv(pre_season_17_rosters,
                 "roster_data/pre_season/pre_roster_2017.csv")

teams_2018 <- team_pbp_data %>%
  dplyr::filter(pbp_season == 2018) %>%
  dplyr::pull(posteam)
pre_season_18_rosters <- get_season_rosters(2018,
                                            teams = teams_2018,
                                            type = "pre")
readr::write_csv(pre_season_18_rosters,
                 "roster_data/pre_season/pre_roster_2018.csv")


teams_2019 <- team_pbp_data %>%
  dplyr::filter(pbp_season == 2019) %>%
  dplyr::pull(posteam)
pre_season_19_rosters <- get_season_rosters(2019,
                                            teams = teams_2019,
                                            type = "pre")
readr::write_csv(pre_season_19_rosters,
                 "roster_data/pre_season/pre_roster_2019.csv")


# ------------------------------------------------------------------------------

reg_season_09_rosters <- get_season_rosters(2009,
                                            teams = teams_2009,
                                            type = "reg")
readr::write_csv(reg_season_09_rosters,
                 "roster_data/regular_season/reg_roster_2009.csv")

reg_season_10_rosters <- get_season_rosters(2010,
                                            teams = teams_2010,
                                            type = "reg")
readr::write_csv(reg_season_10_rosters,
                 "roster_data/regular_season/reg_roster_2010.csv")

reg_season_11_rosters <- get_season_rosters(2011,
                                            teams = teams_2011,
                                            type = "reg")
readr::write_csv(reg_season_11_rosters,
                 "roster_data/regular_season/reg_roster_2011.csv")

reg_season_12_rosters <- get_season_rosters(2012,
                                            teams = teams_2012,
                                            type = "reg")
readr::write_csv(reg_season_12_rosters,
                 "roster_data/regular_season/reg_roster_2012.csv")

reg_season_13_rosters <- get_season_rosters(2013,
                                            teams = teams_2013,
                                            type = "reg")
readr::write_csv(reg_season_13_rosters,
                 "roster_data/regular_season/reg_roster_2013.csv")


reg_season_14_rosters <- get_season_rosters(2014,
                                            teams = teams_2014,
                                            type = "reg")
readr::write_csv(reg_season_14_rosters,
                 "roster_data/regular_season/reg_roster_2014.csv")


reg_season_15_rosters <- get_season_rosters(2015,
                                            teams = teams_2015,
                                            type = "reg")
readr::write_csv(reg_season_15_rosters,
                 "roster_data/regular_season/reg_roster_2015.csv")

reg_season_16_rosters <- get_season_rosters(2016,
                                            teams = teams_2016,
                                            type = "reg")
readr::write_csv(reg_season_16_rosters,
                 "roster_data/regular_season/reg_roster_2016.csv")

reg_season_17_rosters <- get_season_rosters(2017,
                                            teams = teams_2017,
                                            type = "reg")
readr::write_csv(reg_season_17_rosters,
                 "roster_data/regular_season/reg_roster_2017.csv")

reg_season_18_rosters <- get_season_rosters(2018,
                                            teams = teams_2018,
                                            type = "reg")
readr::write_csv(reg_season_18_rosters,
                 "roster_data/regular_season/reg_roster_2018.csv")

reg_season_19_rosters <- get_season_rosters(2019,
                                            teams = teams_2019,
                                            type = "reg")
readr::write_csv(reg_season_19_rosters,
                 "roster_data/regular_season/reg_roster_2019.csv")



# ------------------------------------------------------------------------------


post_season_09_rosters <- get_season_rosters(2009,
                                            teams = teams_2009,
                                            type = "post")
readr::write_csv(post_season_09_rosters,
                 "roster_data/post_season/post_roster_2009.csv")


post_season_10_rosters <- get_season_rosters(2010,
                                            teams = teams_2010,
                                            type = "post")
readr::write_csv(post_season_10_rosters,
                 "roster_data/post_season/post_roster_2010.csv")


post_season_11_rosters <- get_season_rosters(2011,
                                            teams = teams_2011,
                                            type = "post")
readr::write_csv(post_season_11_rosters,
                 "roster_data/post_season/post_roster_2011.csv")


post_season_12_rosters <- get_season_rosters(2012,
                                            teams = teams_2012,
                                            type = "post")
readr::write_csv(post_season_12_rosters,
                 "roster_data/post_season/post_roster_2012.csv")


post_season_13_rosters <- get_season_rosters(2013,
                                            teams = teams_2013,
                                            type = "post")
readr::write_csv(post_season_13_rosters,
                 "roster_data/post_season/post_roster_2013.csv")

post_season_14_rosters <- get_season_rosters(2014,
                                            teams = teams_2014,
                                            type = "post")
readr::write_csv(post_season_14_rosters,
                 "roster_data/post_season/post_roster_2014.csv")


post_season_15_rosters <- get_season_rosters(2015,
                                            teams = teams_2015,
                                            type = "post")
readr::write_csv(post_season_15_rosters,
                 "roster_data/post_season/post_roster_2015.csv")


post_season_16_rosters <- get_season_rosters(2016,
                                            teams = teams_2016,
                                            type = "post")
readr::write_csv(post_season_16_rosters,
                 "roster_data/post_season/post_roster_2016.csv")


post_season_17_rosters <- get_season_rosters(2017,
                                            teams = teams_2017,
                                            type = "post")
readr::write_csv(post_season_17_rosters,
                 "roster_data/post_season/post_roster_2017.csv")


post_season_18_rosters <- get_season_rosters(2018,
                                            teams = teams_2018,
                                            type = "post")
readr::write_csv(post_season_18_rosters,
                 "roster_data/post_season/post_roster_2018.csv")




