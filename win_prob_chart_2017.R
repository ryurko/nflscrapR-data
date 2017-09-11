library(nflscrapR)

pbp_2017 <- season_play_by_play(2017)

library(tidyverse)
pit_cle_game <- ggplot(data = filter(pbp_2017,GameID == "2017091003", 
                     !is.na(TimeSecs), 
                     !is.na(Home_WP_pre), 
                     !is.na(Away_WP_pre),
                     PlayType != "Timeout" & PlayType != "Quarter End" &
                       PlayType != "Half End" & PlayType != "Game End" & 
                       PlayType != "Two Minute Warning" & PlayType != "End of Game"),
       aes(x = TimeSecs)) + 
  geom_hline(yintercept = 0.5, color = "black") + 
  geom_line(aes(y = Away_WP_pre), color = "black", size = 2) + 
  geom_line(aes(y = Home_WP_pre), color = "brown", size = 2) + 
  annotate("text", x = 1200, y = 0.1, label = "CLE", color = "brown", size = 8) + 
  annotate("text", x = 1200, y = 0.9, label = "PIT", color = "black", size = 8) + 
  scale_x_reverse() + ylim(c(0,1)) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 1 Win Probability Chart",
    subtitle = "Pittsburgh Steelers vs. Cleveland Browns",
    caption = "Data from nflscrapR"
  )
pit_cle_game
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

