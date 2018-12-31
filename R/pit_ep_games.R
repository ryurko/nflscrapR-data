# Access tidyverse
# install.packages("tidyverse")
library(tidyverse)

# Let's work with season-level data this time, could use the 
# scrape_season_play_by_play() function to do this:
# pbp_18 <- scrape_season_play_by_play(2018)
# But this takes awhile, instead can directly access data I've already scraped:
pbp_18 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2018.csv")


# Access nflscrapR and get the Steelers game ids:
library(nflscrapR)
pit_games <- scrape_game_ids(2018, teams = "PIT")

# Steelers' play-by-play:
pit_pbp_18 <- pbp_18 %>%
  filter(game_id %in% pit_games$game_id)

# Access the team colors
data("nflteams")
scale_fill_manual(values = sapply(epa_passer_db_teams, function(x) nflteams$primary[which(nflteams$abbr == x)]), 
                  guide = FALSE)

# Get Steelers primary color:
pit_primary_color <- nflteams %>% 
  filter(abbr == "PIT") %>%
  pull(primary)

# View the distribution of Steelers and their opponents EPA for every game only
# on pass and run plays:
pit_pbp_18 %>%
  filter(!is.na(posteam),
         play_type %in% c("pass", "run")) %>%
  mutate(pit_home = if_else(home_team == "PIT", TRUE, FALSE),
         game_id_team = if_else(pit_home,
                                paste0(game_date, ": vs ", away_team),
                                paste0(game_date, ": at ", home_team))) %>%
    ggplot(aes(x = epa, fill = posteam, color = posteam)) +
    geom_density(alpha = 0.3) +
    geom_rug(alpha = 0.7, size = 2) +
    scale_fill_manual(values = sapply(unique(pit_pbp_18$posteam[which(!is.na(pit_pbp_18$posteam))]), 
                                      function(x) {
                                        ifelse(x != "PIT" & 
                                                 nflteams$primary[which(nflteams$abbr == x)] == pit_primary_color,
                                               nflteams$secondary[which(nflteams$abbr == x)],
                                               nflteams$primary[which(nflteams$abbr == x)])
                                        }), 
                      guide = FALSE) +
    scale_color_manual(values = sapply(unique(pit_pbp_18$posteam[which(!is.na(pit_pbp_18$posteam))]), 
                                      function(x) {
                                        ifelse(x != "PIT" & 
                                                 nflteams$primary[which(nflteams$abbr == x)] == pit_primary_color,
                                               nflteams$secondary[which(nflteams$abbr == x)],
                                               nflteams$primary[which(nflteams$abbr == x)])
                                      }), 
                      guide = FALSE) +
    facet_wrap(~ game_id_team, ncol = 4) + 
    labs(x = "Expected points added",
         y = "Density",
         title = "Comparison of EPA distributions on all pass and run plays in Pittsburgh Steelers 2018 season",
         caption = "Data from `nflscrapR`; colors courtesy of `teamcolors`") +
      theme_bw() +
      theme(axis.title = element_text(size = 14),
            axis.text = element_text(size = 14),
            plot.title = element_text(size = 16),
            plot.caption = element_text(size = 12),
            strip.background = element_blank(),
            strip.text = element_text(size = 12))
         