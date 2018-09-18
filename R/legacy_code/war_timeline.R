# Look at the Le'Veon Bell's career using WAR

# Access the necessary packages:
# install.packages("tidyverse")
library(tidyverse)

# Load RB WPA based WAR tables from 2013 to 2017, following Bell's career:
rb_war_df <- map_dfr(c(13:17), 
                     function(x) {
                       suppressMessages(read_csv(paste("https://raw.github.com/ryurko/nflscrapR-data/master/data/war_stats/season_estimates/wpa_based/rb_tables/rb_war_",
                                         x, ".csv", sep = ""))) %>%
                         mutate(Season = x)
                       })

# Load the QB and WR tables as well:
qb_war_df <- map_dfr(c(13:17), 
                     function(x) {
                       suppressMessages(read_csv(paste("https://raw.github.com/ryurko/nflscrapR-data/master/data/war_stats/season_estimates/wpa_based/qb_tables/qb_war_",
                                                       x, ".csv", sep = ""))) %>%
                         mutate(Season = x)
                     })

wr_war_df <- map_dfr(c(13:17), 
                     function(x) {
                       suppressMessages(read_csv(paste("https://raw.github.com/ryurko/nflscrapR-data/master/data/war_stats/season_estimates/wpa_based/wr_tables/wr_war_",
                                                       x, ".csv", sep = ""))) %>%
                         mutate(Season = x)
                     })

# Use the teamcolors package to get the team colors for NFL teams:
# install.packages("teamcolors")
library(teamcolors)
nfl_teamcolors <- teamcolors %>%
  filter(league == "nfl")

pit_primary_color <- nfl_teamcolors %>%
  filter(name == "Pittsburgh Steelers") %>%
  pull(primary)

pit_secondary_color <- nfl_teamcolors %>%
  filter(name == "Pittsburgh Steelers") %>%
  pull(secondary)


# Now grab Le'Veon Bell's WAR from the table:

bell_war_df <- rb_war_df %>%
  filter(Player_ID_Name == "L.Bell-00-0030496") %>%
  select(Player_ID_Name, total_WAR, Season) %>%
  mutate(Player_ID_Name = str_sub(Player_ID_Name, 1, nchar(Player_ID_Name) -11))


# Grab Brown's WAR:
brown_war_df <- wr_war_df %>%
  filter(Player_ID_Name == "A.Brown-00-0027793")  %>%
  select(Player_ID_Name, total_WAR, Season) %>%
  mutate(Player_ID_Name = str_sub(Player_ID_Name, 1, nchar(Player_ID_Name) -11))

# Grab Ben's WAR:
ben_war_df <- qb_war_df %>%
  filter(Player_ID_Name == "B.Roethlisberger-00-0022924")  %>%
  select(Player_ID_Name, total_WAR, Season) %>%
  mutate(Player_ID_Name = str_sub(Player_ID_Name, 1, nchar(Player_ID_Name) -11))

# Stack the data:
pit_war_df <- bell_war_df %>%
  bind_rows(brown_war_df, ben_war_df) %>%
  mutate(Season = 2000 + Season)

# Now league averages:
rb_average_df <- rb_war_df %>%
  group_by(Season) %>%
  summarise(league_war = mean(total_WAR, na.rm = TRUE)) %>%
  mutate(`League Average` = "RB")

wr_average_df <- wr_war_df %>%
  group_by(Season) %>%
  summarise(league_war = mean(total_WAR, na.rm = TRUE)) %>%
  mutate(`League Average` = "WR")

qb_average_df <- qb_war_df %>%
  group_by(Season) %>%
  summarise(league_war = mean(total_WAR, na.rm = TRUE)) %>%
  mutate(`League Average` = "QB")

nfl_average_df <- rb_average_df %>%
  bind_rows(wr_average_df, qb_average_df) %>%
  mutate(Season = 2000 + Season)

# Find overall averages for each position:
rb_average_war <- rb_war_df %>%
  summarise(league_war = mean(total_WAR, na.rm = TRUE)) %>%
  pull(league_war)

qb_average_war <- qb_war_df %>%
  summarise(league_war = mean(total_WAR, na.rm = TRUE)) %>%
  pull(league_war)

wr_average_war <- wr_war_df %>%
  summarise(league_war = mean(total_WAR, na.rm = TRUE)) %>%
  pull(league_war)



# Create timeline points to include:

# Grab Deangelo Williams WAR in 2015:
williams_war_df <- rb_war_df %>%
  filter(Player_ID_Name == "De.Williams-00-0024242", Season == 15) %>%
  select(Player_ID_Name, total_WAR, Season) %>%
  mutate(Player_ID_Name = str_sub(Player_ID_Name, 1, nchar(Player_ID_Name) -11))

# Grab JuJu's WAR in 2017:
juju_war_df <- wr_war_df %>%
  filter(Player_ID_Name == "J.Smith-Schuster-00-0033857", Season == 17)  %>%
  select(Player_ID_Name, total_WAR, Season) %>%
  mutate(Player_ID_Name = str_sub(Player_ID_Name, 1, nchar(Player_ID_Name) -11))

# Join these together with additional key points for Bell's rookie season
# and Brown leading the NFL in receptions and receiving yards

key_points_df <- data.frame(Player_ID_Name = c("None", "None"),
                            Season = c(13, 14),
                            total_WAR = c(pull(filter(bell_war_df, Season == 13),
                                             total_WAR),
                                          pull(filter(brown_war_df, Season == 14),
                                               total_WAR))) %>%
  bind_rows(williams_war_df, juju_war_df) %>%
  mutate(Season = 2000 + Season,
         Label = c("Bell's WAR in\nrookie season",
                   "Brown leads NFL in\nreceptions and\nreceiving yards",
                   "Williams' WAR\n filling in for Bell",
                   "JuJu's WAR in\nrookie season"))

# Now create the timeline plot comparing the three stars of the Steelers,
# showing how they compare throughout Le'Veon Bell's career:

library(grid)
library(ggrepel)

killer_b_timeline <- ggplot(filter(pit_war_df, Player_ID_Name != "L.Bell"), aes(x = Season, y = total_WAR)) + 
  geom_segment(x = 2013, xend = 2017, y = qb_average_war, yend = qb_average_war, color = "darkblue", size = 2) + 
  geom_segment(x = 2013, xend = 2017, y = wr_average_war, yend = wr_average_war, color = "darkgray", size = 2) + 
  geom_segment(x = 2013, xend = 2017, y = rb_average_war, yend = rb_average_war, color = "darkred", size = 2) + 
  geom_line(aes(linetype = Player_ID_Name), color = pit_primary_color, size = 2) +

  geom_line(data = filter(pit_war_df, Player_ID_Name == "L.Bell"), aes(x = Season, y = total_WAR),
            color = pit_secondary_color, size = 2) +
  geom_point(data = key_points_df, aes(x = Season, y = total_WAR), color = pit_primary_color,
             size = 5) + 
  geom_label_repel(data = key_points_df, aes(x = Season, y = total_WAR, label = Label), 
                  fontface = 'bold',
                  segment.color = 'black',
                  box.padding = 0.35, point.padding = 0.5,
                  segment.size = 1,
                  arrow = arrow(length = unit(0.01, 'npc')),
                  size = 4) +
  scale_color_manual(values = c("darkblue", "darkred", "darkgray")) + 
  geom_hline(yintercept=0,linetype="dotted",color="black") +
  ylab("Wins Above Replacement (WAR)") + xlab("Season") + scale_x_continuous(breaks=c(2013:2017)) +
  theme(panel.grid.minor = element_blank(),panel.grid.major.x = element_blank(),
        panel.background = element_blank(), panel.border = element_blank(),
        plot.margin = unit(c(1, 7, 2, 1), "lines"),
        plot.title = element_text(size=20,face = 2),
        plot.subtitle = element_text(size=16),
        axis.title.x = element_text(size=14),
        axis.title.y = element_text(size=14),
        axis.text.x = element_text(size=12),
        axis.text.y = element_text(size=12),
        legend.position = "none") +
  labs(title="Timeline of the Pittsburgh Steelers Killer B's with Wins Above Replacement (WAR), 2013-17",
       subtitle="Comparison of Ben, Brown, and Bell to Positional Averages",
       caption = "Data courtesy of nflscrapR (Ron Yurko, Max Horowitz, Sam Ventura)\nDepartment of Statistics, Carnegie Mellon University") +
  #annotate("text",x=2010, y= 0.36, label = "PIT loses\nSuper Bowl XLV", color="black") +
  #annotate("rect",xmin=2012,xmax=2016,ymin=min(pit_war_df$total_WAR),
  #         ymax=max(pit_war_df$total_WAR),alpha=.1,fill="gold") +
  #annotate("text",x=2014,y = .45, label="Todd Haley Era",fontface=2,size=6) +
  #annotate("text",x=2010.5,y = .45, label="Bruce Arians Era",fontface=2,size=6) +
  #annotate("text",x=2012, y= 0.25, 
  #         label = "Ben Roethlisberger\nmisses 3 games due to injury\nand PIT misses playoffs", color="black") +
  #annotate("text",x=2013,y=0.5,label="Bell's\nrookie season") +
  #annotate("text",x=2014.5,y=2,label="Brown leads NFL in\nreceptions and\nreceiving yards") +
  #annotate("text",x=2014.5,y=.48,label="Williams fills in\nfor Bell") +
  #annotate("text",x=2017,y=.48,label="JuJu's\nrookie season") +
  annotation_custom(grob = textGrob(label="Roethlisberger",hjust=0,
                                    gp=gpar(fontsize=16,fontface=2,col=pit_primary_color)),xmin=2017,xmax = 2017,
                    ymin = pull(filter(pit_war_df,
                                     Player_ID_Name == "B.Roethlisberger",
                                     Season == 2017), total_WAR),
                    ymax = pull(filter(pit_war_df,
                                       Player_ID_Name == "B.Roethlisberger",
                                       Season == 2017), total_WAR)) +
  annotation_custom(grob = textGrob(label="Brown",hjust=0,
                                    gp=gpar(fontsize=16,fontface=2,col=pit_primary_color)),xmin=2017,xmax = 2017,
                    ymin = pull(filter(pit_war_df,
                                       Player_ID_Name == "A.Brown",
                                       Season == 2017), total_WAR),
                    ymax = pull(filter(pit_war_df,
                                       Player_ID_Name == "A.Brown",
                                       Season == 2017), total_WAR)) +
  annotation_custom(grob = textGrob(label="Bell",hjust=0,
                                    gp=gpar(fontsize=16,fontface=2,col=pit_secondary_color)),xmin=2017,xmax = 2017,
                    ymin = pull(filter(pit_war_df,
                                       Player_ID_Name == "L.Bell",
                                       Season == 2017), total_WAR),
                    ymax = pull(filter(pit_war_df,
                                       Player_ID_Name == "L.Bell",
                                       Season == 2017), total_WAR)) +
  annotation_custom(grob = textGrob(label="Average QB",hjust=0,
                                    gp=gpar(fontsize=16,fontface=2,col="darkblue")),xmin=2017,xmax = 2017,
                    ymin = qb_average_war,
                    ymax = qb_average_war) + 
  annotation_custom(grob = textGrob(label="Average WR",hjust=0,
                                    gp=gpar(fontsize=16,fontface=2,col="darkgray")),xmin=2017,xmax = 2017,
                    ymin = wr_average_war,
                    ymax = wr_average_war) + 
  annotation_custom(grob = textGrob(label="Average RB",hjust=0,
                                    gp=gpar(fontsize=16,fontface=2,col="darkred")),xmin=2017,xmax = 2017,
                    ymin = rb_average_war,
                    ymax = rb_average_war) 
  
gb <- ggplot_build(killer_b_timeline)
gt <- ggplot_gtable(gb)

gt$layout$clip[gt$layout$name=="panel"] <- "off"

grid.draw(gt)



# --------------------------

# RB ranks for each season:

rb_war_ranks_df <- rb_war_df %>%
  select(Player_ID_Name, total_WAR, Season) %>%
  group_by(Season) %>%
  arrange(Season, desc(total_WAR)) %>%
  mutate(rank = row_number()) %>%
  ungroup() %>%
  mutate(Player_ID_Name = str_sub(Player_ID_Name, 1, nchar(Player_ID_Name) -11))

  


