library(nflscrapR)

pbp_2017 <- season_play_by_play(2017)

library(tidyverse)
pit_ind_game_data <- filter(pbp_2017,GameID == "2017111203", 
       !is.na(TimeSecs), 
       !is.na(Home_WP_pre), 
       !is.na(Away_WP_pre),
       PlayType != "Timeout" & PlayType != "Quarter End" &
         PlayType != "Half End" & PlayType != "Game End" & 
         PlayType != "Two Minute Warning") %>% bind_rows(list("TimeSecs"=0, "Home_WP_pre" = 0, "Away_WP_pre" = 1))

pit_ind_game <- ggplot(data = pit_ind_game_data,
       aes(x = TimeSecs)) + 
  geom_hline(yintercept = 0.5, color = "black") + 
  geom_line(aes(y = Away_WP_pre), color = "black", size = 2) + 
  geom_line(aes(y = Home_WP_pre), color = "blue", size = 2) + 
  annotate("text", x = 1200, y = 0.9, label = "IND", color = "blue", size = 8) + 
  annotate("text", x = 1200, y = 0.1, label = "PIT", color = "black", size = 8) + 
  scale_x_reverse() + ylim(c(0,1)) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 10 Win Probability Chart",
    subtitle = "Pittsburgh Steelers vs. Indianapolis Colts",
    caption = "Data from nflscrapR"
  )
pit_ind_game
plotly::ggplotly(kc_ne_game)


dal_nyg_game <- ggplot(data = filter(pbp_2017,GameID == "2017091012", 
                                     !is.na(TimeSecs), 
                                     !is.na(Home_WP_pre), 
                                     !is.na(Away_WP_pre),
                                     PlayType != "Timeout" & PlayType != "Quarter End" &
                                       PlayType != "Half End" & PlayType != "Game End" & 
                                       PlayType != "Two Minute Warning" & PlayType != "End of Game"),
                       aes(x = TimeSecs)) + 
  geom_hline(yintercept = 0.5, color = "black") + 
  geom_line(aes(y = Away_WP_pre), color = "blue", size = 2) + 
  geom_line(aes(y = Home_WP_pre), color = "gray", size = 2) + 
  annotate("text", x = 2500, y = 0.9, label = "DAL", color = "gray", size = 8) + 
  annotate("text", x = 2500, y = 0.1, label = "NYG", color = "blue", size = 8) + 
  scale_x_reverse() + ylim(c(0,1)) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 1 Win Probability Chart",
    subtitle = "New York Giants vs. Dallas Cowboys",
    caption = "Data from nflscrapR"
  ) + theme_bw()
dal_nyg_game

#  Steelers game:

games_2017 <- season_games(2017)

steelers_pbp <- game_play_by_play(2017111600)

ggplot(data = filter(steelers_pbp, 
                     !is.na(TimeSecs), 
                     !is.na(Home_WP_pre), 
                     !is.na(Away_WP_pre),
                     PlayType != "Timeout" & PlayType != "Quarter End" &
                       PlayType != "Half End" & PlayType != "Game End" & 
                       PlayType != "Two Minute Warning" & PlayType != "End of Game"),
       aes(x = TimeSecs)) + 
  geom_hline(yintercept = 0.5, color = "black") + 
  geom_line(aes(y = Away_WP_pre), color = "lightblue", size = 2) + 
  geom_line(aes(y = Home_WP_pre), color = "black", size = 2) + 
  annotate("text", x = 3000, y = 0.9, label = "PIT", color = "black", size = 8) + 
  annotate("text", x = 3000, y = 0.1, label = "TEN", color = "lightblue", size = 8) + 
  scale_x_reverse(breaks = seq(0, 3600, 300)) + ylim(c(0,1))+ 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 11 Win Probability Chart",
    subtitle = "Titans vs. Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()

seahawks_pbp <- game_play_by_play(2017112000)
seahawks_chart <- filter(seahawks_pbp, 
                         !is.na(TimeSecs), 
                         !is.na(Home_WP_pre), 
                         !is.na(Away_WP_pre),
                         PlayType != "Timeout" & PlayType != "Quarter End" &
                           PlayType != "Half End" & PlayType != "Game End" & 
                           PlayType != "Two Minute Warning" & PlayType != "End of Game") %>%
  bind_rows(list("TimeSecs"=0, "Home_WP_pre" = 0, "Away_WP_pre" = 1))

ggplot(data = seahawks_chart) + 
  geom_hline(yintercept = 0.5, color = "black") + 
  geom_line(aes(x = TimeSecs, y = Away_WP_pre), color = "#A6192E", size = 2) + 
  geom_line(aes(x = TimeSecs,y = Home_WP_pre), color = "#001433", size = 2) + 
  annotate("text", x = 1800, y = 0.9, label = "ATL", color = "#A6192E", size = 8) + 
  annotate("text", x = 1800, y = 0.1, label = "SEA", color = "#001433", size = 8) + 
  scale_x_reverse(breaks = seq(0, 3600, 300)) + ylim(c(0,1))+ 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 11 Win Probability Chart",
    subtitle = "Atlanta Falcons vs. Seattle Seahawks",
    caption = "Data from nflscrapR"
  ) + theme_bw()




# WAS vs NO

no_was_game_data <- filter(pbp_2017,GameID == "2017111905", 
                            !is.na(TimeSecs), 
                            !is.na(Home_WP_pre), 
                            !is.na(Away_WP_pre),
                            PlayType != "Timeout" & PlayType != "Quarter End" &
                              PlayType != "Half End" & PlayType != "Game End" & 
                              PlayType != "Two Minute Warning") %>% bind_rows(list("TimeSecs"=0, "Home_WP_pre" = 1, "Away_WP_pre" = 0))

ggplot(data = filter(no_was_game_data, 
                     !is.na(TimeSecs), 
                     !is.na(Home_WP_pre), 
                     !is.na(Away_WP_pre),
                     PlayType != "Timeout" & PlayType != "Quarter End" &
                       PlayType != "Half End" & PlayType != "Game End" & 
                       PlayType != "Two Minute Warning" & PlayType != "End of Game"),
       aes(x = TimeSecs)) + 
  geom_hline(yintercept = 0.5, color = "black") + 
  geom_line(aes(y = Away_WP_pre), color = "darkred", size = 2) + 
  geom_line(aes(y = Home_WP_pre), color = "black", size = 2) + 
  annotate("text", x = 3000, y = 0.9, label = "WAS", color = "darkred", size = 8) + 
  annotate("text", x = 3000, y = 0.1, label = "NO", color = "black", size = 8) + 
  scale_x_reverse(breaks = seq(0, 3600, 300)) + ylim(c(0,1))+ 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 11 Win Probability Chart",
    subtitle = "Washington vs. New Orleans",
    caption = "Data from nflscrapR"
  ) + theme_bw()


# Playoffs:

playoff_ids_2017 <- extracting_gameids(2017, playoffs = TRUE)
no_car_pbp <- game_play_by_play(playoff_ids_2017[5])

no_car_game_data <- dplyr::filter(no_car_pbp, 
                           !is.na(TimeSecs), 
                           !is.na(Home_WP_pre), 
                           !is.na(Away_WP_pre),
                           PlayType != "Timeout" & PlayType != "Quarter End" &
                             PlayType != "Half End" & PlayType != "Game End" & 
                             PlayType != "Two Minute Warning") %>% 
  dplyr::bind_rows(list("TimeSecs"=0, "Home_WP_pre" = 1, "Away_WP_pre" = 0))

library(ggplot2)
no_car_plot <- ggplot(data = dplyr::filter(no_car_game_data, 
                     !is.na(TimeSecs), 
                     !is.na(Home_WP_pre), 
                     !is.na(Away_WP_pre),
                     PlayType != "Timeout" & PlayType != "Quarter End" &
                       PlayType != "Half End"  & 
                       PlayType != "Two Minute Warning"),
       aes(x = TimeSecs)) + 
  geom_hline(yintercept = 0.5, color = "black") + 
  geom_line(aes(y = Away_WP_pre), color = "lightblue", size = 2) + 
  geom_line(aes(y = Home_WP_pre), color = "black", size = 2) + 
  annotate("text", x = 3000, y = 0.1, label = "CAR", color = "lightblue", size = 8) + 
  annotate("text", x = 3000, y = 0.9, label = "NO", color = "black", size = 8) + 
  scale_x_reverse(breaks = seq(0, 3600, 300)) + ylim(c(0,1))+ 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Playoffs Probability Chart",
    subtitle = "Carolina vs. New Orleans",
    caption = "Data from nflscrapR"
  ) + theme_bw()

plotly::ggplotly(no_car_plot)

library(teamcolors)
nfl_teamcolors <- teamcolors %>% filter(league == "nfl")
phi_color <- nfl_teamcolors %>%
  filter(name == "Philadelphia Eagles") %>%
  pull(primary)
ne_color <- nfl_teamcolors %>%
  filter(name == "New England Patriots") %>%
  pull(secondary)


superbowl_18 <- game_play_by_play(playoff_ids_2017[13])

ggplot(data = dplyr::filter(superbowl_18, 
                                           !is.na(TimeSecs), 
                                           !is.na(Home_WP_pre), 
                                           !is.na(Away_WP_pre),
                                           PlayType != "Timeout" & PlayType != "Quarter End" &
                                             PlayType != "Half End"  & 
                                             PlayType != "Two Minute Warning"),
                      aes(x = TimeSecs)) + 
  geom_hline(yintercept = 0.5, color = "black") + 
  geom_line(aes(y = Away_WP_pre), color = phi_color, size = 2) + 
  geom_line(aes(y = Home_WP_pre), color = ne_color, size = 2) + 
  annotate("text", x = 3000, y = 0.1, label = "NE", color = ne_color, size = 8) + 
  annotate("text", x = 3000, y = 0.9, label = "PHI", color = phi_color, size = 8) + 
  scale_x_reverse(breaks = seq(0, 3600, 300)) + ylim(c(0,1))+ 
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Super Bowl LII Win Probability Chart",
    subtitle = "Philadelphia Eagles vs. New England Patriots",
    caption = "Data from nflscrapR"
  ) + theme_bw()


passing_summary <- superbowl_18 %>%
  filter(PassAttempt == 1 & PlayType != "No Play") %>%
  group_by(posteam) %>%
  mutate(GameDrive = paste(as.character(GameID), as.character(Drive),sep="-")) %>%
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
            airEPA_Comp = sum(Reception*airEPA,na.rm=TRUE),
            airEPA_Incomp = sum(as.numeric(Reception==0)*airEPA,na.rm=TRUE),
            Total_Raw_airEPA = sum(airEPA,na.rm=TRUE),
            Raw_airEPA_per_Att = Total_Raw_airEPA / Attempts,
            Raw_airEPA_per_Drive = Total_Raw_airEPA / Drives,
            airEPA_per_Att = airEPA_Comp / Attempts,
            airEPA_per_Comp = airEPA_Comp / Completions,
            airEPA_per_Drive = airEPA_Comp / Drives,
            air_Success_Rate = length(which(airEPA>0)) / Attempts,
            air_Comp_Success_Rate = length(which((Reception*airEPA)>0)) / Attempts,
            airWPA_Comp = sum(Reception*airWPA,na.rm=TRUE),
            airWPA_Incomp = sum(as.numeric(Reception==0)*airWPA,na.rm=TRUE),
            Total_Raw_airWPA = sum(airWPA,na.rm=TRUE),
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
  
