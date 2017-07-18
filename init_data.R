# Install (or update) nflscrapR:
# (Make sure devtools is installed with:
#  install_packages("devtools")
# )

devtools::install_github(repo = "maksimhorowitz/nflscrapR")

# Access nflscrapR and the tidyverse:

library(nflscrapR)
library(tidyverse)

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

# Each file is saved individually, omitted the code doing that

# Bind the seasons together to make one dataset:

pbp_data <- bind_rows(pbp_2009, pbp_2010, pbp_2011,
                      pbp_2012, pbp_2013, pbp_2014,
                      pbp_2015, pbp_2016)

# Define the functions to generate the statistics:

calc_passing_splits <- function(splits,pbp_df) {
  split_groups <- lapply(splits, as.symbol)
  # Filter to only pass attempts:
  pbp_df <- pbp_df %>% filter(PassAttempt == 1 & PlayType != "No Play")
  pass_output <- pbp_df %>% group_by_(.dots=split_groups) %>%
    summarise(Attempts = n(),Completions = sum(Reception,na.rm=TRUE),
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
              TD_per_Comp = TDs / Completions)
  return(pass_output)
}

calc_rushing_splits <- function(splits,pbp_df) {
  split_groups <- lapply(splits, as.symbol)
  # Filter to only rush attempts:
  pbp_df <- pbp_df %>% filter(RushAttempt == 1 & PlayType != "No Play")
  rush_output <- pbp_df %>% group_by_(.dots=split_groups) %>%
    summarise(Carries = n(),
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
              Fumbles_per_Car = Fumbles / Carries) 
  return(rush_output)
}

calc_receiving_splits <- function(splits,pbp_df) {
  split_groups <- lapply(splits, as.symbol)
  # Filter to only pass attempts:
  pbp_df <- pbp_df %>% filter(PassAttempt == 1 & PlayType != "No Play")
  rec_output <- pbp_df %>% group_by_(.dots=split_groups) %>%
    summarise(Targets = n(), Receptions = sum(Reception,na.rm=TRUE),
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
              TD_per_Rec = TDs / Receptions) 
  return(rec_output)
}

# Due to the other J.Nelson on ARZ, change his name to JJ.Nelson:
pbp_data$Receiver <- with(pbp_data,ifelse(Receiver=="J.Nelson"&posteam=="ARI",
                                          "JJ.Nelson",Receiver))
# For now just make LA be STL, and also JAX be JAC:
pbp_data$posteam <- with(pbp_data,ifelse(posteam=="LA","STL",posteam))
pbp_data$DefensiveTeam <- with(pbp_data,ifelse(DefensiveTeam=="LA","STL",DefensiveTeam))
pbp_data$posteam <- with(pbp_data,ifelse(posteam=="JAX","JAC",posteam))
pbp_data$DefensiveTeam <- with(pbp_data,ifelse(DefensiveTeam=="JAX","JAC",DefensiveTeam))

# First generate stats at the Season level for each player (also accounting for team),
# removing the observations with missing player names:

season_passing_df <- calc_passing_splits(c("Season","Passer","posteam"), pbp_data) %>% 
  filter(!is.na(Passer)) %>% arrange(Season,desc(Attempts)) %>% rename(Team=posteam)

season_receiving_df <- calc_receiving_splits(c("Season","Receiver","posteam"), pbp_data) %>% 
  filter(!is.na(Receiver)) %>% arrange(Season,desc(Targets)) %>% rename(Team=posteam)

season_rushing_df <- calc_rushing_splits(c("Season","Rusher","posteam"), pbp_data) %>%
  filter(!is.na(Rusher)) %>% arrange(Season,desc(Carries)) %>% rename(Team=posteam)

# Save each file

# Game level:

game_passing_df <- calc_passing_splits(c("GameID","Passer","posteam","DefensiveTeam"), pbp_data) %>% 
  filter(!is.na(Passer)) %>% arrange(GameID,desc(Attempts)) %>% rename(Team=posteam,
                                                                       Opponent=DefensiveTeam)

game_receiving_df <- calc_receiving_splits(c("GameID","Receiver","posteam","DefensiveTeam"), pbp_data) %>% 
  filter(!is.na(Receiver)) %>% arrange(GameID,desc(Targets))  %>% rename(Team=posteam,
                                                                         Opponent=DefensiveTeam)

game_rushing_df <- calc_rushing_splits(c("GameID","Rusher","posteam","DefensiveTeam"), pbp_data) %>%
  filter(!is.na(Rusher)) %>% arrange(GameID,desc(Carries))  %>% rename(Team=posteam,
                                                                       Opponent=DefensiveTeam)




