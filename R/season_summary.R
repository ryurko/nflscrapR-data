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

# Now using the the NFL logo images provided to us by Michael Lopex, we can
# also include the logos for each team on the plot rather than the team abbreviation:

# Install the ggimage package:
# install.packages("ggimage")
library(ggimage)

nfl_logo_url <- getURL("https://raw.githubusercontent.com/statsbylopez/BlogPosts/master/nfl_teamlogos.csv")
nfl_logos_df <- read_csv("https://raw.githubusercontent.com/statsbylopez/BlogPosts/master/nfl_teamlogos.csv")
scrimmage.plays.summary <- scrimmage.plays.summary %>% 
  left_join(df.logos, by = c("posteam" = "team_code"))

# Now generate the same plot as Burke:
offense_epa_18 %>%
  inner_join(defense_epa_18, by = c("posteam" = "defteam")) %>%
  left_join(nfl_logos_df, by = c("posteam" = "team_code")) %>%
  ggplot(aes(x = off_epa_per_game, y = def_epa_per_game)) +
  geom_image(aes(image = url), size = 0.05) +
  labs(x = "Offensive EPA per game",
       y = "Defensive EPA per game",
       caption = "Data from nflscrapR",
       title = "Offensive and Defensive EPA per game for each team",
       subtitle = "Through week 7 of 2018 NFL season") +
  geom_hline(yintercept = 0, color = "red", linetype = "dashed") +
  geom_vline(xintercept = 0, color = "red", linetype = "dashed") +
  theme_bw()


