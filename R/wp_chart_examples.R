# Access nflscrapR:
library(nflscrapR)

pit_games <- scrape_game_ids(2018, teams = "PIT")
cle_games <- scrape_game_ids(2018, teams = "CLE")

# Bengals vs Steelers:
pit_cin_pbp <- scrape_json_play_by_play(2018123009)

# Browns vs Ravens:
cle_bal_pbp <- scrape_json_play_by_play(2018123000)

pit_no_pbp <- scrape_json_play_by_play(2018122313)

# Access the nflteams dataset that has the colors from the 
# `teamcolors` package by Ben Baumer and Gregory Matthews:
library(tidyverse)
data("nflteams")
pit_color <- nflteams %>%
  filter(abbr == "PIT") %>%
  pull(secondary)
cin_color <- nflteams %>%
  filter(abbr == "CIN") %>%
  pull(secondary)
cle_color <- nflteams %>%
  filter(abbr == "CLE") %>%
  pull(primary) 
bal_color <- nflteams %>%
  filter(abbr == "BAL") %>%
  pull(primary)
no_color <- nflteams %>%
  filter(abbr == "NO") %>%
  pull(secondary)

# ------------------------------------------------------
# Can create simple win probability chart easily:
pit_no_pbp %>%
  filter(!is.na(home_wp),
         !is.na(away_wp),
         timeout == 0,
         qtr %in% c(1, 2, 3, 4)) %>%
  dplyr::select(game_seconds_remaining,
                home_wp,
                away_wp) %>%
  gather(team, wpa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = wpa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("NO", "PIT"),
                     values = c(no_color, pit_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = .25)) +
  annotate("text", x = 3000, y = .25, label = "PIT", color = pit_color, size = 8) + 
  annotate("text", x = 3000, y = .75, label = "NO", color = no_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 16 Win Probability Chart",
    subtitle = "Pittsburgh Steelers vs New Orleans Saints",
    caption = "Data from nflscrapR"
  ) + theme_bw()



pit_cin_pbp %>%
  filter(!is.na(home_wp),
         !is.na(away_wp),
         timeout == 0,
         qtr %in% c(1,2,3,4)) %>%
  dplyr::select(game_seconds_remaining,
                home_wp,
                away_wp) %>%
  gather(team, wpa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = wpa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("CIN", "PIT"),
                     values = c(cin_color, pit_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = .25)) +
  annotate("text", x = 3000, y = .25, label = "PIT", color = pit_color, size = 8) + 
  annotate("text", x = 3000, y = .75, label = "CIN", color = cin_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 17 Win Probability Chart",
    subtitle = "Cincinnati Bengals vs. Pittsburgh Steelers",
    caption = "Data from nflscrapR"
  ) + theme_bw()



cle_bal_pbp %>%
  filter(!is.na(home_wp),
         !is.na(away_wp),
         timeout == 0,
         qtr %in% c(1,2,3,4)) %>%
  dplyr::select(game_seconds_remaining,
                home_wp,
                away_wp) %>%
  gather(team, wpa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = wpa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("CLE", "BAL"),
                     values = c(cle_color, bal_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  scale_y_continuous(limits = c(0, 1), breaks = seq(0, 1, by = .25)) +
  annotate("text", x = 3000, y = .75, label = "BAL", color = bal_color, size = 8) + 
  annotate("text", x = 3000, y = .25, label = "CLE", color = cle_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 17 Win Probability Chart",
    subtitle = "Cleveland Browns vs. Baltimore Ravens",
    caption = "Data from nflscrapR"
  ) + theme_bw()
