# This file provides code for comparing the 2018 season performances of
# Ryan Fitzpatrick and Jameis Winston

# Access tidyverse
# install.packages("tidyverse")
library(tidyverse)

# Let's work with season-level data this time, could use the 
# scrape_season_play_by_play() function to do this:
# pbp_18 <- scrape_season_play_by_play(2018)
# But this takes awhile, instead can directly access data I've already scraped:
pbp_18 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2018.csv")

# Access nflscrapR:
library(nflscrapR)

# Gather the Buccaneers 2018 games:
tb_season <- scrape_game_ids(season = 2018, teams = "TB")
tb_games <- tb_season %>%
  filter(state_of_game == "POST") %>%
  pull(game_id)

# Filter the play-by-play to be when TB was posteam
tb_pbp_18 <- pbp_18 %>% 
  filter(posteam == "TB")

# Get the TB primary and secondary colors:
data("nflteams")
tb_colors <- nflteams %>%
  filter(abbr == "TB") %>%
  select(primary, secondary) %>%
  as.character()

# Now generate ridge plots comparing the EPA on dropbacks for Fitzpatrick
# and Winston in 2018:
library(ggridges)

ave_epa_dropback <- tb_pbp_18 %>%
  filter(play_type %in% c("pass", "run"),
         qb_dropback == 1) %>%
  mutate(qb_name = ifelse(is.na(passer_player_name), rusher_player_name,
                          passer_player_name)) %>%
  filter(qb_name %in% c("R.Fitzpatrick", "J.Winston")) %>%
  group_by(qb_name) %>%
  summarise(ave_epa = mean(epa, na.rm = TRUE))

tb_pbp_18 %>%
  filter(play_type %in% c("pass", "run"),
         qb_dropback == 1) %>%
  mutate(qb_name = ifelse(is.na(passer_player_name), rusher_player_name,
                          passer_player_name)) %>%
  filter(qb_name %in% c("R.Fitzpatrick", "J.Winston")) %>%
  ggplot(aes(x = epa, fill = qb_name, color = qb_name)) +
  scale_fill_manual(values = tb_colors) + 
  scale_color_manual(values = tb_colors, 
                        guide = FALSE) + 
  geom_density(color = "white", alpha = 0.7) +
  geom_rug(alpha = 0.7) +
  geom_vline(data = ave_epa_dropback, aes(xintercept = ave_epa, color = qb_name),
             size = 2) +
  #geom_density_ridges(rel_min_height = 0.01, jittered_points = TRUE, color = "white",
  #                    position = position_points_jitter(width = 0.05, height = 0),
  #                    point_shape = '|', point_size = 2, point_alpha = 0.7, alpha = 0.8,
  #                    scale = 0.8) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "darkred") +
  labs(title = "Who should start for Tampa Bay?",
       subtitle = "Comparison of EPA distributions on dropbacks for Fitzpatrick and Winston through week 11",
       caption = "Data from `nflscrapR`; colors courtesy of `teamcolors`",
       y = "Density", x = "Expected Points Added",
       fill = "QB") +
  #scale_y_discrete(expand = c(0.01, 0)) +
  theme_bw() +
  theme(axis.title = element_text(size = 14),
        axis.text = element_text(size = 12),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12),
        legend.position = "bottom",
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 14))


tb_pbp_18 %>%
  filter(play_type %in% c("pass", "run"),
         qb_dropback == 1) %>%
  mutate(qb_name = ifelse(is.na(passer_player_name), rusher_player_name,
                          passer_player_name)) %>%
  filter(qb_name %in% c("R.Fitzpatrick", "J.Winston")) %>%
  ggplot(aes(x = epa, fill = qb_name, color = qb_name)) +
  scale_fill_manual(values = tb_colors) + 
  scale_color_manual(values = tb_colors, 
                     guide = FALSE) + 
  geom_density(color = "white", alpha = 0.7) +
  geom_rug(alpha = 0.7) +
  #geom_density_ridges(rel_min_height = 0.01, jittered_points = TRUE, color = "white",
  #                    position = position_points_jitter(width = 0.05, height = 0),
  #                    point_shape = '|', point_size = 2, point_alpha = 0.7, alpha = 0.8,
  #                    scale = 0.8) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "darkred") +
  labs(title = "Who should start for Tampa Bay?",
       subtitle = "Comparison of EPA distributions on dropbacks for Fitzpatrick and Winston through week 11",
       caption = "Data from `nflscrapR`; colors courtesy of `teamcolors`",
       y = "Density", x = "Expected Points Added",
       fill = "QB") +
  facet_wrap(~ game_date, ncol = 3) +
  #scale_y_discrete(expand = c(0.01, 0)) +
  theme_bw() +
  theme(axis.title = element_text(size = 14),
        axis.text = element_text(size = 12),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12),
        legend.position = "bottom",
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 14),
        strip.background = element_blank(),
        strip.text = element_text(size = 12))

  
  tb_pbp_18 %>%
    filter(play_type %in% c("pass")) %>%
    filter(passer_player_name %in% c("R.Fitzpatrick", "J.Winston")) %>%
    ggplot(aes(x = epa, fill = passer_player_name, color = passer_player_name)) +
    scale_fill_manual(values = tb_colors) + 
    scale_color_manual(values = tb_colors, 
                       guide = FALSE) + 
    geom_density(color = "white", alpha = 0.7) +
    geom_rug(alpha = 0.7) +
    #geom_density_ridges(rel_min_height = 0.01, jittered_points = TRUE, color = "white",
    #                    position = position_points_jitter(width = 0.05, height = 0),
    #                    point_shape = '|', point_size = 2, point_alpha = 0.7, alpha = 0.8,
    #                    scale = 0.8) +
    geom_vline(xintercept = 0, linetype = "dashed", color = "darkred") +
    labs(title = "Who should start for Tampa Bay?",
         subtitle = "Comparison of EPA distributions on pass attempts for Fitzpatrick and Winston through week 11",
         caption = "Data from `nflscrapR`; colors courtesy of `teamcolors`",
         y = "Density", x = "Expected Points Added",
         fill = "QB") +
    #scale_y_discrete(expand = c(0.01, 0)) +
    theme_bw() +
    theme(axis.title = element_text(size = 14),
          axis.text = element_text(size = 12),
          plot.title = element_text(size = 16),
          plot.subtitle = element_text(size = 14),
          plot.caption = element_text(size = 12),
          legend.position = "bottom",
          legend.text = element_text(size = 12),
          legend.title = element_text(size = 14))  

tb_pbp_18 %>%
  filter(play_type %in% c("pass"),
         complete_pass == 1) %>%
  filter(passer_player_name %in% c("R.Fitzpatrick", "J.Winston")) %>%
  ggplot(aes(x = air_epa, fill = passer_player_name, color = passer_player_name)) +
  scale_fill_manual(values = tb_colors) + 
  scale_color_manual(values = tb_colors, 
                     guide = FALSE) + 
  geom_density(color = "white", alpha = 0.7) +
  geom_rug(alpha = 0.7) +
  #geom_density_ridges(rel_min_height = 0.01, jittered_points = TRUE, color = "white",
  #                    position = position_points_jitter(width = 0.05, height = 0),
  #                    point_shape = '|', point_size = 2, point_alpha = 0.7, alpha = 0.8,
  #                    scale = 0.8) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "darkred") +
  labs(title = "Who should start for Tampa Bay?",
       subtitle = "Comparison of air EPA distributions on completions for Fitzpatrick and Winston through week 11",
       caption = "Data from `nflscrapR`; colors courtesy of `teamcolors`",
       y = "Density", x = "Air Expected Points Added",
       fill = "QB") +
  #scale_y_discrete(expand = c(0.01, 0)) +
  theme_bw() +
  theme(axis.title = element_text(size = 14),
        axis.text = element_text(size = 12),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12),
        legend.position = "bottom",
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 14))

tb_pbp_18 %>%
  filter(play_type %in% c("pass"),
         complete_pass == 1) %>%
  filter(passer_player_name %in% c("R.Fitzpatrick", "J.Winston")) %>%
  ggplot(aes(x = yac_epa, fill = passer_player_name, color = passer_player_name)) +
  scale_fill_manual(values = tb_colors) + 
  scale_color_manual(values = tb_colors, 
                     guide = FALSE) + 
  geom_density(color = "white", alpha = 0.7) +
  geom_rug(alpha = 0.7) +
  #geom_density_ridges(rel_min_height = 0.01, jittered_points = TRUE, color = "white",
  #                    position = position_points_jitter(width = 0.05, height = 0),
  #                    point_shape = '|', point_size = 2, point_alpha = 0.7, alpha = 0.8,
  #                    scale = 0.8) +
  geom_vline(xintercept = 0, linetype = "dashed", color = "darkred") +
  labs(title = "Who should start for Tampa Bay?",
       subtitle = "Comparison of YAC EPA distributions on completions for Fitzpatrick and Winston through week 11",
       caption = "Data from `nflscrapR`; colors courtesy of `teamcolors`",
       y = "Density", x = "YAC Expected Points Added",
       fill = "QB") +
  #scale_y_discrete(expand = c(0.01, 0)) +
  theme_bw() +
  theme(axis.title = element_text(size = 14),
        axis.text = element_text(size = 12),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12),
        legend.position = "bottom",
        legend.text = element_text(size = 12),
        legend.title = element_text(size = 14))

