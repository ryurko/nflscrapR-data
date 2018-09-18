library(teamcolors)
library(tidyverse)
nfl_teamcolors <- teamcolors %>% filter(league == "nfl")
pit_color <- nfl_teamcolors %>%
  filter(name == "Pittsburgh Steelers") %>%
  pull(primary)
cle_color <- nfl_teamcolors %>%
  filter(name == "Cleveland Browns") %>%
  pull(primary)


testing_live_pbp %>%
  filter(!is.na(play_type),
         !is.na(game_seconds_remaining),
         !is.na(total_home_epa),
         !is.na(total_away_epa),
         qtr %in% c(1, 2, 3, 4)) %>%
  dplyr::select(game_seconds_remaining,
                total_home_epa,
                total_away_epa) %>%
  gather(team, epa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = epa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("PIT", "CLE"),
                     values = c(pit_color, cle_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  annotate("text", x = 3000, y = 10, label = "PIT", color = pit_color, size = 8) + 
  annotate("text", x = 3000, y = -10, label = "CLE", color = cle_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Cumulative Expected Points Added",
    title = "Week 1 Cumulative EPA Chart",
    subtitle = "Cleveland Browns vs. Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()

testing_live_pbp %>%
  filter(!is.na(play_type),
         !is.na(game_seconds_remaining),
         !is.na(total_home_rush_epa),
         !is.na(total_away_rush_epa),
         qtr %in% c(1, 2, 3, 4)) %>%
  dplyr::select(game_seconds_remaining,
                total_home_rush_epa,
                total_away_rush_epa) %>%
  gather(team, epa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = epa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("KC", "PIT"),
                     values = c(kc_color, pit_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  annotate("text", x = 3000, y = -10, label = "PIT", color = pit_color, size = 8) + 
  annotate("text", x = 3000, y = 10, label = "KC", color = kc_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Cumulative Rushing Expected Points Added",
    title = "Week 2 Cumulative Rushing EPA Chart",
    subtitle = "Kansas City Chiefs vs. Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()

testing_live_pbp %>%
  filter(!is.na(play_type),
         !is.na(game_seconds_remaining),
         !is.na(total_home_rush_wpa),
         !is.na(total_away_rush_wpa),
         qtr %in% c(1, 2, 3, 4)) %>%
  dplyr::select(game_seconds_remaining,
                total_home_rush_wpa,
                total_away_rush_wpa) %>%
  gather(team, wpa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = wpa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("KC", "PIT"),
                     values = c(kc_color, pit_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  scale_y_continuous(limits = c(-.5, .5), breaks = seq(-1, 1, by = .125)) +
  annotate("text", x = 3000, y = -.25, label = "PIT", color = pit_color, size = 8) + 
  annotate("text", x = 3000, y = .25, label = "KC", color = kc_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Cumulative Rushing Win Probability Added",
    title = "Week 2 Cumulative Rushing WPA Chart",
    subtitle = "Kansas City Chiefs vs. Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()

testing_live_pbp %>%
  filter(!is.na(play_type),
         !is.na(game_seconds_remaining),
         !is.na(total_home_pass_wpa),
         !is.na(total_away_pass_wpa),
         qtr %in% c(1, 2, 3, 4)) %>%
  dplyr::select(game_seconds_remaining,
                total_home_pass_wpa,
                total_away_pass_wpa) %>%
  gather(team, wpa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = wpa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("KC", "PIT"),
                     values = c(kc_color, pit_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  scale_y_continuous(limits = c(-.5, .5), breaks = seq(-1, 1, by = .125)) +
  annotate("text", x = 3000, y = -.25, label = "PIT", color = pit_color, size = 8) + 
  annotate("text", x = 3000, y = .25, label = "KC", color = kc_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Cumulative Passing Win Probability Added",
    title = "Week 2 Cumulative Passing WPA Chart",
    subtitle = "Kansas City Chiefs vs. Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()


testing_live_pbp %>%
  filter(!is.na(play_type),
         !is.na(game_seconds_remaining),
         !is.na(total_home_pass_epa),
         !is.na(total_away_pass_epa),
         qtr %in% c(1, 2, 3, 4)) %>%
  dplyr::select(game_seconds_remaining,
                total_home_pass_epa,
                total_away_pass_epa) %>%
  gather(team, epa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = epa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("KC", "PIT"),
                     values = c(kc_color, pit_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  annotate("text", x = 3000, y = -8, label = "PIT", color = pit_color, size = 8) + 
  annotate("text", x = 3000, y = 8, label = "KC", color = kc_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Cumulative Passing Expected Points Added",
    title = "Week 2 Cumulative Passing EPA Chart",
    subtitle = "Kansas City Chiefs vs. Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()

testing_live_pbp %>%
  filter(!is.na(play_type),
         !is.na(game_seconds_remaining),
         !is.na(total_home_comp_air_epa),
         !is.na(total_away_comp_air_epa),
         qtr %in% c(1, 2, 3, 4)) %>%
  dplyr::select(game_seconds_remaining,
                total_home_comp_air_epa,
                total_away_comp_air_epa) %>%
  gather(team, epa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = epa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("KC", "PIT"),
                     values = c(kc_color, pit_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  annotate("text", x = 3000, y = -10, label = "PIT", color = pit_color, size = 8) + 
  annotate("text", x = 3000, y = 10, label = "KC", color = kc_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Cumulative Air Expected Points Added (completions)",
    title = "Week 2 Cumulative airEPA Chart for Completions",
    subtitle = "Kansas City Chiefs vs. Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()

testing_live_pbp %>%
  filter(!is.na(play_type),
         !is.na(game_seconds_remaining),
         !is.na(total_home_comp_yac_epa),
         !is.na(total_away_comp_yac_epa),
         qtr %in% c(1, 2, 3, 4)) %>%
  dplyr::select(game_seconds_remaining,
                total_home_comp_yac_epa,
                total_away_comp_yac_epa) %>%
  gather(team, epa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = epa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("KC", "PIT"),
                     values = c(kc_color, pit_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  annotate("text", x = 3000, y = -5, label = "PIT", color = pit_color, size = 8) + 
  annotate("text", x = 3000, y = 5, label = "KC", color = kc_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Cumulative YAC Expected Points Added (completions)",
    title = "Week 2 Cumulative yacEPA Chart for Completions",
    subtitle = "Kansas City Chiefs vs. Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()


testing_live_pbp %>%
  filter(!is.na(play_type),
         !is.na(game_seconds_remaining),
         !is.na(total_home_comp_yac_wpa),
         !is.na(total_away_comp_yac_wpa),
         qtr %in% c(1, 2, 3, 4)) %>%
  dplyr::select(game_seconds_remaining,
                total_home_comp_yac_wpa,
                total_away_comp_yac_wpa) %>%
  gather(team, wpa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = wpa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  geom_hline(yintercept = -0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("KC", "PIT"),
                     values = c(kc_color, pit_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  #scale_y_continuous(limits = c(-.5, .5), breaks = seq(-1, 1, by = .125)) +
  annotate("text", x = 3000, y = -.25, label = "PIT", color = pit_color, size = 8) + 
  annotate("text", x = 3000, y = .25, label = "KC", color = kc_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Cumulative YAC Win Probability Added (completions)",
    title = "Week 2 Cumulative yacWPA Chart for Completions",
    subtitle = "Kansas City Chiefs vs. Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()

testing_live_pbp %>%
  filter(!is.na(play_type),
         !is.na(game_seconds_remaining),
         !is.na(total_home_comp_air_wpa),
         !is.na(total_away_comp_air_wpa),
         qtr %in% c(1, 2, 3, 4)) %>%
  dplyr::select(game_seconds_remaining,
                total_home_comp_air_wpa,
                total_away_comp_air_wpa) %>%
  gather(team, wpa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = wpa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  geom_hline(yintercept = -0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("KC", "PIT"),
                     values = c(kc_color, pit_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  #scale_y_continuous(limits = c(-.5, .5), breaks = seq(-1, 1, by = .125)) +
  annotate("text", x = 3000, y = -.25, label = "PIT", color = pit_color, size = 8) + 
  annotate("text", x = 3000, y = .25, label = "KC", color = kc_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Cumulative Air Win Probability Added (completions)",
    title = "Week 2 Cumulative airWPA Chart for Completions",
    subtitle = "Kansas City Chiefs vs. Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()

testing_live_pbp %>%
  filter(!is.na(home_wp),
         !is.na(away_wp),
         qtr %in% c(1, 2, 3, 4)) %>%
  dplyr::select(game_seconds_remaining,
                home_wp,
                away_wp) %>%
  gather(team, wpa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = wpa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("PIT", "CLE"),
                     values = c(pit_color, cle_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  annotate("text", x = 3000, y = .35, label = "CLE", color = cle_color, size = 8) + 
  annotate("text", x = 3000, y = .75, label = "PIT", color = pit_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 1 Win Probability Chart (Regulation)",
    subtitle = "Cleveland Browns vs. Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()

testing_live_pbp %>%
  filter(!is.na(home_wp),
         !is.na(away_wp),
         timeout == 0,
         qtr %in% c(5)) %>%
  dplyr::select(game_seconds_remaining,
                home_wp,
                away_wp) %>%
  gather(team, wpa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = wpa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("PIT", "CLE"),
                     values = c(pit_color, cle_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 600, 300)) + 
  annotate("text", x = 500, y = .35, label = "CLE", color = cle_color, size = 8) + 
  annotate("text", x = 500, y = .75, label = "PIT", color = pit_color, size = 8) +
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 1 Win Probability Chart (Overtime)",
    subtitle = "Cleveland Browns vs. Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()


testingwp <- game_play_by_play(2018091605)


ggplot(data = dplyr::filter(testingwp, 
                            !is.na(TimeSecs), 
                            !is.na(Home_WP_pre), 
                            !is.na(Away_WP_pre),
                            qtr %in% c(1, 2, 3, 4),
                            PlayType != "Timeout" & PlayType != "Quarter End" &
                              PlayType != "Half End"  & 
                              PlayType != "Two Minute Warning"),
       aes(x = TimeSecs)) + 
  geom_hline(yintercept = 0.5, color = "black") + 
  geom_line(aes(y = Away_WP_pre), color = kc_color, size = 2) + 
  geom_line(aes(y = Home_WP_pre), color = pit_color, size = 2) + 
  annotate("text", x = 3000, y = 0.35, label = "PIT", color = pit_color, size = 8) + 
  annotate("text", x = 3000, y = 0.75, label = "KC", color = kc_color, size = 8) + 
  scale_x_reverse(breaks = seq(0, 3600, 300)) + ylim(c(0,1))+ 
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 2 Win Probability Chart",
    subtitle = "Kansas City Chiefs vs Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()