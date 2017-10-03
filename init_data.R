# Install (or update) nflscrapR:
# (Make sure devtools is installed with:
#  install_packages("devtools")
# )

devtools::install_github(repo = "maksimhorowitz/nflscrapR")

# Access nflscrapR:

library(nflscrapR)

# Using the season_play_by_play() function, create datasets
# for each season:

pbp_2009 <- season_play_by_play(2009)
pbp_2010 <- season_play_by_play(2010)
pbp_2011 <- season_play_by_play(2011)
pbp_2012 <- season_play_by_play(2012)
pbp_2013 <- season_play_by_play(2013)
pbp_2014 <- season_play_by_play(2014)
pbp_2015 <- season_play_by_play(2015)
pbp_2016 <- season_play_by_play(2016)
pbp_2017 <- season_play_by_play(2017)

# Access THE tidyverse:

library(tidyverse)

# Each file is saved individually
write_csv(pbp_2009, "~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2009.csv")
write_csv(pbp_2010, "~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2010.csv")
write_csv(pbp_2011, "~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2011.csv")
write_csv(pbp_2012, "~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2012.csv")
write_csv(pbp_2013, "~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2013.csv")
write_csv(pbp_2014, "~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2014.csv")
write_csv(pbp_2015, "~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2015.csv")
write_csv(pbp_2016, "~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2016.csv")
write_csv(pbp_2017, "~/Documents/nflscrapR-data/data/season_play_by_play/pbp_2017.csv")


# Bind the seasons together to make one dataset:

pbp_data <- bind_rows(pbp_2009, pbp_2010, pbp_2011,
                      pbp_2012, pbp_2013, pbp_2014,
                      pbp_2015, pbp_2016, pbp_2017)

# Helper function to return the player's most common
# name associated with the ID:

find_player_name <- function(player_names){
  if (length(player_names)==0){
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
  # Filter to only pass attempts:
  pbp_df <- pbp_df %>% filter(PassAttempt == 1 & PlayType != "No Play")
  pass_output <- pbp_df %>% group_by_(.dots=split_groups) %>%
    summarise(Player_Name = find_player_name(Passer[which(!is.na(Passer))]),
              Attempts = n(),Completions = sum(Reception,na.rm=TRUE),
              Comp_Perc = Completions / Attempts,
              Total_Yards = sum(Yards.Gained,na.rm = TRUE),
              Total_AirYards = sum(AirYards,na.rm=TRUE),
              Yards_per_Att = Total_Yards / Attempts,
              Yards_per_Comp = Total_Yards / Completions,
              AirYards_per_Att = Total_AirYards / Attempts,
              AirYards_per_Comp = sum(Reception*AirYards,na.rm=TRUE) / Completions,
              TimesHit = sum(QBHit,na.rm=TRUE),
              Interceptions = sum(InterceptionThrown,na.rm = TRUE),
              TDs = sum(Touchdown,na.rm=TRUE),
              Air_TDs = sum(as.numeric(YardsAfterCatch==0)*Touchdown,na.rm=TRUE),
              Air_TD_Rate = Air_TDs / TDs,
              TD_to_Int = TDs / Interceptions,
              Total_EPA = sum(EPA,na.rm=TRUE),
              Success_Rate = length(which(EPA>0)) / Attempts,
              EPA_per_Att = Total_EPA / Attempts,
              EPA_per_Comp = sum(Reception*EPA,na.rm=TRUE) / Completions,
              EPA_Comp_Perc = sum(Reception*EPA,na.rm=TRUE)/sum(abs(EPA),na.rm=TRUE),
              TD_per_Att = TDs / Attempts,
              Int_per_Att = Interceptions / Attempts,
              TD_per_Comp = TDs / Completions,
              Total_WPA = sum(WPA,na.rm=TRUE),
              Win_Success_Rate = length(which(WPA>0)) / Attempts,
              WPA_per_Att = Total_WPA / Attempts,
              WPA_per_Comp = sum(Reception*WPA,na.rm=TRUE) / Completions,
              WPA_Comp_Perc = sum(Reception*WPA,na.rm=TRUE)/sum(abs(WPA),na.rm=TRUE),
              Total_Clutch_EPA = sum(EPA*abs(WPA),na.rm=TRUE),
              airEPA_Comp = sum(Reception*airEPA,na.rm=TRUE),
              airEPA_Incomp = sum(as.numeric(Reception==0)*airEPA,na.rm=TRUE),
              Total_airEPA = sum(airEPA,na.rm=TRUE),
              airEPA_per_Att = Total_airEPA / Attempts,
              airEPA_per_Comp = airEPA_Comp / Completions,
              air_Success_Rate = length(which(airEPA>0)) / Attempts,
              air_Comp_Success_Rate = length(which((Reception*airEPA)>0)) / Attempts)
  return(pass_output)
}

calc_rushing_splits <- function(splits,pbp_df) {
  split_groups <- lapply(splits, as.symbol)
  # Filter to only rush attempts:
  pbp_df <- pbp_df %>% filter(RushAttempt == 1 & PlayType != "No Play")
  rush_output <- pbp_df %>% group_by_(.dots=split_groups) %>%
    summarise(Player_Name = find_player_name(Rusher[which(!is.na(Rusher))]),
              Carries = n(),
              Total_Yards = sum(Yards.Gained,na.rm = TRUE),
              Yards_per_Car = Total_Yards / Carries,
              Fumbles = sum(Fumble,na.rm = TRUE),
              TDs = sum(Touchdown,na.rm=TRUE),
              TD_to_Fumbles = TDs / Fumbles,
              Total_EPA = sum(EPA,na.rm=TRUE),
              Success_Rate = length(which(EPA>0)) / Carries,
              EPA_per_Car = Total_EPA / Carries,
              EPA_Ratio = sum(as.numeric(EPA>0)*EPA,na.rm=TRUE)/sum(abs(EPA),na.rm=TRUE),
              TD_per_Car = TDs / Carries,
              Fumbles_per_Car = Fumbles / Carries,
              Total_WPA = sum(WPA,na.rm=TRUE),
              Win_Success_Rate = length(which(WPA>0)) / Carries,
              WPA_per_Car = Total_WPA / Carries,
              WPA_Ratio = sum(as.numeric(WPA>0)*WPA,na.rm=TRUE)/sum(abs(WPA),na.rm=TRUE),
              Total_Clutch_EPA = sum(EPA*abs(WPA),na.rm=TRUE)) 
  return(rush_output)
}

calc_receiving_splits <- function(splits,pbp_df) {
  split_groups <- lapply(splits, as.symbol)
  # Filter to only pass attempts:
  pbp_df <- pbp_df %>% filter(PassAttempt == 1 & PlayType != "No Play")
  rec_output <- pbp_df %>% group_by_(.dots=split_groups) %>%
    summarise(Player_Name = find_player_name(Receiver[which(!is.na(Receiver))]),
              Targets = n(), Receptions = sum(Reception,na.rm=TRUE),
              Total_Yards = sum(Yards.Gained,na.rm = TRUE),
              Total_YAC = sum(YardsAfterCatch,na.rm=TRUE),
              Yards_per_Rec = Total_Yards / Receptions,
              Yards_per_Target = Total_Yards / Targets,
              YAC_per_Rec = Total_YAC / Receptions,
              Rec_Percentage = Receptions / Targets,
              Fumbles = sum(Fumble,na.rm = TRUE),
              TDs = sum(Touchdown,na.rm=TRUE),
              AC_TDs = sum(as.numeric(YardsAfterCatch>0)*Touchdown,na.rm=TRUE),
              AC_TD_Rate = AC_TDs / TDs,
              TD_to_Fumbles = TDs / Fumbles,
              Total_EPA = sum(EPA,na.rm=TRUE),
              Success_Rate = length(which(EPA>0)) / Targets,
              EPA_per_Rec = sum(Reception*EPA,na.rm=TRUE) / Receptions,
              EPA_per_Target = Total_EPA / Targets,
              EPA_Rec_Perc = sum(Reception*EPA,na.rm=TRUE)/sum(abs(EPA),na.rm=TRUE),
              TD_per_Targets = TDs / Targets,
              Fumbles_per_Rec = Fumbles / Receptions,
              TD_per_Rec = TDs / Receptions,
              Total_WPA = sum(WPA,na.rm=TRUE),
              Win_Success_Rate = length(which(WPA>0)) / Targets,
              WPA_per_Target = Total_WPA / Targets,
              WPA_per_Rec = sum(Reception*WPA,na.rm=TRUE) / Receptions,
              WPA_Rec_Perc = sum(Reception*WPA,na.rm=TRUE)/sum(abs(WPA),na.rm=TRUE),
              Total_Clutch_EPA = sum(EPA*abs(WPA),na.rm=TRUE),
              AirYards_per_Target = sum(AirYards,na.rm=TRUE) / Targets,
              airEPA_per_Target = sum(airEPA,na.rm=TRUE) / Targets,
              yacEPA_Rec = sum(Reception*yacEPA,na.rm=TRUE),
              yacEPA_Drop = sum(as.numeric(Reception==0)*yacEPA,na.rm=TRUE),
              Total_yacEPA = sum(yacEPA,na.rm=TRUE),
              yacEPA_per_Target = Total_yacEPA / Targets,
              yacEPA_per_Rec = yacEPA_Rec / Receptions,
              yac_Success_Rate = length(which(yacEPA>0)) / Targets,
              yac_Rec_Success_Rate = length(which((Reception*yacEPA)>0)) / Targets)
  return(rec_output)
}

# For now just make LA be STL, and also JAX be JAC:
#pbp_data$posteam <- with(pbp_data,ifelse(posteam=="LA","STL",posteam))
#pbp_data$DefensiveTeam <- with(pbp_data,ifelse(DefensiveTeam=="LA","STL",DefensiveTeam))
pbp_data$posteam <- with(pbp_data,ifelse(posteam=="JAX","JAC",posteam))
pbp_data$DefensiveTeam <- with(pbp_data,ifelse(DefensiveTeam=="JAX","JAC",DefensiveTeam))

# First generate stats at the Season level for each player (also accounting for team),
# removing the observations with missing player names:

season_passing_df <- calc_passing_splits(c("Season","Passer_ID","posteam"), pbp_data) %>% 
  filter(Passer_ID != "None") %>% arrange(Season,desc(Attempts)) %>% rename(Team=posteam)

season_receiving_df <- calc_receiving_splits(c("Season","Receiver_ID","posteam"), pbp_data) %>% 
  filter(Receiver_ID != "None") %>% arrange(Season,desc(Targets)) %>% rename(Team=posteam)

season_rushing_df <- calc_rushing_splits(c("Season","Rusher_ID","posteam"), pbp_data) %>%
  filter(Rusher_ID != "None") %>% arrange(Season,desc(Carries)) %>% rename(Team=posteam)

# Save each file
write_csv(season_passing_df, "~/Documents/nflscrapR-data/data/season_player_stats/season_passing_df.csv")
write_csv(season_receiving_df, "~/Documents/nflscrapR-data/data/season_player_stats/season_receiving_df.csv")
write_csv(season_rushing_df, "~/Documents/nflscrapR-data/data/season_player_stats/season_rushing_df.csv")


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

# Save each file
write_csv(game_passing_df, "~/Documents/nflscrapR-data/data/game_player_stats/game_passing_df.csv")
write_csv(game_receiving_df, "~/Documents/nflscrapR-data/data/game_player_stats/game_receiving_df.csv")
write_csv(game_rushing_df, "~/Documents/nflscrapR-data/data/game_player_stats/game_rushing_df.csv")



