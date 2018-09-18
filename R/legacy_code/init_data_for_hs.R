team_pass_17 <- team_season_passing_df %>% filter(Season == 2017) %>% ungroup %>%
  select(Team, Attempts, Completions, Comp_Perc, Total_Yards, 
         Yards_per_Att, Interceptions, TDs, Total_EPA, Total_WPA) %>%
  rename(Passing_Attempts = Attempts, Completion_Percentage = Comp_Perc,
         Passing_Yards = Total_Yards, Passing_Yards_per_Attempt = Yards_per_Att,
         Passing_Touchdowns = TDs, Passing_EPA = Total_EPA, Passing_WPA = Total_WPA)

team_rush_17 <- team_season_rushing_df %>% filter(Season == 2017) %>% ungroup %>%
  select(Team, Carries, Total_Yards, Yards_per_Car, Fumbles, TDs, Total_EPA, Total_WPA) %>%
  rename(Rushing_Attempts = Carries, Rushing_Yards = Total_Yards, 
         Rushing_Yards_per_Attempt = Yards_per_Car, Rushing_Touchdowns = TDs,
         Rushing_EPA = Total_EPA, Rushing_WPA = Total_WPA) %>% filter(!is.na(Team))

team_offense_2017 <- team_pass_17 %>% left_join(team_rush_17, by = "Team")
write_csv(team_offense_2017, "nfl_team_offense_2017.csv")

