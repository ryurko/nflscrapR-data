library(tidyverse)
library(ggplot2)
library(grid)

# Use the calc_passing_splits() function to
# generate team and season level stats:

team_passing <- calc_passing_splits(c("posteam","Season"), pbp_data) %>% filter(posteam != "")

# For rushing:

team_rushing <- calc_rushing_splits(c("posteam","Season"), pbp_data) %>% filter(posteam != "") %>%
  rename(EPA_per_Att=EPA_per_Car)

# League averages:

league_passing <- calc_passing_splits(c("Season"), pbp_data)
league_passing$posteam <- "League Average"

league_rushing <- calc_rushing_splits(c("Season"), pbp_data) %>%
  rename(EPA_per_Att=EPA_per_Car)
league_rushing$posteam <- "League Average"


pit_timeline <- ggplot(filter(team_passing,posteam != "PIT"),aes(x=Season,y=EPA_per_Att,group=posteam)) + 
  geom_line(color="lightgray",alpha=.5) + 
  geom_line(data=league_passing,aes(x=Season,y=EPA_per_Att),color="blue",size=1) +
  geom_line(data=filter(team_passing, posteam == "PIT"),
            aes(x=Season,y=EPA_per_Att),color="gold3",size=1) + 
  geom_point(data=filter(team_passing,posteam == "PIT",Season %in% c(2010,2012,2014)),
             aes(x=Season,y=EPA_per_Att),color="gold3",size=5) +
  geom_hline(yintercept=0,linetype="dashed",color="black") +
  geom_line(data=filter(team_rushing,posteam != "PIT"),aes(x=Season,y=EPA_per_Att,group=posteam), 
            color="lightgray",alpha=.5) +
  geom_line(data=league_rushing,aes(x=Season,y=EPA_per_Att),color="red",size=1) +
  geom_line(data=filter(team_rushing, posteam == "PIT"),
            aes(x=Season,y=EPA_per_Att),color="black",size=1) +
  geom_point(data=filter(team_rushing,posteam == "PIT",Season %in% c(2013,2015)),
             aes(x=Season,y=EPA_per_Att),color="black",size=5) +
  ylab("EPA Per Attempt") + xlab("Season") + scale_x_continuous(breaks=c(2009:2016)) +
  theme(panel.grid.minor = element_blank(),panel.grid.major.x = element_blank(),
      panel.background = element_blank(), panel.border = element_blank(),
      plot.margin = unit(c(1, 7, 2, 1), "lines"),
      plot.title = element_text(size=20,face = 2),
      plot.subtitle = element_text(size=16),
      axis.title.x = element_text(size=14),
      axis.title.y = element_text(size=14),
      axis.text.x = element_text(size=12),
      axis.text.y = element_text(size=12)) +
  geom_text(x=2010,y=.025,label="Positive Value Plays",color="blue") +
  geom_text(x=2010,y=-.025,label="Negative Value Plays",color="red") +
  labs(title="Timeline of Pittsburgh Steelers Offense with Expected Points Added per Attempt, 2009-2016",
       subtitle="Increasing efficiency of passing versus rushing, and how Pittsburgh compares to the league",
       caption = "Data from nflscrapR (Ron Yurko, Max Horowitz, Sam Ventura)\nDepartment of Statistics, Carnegie Mellon University") +
  annotate("text",x=2010, y= 0.36, label = "PIT loses\nSuper Bowl XLV", color="black") +
  annotate("rect",xmin=2012,xmax=2016,ymin=min(team_rushing$EPA_per_Att),
           ymax=max(team_passing$EPA_per_Att),alpha=.1,fill="gold") +
  annotate("text",x=2014,y = .45, label="Todd Haley Era",fontface=2,size=6) +
  annotate("text",x=2010.5,y = .45, label="Bruce Arians Era",fontface=2,size=6) +
  annotate("text",x=2012, y= 0.25, 
           label = "Ben Roethlisberger\nmisses 3 games due to injury\nand PIT misses playoffs", color="black") +
  annotate("text",x=2013,y=-.17,label="Le'Veon Bell's\nrookie season") +
  annotate("text",x=2014,y=.38,label="Antonio Brown leads\nNFL in receptions and\nreceiving yards") +
  annotate("text",x=2015,y=.09,label="DeAngelo Williams\nfills in for suspended\nand injured Bell") +
  annotation_custom(grob = textGrob(label="PIT Passing",hjust=0,
                                    gp=gpar(fontsize=12,fontface=2,col="gold3")),xmin=2016,xmax = 2016,
                    ymin=team_passing$EPA_per_Att[which(team_passing$posteam=="PIT" & team_passing$Season==2016)],
                    ymax=team_passing$EPA_per_Att[which(team_passing$posteam=="PIT" & team_passing$Season==2016)]) +
  annotation_custom(grob = textGrob(label="NFL Passing\n(Average)",hjust=0,
                                    gp=gpar(fontsize=12,fontface=2,col="blue")),xmin=2016,xmax = 2016,
                    ymin=league_passing$EPA_per_Att[which(league_passing$Season==2016)],
                    ymax=league_passing$EPA_per_Att[which(league_passing$Season==2016)]) +
  annotation_custom(grob = textGrob(label="PIT Rushing",hjust=0,
                                    gp=gpar(fontsize=12,fontface=2,col="black")),xmin=2016,xmax = 2016,
                    ymin=team_rushing$EPA_per_Att[which(team_rushing$posteam=="PIT" & team_rushing$Season==2016)],
                    ymax=team_rushing$EPA_per_Att[which(team_rushing$posteam=="PIT" & team_rushing$Season==2016)]) +
  annotation_custom(grob = textGrob(label="NFL Rushing\n(Average)",hjust=0,vjust = .5,
                                    gp=gpar(fontsize=12,fontface=2,col="red")),xmin=2016,xmax = 2016,
                    ymin=league_rushing$EPA_per_Att[which(league_rushing$Season==2016)],
                    ymax=league_rushing$EPA_per_Att[which(league_rushing$Season==2016)])

gb <- ggplot_build(pit_timeline)
gt <- ggplot_gtable(gb)

gt$layout$clip[gt$layout$name=="panel"] <- "off"

grid.draw(gt)

# ----------------------------------------------

# Defense timeline

# Use the calc_passing_splits() function to
# generate team and season level stats:

team_passing_def <- calc_passing_splits(c("DefensiveTeam","Season"), pbp_data) %>% filter(DefensiveTeam != "")

# For rushing:

team_rushing_def <- calc_rushing_splits(c("DefensiveTeam","Season"), pbp_data) %>% filter(DefensiveTeam != "") %>%
  rename(EPA_per_Att=EPA_per_Car)

league_passing$DefensiveTeam <- "League Average"


league_rushing$DefensiveTeam <- "League Average"


pit_timeline_def <- ggplot(filter(team_passing_def,DefensiveTeam != "PIT"),aes(x=Season,y=EPA_per_Att,group=DefensiveTeam)) + 
  geom_line(color="lightgray",alpha=.5) + 
  geom_line(data=league_passing,aes(x=Season,y=EPA_per_Att),color="blue",size=1) +
  geom_line(data=filter(team_passing_def, DefensiveTeam == "PIT"),
            aes(x=Season,y=EPA_per_Att),color="gold3",size=1) + 
  geom_point(data=filter(team_passing_def,DefensiveTeam == "PIT",Season %in% c(2014)),
             aes(x=Season,y=EPA_per_Att),color="gold3",size=5) +
  geom_hline(yintercept=0,linetype="dashed",color="black") +
  geom_line(data=filter(team_rushing_def,DefensiveTeam != "PIT"),aes(x=Season,y=EPA_per_Att,group=DefensiveTeam), 
            color="lightgray",alpha=.5) +
  geom_line(data=league_rushing,aes(x=Season,y=EPA_per_Att),color="red",size=1) +
  geom_line(data=filter(team_rushing_def, DefensiveTeam == "PIT"),
            aes(x=Season,y=EPA_per_Att),color="black",size=1) +
  geom_point(data=filter(team_rushing_def,DefensiveTeam == "PIT",Season %in% c(2010,2012,2014)),
             aes(x=Season,y=EPA_per_Att),color="black",size=5) +
  ylab("EPA Per Attempt") + xlab("Season") + scale_x_continuous(breaks=c(2009:2016)) +
  theme(panel.grid.minor = element_blank(),panel.grid.major.x = element_blank(),
        panel.background = element_blank(), panel.border = element_blank(),
        plot.margin = unit(c(1, 7, 2, 1), "lines"),
        plot.title = element_text(size=20,face = 2),
        plot.subtitle = element_text(size=16),
        axis.title.x = element_text(size=14),
        axis.title.y = element_text(size=14),
        axis.text.x = element_text(size=12),
        axis.text.y = element_text(size=12)) +
  geom_text(x=2010,y=.05,label="Positive Value Plays",color="blue") +
  geom_text(x=2010,y=-.04,label="Negative Value Plays",color="red") +
  labs(title="Timeline of Pittsburgh Steelers Defense with Expected Points Allowed per Attempt, 2009-2016",
       subtitle="Increasing efficiency of passing versus rushing, and how Pittsburgh's defense compares to the league",
       caption = "Data from nflscrapR (Ron Yurko, Max Horowitz, Sam Ventura)\nDepartment of Statistics, Carnegie Mellon University") +
  annotate("text",x=2010, y= -.12, label = "PIT loses\nSuper Bowl XLV", color="black") +
  annotate("rect",xmin=2009,xmax=2015,ymin=min(team_rushing_def$EPA_per_Att),
           ymax=max(team_passing_def$EPA_per_Att),alpha=.1,fill="gold") +
  annotate("text",x=2012,y = .38, label="Dick LeBeau Era",fontface=2,size=6) +
  annotate("text",x=2012,y = -.15, label="James Harrison\nreleased in offseason") +
  annotate("text",x=2014,y = .27, label="Troy Polamalu's\nfinal season") +
  annotate("text",x=2014,y = -.12, label="James Harrison\nreturns to PIT") +
  annotation_custom(grob = textGrob(label="PIT Passing\nDefense",hjust=0,vjust=-.25,
                                    gp=gpar(fontsize=12,fontface=2,col="gold3")),xmin=2016,xmax = 2016,
                    ymin=team_passing_def$EPA_per_Att[which(team_passing_def$DefensiveTeam=="PIT" & team_passing_def$Season==2016)],
                    ymax=team_passing_def$EPA_per_Att[which(team_passing_def$DefensiveTeam=="PIT" & team_passing_def$Season==2016)]) +
  annotation_custom(grob = textGrob(label="NFL Passing\n(Average)",hjust=0,vjust=1,
                                    gp=gpar(fontsize=12,fontface=2,col="blue")),xmin=2016,xmax = 2016,
                    ymin=league_passing$EPA_per_Att[which(league_passing$Season==2016)],
                    ymax=league_passing$EPA_per_Att[which(league_passing$Season==2016)]) +
  annotation_custom(grob = textGrob(label="PIT Rushing\nDefense",hjust=0,vjust=-.25,
                                    gp=gpar(fontsize=12,fontface=2,col="black")),xmin=2016,xmax = 2016,
                    ymin=team_rushing_def$EPA_per_Att[which(team_rushing_def$DefensiveTeam=="PIT" & team_rushing$Season==2016)],
                    ymax=team_rushing_def$EPA_per_Att[which(team_rushing_def$DefensiveTeam=="PIT" & team_rushing$Season==2016)]) +
  annotation_custom(grob = textGrob(label="NFL Rushing\n(Average)",hjust=0,vjust = 1,
                                    gp=gpar(fontsize=12,fontface=2,col="red")),xmin=2016,xmax = 2016,
                    ymin=league_rushing$EPA_per_Att[which(league_rushing$Season==2016)],
                    ymax=league_rushing$EPA_per_Att[which(league_rushing$Season==2016)])

gd <- ggplot_build(pit_timeline_def)
gtd <- ggplot_gtable(gd)

gtd$layout$clip[gtd$layout$name=="panel"] <- "off"

grid.draw(gtd)
  
# --------------------------------------------------------

# Comparison of Big Ben to Brady
league_passing$Player_Name <- "LeagueAverage"

brady_ben_airEPA_comp <- ggplot(filter(season_passing_df,Player_Name != "B.Roethlisberger" & Player_Name !="T.Brady",Attempts >= 50),
       aes(x=Season,y=airEPA_per_Comp,group=Player_Name)) + 
  geom_line(color="lightgray",alpha=.5) + 
  geom_line(data=league_passing,aes(x=Season,y=airEPA_per_Comp),color="blue",size=1) +
  geom_line(data=filter(season_passing_df, Player_Name == "B.Roethlisberger"),
            aes(x=Season,y=airEPA_per_Comp),color="black",size=1) + 
  geom_line(data=filter(season_passing_df, Player_Name == "T.Brady"),
            aes(x=Season,y=airEPA_per_Comp),color="red",size=1) + 
  geom_hline(yintercept=0,linetype="dashed",color="red") + 
  theme(panel.grid.minor = element_blank(),panel.grid.major.x = element_blank(),
        panel.background = element_blank(), panel.border = element_blank(),
        plot.margin = unit(c(1, 7, 2, 1), "lines"),
        plot.title = element_text(size=20,face = 2),
        plot.subtitle = element_text(size=16),
        axis.title.x = element_text(size=14),
        axis.title.y = element_text(size=14),
        axis.text.x = element_text(size=12),
        axis.text.y = element_text(size=12)) +
  geom_text(x=2010,y=.025,label="Positive Value Plays",color="blue") +
  geom_text(x=2010,y=-.025,label="Negative Value Plays",color="red") +
  labs(title="Big Ben vs Tom Brady with airEPA per Completion , 2009-2016",
       caption = "Data from nflscrapR (Ron Yurko, Max Horowitz, Sam Ventura)\nDepartment of Statistics, Carnegie Mellon University") +
  annotation_custom(grob = textGrob(label="Big Ben",hjust=0,
                                    gp=gpar(fontsize=12,fontface=2,col="black")),xmin=2016,xmax = 2016,
                    ymin=season_passing_df$airEPA_per_Comp[which(season_passing_df$Player_Name=="B.Roethlisberger" & season_passing_df$Season==2016)],
                    ymax=season_passing_df$airEPA_per_Comp[which(season_passing_df$Player_Name=="B.Roethlisberger" & season_passing_df$Season==2016)]) +
  annotation_custom(grob = textGrob(label="NFL Passing\n(Average)",hjust=0,vjust=1,
                                    gp=gpar(fontsize=12,fontface=2,col="blue")),xmin=2016,xmax = 2016,
                    ymin=league_passing$airEPA_per_Comp[which(league_passing$Season==2016)],
                    ymax=league_passing$airEPA_per_Comp[which(league_passing$Season==2016)]) +
  annotation_custom(grob = textGrob(label="Tom Brady",hjust=0,
                                    gp=gpar(fontsize=12,fontface=2,col="red")),xmin=2016,xmax = 2016,
                    ymin=season_passing_df$airEPA_per_Comp[which(season_passing_df$Player_Name=="T.Brady" & season_passing_df$Season==2016)],
                    ymax=season_passing_df$airEPA_per_Comp[which(season_passing_df$Player_Name=="T.Brady" & season_passing_df$Season==2016)]) +
  ylab("airEPA per Completion") + scale_x_continuous(breaks=c(2009:2016))
  
  
gd <- ggplot_build(brady_ben_airEPA_comp)
gtd <- ggplot_gtable(gd)

gtd$layout$clip[gtd$layout$name=="panel"] <- "off"

grid.draw(gtd)


brady_ben_EPA_comp <- ggplot(filter(season_passing_df,Player_Name != "B.Roethlisberger" & Player_Name !="T.Brady",Attempts >= 50),
                                aes(x=Season,y=EPA_per_Comp,group=Player_Name)) + 
  geom_line(color="lightgray",alpha=.5) + 
  geom_line(data=league_passing,aes(x=Season,y=EPA_per_Comp),color="blue",size=1) +
  geom_line(data=filter(season_passing_df, Player_Name == "B.Roethlisberger"),
            aes(x=Season,y=EPA_per_Comp),color="black",size=1) + 
  geom_line(data=filter(season_passing_df, Player_Name == "T.Brady"),
            aes(x=Season,y=EPA_per_Comp),color="red",size=1) + 
  geom_hline(yintercept=0,linetype="dashed",color="red") + 
  theme(panel.grid.minor = element_blank(),panel.grid.major.x = element_blank(),
        panel.background = element_blank(), panel.border = element_blank(),
        plot.margin = unit(c(1, 7, 2, 1), "lines"),
        plot.title = element_text(size=20,face = 2),
        plot.subtitle = element_text(size=16),
        axis.title.x = element_text(size=14),
        axis.title.y = element_text(size=14),
        axis.text.x = element_text(size=12),
        axis.text.y = element_text(size=12)) +
  geom_text(x=2010,y=.025,label="Positive Value Plays",color="blue") +
  geom_text(x=2010,y=-.025,label="Negative Value Plays",color="red") +
  labs(title="Big Ben vs Tom Brady with EPA per Completion , 2009-2016",
       caption = "Data from nflscrapR (Ron Yurko, Max Horowitz, Sam Ventura)\nDepartment of Statistics, Carnegie Mellon University") +
  annotation_custom(grob = textGrob(label="Big Ben",hjust=0,
                                    gp=gpar(fontsize=12,fontface=2,col="black")),xmin=2016,xmax = 2016,
                    ymin=season_passing_df$EPA_per_Comp[which(season_passing_df$Player_Name=="B.Roethlisberger" & season_passing_df$Season==2016)],
                    ymax=season_passing_df$EPA_per_Comp[which(season_passing_df$Player_Name=="B.Roethlisberger" & season_passing_df$Season==2016)]) +
  annotation_custom(grob = textGrob(label="NFL Passing\n(Average)",hjust=0,vjust=1,
                                    gp=gpar(fontsize=12,fontface=2,col="blue")),xmin=2016,xmax = 2016,
                    ymin=league_passing$EPA_per_Comp[which(league_passing$Season==2016)],
                    ymax=league_passing$EPA_per_Comp[which(league_passing$Season==2016)]) +
  annotation_custom(grob = textGrob(label="Tom Brady",hjust=0,
                                    gp=gpar(fontsize=12,fontface=2,col="red")),xmin=2016,xmax = 2016,
                    ymin=season_passing_df$EPA_per_Comp[which(season_passing_df$Player_Name=="T.Brady" & season_passing_df$Season==2016)],
                    ymax=season_passing_df$EPA_per_Comp[which(season_passing_df$Player_Name=="T.Brady" & season_passing_df$Season==2016)]) +
  ylab("EPA per Completion") + scale_x_continuous(breaks=c(2009:2016))


gd <- ggplot_build(brady_ben_EPA_comp)
gtd <- ggplot_gtable(gd)

gtd$layout$clip[gtd$layout$name=="panel"] <- "off"

grid.draw(gtd)


