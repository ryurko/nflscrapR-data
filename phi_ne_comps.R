library(tidyverse)

team_game_passing_df <- read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/game_team_stats/game_passing_df.csv")
team_game_rushing_df <- read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/game_team_stats/game_rushing_df.csv")


# Group by each team, then arrange the weeks and add an index to count:
team_weekly_passing_2017 <- team_game_passing_df %>%
  filter(GameID > 2017010115) %>%
  group_by(Team) %>%
  arrange(Team, GameID) %>%
  mutate(Game = row_number())

team_weekly_rushing_2017 <- team_game_rushing_df %>%
  filter(GameID > 2017010115) %>%
  group_by(Team) %>%
  arrange(Team, GameID) %>%
  mutate(Game = row_number())

# Get the team colors:

library(teamcolors)
nfl_teamcolors <- teamcolors %>% filter(league == "nfl")
phi_color <- nfl_teamcolors %>%
  filter(name == "Philadelphia Eagles") %>%
  pull(primary)
ne_color <- nfl_teamcolors %>%
  filter(name == "New England Patriots") %>%
  pull(secondary)

ggplot(filter(team_weekly_passing_2017, !(Team %in% c("PHI", "NE"))),
       aes(x=Game,y=EPA_per_Att,group=Team)) + 
  geom_line(color="lightgray",alpha=.5) + 
  geom_line(data=filter(team_weekly_passing_2017, Team == "PHI"),
            aes(x=Game,y=EPA_per_Att),color=phi_color,size=1) + 
  geom_line(data=filter(team_weekly_passing_2017, Team == "NE"),
            aes(x=Game,y=EPA_per_Att),color=ne_color,size=1) + 
  geom_hline(yintercept=0,linetype="dashed",color="black") + 
  theme_bw() + ylab("Passing EPA per Attempt") +
  annotate("text",x=3, y= 1, label = "NE", color=ne_color) +
  annotate("text",x=3, y= -.25, label = "PHI", color=phi_color) +
  labs(title="Comparison of Philadelphia Eagles and New England Patriots Passing EPA per Attempt in 2017",
       caption = "Data from nflscrapR (Ron Yurko, Max Horowitz, Sam Ventura)\nDepartment of Statistics & Data Science, Carnegie Mellon University") 
  
ggplot(filter(team_weekly_rushing_2017, !(Team %in% c("PHI", "NE"))),
       aes(x=Game,y=EPA_per_Car,group=Team)) + 
  geom_line(color="lightgray",alpha=.5) + 
  geom_line(data=filter(team_weekly_rushing_2017, Team == "PHI"),
            aes(x=Game,y=EPA_per_Car),color=phi_color,size=1) + 
  geom_line(data=filter(team_weekly_rushing_2017, Team == "NE"),
            aes(x=Game,y=EPA_per_Car),color=ne_color,size=1) + 
  geom_hline(yintercept=0,linetype="dashed",color="black") + 
  theme_bw() + ylab("Rushing EPA per Attempt") +
  annotate("text",x=3, y= -.5, label = "NE", color=ne_color) +
  annotate("text",x=3, y= .5, label = "PHI", color=phi_color) +
  labs(title="Comparison of Philadelphia Eagles and New England Patriots Rushing EPA per Attempt in 2017",
       caption = "Data from nflscrapR (Ron Yurko, Max Horowitz, Sam Ventura)\nDepartment of Statistics & Data Science, Carnegie Mellon University") 

# Load the pbp data:

pbp_data <- bind_rows(read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2009.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2010.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2011.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2012.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2013.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2014.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2015.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2016.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2017.csv"))


# For each game group by the posteam and find the number of plays where the team 
# is leading in WP and how many plays:

posteam_wp_lead <- pbp_data %>%
  filter(Season == 2017, !is.na(posteam)) %>%
  group_by(GameID, posteam) %>%
  summarise(N_Leading_Off = length(which(Win_Prob > .5)),
            N_Plays_Off = n()) %>%
  rename(Team = posteam)

# Same for defense:

defteam_wp_lead <- pbp_data %>%
  filter(Season == 2017, !is.na(DefensiveTeam)) %>%
  group_by(GameID, DefensiveTeam) %>%
  summarise(N_Leading_Def = length(which(Win_Prob < .5)),
            N_Plays_Def = n()) %>%
  rename(Team = DefensiveTeam)

# Join the two together:
team_wp_lead <- posteam_wp_lead %>%
  left_join(defteam_wp_lead, by = c("GameID", "Team")) %>%
  ungroup() %>%
  group_by(Team) %>%
  arrange(GameID) %>%
  mutate(N_Leading = N_Leading_Off + N_Leading_Def,
         N_Plays = N_Plays_Off + N_Plays_Def,
         Leading_Perc = N_Leading / N_Plays,
         Game = row_number())

library(ggrepel)
ggplot(filter(team_wp_lead, !(Team %in% c("PHI", "NE"))),
       aes(x=Game,y=Leading_Perc,group=Team)) + 
  geom_line(color="lightgray",alpha=.5) + 
  geom_line(data=filter(team_wp_lead, Team == "PHI"),
            aes(x=Game,y=Leading_Perc),color=phi_color,size=1) + 
  geom_line(data=filter(team_wp_lead, Team == "NE"),
            aes(x=Game,y=Leading_Perc),color=ne_color,size=1) + 
  geom_hline(yintercept=.5,linetype="dashed",color="black") + 
  ylim(0, 1) +
  geom_point(data=filter(team_wp_lead, Team %in% c("PHI")),
                  aes(x = Game, y = Leading_Perc),
                  size = 1, color = phi_color) +
  geom_point(data=filter(team_wp_lead, Team %in% c("NE")),
             aes(x = Game, y = Leading_Perc),
             size = 1, color = ne_color) +
  geom_text_repel(data=filter(team_wp_lead, Team %in% c("NE", "PHI")),
            aes(label = round(Leading_Perc, digits = 4), y = Leading_Perc),
            size = 3) +
  theme_bw() + ylab("% of Plays Leading in Win Probability") +
  annotate("text",x=3, y= 1, label = "NE", color=ne_color, size = 5) +
  annotate("text",x=3, y= .25, label = "PHI", color=phi_color, size = 5) +
  labs(title="Comparison of Philadelphia Eagles and New England Patriots Win Probability Lead % in 2017",
       caption = "Data from nflscrapR (Ron Yurko, Max Horowitz, Sam Ventura)\nDepartment of Statistics & Data Science, Carnegie Mellon University") 

team_wp_lead_season <- team_wp_lead %>%
  ungroup() %>%
  group_by(Team) %>%
  summarise(N_Leading_Total = sum(N_Leading),
            N_Plays_Total = sum(N_Plays),
            Leading_Perc_Total = N_Leading_Total / N_Plays_Total) %>%
  arrange(Leading_Perc_Total) %>%
  mutate(Team = factor(Team, levels = Team[order(Leading_Perc_Total)]))

team_bar_colors <- rep("grey", 32)
team_bar_colors[which(team_wp_lead_season$Team == "PHI")] <- phi_color
team_bar_colors[which(team_wp_lead_season$Team == "NE")] <- ne_color

ggplot(team_wp_lead_season, aes(x = Team, y = Leading_Perc_Total, fill = Team)) + 
  geom_bar(stat = "identity") + scale_fill_manual(values = team_bar_colors,
                                                  guide = FALSE) + ylim(0,1) +
  geom_hline(yintercept = .5, linetype = "dashed", color = "black") + 
  geom_text(aes(label = round(Leading_Perc_Total, digits = 4), y = Leading_Perc_Total),
            size = 3, hjust =-1) +
  theme_bw() +  coord_flip() + 
  ylab("% of Plays Leading in Win Probability") +
  labs(title="Comparison of Teams with the Percentage of Plays Leading in Win Probability in 2017",
       caption = "Data from nflscrapR (Ron Yurko, Max Horowitz, Sam Ventura)\nDepartment of Statistics & Data Science, Carnegie Mellon University") 




