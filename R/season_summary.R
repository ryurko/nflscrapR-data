# This file generates charts summarizing the performances of teams in the
# current NFL season using nflscrapR expected points and win probability.

# Access tidyverse
# install.packages("tidyverse")
library(tidyverse)

# Let's work with season-level data this time, could use the 
# scrape_season_play_by_play() function to do this:
# pbp_18 <- scrape_season_play_by_play(2018)
# But this takes awhile, instead can directly access data I've already scraped:
pbp_18 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2018.csv")

# Let's recreate the figure Brian Burke tweets out, with team EPA per game. 
# We'll first do this for the offense (also calculate various other stats
# to plot later on):
offense_epa_18 <- pbp_18 %>%
  filter(!is.na(posteam)) %>%
  group_by(posteam) %>%
  # Create a variable that denotes if it is either a pass or run:
  mutate(pass_run_ind = ifelse(play_type %in% c("pass", "run"),
                               1, 0),
         # Punts without penalties:
         punt_ind = ifelse(play_type == "punt", 1, 0),
         # Kickoffs without penalties:
         kickoff_ind = ifelse(play_type == "kickoff", 1, 0),
         # Designed run indicator:
         designed_run_ind = ifelse(play_type == "run" & qb_dropback == 0, 1, 0)) %>%
  summarise(# Variables with counts:
            n_games = length(unique(game_id)),
            n_dropbacks = sum(qb_dropback, na.rm = TRUE),
            n_all_runs = sum(rush_attempt * pass_run_ind, na.rm = TRUE),
            n_designed_runs = sum(designed_run_ind, na.rm = TRUE),
            n_pass_attempts = sum(pass_attempt * pass_run_ind, na.rm = TRUE),
            n_completions = sum(complete_pass, na.rm = TRUE),
            n_sacks = sum(sack, na.rm = TRUE),
            n_punts = sum(punt_ind, na.rm = TRUE),
            n_kickoffs = sum(kickoff_ind, na.rm = TRUE),
            n_pass_run_plays = sum(pass_run_ind, na.rm = TRUE),
            # Variables with total EPA and WPA for various types of plays:
            off_total_epa = sum(epa, na.rm = TRUE),
            off_total_wpa = sum(wpa, na.rm = TRUE),
            off_pass_run_epa = sum(epa * pass_run_ind, na.rm = TRUE),
            off_pass_run_wpa = sum(wpa * pass_run_ind, na.rm = TRUE),
            off_dropback_epa = sum(epa * qb_dropback * pass_run_ind, na.rm = TRUE),
            off_dropback_wpa = sum(wpa * qb_dropback * pass_run_ind, na.rm = TRUE),
            off_pass_epa = sum(epa * pass_attempt * pass_run_ind, na.rm = TRUE),
            off_pass_wpa = sum(wpa * pass_attempt * pass_run_ind, na.rm = TRUE),
            off_all_run_epa = sum(epa * rush_attempt * pass_run_ind, na.rm = TRUE),
            off_all_run_wpa = sum(wpa * rush_attempt * pass_run_ind, na.rm = TRUE),
            off_des_run_epa = sum(epa * designed_run_ind, na.rm = TRUE),
            off_des_run_wpa = sum(wpa * designed_run_ind, na.rm = TRUE),
            off_total_comp_air_epa = sum(complete_pass * air_epa, na.rm = TRUE),
            off_total_comp_air_wpa = sum(complete_pass * air_wpa, na.rm = TRUE),
            off_total_comp_yac_epa = sum(complete_pass * yac_epa, na.rm = TRUE),
            off_total_comp_yac_wpa = sum(complete_pass * yac_wpa, na.rm = TRUE),
            off_punt_epa = sum(epa * punt_ind, na.rm = TRUE),
            off_punt_wpa = sum(wpa * punt_ind, na.rm = TRUE),
            off_kickoff_epa = sum(epa * kickoff_ind, na.rm = TRUE),
            off_kickoff_wpa = sum(wpa * kickoff_ind, na.rm = TRUE),
            off_sacks_epa = sum(epa * sack, na.rm = TRUE),
            off_sacks_wpa = sum(wpa * sack, na.rm = TRUE),
            # Success rates:
            off_pass_run_sr = length(which(epa > 0 & pass_run_ind == 1)) / n_pass_run_plays,
            off_all_runs_sr = length(which(epa > 0 & 
                                         rush_attempt == 1 & 
                                         pass_run_ind == 1)) / n_all_runs,
            off_des_runs_sr = length(which(epa > 0 & 
                                         designed_run_ind == 1)) / n_designed_runs,
            off_dropback_sr = length(which(epa > 0 & qb_dropback == 1 &
                                         pass_run_ind == 1)) / n_dropbacks) %>%
  mutate(# Now the rate level statistics, first EPA based:
         off_epa_per_game = off_total_epa / n_games,
         off_epa_per_pass_run = off_pass_run_epa / n_pass_run_plays,
         off_epa_per_dropback = off_dropback_epa / n_dropbacks,
         off_epa_per_pass = off_pass_epa / n_pass_attempts,
         off_epa_per_all_run = off_all_run_epa / n_all_runs,
         off_epa_per_des_run = off_des_run_epa / n_designed_runs,
         off_air_epa_per_comp = off_total_comp_air_epa / n_completions,
         off_yac_epa_per_comp = off_total_comp_yac_epa / n_completions,
         off_epa_per_punt = off_punt_epa / n_punts,
         off_epa_per_ko = off_kickoff_epa / n_kickoffs,
         off_epa_per_sack = off_sacks_epa / n_sacks,
         # Now WPA based:
         off_wpa_per_game = off_total_wpa / n_games,
         off_wpa_per_pass_run = off_pass_run_wpa / n_pass_run_plays,
         off_wpa_per_dropback = off_dropback_wpa / n_dropbacks,
         off_wpa_per_pass = off_pass_wpa / n_pass_attempts,
         off_wpa_per_all_run = off_all_run_wpa / n_all_runs,
         off_wpa_per_des_run = off_des_run_wpa / n_designed_runs,
         off_air_wpa_per_comp = off_total_comp_air_wpa / n_completions,
         off_yac_wpa_per_comp = off_total_comp_yac_wpa / n_completions,
         off_wpa_per_punt = off_punt_wpa / n_punts,
         off_wpa_per_ko = off_kickoff_wpa / n_kickoffs,
         off_wpa_per_sack = off_sacks_wpa / n_sacks)

# Now for defense:
defense_epa_18 <- pbp_18 %>%
  filter(!is.na(defteam)) %>%
  group_by(defteam) %>%
  # Create a variable that denotes if it is either a pass or run:
  mutate(pass_run_ind = ifelse(play_type %in% c("pass", "run"),
                               1, 0),
         # Punts without penalties:
         punt_ind = ifelse(play_type == "punt", 1, 0),
         # Kickoffs without penalties:
         kickoff_ind = ifelse(play_type == "kickoff", 1, 0),
         # Designed run indicator:
         designed_run_ind = ifelse(play_type == "run" & qb_dropback == 0, 1, 0)) %>%
  summarise(# Variables with counts:
            n_games = length(unique(game_id)),
            n_dropbacks = sum(qb_dropback, na.rm = TRUE),
            n_all_runs = sum(rush_attempt * pass_run_ind, na.rm = TRUE),
            n_designed_runs = sum(designed_run_ind, na.rm = TRUE),
            n_pass_attempts = sum(pass_attempt * pass_run_ind, na.rm = TRUE),
            n_completions = sum(complete_pass, na.rm = TRUE),
            n_sacks = sum(sack, na.rm = TRUE),
            n_punts = sum(punt_ind, na.rm = TRUE),
            n_kickoffs = sum(kickoff_ind, na.rm = TRUE),
            n_pass_run_plays = sum(pass_run_ind, na.rm = TRUE),
            # Variables with total EPA and WPA for various types of plays:
            def_total_epa = sum(epa, na.rm = TRUE),
            def_total_wpa = sum(wpa, na.rm = TRUE),
            def_pass_run_epa = sum(epa * pass_run_ind, na.rm = TRUE),
            def_pass_run_wpa = sum(wpa * pass_run_ind, na.rm = TRUE),
            def_dropback_epa = sum(epa * qb_dropback * pass_run_ind, na.rm = TRUE),
            def_dropback_wpa = sum(wpa * qb_dropback * pass_run_ind, na.rm = TRUE),
            def_pass_epa = sum(epa * pass_attempt * pass_run_ind, na.rm = TRUE),
            def_pass_wpa = sum(wpa * pass_attempt * pass_run_ind, na.rm = TRUE),
            def_all_run_epa = sum(epa * rush_attempt * pass_run_ind, na.rm = TRUE),
            def_all_run_wpa = sum(wpa * rush_attempt * pass_run_ind, na.rm = TRUE),
            def_des_run_epa = sum(epa * designed_run_ind, na.rm = TRUE),
            def_des_run_wpa = sum(wpa * designed_run_ind, na.rm = TRUE),
            def_total_comp_air_epa = sum(complete_pass * air_epa, na.rm = TRUE),
            def_total_comp_air_wpa = sum(complete_pass * air_wpa, na.rm = TRUE),
            def_total_comp_yac_epa = sum(complete_pass * yac_epa, na.rm = TRUE),
            def_total_comp_yac_wpa = sum(complete_pass * yac_wpa, na.rm = TRUE),
            def_punt_epa = sum(epa * punt_ind, na.rm = TRUE),
            def_punt_wpa = sum(wpa * punt_ind, na.rm = TRUE),
            def_kickoff_epa = sum(epa * kickoff_ind, na.rm = TRUE),
            def_kickoff_wpa = sum(wpa * kickoff_ind, na.rm = TRUE),
            def_sacks_epa = sum(epa * sack, na.rm = TRUE),
            def_sacks_wpa = sum(wpa * sack, na.rm = TRUE),
            # Success rates:
            def_pass_run_sr = length(which(epa < 0 & pass_run_ind == 1)) / n_pass_run_plays,
            def_all_runs_sr = length(which(epa < 0 & 
                                         rush_attempt == 1 & 
                                         pass_run_ind == 1)) / n_all_runs,
            def_des_runs_sr = length(which(epa < 0 & 
                                         designed_run_ind == 1)) / n_designed_runs,
            def_dropback_sr = length(which(epa < 0 & qb_dropback == 1 &
                                         pass_run_ind == 1)) / n_dropbacks) %>%
  mutate(# Now the rate level statistics, first EPA based:
    def_epa_per_game = -1 * def_total_epa / n_games,
    def_epa_per_pass_run = -1 * def_pass_run_epa / n_pass_run_plays,
    def_epa_per_dropback = -1 * def_dropback_epa / n_dropbacks,
    def_epa_per_pass = -1 * def_pass_epa / n_pass_attempts,
    def_epa_per_all_run = -1 * def_all_run_epa / n_all_runs,
    def_epa_per_des_run = -1 * def_des_run_epa / n_designed_runs,
    def_air_epa_per_comp = -1 * def_total_comp_air_epa / n_completions,
    def_yac_epa_per_comp = -1 * def_total_comp_yac_epa / n_completions,
    def_epa_per_punt = -1 * def_punt_epa / n_punts,
    def_epa_per_ko = -1 * def_kickoff_epa / n_kickoffs,
    def_epa_per_sack = -1 * def_sacks_epa / n_sacks,
    # Now WPA based:
    def_wpa_per_game = -1 * def_total_wpa / n_games,
    def_wpa_per_pass_run = -1 * def_pass_run_wpa / n_pass_run_plays,
    def_wpa_per_dropback = -1 * def_dropback_wpa / n_dropbacks,
    def_wpa_per_pass = -1 * def_pass_wpa / n_pass_attempts,
    def_wpa_per_all_run = -1 * def_all_run_wpa / n_all_runs,
    def_wpa_per_des_run = -1 * def_des_run_wpa / n_designed_runs,
    def_air_wpa_per_comp = -1 * def_total_comp_air_wpa / n_completions,
    def_yac_wpa_per_comp = -1 * def_total_comp_yac_wpa / n_completions,
    def_wpa_per_punt = -1 * def_punt_wpa / n_punts,
    def_wpa_per_ko = -1 * def_kickoff_wpa / n_kickoffs,
    def_wpa_per_sack = -1 * def_sacks_wpa / n_sacks)

# Now using the the NFL logo images provided to us by Michael Lopez, we can
# also include the logos for each team on the plot rather than the team abbreviation:

# Install the ggimage package:
# install.packages("ggimage")
library(ggimage)

nfl_logo_url <- getURL("https://raw.githubusercontent.com/statsbylopez/BlogPosts/master/nfl_teamlogos.csv")
nfl_logos_df <- read_csv("https://raw.githubusercontent.com/statsbylopez/BlogPosts/master/nfl_teamlogos.csv")
scrimmage.plays.summary <- scrimmage.plays.summary %>% 
  left_join(df.logos, by = c("posteam" = "team_code"))

# Create the data frame to be used for all of the charts:
chart_summary_data <- offense_epa_18 %>%
  inner_join(defense_epa_18, by = c("posteam" = "defteam")) %>%
  left_join(nfl_logos_df, by = c("posteam" = "team_code"))

# ------------------------------------------------------------------------------

# Generate the same offensive and defensive EPA per game plot as Burke:
chart_summary_data %>%
  ggplot(aes(x = off_epa_per_game, y = def_epa_per_game)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive EPA per game",
       y = "Defensive EPA per game",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive EPA per game for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw() +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12))

# Now for all pass and run plays:
chart_summary_data %>%
  ggplot(aes(x = off_epa_per_pass_run, y = def_epa_per_pass_run)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive EPA per pass and run play",
       y = "Defensive EPA per pass and run play",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive EPA per pass and run plays for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw() +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12))

# Pass and run success rates:
chart_summary_data %>%
  ggplot(aes(x = off_pass_run_sr, y = def_pass_run_sr)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive success rate for pass and run plays",
       y = "Defensive success rate for pass and run plays",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive success rate for pass and run plays for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  geom_hline(yintercept = 0.5, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0.5, color = "red", linetype = "dashed") +
  theme_bw() +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12))

# Dropbacks:
chart_summary_data %>%
  ggplot(aes(x = off_epa_per_dropback, y = def_epa_per_dropback)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive EPA per dropback",
       y = "Defensive EPA per dropback",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive EPA per dropback for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw() +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12))

chart_summary_data %>%
  ggplot(aes(x = off_dropback_sr, y = def_dropback_sr)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive dropback success rate",
       y = "Defensive dropback success rate",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive dropback success rates for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  geom_hline(yintercept = 0.5, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0.5, color = "red", linetype = "dashed") +
  theme_bw() +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12))

# What about through the air?
chart_summary_data %>%
  ggplot(aes(x = off_air_epa_per_comp, y = def_air_epa_per_comp)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive air EPA per completion",
       y = "Defensive air EPA per completion",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive air EPA per completion for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw() +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12))

# Now yards after catch:
chart_summary_data %>%
  ggplot(aes(x = off_yac_epa_per_comp, y = def_yac_epa_per_comp)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive yac EPA per completion",
       y = "Defensive yac EPA per completion",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive yac EPA per completion for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  #geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  #geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw() +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12))

# Designed runs:
chart_summary_data %>%
  ggplot(aes(x = off_epa_per_des_run, y = def_epa_per_des_run)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive EPA per designed run",
       y = "Defensive EPA per designed run",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive EPA per designed run for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw() +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12))
chart_summary_data %>%
  ggplot(aes(x = off_des_runs_sr, y = def_des_runs_sr)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive designed run success rate",
       y = "Defensive designed run success rate",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive designed run success rates for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  geom_hline(yintercept = 0.5, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0.5, color = "red", linetype = "dashed") +
  theme_bw() +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12))


# Fun one - sacks:
chart_summary_data %>%
  ggplot(aes(x = off_epa_per_sack, y = def_epa_per_sack)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive EPA per sack",
       y = "Defensive EPA per sack",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive EPA per sack for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw() +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12))


# Special teams time, first punting:
chart_summary_data %>%
  ggplot(aes(x = off_epa_per_punt, y = def_epa_per_punt)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive EPA per punt",
       y = "Defensive EPA per punt",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive EPA per punt for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw() +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12))

# Kickoffs
chart_summary_data %>%
  ggplot(aes(x = off_epa_per_ko, y = def_epa_per_ko)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive EPA per kickoff",
       y = "Defensive EPA per kickoff",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive EPA per kickoff for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw() +
  theme(axis.title = element_text(size = 12),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 16),
        plot.subtitle = element_text(size = 14),
        plot.caption = element_text(size = 12))

