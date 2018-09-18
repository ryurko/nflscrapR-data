library(tidyverse)

# Load the player game data

player_games <- read_csv("data/game_player_stats/game_receiving_df.csv")

# Add a variable for team target share:

rec_game_utilization_data <- player_games %>%
  group_by(GameID, Team) %>%
  mutate(team_targets = sum(Targets)) %>%
  ungroup() %>%
  mutate(target_share = Targets / team_targets) %>%
  select(GameID, Team, Receiver_ID, Player_Name, Targets, team_targets,
         target_share, EPA_per_Target, RACR,
         EPA_per_Rec, WPA_per_Rec, WPA_per_Target,
         air_Success_Rate, air_Rec_Success_Rate)

# View the JuJu's skill curve:
rec_game_utilization_data %>%
  filter(Receiver_ID == "00-0033857") %>%
  ggplot(aes(x = target_share, y = EPA_per_Rec)) +
  geom_point() +
  geom_smooth() +
  labs(x = "Proportion of team targets",
       y = "EPA per reception",
       title = "JuJu's EPA per reception skill curve") +
  theme_bw() +
  theme(axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        plot.title = element_text(size = 18))

# Antonio brown
rec_game_utilization_data %>%
  filter(Receiver_ID == "00-0031382") %>%
  mutate(year = str_sub(GameID, start = 1, end = 4)) %>%
  ggplot(aes(x = target_share, y = RACR)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~year, ncol = 2) +
  labs(x = "Proportion of team targets",
       y = "RACR",
       title = "Jaris Landry's RACR skill curve") +
  theme_bw() +
  theme(axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        plot.title = element_text(size = 18))


rec_game_utilization_data %>%
  filter(Receiver_ID == "00-0027793") %>%
  mutate(year = str_sub(GameID, start = 1, end = 4)) %>%
  ggplot(aes(x = target_share, y = air_Success_Rate)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~year, ncol = 3) +
  labs(x = "Proportion of team targets",
       y = "air Success Rate",
       title = "Antonio Brown's air success rate skill curve") +
  theme_bw() +
  theme(axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        plot.title = element_text(size = 18))


rec_game_utilization_data %>%
  filter(Receiver_ID == "00-0031382") %>%
  mutate(year = str_sub(GameID, start = 1, end = 4)) %>%
  ggplot(aes(x = target_share, y = EPA_per_Rec)) +
  geom_point() +
  geom_smooth() +
  facet_wrap(~year, ncol = 3) +
  labs(x = "Proportion of team targets",
       y = "EPA per reception",
       title = "Jarvis Landry's EPA per reception skill curve") +
  theme_bw() +
  theme(axis.text = element_text(size = 12),
        axis.title = element_text(size = 14),
        plot.title = element_text(size = 18))
