# Purpose: Calculate the frequencies teams went for it correctly based on the 
#          NYT 4th down bot. Borrow code from: https://github.com/statsbylopez/nfl-fourth-down/blob/master/Code/Data%20Wrangling.Rmd

# Access tidyverse:
library(tidyverse)

# Join together the regular season play-by-play data including a column to 
# denote the season from 2009 to 2017:
fourth_down_plays <- map_dfr(c(2009:2018),
                    function(x) {
                      read_csv(paste0("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_",
                                      x, ".csv")) %>%
                        mutate(pbp_season = x) %>%
                        select(-fumble_recovery_2_player_id, -fumble_recovery_2_yards, -blocked_player_id)
                    }) %>%
  dplyr::select(posteam, defteam, yardline_100, ydstogo, down, play_type, wp,
                pbp_season) %>%
  filter(down == 4, !(play_type %in% c("no_play", "qb_spike", "qb_kneel"))) %>%
  mutate(went_for_it = as.numeric(play_type %in% c("pass", "run")),
         cap_ydstogo = ifelse(ydstogo >= 10, 10, ydstogo))


# Next borrow the code exactly from Lopez's example to join the NYT info:
df_goforit <- expand.grid(yardline_100_from_own_goal = 1:99, ydstogo = 1:10)
df_goforit <- df_goforit %>%
  mutate(coaches_should = "punt")
df_goforit <- df_goforit %>%
  mutate(
    coaches_should = ifelse((ydstogo == 1), "Go for it", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 28 & ydstogo == 2), "Go for it", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 41 & yardline_100_from_own_goal <=80 & ydstogo == 3), "Go for it", coaches_should), 
    coaches_should = ifelse((yardline_100_from_own_goal > 80 & yardline_100_from_own_goal <=96 & ydstogo == 3), "FG", coaches_should), 
    coaches_should = ifelse((yardline_100_from_own_goal > 96 & ydstogo == 3), "Go for it", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 45 & yardline_100_from_own_goal <=72 & ydstogo == 4), "Go for it", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 72 & ydstogo == 4), "FG", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 50 & yardline_100_from_own_goal <=68 & ydstogo == 5), "Go for it", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 68 & ydstogo == 5), "FG", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 53 & yardline_100_from_own_goal <= 67 & ydstogo == 6), "Go for it", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 67 & ydstogo == 6), "FG", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 59 & yardline_100_from_own_goal <= 65 & ydstogo == 7), "Go for it", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 65 & ydstogo == 7), "FG", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 59 & yardline_100_from_own_goal <=64 & ydstogo == 8), "Go for it", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 64 & ydstogo == 8), "FG", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 62 & yardline_100_from_own_goal <=65 & ydstogo == 9), "Go for it", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 65 & ydstogo == 9), "FG", coaches_should),
    coaches_should = ifelse((yardline_100_from_own_goal > 63 & ydstogo == 10), "FG", coaches_should)
  )
df_goforit <- df_goforit %>% 
  filter(yardline_100_from_own_goal + ydstogo <= 100 & yardline_100_from_own_goal + ydstogo >= 10)

# Now join to the fourth-down plays with the go for it:
fourth_down_plays <- fourth_down_plays %>%
  mutate(yardline_100_from_own_goal = 100 - yardline_100) %>%
  inner_join(df_goforit, by = c("yardline_100_from_own_goal", "cap_ydstogo" = "ydstogo"))

# Combine JAC and JAX as well as SD and LAC:
fourth_down_plays <- fourth_down_plays %>%
  mutate(posteam = ifelse(posteam == "JAC", "JAX", posteam),
         defteam = ifelse(defteam == "JAC", "JAX", defteam),
         posteam = ifelse(posteam == "SD", "LAC", posteam),
         defteam = ifelse(defteam == "SD", "LAC", defteam))

# Generate Baldwin plot:
fourth_down_plays %>%
  filter(coaches_should == "Go for it",
         pbp_season >= 2016, ydstogo <= 5,
         wp >= .2 & wp <= .8) %>%
  group_by(posteam) %>%
  summarize(went_for_it_perc = mean(went_for_it)) %>%
  ungroup() %>%
  mutate(posteam = fct_reorder(posteam, went_for_it_perc)) %>%
  ggplot(aes(x = posteam, y = went_for_it_perc)) +
  geom_bar(stat = "identity") +
  theme_bw() +
  coord_flip() +
  labs(y = "Proportion of 4th down plays team went for it in NYT-recommended spots",
       x = "Team",
       title = "4th down go rate in NYT-recommended spots, 2016-18",
       subtitle = "5 or fewer yards to go, win probability between 20% and 80%",
       caption = "Data via nflscrapR")

write_csv(fourth_down_plays, "fourth_down_plays.csv")
fourth_down_plays <- read_csv("fourth_down_plays.csv")

# Change STL to LA:
fourth_down_plays <- fourth_down_plays %>%
  mutate(posteam = ifelse(posteam == "STL", "LA", posteam),
         defteam = ifelse(defteam == "STL", "LA", defteam))

library(ggrepel)

nflteams <- nflscrapR::nflteams %>%
  filter(abbr %in% unique(fourth_down_plays$posteam)) %>%
  # Modify Oakland primary color:
  mutate(primary = ifelse(abbr %in% c("OAK", "PIT", "SEA", "TEN",
                                         "JAX", "NE", "ATL"), 
                          secondary, primary))

# Create a dataset that has summaries of each team based on the final season
# to highlight for each division:
team_2018_summary <-
  fourth_down_plays %>%
  filter(coaches_should == "Go for it",
         pbp_season == 2018) %>%
  group_by(posteam) %>%
  summarize(went_for_it_perc = mean(went_for_it)) %>%
  ungroup() %>%
  inner_join(nflteams, by = c("posteam" = "abbr")) %>%
  arrange(desc(went_for_it_perc)) 


division_plots <- lapply(sort(unique(team_2018_summary$division)),
                         function(nfl_division) {
                           
                           division_teams <- team_2018_summary %>%
                             filter(division == nfl_division) %>%
                             mutate(posteam = fct_reorder(posteam, desc(went_for_it_perc)))
                           
                           plot_data <- fourth_down_plays %>%
                             filter(coaches_should == "Go for it",
                                    posteam %in% division_teams$posteam) %>%
                             group_by(posteam, pbp_season) %>%
                             summarize(went_for_it_perc = mean(went_for_it)) %>%
                             ungroup() %>%
                             mutate(posteam = factor(posteam,
                                                     levels = levels(division_teams$posteam))) %>%
                             mutate(team_label = if_else(pbp_season == max(pbp_season),
                                                         as.character(posteam), 
                                                         NA_character_))
                             
                           
                           fourth_down_plays %>%
                             filter(coaches_should == "Go for it") %>%
                             group_by(posteam, pbp_season) %>%
                             summarize(went_for_it_perc = mean(went_for_it)) %>%
                             ungroup() %>%
                             filter(!(posteam %in% division_teams$posteam)) %>%
                             ggplot(aes(x = pbp_season, y = went_for_it_perc, group = posteam)) +
                             geom_line(color = "gray", alpha = 0.5) +
                             geom_line(data = plot_data,
                                       aes(x = pbp_season, y = went_for_it_perc, group = posteam,
                                           color = posteam)) +
                             geom_label_repel(data = plot_data,
                                              aes(label = team_label,
                                                  color = posteam), nudge_x = 1, na.rm = TRUE,
                                              direction = "y") +
                             scale_color_manual(values = division_teams$primary, guide = FALSE) +
                             scale_x_continuous(limits = c(2009, 2019),
                                                breaks = c(2009:2018)) +
                             scale_y_continuous(limits = c(0, .65)) +
                             theme_bw() +
                             labs(x = "Year", y = "Went for it %",
                                  title = paste0("Division: ", nfl_division)) 
                           
                         })

library(cowplot)

plot_grid(plotlist = division_plots, ncol = 4, align = "hv")



smooth_end_division_plots <- lapply(sort(unique(team_2018_summary$division)),
                                function(nfl_division) {
                                  division_teams <- team_2018_summary %>%
                                    filter(division == nfl_division) %>%
                                    mutate(posteam = fct_reorder(posteam, desc(went_for_it_perc)))
                                  
                                  plot_data <- fourth_down_plays %>%
                                    filter(coaches_should == "Go for it",
                                           posteam %in% division_teams$posteam) %>%
                                    inner_join(nflteams, by = c("posteam" = "abbr")) %>%
                                    group_by(posteam, pbp_season) %>%
                                    summarize(went_for_it_perc = mean(went_for_it),
                                              team_color = first(primary)) %>%
                                    ungroup() %>%
                                    mutate(posteam = factor(posteam,
                                                            levels = levels(division_teams$posteam))) %>%
                                    mutate(team_label = if_else(pbp_season == max(pbp_season),
                                                                as.character(posteam), 
                                                                NA_character_))
                                  
                                  label_info <-
                                    split(plot_data, plot_data$posteam) %>%
                                    lapply(function(team_data){
                                      data.frame(
                                        final_pred = loess(went_for_it_perc ~ pbp_season, 
                                                          span = 0.8, data = team_data) %>%
                                          predict(newdata = data.frame(pbp_season = 2018)), 
                                        max = 2018,
                                        team = team_data$posteam[1],
                                        team_color = team_data$team_color[1]
                                      )}) %>%
                                    bind_rows
                                  
                                  
                                  fourth_down_plays %>%
                                    filter(coaches_should == "Go for it") %>%
                                    group_by(posteam, pbp_season) %>%
                                    summarize(went_for_it_perc = mean(went_for_it)) %>%
                                    ungroup() %>%
                                    filter(!(posteam %in% division_teams$posteam)) %>%
                                    ggplot(aes(x = pbp_season, y = went_for_it_perc, group = posteam)) +
                                    geom_smooth(color = "gray91", 
                                                size = .75, se = FALSE) +
                                    geom_point(data = plot_data,
                                               aes(x = pbp_season, y = went_for_it_perc, 
                                                   color = posteam), alpha = .75) +
                                    geom_smooth(data = plot_data,
                                                aes(x = pbp_season, y = went_for_it_perc, group = posteam,
                                                    color = posteam,
                                                    linetype = posteam), se = FALSE,
                                                method = "loess", span = 0.8) +
                                    scale_color_manual(values = division_teams$primary) +
                                    scale_x_continuous(breaks = c(2009:2018),
                                                       expand = c(0, 0)) +
                                    scale_y_continuous(limits = c(0, .65),
                                                       sec.axis = sec_axis(~ .,
                                                                           breaks = label_info$final_pred,
                                                                           labels = label_info$team)) +
                                    theme_bw() +
                                    labs(x = "Year", y = "Went for it %",
                                         color = "Team",
                                         linetype = "Team",
                                         title = paste0("Division: ", nfl_division)) +
                                    guides(color = guide_legend(override.aes = list(size = 1.5))) +
                                    theme(legend.position = c(.4, .85),
                                          legend.direction = "horizontal",
                                          legend.background = element_blank(),
                                          legend.text = element_text(size = 8),
                                          legend.title = element_blank(),
                                          axis.ticks.y.right = element_blank(),
                                          axis.text.y.right = element_text(color = label_info$team_color))
                                  
                                })

plot_grid(plotlist = smooth_end_division_plots, ncol = 4, align = "hv")

