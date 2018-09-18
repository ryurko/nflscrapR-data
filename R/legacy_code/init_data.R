# Install (or update) nflscrapR:
# (Make sure devtools is installed with:
#  install_packages("devtools")
# )

devtools::install_github(repo = "maksimhorowitz/nflscrapR")

# Access nflscrapR:

library(nflscrapR)

# Extract the game IDs for each season then use the purrr package
# to get the season data. This is done instead of the season_play_by_play()
# function to avoid the times when the NFL hates us and prevents the URL
# from being accessed. So I did it this way to ensure I would get all 
# the games in a season.

game_ids_09 <- extracting_gameids(2009)
game_ids_10 <- extracting_gameids(2010)
game_ids_11 <- extracting_gameids(2011)
game_ids_12 <- extracting_gameids(2012)
game_ids_13 <- extracting_gameids(2013)
game_ids_14 <- extracting_gameids(2014)
game_ids_15 <- extracting_gameids(2015)
game_ids_16 <- extracting_gameids(2016)
game_ids_17 <- extracting_gameids(2017)

# Now get each season's play-by-play by mapping the game_play_by_play() 
# function to each game id (and check there are 256 unique ids)

# Access magrittr:
# install_packages("magrittr")
library(magrittr)

# Install purrr and dplyr:
#  install_packages("purrr")
#  install_packages("dplyr")

pbp_2009 <- purrr::map_dfr(game_ids_09, game_play_by_play) %>%
  dplyr::mutate(Season = 2009)
length(unique(pbp_2009$GameID)) == 256

pbp_2010 <- purrr::map_dfr(game_ids_10, game_play_by_play) %>%
  dplyr::mutate(Season = 2010)
length(unique(pbp_2010$GameID)) == 256

pbp_2011 <- purrr::map_dfr(game_ids_11, game_play_by_play) %>%
  dplyr::mutate(Season = 2011)
length(unique(pbp_2011$GameID)) == 256

pbp_2012 <- purrr::map_dfr(game_ids_12, game_play_by_play) %>%
  dplyr::mutate(Season = 2012)
length(unique(pbp_2012$GameID)) == 256

pbp_2013 <- purrr::map_dfr(game_ids_13, game_play_by_play) %>%
  dplyr::mutate(Season = 2013)
length(unique(pbp_2013$GameID)) == 256

pbp_2014 <- purrr::map_dfr(game_ids_14, game_play_by_play) %>%
  dplyr::mutate(Season = 2014)
length(unique(pbp_2014$GameID)) == 256

pbp_2015 <- purrr::map_dfr(game_ids_15, game_play_by_play) %>%
  dplyr::mutate(Season = 2015)
length(unique(pbp_2015$GameID)) == 256

pbp_2016 <- purrr::map_dfr(game_ids_16, game_play_by_play) %>%
  dplyr::mutate(Season = 2016)
length(unique(pbp_2016$GameID)) == 256

pbp_2017 <- purrr::map_dfr(game_ids_17, game_play_by_play) %>%
  dplyr::mutate(Season = 2017)
length(unique(pbp_2017$GameID)) == 256

# Access the tidyverse:
# install.packages("tidyverse")
library(tidyverse)

# Each file is saved individually
write_csv(pbp_2009, "data/season_play_by_play/pbp_2009.csv")
write_csv(pbp_2010, "data/season_play_by_play/pbp_2010.csv")
write_csv(pbp_2011, "data/season_play_by_play/pbp_2011.csv")
write_csv(pbp_2012, "data/season_play_by_play/pbp_2012.csv")
write_csv(pbp_2013, "data/season_play_by_play/pbp_2013.csv")
write_csv(pbp_2014, "data/season_play_by_play/pbp_2014.csv")
write_csv(pbp_2015, "data/season_play_by_play/pbp_2015.csv")
write_csv(pbp_2016, "data/season_play_by_play/pbp_2016.csv")
write_csv(pbp_2017, "data/season_play_by_play/pbp_2017.csv")

# Same thing for playoffs:

playoff_ids_09 <- extracting_gameids(2009, playoffs = TRUE)
playoff_ids_10 <- extracting_gameids(2010, playoffs = TRUE)
playoff_ids_11 <- extracting_gameids(2011, playoffs = TRUE)
playoff_ids_12 <- extracting_gameids(2012, playoffs = TRUE)
playoff_ids_13 <- extracting_gameids(2013, playoffs = TRUE)
playoff_ids_14 <- extracting_gameids(2014, playoffs = TRUE)
playoff_ids_15 <- extracting_gameids(2015, playoffs = TRUE)
playoff_ids_16 <- extracting_gameids(2016, playoffs = TRUE)
playoff_ids_17 <- extracting_gameids(2017, playoffs = TRUE)

playoff_pbp_2009 <- purrr::map_dfr(playoff_ids_09, game_play_by_play) %>%
  dplyr::mutate(Season = 2009)
length(unique(playoff_pbp_2009$GameID)) == 12

playoff_pbp_2010 <- purrr::map_dfr(playoff_ids_10, game_play_by_play) %>%
  dplyr::mutate(Season = 2010)
length(unique(playoff_pbp_2010$GameID)) == 12

playoff_pbp_2011 <- purrr::map_dfr(playoff_ids_11, game_play_by_play) %>%
  dplyr::mutate(Season = 2011)
length(unique(playoff_pbp_2011$GameID)) == 12

playoff_pbp_2012 <- purrr::map_dfr(playoff_ids_12, game_play_by_play) %>%
  dplyr::mutate(Season = 2012)
length(unique(playoff_pbp_2012$GameID)) == 12

playoff_pbp_2013 <- purrr::map_dfr(playoff_ids_13, game_play_by_play) %>%
  dplyr::mutate(Season = 2013)
length(unique(playoff_pbp_2013$GameID)) == 12

playoff_pbp_2014 <- purrr::map_dfr(playoff_ids_14, game_play_by_play) %>%
  dplyr::mutate(Season = 2014)
length(unique(playoff_pbp_2014$GameID)) == 12

playoff_pbp_2015 <- purrr::map_dfr(playoff_ids_15, game_play_by_play) %>%
  dplyr::mutate(Season = 2015)
length(unique(playoff_pbp_2015$GameID)) == 12

playoff_pbp_2016 <- purrr::map_dfr(playoff_ids_16, game_play_by_play) %>%
  dplyr::mutate(Season = 2016)
length(unique(playoff_pbp_2016$GameID)) == 12

playoff_pbp_2017 <- purrr::map_dfr(playoff_ids_17, game_play_by_play) %>%
  dplyr::mutate(Season = 2017)
length(unique(playoff_pbp_2017$GameID)) == 12

# Each file is saved individually
write_csv(playoff_pbp_2009, "data/playoff_play_by_play/playoff_pbp_2009.csv")
write_csv(playoff_pbp_2010, "data/playoff_play_by_play/playoff_pbp_2010.csv")
write_csv(playoff_pbp_2011, "data/playoff_play_by_play/playoff_pbp_2011.csv")
write_csv(playoff_pbp_2012, "data/playoff_play_by_play/playoff_pbp_2012.csv")
write_csv(playoff_pbp_2013, "data/playoff_play_by_play/playoff_pbp_2013.csv")
write_csv(playoff_pbp_2014, "data/playoff_play_by_play/playoff_pbp_2014.csv")
write_csv(playoff_pbp_2015, "data/playoff_play_by_play/playoff_pbp_2015.csv")
write_csv(playoff_pbp_2016, "data/playoff_play_by_play/playoff_pbp_2016.csv")
write_csv(playoff_pbp_2017, "data/playoff_play_by_play/playoff_pbp_2017.csv")


# Bind the seasons together to make one dataset:
pbp_data <- bind_rows(pbp_2009, pbp_2010, pbp_2011,
                      pbp_2012, pbp_2013, pbp_2014,
                      pbp_2015, pbp_2016, pbp_2017)

# Bind playoffs together to make one dataset:
playoff_pbp_data <- bind_rows(playoff_pbp_2009, playoff_pbp_2010, 
                              playoff_pbp_2011, playoff_pbp_2012, 
                              playoff_pbp_2013, playoff_pbp_2014,
                              playoff_pbp_2015, playoff_pbp_2016,
                              playoff_pbp_2017)

# Helper function to return the player's most common
# name associated with the ID:

find_player_name <- function(player_names){
  if (length(player_names) == 0) {
    result <- "None"
  } else{
    table_name <- table(player_names)
    result <- names(table_name)[which.max(table_name)]
  }
  return(result)
}

# Define the functions to generate the statistics:

calc_passing_splits <- function(splits,pbp_df) {
  split_groups <- lapply(splits, as.symbol)
  # Filter to only pass attempts and add the GameDrive column:
  pbp_df <- pbp_df %>% filter(PassAttempt == 1 & PlayType != "No Play") %>%
    mutate(GameDrive = paste(as.character(GameID), as.character(Drive), sep = "-"))
  pass_output <- pbp_df %>% group_by_(.dots=split_groups) %>%
    summarise(Player_Name = find_player_name(Passer[which(!is.na(Passer))]),
              Attempts = n(),Completions = sum(Reception,na.rm=TRUE),
              Drives = n_distinct(GameDrive),
              Comp_Perc = Completions / Attempts,
              Total_Yards = sum(Yards.Gained,na.rm = TRUE),
              Total_Raw_AirYards = sum(AirYards,na.rm=TRUE),
              Total_Comp_AirYards = sum(Reception*AirYards, na.rm=TRUE),
              Yards_per_Att = Total_Yards / Attempts,
              Yards_per_Comp = Total_Yards / Completions,
              Yards_per_Drive = Total_Yards / Drives,
              Raw_AirYards_per_Att = Total_Raw_AirYards / Attempts,
              Comp_AirYards_per_Att = Total_Comp_AirYards / Attempts,
              Raw_AirYards_per_Comp = Total_Raw_AirYards / Completions,
              Comp_AirYards_per_Comp = Total_Comp_AirYards / Completions,
              Raw_AirYards_per_Drive = Total_Raw_AirYards / Drives,
              Comp_AirYards_per_Drive = Total_Comp_AirYards / Drives,
              PACR = Total_Yards / Total_Raw_AirYards,
              TimesHit = sum(QBHit,na.rm=TRUE),
              TimesHit_per_Drive = TimesHit / Drives,
              Interceptions = sum(InterceptionThrown,na.rm = TRUE),
              TDs = sum(Touchdown,na.rm=TRUE),
              Air_TDs = sum(as.numeric(YardsAfterCatch==0)*Touchdown,na.rm=TRUE),
              aPACR = (Total_Yards + (20 * TDs) - (45 * Interceptions)) / Total_Raw_AirYards,
              Air_TD_Rate = Air_TDs / TDs,
              TD_to_Int = TDs / Interceptions,
              Total_EPA = sum(EPA,na.rm=TRUE),
              Success_Rate = length(which(EPA>0)) / Attempts,
              EPA_per_Att = Total_EPA / Attempts,
              EPA_per_Comp = sum(Reception*EPA,na.rm=TRUE) / Completions,
              EPA_Comp_Perc = sum(Reception*EPA,na.rm=TRUE)/sum(abs(EPA),na.rm=TRUE),
              TD_per_Att = TDs / Attempts,
              Air_TD_per_Att = Air_TDs / Attempts,
              Int_per_Att = Interceptions / Attempts,
              TD_per_Comp = TDs / Completions,
              Air_TD_per_Comp = Air_TDs / Completions,
              TD_per_Drive = TDs / Drives,
              Air_TD_per_Drive = Air_TDs / Drives,
              Int_per_Drive = Interceptions / Drives,
              EPA_per_Drive = Total_EPA / Drives,
              Total_WPA = sum(WPA,na.rm=TRUE),
              Win_Success_Rate = length(which(WPA>0)) / Attempts,
              WPA_per_Att = Total_WPA / Attempts,
              WPA_per_Comp = sum(Reception*WPA,na.rm=TRUE) / Completions,
              WPA_Comp_Perc = sum(Reception*WPA,na.rm=TRUE)/sum(abs(WPA),na.rm=TRUE),
              WPA_per_Drive = Total_WPA / Drives,
              Total_Clutch_EPA = sum(EPA*abs(WPA),na.rm=TRUE),
              Clutch_EPA_per_Att = Total_Clutch_EPA / Attempts,
              Clutch_EPA_per_Drive = Total_Clutch_EPA / Drives,
              airEPA_Comp = sum(Reception*airEPA,na.rm = TRUE),
              airEPA_Incomp = sum(as.numeric(Reception == 0)*airEPA, na.rm = TRUE),
              Total_Raw_airEPA = sum(airEPA,na.rm = TRUE),
              Raw_airEPA_per_Att = Total_Raw_airEPA / Attempts,
              Raw_airEPA_per_Drive = Total_Raw_airEPA / Drives,
              epa_PACR = Total_EPA / Total_Raw_airEPA,
              airEPA_per_Att = airEPA_Comp / Attempts,
              airEPA_per_Comp = airEPA_Comp / Completions,
              airEPA_per_Drive = airEPA_Comp / Drives,
              air_Success_Rate = length(which(airEPA>0)) / Attempts,
              air_Comp_Success_Rate = length(which((Reception*airEPA)>0)) / Attempts,
              airWPA_Comp = sum(Reception*airWPA,na.rm = TRUE),
              airWPA_Incomp = sum(as.numeric(Reception == 0)*airWPA, na.rm = TRUE),
              Total_Raw_airWPA = sum(airWPA,na.rm = TRUE),
              wpa_PACR = Total_WPA / Total_Raw_airWPA,
              Raw_airWPA_per_Att = Total_Raw_airWPA / Attempts,
              Raw_airWPA_per_Drive = Total_Raw_airWPA / Drives,
              airWPA_per_Att = airWPA_Comp / Attempts,
              airWPA_per_Comp = airWPA_Comp / Completions,
              airWPA_per_Drive = airWPA_Comp / Drives,
              air_Win_Success_Rate = length(which(airWPA>0)) / Attempts,
              air_Comp_Win_Success_Rate = length(which((Reception*airWPA)>0)) / Attempts,
              yacEPA_Comp = sum(Reception*yacEPA,na.rm=TRUE),
              yacEPA_Drop = sum(as.numeric(Reception==0)*yacEPA,na.rm=TRUE),
              Total_yacEPA = sum(yacEPA,na.rm=TRUE),
              yacEPA_per_Att = Total_yacEPA / Attempts,
              yacEPA_per_Comp = yacEPA_Comp / Completions,
              yacEPA_Rec_per_Drive = yacEPA_Comp / Drives,
              yacEPA_Drop_per_Drive = yacEPA_Drop / Drives,
              yacWPA_Comp = sum(Reception*yacWPA,na.rm=TRUE),
              yacWPA_Drop = sum(as.numeric(Reception==0)*yacWPA,na.rm=TRUE),
              Total_yacWPA = sum(yacWPA,na.rm=TRUE),
              yacWPA_per_Att = Total_yacWPA / Attempts,
              yacWPA_per_Comp = yacWPA_Comp / Completions,
              yacWPA_Comp_per_Drive = yacWPA_Comp / Drives,
              yacWPA_Drop_per_Drive = yacWPA_Drop / Drives,
              yac_Success_Rate = length(which(yacEPA>0)) / Attempts,
              yac_Rec_Success_Rate = length(which((Reception*yacEPA)>0)) / Attempts,
              yac_Win_Success_Rate = length(which(yacWPA>0)) / Attempts,
              yac_Comp_Win_Success_Rate = length(which((Reception*yacWPA)>0)) / Attempts)
  return(pass_output)
}

calc_rushing_splits <- function(splits,pbp_df) {
  split_groups <- lapply(splits, as.symbol)
  # Filter to only rush attempts:
  pbp_df <- pbp_df %>% filter(RushAttempt == 1 & PlayType != "No Play") %>%
    mutate(GameDrive = paste(as.character(GameID), as.character(Drive),sep="-"))
  rush_output <- pbp_df %>% group_by_(.dots=split_groups) %>%
    summarise(Player_Name = find_player_name(Rusher[which(!is.na(Rusher))]),
              Carries = n(),
              Drives = n_distinct(GameDrive),
              Car_per_Drive = Carries / Drives,
              Total_Yards = sum(Yards.Gained,na.rm = TRUE),
              Yards_per_Car = Total_Yards / Carries,
              Yards_per_Drive = Total_Yards / Drives,
              Fumbles = sum(Fumble,na.rm = TRUE),
              TDs = sum(Touchdown,na.rm=TRUE),
              TD_to_Fumbles = TDs / Fumbles,
              Total_EPA = sum(EPA,na.rm=TRUE),
              Success_Rate = length(which(EPA>0)) / Carries,
              EPA_per_Car = Total_EPA / Carries,
              EPA_Ratio = sum(as.numeric(EPA>0)*EPA,na.rm=TRUE)/sum(abs(EPA),na.rm=TRUE),
              TD_per_Car = TDs / Carries,
              Fumbles_per_Car = Fumbles / Carries,
              Fumbles_per_Drive = Fumbles / Drives,
              TD_Drive = TDs / Drives,
              EPA_per_Drive = Total_EPA / Drives,
              Total_WPA = sum(WPA,na.rm=TRUE),
              WPA_per_Drive = Total_WPA / Drives,
              Win_Success_Rate = length(which(WPA>0)) / Carries,
              WPA_per_Car = Total_WPA / Carries,
              WPA_Ratio = sum(as.numeric(WPA>0)*WPA,na.rm=TRUE)/sum(abs(WPA),na.rm=TRUE),
              Total_Clutch_EPA = sum(EPA*abs(WPA),na.rm=TRUE),
              Clutch_EPA_per_Car = Total_Clutch_EPA / Carries,
              Clutch_EPA_per_Drive = Total_Clutch_EPA / Drives) 
  return(rush_output)
}

calc_receiving_splits <- function(splits,pbp_df) {
  split_groups <- lapply(splits, as.symbol)
  # Filter to only pass attempts:
  pbp_df <- pbp_df %>% filter(PassAttempt == 1 & PlayType != "No Play") %>%
    mutate(GameDrive = paste(as.character(GameID), as.character(Drive),sep="-"))
  rec_output <- pbp_df %>% group_by_(.dots=split_groups) %>%
    summarise(Player_Name = find_player_name(Receiver[which(!is.na(Receiver))]),
              Targets = n(), Receptions = sum(Reception,na.rm=TRUE),
              Drives = n_distinct(GameDrive),
              Targets_per_Drive = Targets / Drives,
              Rec_per_Drive = Receptions / Drives,
              Total_Yards = sum(Yards.Gained,na.rm = TRUE),
              Yards_per_Drive = Total_Yards / Drives,
              Total_Raw_YAC = sum(YardsAfterCatch,na.rm=TRUE),
              Yards_per_Rec = Total_Yards / Receptions,
              Yards_per_Target = Total_Yards / Targets,
              YAC_per_Target = Total_Raw_YAC / Targets,
              Total_Caught_YAC = sum(Reception*YardsAfterCatch,na.rm=TRUE),
              Total_Dropped_YAC = sum(as.numeric(Reception==0)*YardsAfterCatch,na.rm=TRUE),
              Caught_YAC_per_Target = Total_Caught_YAC / Targets,
              Dropped_YAC_per_Target = Total_Dropped_YAC / Targets,
              YAC_per_Rec = Total_Raw_YAC / Receptions,
              Caught_YAC_per_Rec = Total_Caught_YAC / Receptions,
              Dropped_YAC_per_Rec = Total_Dropped_YAC / Receptions,
              YAC_per_Drive = Total_Raw_YAC / Drives,
              Caught_YAC_per_Drive = Total_Caught_YAC / Drives,
              Dropped_YAC_per_Drive = Total_Dropped_YAC / Drives,
              Rec_Percentage = Receptions / Targets,
              Fumbles = sum(Fumble,na.rm = TRUE),
              TDs = sum(Touchdown,na.rm=TRUE),
              TDs_per_Drive = TDs / Drives,
              Fumbles_per_Drive = Fumbles / Drives,
              AC_TDs = sum(as.numeric(YardsAfterCatch > 0)*Touchdown,na.rm=TRUE),
              AC_TDs_per_Drive = AC_TDs / Drives,
              AC_TD_Rate = AC_TDs / TDs,
              TD_to_Fumbles = TDs / Fumbles,
              Total_EPA = sum(EPA,na.rm=TRUE),
              EPA_per_Drives = Total_EPA / Drives,
              Success_Rate = length(which(EPA>0)) / Targets,
              EPA_per_Rec = sum(Reception*EPA,na.rm=TRUE) / Receptions,
              EPA_per_Target = Total_EPA / Targets,
              EPA_Rec_Perc = sum(Reception*EPA,na.rm=TRUE)/sum(abs(EPA),na.rm=TRUE),
              TD_per_Targets = TDs / Targets,
              Fumbles_per_Rec = Fumbles / Receptions,
              TD_per_Rec = TDs / Receptions,
              Total_WPA = sum(WPA,na.rm=TRUE),
              WPA_per_Drive = Total_WPA / Drives,
              Win_Success_Rate = length(which(WPA>0)) / Targets,
              WPA_per_Target = Total_WPA / Targets,
              WPA_per_Rec = sum(Reception*WPA,na.rm=TRUE) / Receptions,
              WPA_Rec_Perc = sum(Reception*WPA,na.rm=TRUE)/sum(abs(WPA),na.rm=TRUE),
              Total_Clutch_EPA = sum(EPA*abs(WPA),na.rm=TRUE),
              Clutch_EPA_per_Drive = Total_Clutch_EPA / Drives,
              Total_Raw_AirYards = sum(AirYards,na.rm=TRUE),
              PACR = Total_Yards / Total_Raw_AirYards,
              Total_Caught_AirYards = sum(Reception*AirYards, na.rm=TRUE),
              Raw_AirYards_per_Target = Total_Raw_AirYards / Targets,
              RACR = Total_Yards / Total_Raw_AirYards,
              Total_Raw_airEPA = sum(airEPA, na.rm=TRUE),
              Total_Caught_airEPA = sum(Reception*airEPA, na.rm=TRUE),
              Raw_airEPA_per_Drive = Total_Raw_airEPA / Drives,
              Caught_airEPA_per_Drive = Total_Caught_airEPA / Drives,
              airEPA_per_Target = Total_Raw_airEPA / Targets,
              Caught_airEPA_per_Target = Total_Caught_airEPA / Targets,
              epa_RACR = Total_EPA / Total_Raw_airEPA,
              Total_Raw_airWPA = sum(airWPA, na.rm=TRUE),
              Total_Caught_airWPA = sum(Reception*airWPA, na.rm=TRUE),
              Raw_airWPA_per_Drive = Total_Raw_airWPA / Drives,
              Caught_airWPA_per_Drive = Total_Caught_airWPA / Drives,
              airWPA_per_Target = Total_Raw_airWPA / Targets,
              Caught_airWPA_per_Target = Total_Caught_airWPA / Targets,
              yacEPA_Rec = sum(Reception*yacEPA,na.rm=TRUE),
              yacEPA_Drop = sum(as.numeric(Reception==0)*yacEPA,na.rm=TRUE),
              Total_yacEPA = sum(yacEPA,na.rm=TRUE),
              yacEPA_per_Target = Total_yacEPA / Targets,
              yacEPA_per_Rec = yacEPA_Rec / Receptions,
              yacEPA_Rec_per_Drive = yacEPA_Rec / Drives,
              yacEPA_Drop_per_Drive = yacEPA_Drop / Drives,
              yacWPA_Rec = sum(Reception*yacWPA,na.rm=TRUE),
              yacWPA_Drop = sum(as.numeric(Reception==0)*yacWPA,na.rm=TRUE),
              Total_yacWPA = sum(yacWPA,na.rm=TRUE),
              yacWPA_per_Target = Total_yacWPA / Targets,
              yacWPA_per_Rec = yacWPA_Rec / Receptions,
              yacWPA_Rec_per_Drive = yacWPA_Rec / Drives,
              yacWPA_Drop_per_Drive = yacWPA_Drop / Drives,
              wpa_RACR = Total_WPA / Total_Raw_airWPA,
              yac_Success_Rate = length(which(yacEPA>0)) / Targets,
              yac_Rec_Success_Rate = length(which((Reception*yacEPA)>0)) / Targets,
              air_Success_Rate = length(which(airEPA>0)) / Targets,
              air_Rec_Success_Rate = length(which((Reception*airEPA)>0)) / Targets,
              yac_Win_Success_Rate = length(which(yacWPA>0)) / Targets,
              yac_Rec_Win_Success_Rate = length(which((Reception*yacWPA)>0)) / Targets,
              air_Win_Success_Rate = length(which(airWPA>0)) / Targets,
              air_Rec_Win_Success_Rate = length(which((Reception*airWPA)>0)) / Targets)
  return(rec_output)
}

# For now just make JAX be JAC:
pbp_data$posteam <- with(pbp_data,
                         ifelse(posteam == "JAX","JAC", posteam))
pbp_data$DefensiveTeam <- with(pbp_data,
                               ifelse(DefensiveTeam == "JAX", "JAC", DefensiveTeam))

playoff_pbp_data$posteam <- with(playoff_pbp_data, 
                                 ifelse(posteam == "JAX", "JAC", posteam))
playoff_pbp_data$DefensiveTeam <- with(playoff_pbp_data,
                                       ifelse(DefensiveTeam == "JAX", "JAC", DefensiveTeam))

# First generate stats at the Season level for each player,
# removing the observations with missing player names:

season_passing_df <- calc_passing_splits(c("Season","Passer_ID"), pbp_data) %>% 
  filter(Passer_ID != "None") %>% arrange(Season,desc(Attempts)) 

season_receiving_df <- calc_receiving_splits(c("Season","Receiver_ID"), pbp_data) %>% 
  filter(Receiver_ID != "None") %>% arrange(Season,desc(Targets)) 

season_rushing_df <- calc_rushing_splits(c("Season","Rusher_ID"), pbp_data) %>%
  filter(Rusher_ID != "None") %>% arrange(Season,desc(Carries)) 

# Playoffs:

playoff_passing_df <- calc_passing_splits(c("Season","Passer_ID"), playoff_pbp_data) %>% 
  filter(Passer_ID != "None") %>% arrange(Season,desc(Attempts)) %>% rename(Team = posteam)

playoff_receiving_df <- calc_receiving_splits(c("Season","Receiver_ID"), playoff_pbp_data) %>% 
  filter(Receiver_ID != "None") %>% arrange(Season,desc(Targets)) %>% rename(Team = posteam)

playoff_rushing_df <- calc_rushing_splits(c("Season","Rusher_ID"), playoff_pbp_data) %>%
  filter(Rusher_ID != "None") %>% arrange(Season,desc(Carries)) %>% rename(Team = posteam)


# Save each file
write_csv(season_passing_df, "data/season_player_stats/season_passing_df.csv")
write_csv(season_receiving_df, "data/season_player_stats/season_receiving_df.csv")
write_csv(season_rushing_df, "data/season_player_stats/season_rushing_df.csv")

write_csv(playoff_passing_df, "data/playoff_player_stats/season_passing_df.csv")
write_csv(playoff_receiving_df, "data/playoff_player_stats/season_receiving_df.csv")
write_csv(playoff_rushing_df, "data/playoff_player_stats/season_rushing_df.csv")

# Season level for each team:
team_season_passing_df <- calc_passing_splits(c("Season","posteam"), pbp_data) %>% 
  arrange(Season,desc(Attempts)) %>% rename(Team=posteam)

team_season_receiving_df <- calc_receiving_splits(c("Season","posteam"), pbp_data) %>% 
  arrange(Season,desc(Targets)) %>% rename(Team=posteam)

team_season_rushing_df <- calc_rushing_splits(c("Season","posteam"), pbp_data) %>%
  arrange(Season,desc(Carries)) %>% rename(Team=posteam)

team_def_season_passing_df <- calc_passing_splits(c("Season","DefensiveTeam"), pbp_data) %>% 
  arrange(Season,desc(Attempts)) %>% rename(Team=DefensiveTeam)

team_def_season_receiving_df <- calc_receiving_splits(c("Season","DefensiveTeam"), pbp_data) %>% 
  arrange(Season,desc(Targets)) %>% rename(Team=DefensiveTeam)

team_def_season_rushing_df <- calc_rushing_splits(c("Season","DefensiveTeam"), pbp_data) %>%
  arrange(Season,desc(Carries)) %>% rename(Team=DefensiveTeam)

# Playoffs:
team_playoff_passing_df <- calc_passing_splits(c("Season","posteam"), playoff_pbp_data) %>% 
  arrange(Season,desc(Attempts)) %>% rename(Team=posteam)

team_playoff_receiving_df <- calc_receiving_splits(c("Season","posteam"), playoff_pbp_data) %>% 
  arrange(Season,desc(Targets)) %>% rename(Team=posteam)

team_playoff_rushing_df <- calc_rushing_splits(c("Season","posteam"), playoff_pbp_data) %>%
  arrange(Season,desc(Carries)) %>% rename(Team=posteam)

team_def_playoff_passing_df <- calc_passing_splits(c("Season","DefensiveTeam"), playoff_pbp_data) %>% 
  arrange(Season,desc(Attempts)) %>% rename(Team=DefensiveTeam)

team_def_playoff_receiving_df <- calc_receiving_splits(c("Season","DefensiveTeam"), playoff_pbp_data) %>% 
  arrange(Season,desc(Targets)) %>% rename(Team=DefensiveTeam)

team_def_playoff_rushing_df <- calc_rushing_splits(c("Season","DefensiveTeam"), playoff_pbp_data) %>%
  arrange(Season,desc(Carries)) %>% rename(Team=DefensiveTeam)

# Save each file
write_csv(team_season_passing_df, "data/season_team_stats/team_season_passing_df.csv")
write_csv(team_season_receiving_df, "data/season_team_stats/team_season_receiving_df.csv")
write_csv(team_season_rushing_df, "data/season_team_stats/team_season_rushing_df.csv")
write_csv(team_def_season_passing_df, "data/season_team_stats/team_def_season_passing_df.csv")
write_csv(team_def_season_receiving_df, "data/season_team_stats/team_def_season_receiving_df.csv")
write_csv(team_def_season_rushing_df, "data/season_team_stats/team_def_season_rushing_df.csv")

write_csv(team_playoff_passing_df, "data/playoff_team_stats/team_playoff_passing_df.csv")
write_csv(team_playoff_receiving_df, "data/playoff_team_stats/team_playoff_receiving_df.csv")
write_csv(team_playoff_rushing_df, "data/playoff_team_stats/team_playoff_rushing_df.csv")
write_csv(team_def_playoff_passing_df, "data/playoff_team_stats/team_def_playoff_passing_df.csv")
write_csv(team_def_playoff_receiving_df, "data/playoff_team_stats/team_def_playoff_receiving_df.csv")
write_csv(team_def_playoff_rushing_df, "data/playoff_team_stats/team_def_playoff_rushing_df.csv")

# Game level:

game_passing_df <- calc_passing_splits(c("GameID","Passer_ID","posteam","DefensiveTeam"), pbp_data) %>% 
  filter(Passer_ID != "None") %>% arrange(GameID,desc(Attempts)) %>% rename(Team=posteam,
                                                                       Opponent=DefensiveTeam)

game_receiving_df <- calc_receiving_splits(c("GameID","Receiver_ID","posteam","DefensiveTeam"), pbp_data) %>% 
  filter(Receiver_ID != "None") %>% arrange(GameID,desc(Targets))  %>% rename(Team=posteam,
                                                                         Opponent=DefensiveTeam)

game_rushing_df <- calc_rushing_splits(c("GameID","Rusher_ID","posteam","DefensiveTeam"), pbp_data) %>%
  filter(Rusher_ID != "None") %>% arrange(GameID,desc(Carries))  %>% rename(Team=posteam,
                                                                       Opponent=DefensiveTeam)

# Playoffs:
playoff_game_passing_df <- calc_passing_splits(c("GameID","Passer_ID","posteam","DefensiveTeam"), playoff_pbp_data) %>% 
  filter(Passer_ID != "None") %>% arrange(GameID,desc(Attempts)) %>% rename(Team=posteam,
                                                                            Opponent=DefensiveTeam)

playoff_game_receiving_df <- calc_receiving_splits(c("GameID","Receiver_ID","posteam","DefensiveTeam"), playoff_pbp_data) %>% 
  filter(Receiver_ID != "None") %>% arrange(GameID,desc(Targets))  %>% rename(Team=posteam,
                                                                              Opponent=DefensiveTeam)

playoff_game_rushing_df <- calc_rushing_splits(c("GameID","Rusher_ID","posteam","DefensiveTeam"), playoff_pbp_data) %>%
  filter(Rusher_ID != "None") %>% arrange(GameID,desc(Carries))  %>% rename(Team=posteam,
                                                                            Opponent=DefensiveTeam)


# Save each file
write_csv(game_passing_df, "data/game_player_stats/game_passing_df.csv")
write_csv(game_receiving_df, "data/game_player_stats/game_receiving_df.csv")
write_csv(game_rushing_df, "data/game_player_stats/game_rushing_df.csv")

write_csv(playoff_game_passing_df, "data/playoff_game_player_stats/playoff_game_passing_df.csv")
write_csv(playoff_game_receiving_df, "data/playoff_game_player_stats/playoff_game_receiving_df.csv")
write_csv(playoff_game_rushing_df, "data/playoff_game_player_stats/playoff_game_rushing_df.csv")


# Team Game level:

team_game_passing_df <- calc_passing_splits(c("GameID","posteam","DefensiveTeam"), pbp_data) %>% 
  arrange(GameID,desc(Attempts)) %>% rename(Team=posteam, Opponent=DefensiveTeam)

team_game_receiving_df <- calc_receiving_splits(c("GameID","posteam","DefensiveTeam"), pbp_data) %>% 
  arrange(GameID,desc(Targets))  %>% rename(Team=posteam,Opponent=DefensiveTeam)

team_game_rushing_df <- calc_rushing_splits(c("GameID","posteam","DefensiveTeam"), pbp_data) %>%
  arrange(GameID,desc(Carries))  %>% rename(Team=posteam,Opponent=DefensiveTeam)

playoff_team_game_passing_df <- calc_passing_splits(c("GameID","posteam","DefensiveTeam"), playoff_pbp_data) %>% 
  arrange(GameID,desc(Attempts)) %>% rename(Team=posteam, Opponent=DefensiveTeam)

playoff_team_game_receiving_df <- calc_receiving_splits(c("GameID","posteam","DefensiveTeam"), playoff_pbp_data) %>% 
  arrange(GameID,desc(Targets))  %>% rename(Team=posteam,Opponent=DefensiveTeam)

playoff_team_game_rushing_df <- calc_rushing_splits(c("GameID","posteam","DefensiveTeam"), playoff_pbp_data) %>%
  arrange(GameID,desc(Carries))  %>% rename(Team=posteam,Opponent=DefensiveTeam)



# Save each file
write_csv(team_game_passing_df, "~/Documents/nflscrapR-data/data/game_team_stats/game_passing_df.csv")
write_csv(team_game_receiving_df, "~/Documents/nflscrapR-data/data/game_team_stats/game_receiving_df.csv")
write_csv(team_game_rushing_df, "~/Documents/nflscrapR-data/data/game_team_stats/game_rushing_df.csv")

write_csv(playoff_team_game_passing_df, "~/Documents/nflscrapR-data/data/playoff_game_team_stats/playoff_game_passing_df.csv")
write_csv(playoff_team_game_receiving_df, "~/Documents/nflscrapR-data/data/playoff_game_team_stats/playoff_game_receiving_df.csv")
write_csv(playoff_team_game_rushing_df, "~/Documents/nflscrapR-data/data/playoff_game_team_stats/playoff_game_rushing_df.csv")


# Team rosters:

# Create a dataset for each season and a vector of the team abbreviations for season:
pbp_data_09 <- filter(pbp_data, Season == 2009)
pbp_data_10 <- filter(pbp_data, Season == 2010)
pbp_data_11 <- filter(pbp_data, Season == 2011)
pbp_data_12 <- filter(pbp_data, Season == 2012)
pbp_data_13 <- filter(pbp_data, Season == 2013)
pbp_data_14 <- filter(pbp_data, Season == 2014)
pbp_data_15 <- filter(pbp_data, Season == 2015)
pbp_data_16 <- filter(pbp_data, Season == 2016)
pbp_data_17 <- filter(pbp_data, Season == 2017)

team_ids_09 <- as.character(na.omit(unique(pbp_data_09$posteam)))
team_ids_10 <- as.character(na.omit(unique(pbp_data_10$posteam)))
team_ids_11 <- as.character(na.omit(unique(pbp_data_11$posteam)))
team_ids_12 <- as.character(na.omit(unique(pbp_data_12$posteam)))
team_ids_13 <- as.character(na.omit(unique(pbp_data_13$posteam)))
team_ids_14 <- as.character(na.omit(unique(pbp_data_14$posteam)))
team_ids_15 <- as.character(na.omit(unique(pbp_data_15$posteam)))
team_ids_16 <- as.character(na.omit(unique(pbp_data_16$posteam)))
team_ids_17 <- as.character(na.omit(unique(pbp_data_17$posteam)))

# Adjust the 2016 ids:
team_ids_16[which(team_ids_16 == "JAC")] <- "JAX"
team_ids_16 <- unique(team_ids_16)

# Find the rosters for each team and season,
# first for 2009 (do positions separately in case NFL doens't work):
qbs_2009 <- season_rosters(2009, teams = team_ids_09, positions = "QUARTERBACK")
rbs_2009 <- season_rosters(2009, team_ids_09, positions = "RUNNING_BACK")
wrs_2009 <- season_rosters(2009, team_ids_09, positions = "WIDE_RECEIVER")
tes_2009 <- season_rosters(2009, team_ids_09, positions = "TIGHT_END")
team_2009_rosters <- bind_rows(qbs_2009, rbs_2009, wrs_2009, tes_2009)

qbs_2010 <- season_rosters(2010, teams = team_ids_10, positions = "QUARTERBACK")
rbs_2010 <- season_rosters(2010, team_ids_10, positions = "RUNNING_BACK")
wrs_2010 <- season_rosters(2010, team_ids_10, positions = "WIDE_RECEIVER")
tes_2010 <- season_rosters(2010, team_ids_10, positions = "TIGHT_END")
team_2010_rosters <- bind_rows(qbs_2010, rbs_2010, wrs_2010, tes_2010)

qbs_2011 <- season_rosters(2011, teams = team_ids_11, positions = "QUARTERBACK")
rbs_2011 <- season_rosters(2011, team_ids_11, positions = "RUNNING_BACK")
wrs_2011 <- season_rosters(2011, team_ids_11, positions = "WIDE_RECEIVER")
tes_2011 <- season_rosters(2011, team_ids_11, positions = "TIGHT_END")
team_2011_rosters <- bind_rows(qbs_2011, rbs_2011, wrs_2011, tes_2011)

qbs_2012 <- season_rosters(2012, teams = team_ids_12, positions = "QUARTERBACK")
rbs_2012 <- season_rosters(2012, team_ids_12, positions = "RUNNING_BACK")
wrs_2012 <- season_rosters(2012, team_ids_12, positions = "WIDE_RECEIVER")
tes_2012 <- season_rosters(2012, team_ids_12, positions = "TIGHT_END")
team_2012_rosters <- bind_rows(qbs_2012, rbs_2012, wrs_2012, tes_2012)

qbs_2013 <- season_rosters(2013, teams = team_ids_13, positions = "QUARTERBACK")
rbs_2013 <- season_rosters(2013, team_ids_13, positions = "RUNNING_BACK")
wrs_2013 <- season_rosters(2013, team_ids_13, positions = "WIDE_RECEIVER")
tes_2013 <- season_rosters(2013, team_ids_13, positions = "TIGHT_END")
team_2013_rosters <- bind_rows(qbs_2013, rbs_2013, wrs_2013, tes_2013)

qbs_2014 <- season_rosters(2014, teams = team_ids_14, positions = "QUARTERBACK")
rbs_2014 <- season_rosters(2014, team_ids_14, positions = "RUNNING_BACK")
wrs_2014 <- season_rosters(2014, team_ids_14, positions = "WIDE_RECEIVER")
tes_2014 <- season_rosters(2014, team_ids_14, positions = "TIGHT_END")
team_2014_rosters <- bind_rows(qbs_2014, rbs_2014, wrs_2014, tes_2014)

qbs_2015 <- season_rosters(2015, teams = team_ids_15, positions = "QUARTERBACK")
rbs_2015 <- season_rosters(2015, team_ids_15, positions = "RUNNING_BACK")
wrs_2015 <- season_rosters(2015, team_ids_15, positions = "WIDE_RECEIVER")
tes_2015 <- season_rosters(2015, team_ids_15, positions = "TIGHT_END")
team_2015_rosters <- bind_rows(qbs_2015, rbs_2015, wrs_2015, tes_2015)

qbs_2016 <- season_rosters(2016, teams = team_ids_16, positions = "QUARTERBACK")
rbs_2016 <- season_rosters(2016, team_ids_16, positions = "RUNNING_BACK")
wrs_2016 <- season_rosters(2016, team_ids_16, positions = "WIDE_RECEIVER")
tes_2016 <- season_rosters(2016, team_ids_16, positions = "TIGHT_END")
team_2016_rosters <- bind_rows(qbs_2016, rbs_2016, wrs_2016, tes_2016)

qbs_2017 <- season_rosters(2017, teams = team_ids_17, positions = "QUARTERBACK")
rbs_2017 <- season_rosters(2017, team_ids_17, positions = "RUNNING_BACK")
wrs_2017 <- season_rosters(2017, team_ids_17, positions = "WIDE_RECEIVER")
tes_2017 <- season_rosters(2017, team_ids_17, positions = "TIGHT_END")
team_2017_rosters <- bind_rows(qbs_2017, rbs_2017, wrs_2017, tes_2017)

# Save these files:
write_csv(team_2009_rosters, "~/Documents/nflscrapR-data/data/team_rosters/team_2009_rosters.csv")
write_csv(team_2010_rosters, "~/Documents/nflscrapR-data/data/team_rosters/team_2010_rosters.csv")
write_csv(team_2011_rosters, "~/Documents/nflscrapR-data/data/team_rosters/team_2011_rosters.csv")
write_csv(team_2012_rosters, "~/Documents/nflscrapR-data/data/team_rosters/team_2012_rosters.csv")
write_csv(team_2013_rosters, "~/Documents/nflscrapR-data/data/team_rosters/team_2013_rosters.csv")
write_csv(team_2014_rosters, "~/Documents/nflscrapR-data/data/team_rosters/team_2014_rosters.csv")
write_csv(team_2015_rosters, "~/Documents/nflscrapR-data/data/team_rosters/team_2015_rosters.csv")
write_csv(team_2016_rosters, "~/Documents/nflscrapR-data/data/team_rosters/team_2016_rosters.csv")
write_csv(team_2017_rosters, "~/Documents/nflscrapR-data/data/team_rosters/team_2017_rosters.csv")

# Create datasets with the results of each game:
# (this takes some time to run)

games_2009 <- season_games(2009) %>% mutate(Season = 2009)
games_2010 <- season_games(2010) %>% mutate(Season = 2010)
games_2011 <- season_games(2011) %>% mutate(Season = 2011)
games_2012 <- season_games(2012) %>% mutate(Season = 2012)
games_2013 <- season_games(2013) %>% mutate(Season = 2013)
games_2014 <- season_games(2014) %>% mutate(Season = 2014)
games_2015 <- season_games(2015) %>% mutate(Season = 2015)
games_2016 <- season_games(2016) %>% mutate(Season = 2016)
games_2017 <- season_games(2017) %>% mutate(Season = 2017)

# Save these files:
write_csv(games_2009, "~/Documents/nflscrapR-data/data/season_games/games_2009.csv")
write_csv(games_2010, "~/Documents/nflscrapR-data/data/season_games/games_2010.csv")
write_csv(games_2011, "~/Documents/nflscrapR-data/data/season_games/games_2011.csv")
write_csv(games_2012, "~/Documents/nflscrapR-data/data/season_games/games_2012.csv")
write_csv(games_2013, "~/Documents/nflscrapR-data/data/season_games/games_2013.csv")
write_csv(games_2014, "~/Documents/nflscrapR-data/data/season_games/games_2014.csv")
write_csv(games_2015, "~/Documents/nflscrapR-data/data/season_games/games_2015.csv")
write_csv(games_2016, "~/Documents/nflscrapR-data/data/season_games/games_2016.csv")
write_csv(games_2017, "~/Documents/nflscrapR-data/data/season_games/games_2017.csv")


