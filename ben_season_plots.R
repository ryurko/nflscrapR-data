library(tidyverse)
library(ggplot2)
library(grid)

# Use the calc_passing_splits() function to
# generate team and season level stats

# Add Season and Month columns:
game_passing_df <- dplyr::mutate(game_passing_df,
                         Season = as.numeric(substr(as.character(GameID),1,4)),
                         Month = as.numeric(substr(as.character(GameID),5,6)))
# Change the season based on the month:
game_passing_df$Season <- ifelse(game_passing_df$Month < 4, game_passing_df$Season - 1,
                                 game_passing_df$Season)

# Find the home team for each game then join to the data:
game_home_away_df <- pbp_data %>% group_by(GameID) %>% summarise(HomeTeam = first(HomeTeam),
                                                                 AwayTeam = first(AwayTeam))

# Left join to dataset then make an indicator if player's team was home:
game_passing_df <- game_passing_df %>% left_join(game_home_away_df,by="GameID") %>%
  mutate(HomeGame = ifelse(Team == HomeTeam,1,0))

# Ben's 2016 season by game:

ben_game_passing <- game_passing_df %>% filter(Player_Name == "B.Roethlisberger")

# Group by Season and add a Week column:
ben_game_passing <- ben_game_passing %>% group_by(Season) %>% mutate(Game_Number = 1:n()) %>% ungroup()


ggplot(filter(ben_game_passing,Season==2016), aes(x=Game_Number,y=EPA_per_Att,group=1)) + 
  geom_line(linetype="dashed") +
  geom_text(aes(label=Opponent,color=as.factor(HomeGame)), size=8) + scale_x_continuous(breaks=1:14) +
  ylab("Expected Points Added per Pass Attempt") + xlab("Game Number") +
  geom_hline(yintercept=0,color="red") +
  labs(title="Big Ben's EPA per Pass Attempt during the 2016 Season",
       caption = "Data from nflscrapR (Ron Yurko, Max Horowitz, Sam Ventura)\nDepartment of Statistics, Carnegie Mellon University") +
  theme(panel.grid.minor = element_blank(),panel.grid.major.x = element_blank(),
        panel.background = element_blank(), panel.border = element_blank(),
        plot.title = element_text(size=20,face = 2),
        plot.subtitle = element_text(size=16),
        axis.title.x = element_text(size=14),
        axis.title.y = element_text(size=14),
        axis.text.x = element_text(size=12),
        axis.text.y = element_text(size=12)) +
  scale_color_brewer(palette = "Set1",
                     labels = c("Away","Home")) + guides(color = guide_legend(title=NULL))


ggplot(filter(ben_game_passing,Season==2015), aes(x=Game_Number,y=EPA_per_Att,group=1)) + 
  geom_line(linetype="dashed") +
  geom_text(aes(label=Opponent,color=as.factor(HomeGame)), size=8) + scale_x_continuous(breaks=1:14) +
  ylab("Expected Points Added per Pass Attempt") + xlab("Game Number") +
  geom_hline(yintercept=0,color="red") +
  labs(title="Big Ben's EPA per Pass Attempt during the 2015 Season",
       caption = "Data from nflscrapR (Ron Yurko, Max Horowitz, Sam Ventura)\nDepartment of Statistics, Carnegie Mellon University") +
  theme(panel.grid.minor = element_blank(),panel.grid.major.x = element_blank(),
        panel.background = element_blank(), panel.border = element_blank(),
        plot.title = element_text(size=20,face = 2),
        plot.subtitle = element_text(size=16),
        axis.title.x = element_text(size=14),
        axis.title.y = element_text(size=14),
        axis.text.x = element_text(size=12),
        axis.text.y = element_text(size=12)) +
  scale_color_brewer(palette = "Set1",
                     labels = c("Away","Home")) + guides(color = guide_legend(title=NULL))

  


