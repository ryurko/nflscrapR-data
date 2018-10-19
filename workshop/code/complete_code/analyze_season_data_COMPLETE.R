# Next using the devtools package, install `nflscrapR` from GitHub:
# devtools::install_github(repo = "maksimhorowitz/nflscrapR")

# Load the package:
library(nflscrapR)

# Access tidyverse
# install.packages("tidyverse")
library(tidyverse)

# Let's work with season-level data this time, could use the 
# scrape_season_play_by_play() function to do this:
# pbp_18 <- scrape_season_play_by_play(2018)
# But this takes awhile, instead can directly access data I've already scraped:
pbp_18 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2018.csv")

# Let's recreate the figure Brian Burke tweets out, with team EPA per game. 
# We'll first do this for the offense:
offense_epa_18 <- pbp_18 %>%
  filter(!is.na(posteam)) %>%
  group_by(posteam) %>%
  summarise(n_games = length(unique(game_id)),
            off_total_epa = sum(epa, na.rm = TRUE)) %>%
  mutate(off_epa_per_game = off_total_epa / n_games)

# Now for defense:
defense_epa_18 <- pbp_18 %>%
  filter(!is.na(defteam)) %>%
  group_by(defteam) %>%
  summarise(n_games = length(unique(game_id)),
            def_total_epa = sum(epa, na.rm = TRUE)) %>%
  # This time multiply by -1, since negative values are better for defense:
  mutate(def_epa_per_game = -1 * def_total_epa / n_games)

# We can now join the two together, then simply plot the team abbreviations:
offense_epa_18 %>%
  inner_join(defense_epa_18, by = c("posteam" = "defteam")) %>%
  ggplot(aes(x = off_epa_per_game, y = def_epa_per_game)) +
  geom_text(aes(label = posteam)) +
  labs(x = "Offensive EPA per game",
       y = "Defensive EPA per game",
       caption = "Data from nflscrapR") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw()

# Great package to use for this plot is ggrepel,
# install.packages("ggrepel")
library(ggrepel)
offense_epa_18 %>%
  inner_join(defense_epa_18, by = c("posteam" = "defteam")) %>%
  ggplot(aes(x = off_epa_per_game, y = def_epa_per_game)) +
  geom_point() +
  geom_text_repel(aes(label = posteam)) +
  labs(x = "Offensive EPA per game",
       y = "Defensive EPA per game",
       caption = "Data from nflscrapR") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw()


# Let's focus on some ways of measuring QB performance, one popular
# EPA-based metric is the Success Rate. This is simply the percentage
# of plays with positive EPA. We'll focus on QBs and compare their EPA per
# dropback against their dropback success rate:
pbp_18 %>%
  filter(qb_dropback == 1) %>%
  group_by(passer_player_id) %>%
  summarise(n_dropbacks = n(),
            total_epa = sum(epa, na.rm = TRUE),
            n_positive_epa = length(which(epa > 0)),
            epa_per_dropback = total_epa / n_dropbacks,
            success_rate = n_positive_epa / n_dropbacks,
            # Get the QB name:
            qb_name = first(passer_player_name)) %>%
  ggplot(aes(x = success_rate, y = epa_per_dropback)) +
  geom_point() +
  geom_text_repel(aes(label = qb_name)) +
  theme_bw() +
  labs(x = "Success Rate (% of dropbacks with EPA > 0)",
       y = "EPA per dropback",
       caption = "Data from nflscrapR")

# Well we have all those trick-plays there! Let's look at the distribution
# of dropbacks:
pbp_18 %>%
  filter(qb_dropback == 1) %>%
  group_by(passer_player_id) %>%
  summarise(n_dropbacks = n()) %>%
  ggplot(aes(x = n_dropbacks)) +
  geom_histogram() +
  theme_bw() +
  labs(x = "Number of dropbacks",
       caption = "Data from nflscrapR")

# Let's make the cutoff 100 dropbacks:
pbp_18 %>%
  filter(qb_dropback == 1) %>%
  filter(!is.na(passer_player_id)) %>%
  group_by(passer_player_id) %>%
  summarise(n_dropbacks = n(),
            total_epa = sum(epa, na.rm = TRUE),
            n_positive_epa = length(which(epa > 0)),
            epa_per_dropback = total_epa / n_dropbacks,
            success_rate = n_positive_epa / n_dropbacks,
            # Get the QB name:
            qb_name = first(passer_player_name)) %>%
  filter(n_dropbacks >= 100) %>%
  ggplot(aes(x = success_rate, y = epa_per_dropback)) +
  geom_point() +
  geom_text_repel(aes(label = qb_name)) +
  # Add reference lines:
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0.5, color = "red", linetype = "dashed") +
  geom_smooth(method = "lm") + 
  theme_bw() +
  labs(x = "Success Rate (% of dropbacks with EPA > 0)",
       y = "EPA per dropback",
       caption = "Data from nflscrapR")


# -----------------------------------------------------------------------------
# OPTIONAL PART FOR THOSE CURIOUS ABOUT SUCCESS RATE DEFINITION:
# Maybe there's a problem with this definition of success rate - what about
# the fractional values close to 0? Do we really care about those? Let's 
# look at the EPA distribution for these dropbacks:
pbp_18 %>%
  filter(qb_dropback == 1) %>%
  filter(!is.na(passer_player_id)) %>%
  ggplot(aes(x = epa)) +
  geom_histogram() + 
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw() +
  labs(x = "EPA on dropbacks") +
  # Additionally, could subset to only look at the range between -0.01 and 0.01:
  scale_x_continuous(limits = c(-0.05, 0.05))
 
pbp_18 %>%
  filter(qb_dropback == 1) %>%
  filter(!is.na(passer_player_id)) %>% 
  group_by(passer_player_id) %>%
  summarise(n_dropbacks = n(),
            total_epa = sum(epa, na.rm = TRUE),
            n_positive_epa = length(which(epa > 0.05)),
            epa_per_dropback = total_epa / n_dropbacks,
            success_rate = n_positive_epa / n_dropbacks,
            # Get the QB name:
            qb_name = first(passer_player_name)) %>%
  filter(n_dropbacks >= 100) %>%
  ggplot(aes(x = success_rate, y = epa_per_dropback)) +
  geom_point() +
  geom_text_repel(aes(label = qb_name)) +
  # Add reference lines:
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0.5, color = "red", linetype = "dashed") +
  geom_smooth(method = "lm") + 
  theme_bw() +
  labs(x = "Success Rate (% of dropbacks with EPA > 0.05)",
       y = "EPA per dropback",
       caption = "Data from nflscrapR")
# -----------------------------------------------------------------------------

# But wait, each passing play is made up of air yards and yards after catch -
# and nflscrapR actually estimates the EPA and WPA for both! Let's plot the 
# QB air and yac EPA per completion on x and y axis, maybe there's some
# structure...

# First look at the distribution of the number of completions:
pbp_18 %>%
  filter(complete_pass == 1) %>%
  group_by(passer_player_id) %>%
  summarise(n_completions = n()) %>%
  ggplot(aes(x = n_completions)) +
  geom_histogram() +
  theme_bw() +
  labs(x = "Number of completions",
       caption = "Data from nflscrapR")

pbp_18 %>%
  filter(complete_pass == 1) %>%
  filter(!is.na(passer_player_id)) %>% 
  group_by(passer_player_id) %>%
  summarise(n_completions = n(),
            total_air_epa = sum(air_epa, na.rm = TRUE),
            total_yac_epa = sum(yac_epa, na.rm = TRUE),
            air_epa_per_comp = total_air_epa / n_completions,
            yac_epa_per_comp = total_yac_epa / n_completions,
            # Get the QB name:
            qb_name = first(passer_player_name)) %>%
  filter(n_completions >= 25) %>%
  ggplot(aes(x = yac_epa_per_comp, y = air_epa_per_comp)) +
  geom_point() +
  geom_text_repel(aes(label = qb_name)) +
  # Add reference lines:
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw() +
  labs(x = "YAC EPA per completion",
       y = "air EPA per completion",
       caption = "Data from nflscrapR",
       title = "air EPA and YAC EPA per completion for QBs in 2018 season",
       subtitle = "Minimum of 25 completions")

# We're not just limited to QBs, can do the same for receivers!
pbp_18 %>%
  filter(complete_pass == 1) %>%
  filter(!is.na(receiver_player_id)) %>% 
  group_by(receiver_player_id) %>%
  summarise(n_receptions = n(),
            total_air_epa = sum(air_epa, na.rm = TRUE),
            total_yac_epa = sum(yac_epa, na.rm = TRUE),
            air_epa_per_rec = total_air_epa / n_receptions,
            yac_epa_per_rec = total_yac_epa / n_receptions,
            # Get the receiver name:
            rec_name = first(receiver_player_name)) %>%
  filter(n_receptions >= 20) %>%
  ggplot(aes(x = yac_epa_per_rec, y = air_epa_per_rec)) +
  geom_point() +
  geom_text_repel(aes(label = rec_name)) +
  # Add reference lines:
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw() +
  labs(x = "YAC EPA per reception",
       y = "air EPA per reception",
       caption = "Data from nflscrapR",
       title = "air EPA and YAC EPA per reception in 2018 season",
       subtitle = "Minimum of 20 receptions")

# How about running back success rate?
pbp_18 %>%
  filter(rush_attempt == 1) %>%
  filter(!is.na(rusher_player_id)) %>% 
  group_by(rusher_player_id) %>%
  summarise(n_rushes = n(),
            total_epa = sum(epa, na.rm = TRUE),
            n_positive_epa = length(which(epa > 0)),
            epa_per_rush = total_epa / n_rushes,
            success_rate = n_positive_epa / n_rushes,
            # Get the rusher name:
            rusher_name = first(rusher_player_name)) %>%
  filter(n_rushes >= 50) %>%
  ggplot(aes(x = success_rate, y = epa_per_rush)) +
  geom_point() +
  geom_text_repel(aes(label = rusher_name)) +
  # Add reference lines:
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0.5, color = "red", linetype = "dashed") +
  geom_smooth(method = "lm") + 
  theme_bw() +
  labs(x = "Success Rate (% of rushes with EPA > 0)",
       y = "EPA per rush",
       caption = "Data from nflscrapR")

# ----------------------------------------------------------------------------
# Can look at other seasons going back to 2009 by replacing the year in
# the following code:
# pbp_X <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2018.csv")

