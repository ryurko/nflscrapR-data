library(tidyverse)

# Using the season_passing_df, view the relationship between
# passing Success Rate and Clutch EPA in 2017:

ggplot(filter(season_passing_df,Season==2017, Attempts >=100),
       aes(x=Success_Rate, y=Total_Clutch_EPA)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("Success Rate") + ylab("Total Clutch EPA") + theme_bw() +
  labs(title="Relationship Between Clutch EPA and Success Rate for Passing in 2017 \n(min 100 attempts)")

# View separately team passing offense and defense:

team_2017_passing_off <- team_season_passing_df %>% filter(Season == 2017) %>% ungroup %>%
  select(Team, Total_EPA, Success_Rate, Total_WPA, Total_Clutch_EPA) %>%
  rename(Passing_EPA = Total_EPA, Passing_SR = Success_Rate, Passing_WPA = Total_WPA,
         Clutch_Passing_EPA = Total_Clutch_EPA)

team_2017_rushing_off <- team_season_rushing_df %>% filter(Season == 2017) %>% ungroup %>%
  select(Team, Total_EPA, Success_Rate, Total_WPA, Total_Clutch_EPA) %>%
  rename(Rushing_EPA = Total_EPA, Rushing_SR = Success_Rate, Rushing_WPA = Total_WPA,
         Clutch_Rushing_EPA = Total_Clutch_EPA)

team_2017_passing_def <- team_def_season_passing_df %>% filter(Season == 2017) %>% ungroup %>%
  select(Team, Total_EPA, Success_Rate, Total_WPA, Total_Clutch_EPA) %>%
  rename(Def_Passing_EPA = Total_EPA, Def_Passing_SR = Success_Rate, Def_Passing_WPA = Total_WPA,
         Def_Clutch_Passing_EPA = Total_Clutch_EPA)

team_2017_rushing_def <- team_def_season_rushing_df %>% filter(Season == 2017) %>% ungroup %>%
  select(Team, Total_EPA, Success_Rate, Total_WPA, Total_Clutch_EPA) %>%
  rename(Def_Rushing_EPA = Total_EPA, Def_Rushing_SR = Success_Rate, Def_Rushing_WPA = Total_WPA,
         Def_Clutch_Rushing_EPA = Total_Clutch_EPA)


team_passing <- team_2017_passing_off %>% left_join(team_2017_passing_def, by = "Team")
team_rushing <- team_2017_rushing_off %>% left_join(team_2017_rushing_def, by = "Team")

team_total <- team_passing %>% left_join(team_rushing, by = "Team") %>% 
  mutate(Total_EPA_Off = Passing_EPA + Rushing_EPA,
         Total_EPA_Def = -1 * (Def_Passing_EPA + Def_Rushing_EPA),
         Total_WPA_Off = Passing_WPA + Rushing_WPA,
         Total_WPA_Def = Def_Passing_WPA + Def_Rushing_WPA,
         Total_Clutch_EPA_Off = Clutch_Passing_EPA + Clutch_Rushing_EPA,
         Total_Clutch_EPA_Def = -1 * (Def_Clutch_Passing_EPA + Def_Clutch_Rushing_EPA)) 

ggplot(team_total, aes(x = Total_EPA_Off, y = Total_EPA_Def)) + geom_text(aes(label=Team), size = 5) +
  geom_hline(yintercept = 0, color="red",linetype="dashed") +
  geom_vline(xintercept = 0,color="red",linetype="dashed") +
  theme_bw() + xlab("Offense EPA") + ylab("Defense EPA") +
  theme(plot.title = element_blank(),
        axis.text.x = element_text(size=16), axis.text.y = element_text(size=16),
        axis.title.x = element_text(size=16), axis.title.y = element_text(size=16)) + 
  labs(caption = "Data from nflscrapR")

ggplot(team_total, aes(x = Total_Clutch_EPA_Off, y = Total_Clutch_EPA_Def)) + geom_text(aes(label=Team), size = 5) +
  geom_hline(yintercept = 0, color="red",linetype="dashed") +
  geom_vline(xintercept = 0,color="red",linetype="dashed") +
  theme_bw() + xlab("Offense Clutch EPA") + ylab("Defense Clutch EPA") +
  theme(plot.title = element_blank(),
        axis.text.x = element_text(size=16), axis.text.y = element_text(size=16),
        axis.title.x = element_text(size=16), axis.title.y = element_text(size=16)) + 
  labs(caption = "Data from nflscrapR")


ggplot(team_total, aes(x = Total_WPA_Off, y = Total_WPA_Def)) + geom_text(aes(label=Team), size = 5) +
  geom_hline(yintercept = 0, color="red",linetype="dashed") +
  geom_vline(xintercept = 0,color="red",linetype="dashed") +
  theme_bw() + xlab("Offense WPA") + ylab("Defense WPA") +
  theme(plot.title = element_blank(),
        axis.text.x = element_text(size=16), axis.text.y = element_text(size=16),
        axis.title.x = element_text(size=16), axis.title.y = element_text(size=16)) + 
  labs(caption = "Data from nflscrapR")

ggplot(mutate(team_passing,Def_Passing_EPA = -1 * Def_Passing_EPA), 
       aes(x = Passing_EPA, y = Def_Passing_EPA)) + geom_text(aes(label=Team), size = 5) +
  geom_hline(yintercept = 0, color="red",linetype="dashed") +
  geom_vline(xintercept = 0,color="red",linetype="dashed") +
  theme_bw() + xlab("Offense Passing EPA") + ylab("Defense Passing EPA") +
  theme(plot.title = element_blank(),
        axis.text.x = element_text(size=16), axis.text.y = element_text(size=16),
        axis.title.x = element_text(size=16), axis.title.y = element_text(size=16)) + 
  labs(caption = "Data from nflscrapR")

ggplot(mutate(team_rushing,Def_Rushing_EPA = -1 * Def_Rushing_EPA), 
       aes(x = Rushing_EPA, y = Def_Rushing_EPA)) + geom_text(aes(label=Team), size = 5) +
  geom_hline(yintercept = 0, color="red",linetype="dashed") +
  geom_vline(xintercept = 0,color="red",linetype="dashed") +
  theme_bw() + xlab("Offense Rushing EPA") + ylab("Defense Rushing EPA") +
  theme(plot.title = element_blank(),
        axis.text.x = element_text(size=16), axis.text.y = element_text(size=16),
        axis.title.x = element_text(size=16), axis.title.y = element_text(size=16)) + 
  labs(caption = "Data from nflscrapR")


ggplot(team_total, aes(x = Rushing_EPA, y = Def_Rushing_EPA)) + geom_text(aes(label=Team), size = 5) +
  geom_hline(yintercept = 0, color="red",linetype="dashed") +
  geom_vline(xintercept = 0,color="red",linetype="dashed") +
  theme_bw() + xlab("Rushing Expected Points Added") + ylab("Rushing Expected Points Allowed") +
  theme(plot.title = element_blank(),
        axis.text.x = element_text(size=16), axis.text.y = element_text(size=16),
        axis.title.x = element_text(size=16), axis.title.y = element_text(size=16)) + 
  labs(caption = "Data from nflscrapR")


# View EPA per drive:
ggplot(filter(season_passing_df, Season == 2017, Attempts >=100),
       aes(x = Success_Rate, y = EPA_per_Drive)) + geom_text(aes(label=Player_Name)) +
  xlab("Success Rate") + ylab("EPA per Drive") + theme_bw() + geom_smooth(method = "lm") +
  labs(title="Relationship Between EPA per Drive and Success Rate for Passing in 2017 \n(min 100 attempts)",
       caption = "Data from nflscrapR")

ggplot(filter(season_receiving_df, Season == 2017, Targets >=50),
       aes(x = Targets_per_Drive, y = EPA_per_Drives)) + geom_text(aes(label=Player_Name)) +
  xlab("Targets per Drive") + ylab("EPA per Drive") + theme_bw() + geom_hline(yintercept = 0,color="red",
                                                                              linetype="dashed") +
  labs(title="Relationship Between EPA per Drive and Targets per Drive for Receiving in 2017 \n(min 50 targets)",
       caption = "Data from nflscrapR")

ggplot(filter(season_rushing_df, Season == 2017, Carries >=25),
       aes(x = Car_per_Drive, y = EPA_per_Drive)) + geom_text(aes(label=Player_Name)) +
  xlab("Carries per Drive") + ylab("EPA per Drive") + theme_bw() + geom_hline(yintercept = 0,color="red",
                                                                              linetype="dashed") +
  labs(title="Relationship Between EPA per Drive and Carries per Drive for Rushing in 2017 \n(min 25 carries)",
       caption = "Data from nflscrapR")


# Using the season_passing_df, view the relationship between
# passing Success Rate and Clutch EPA in 2016:

ggplot(filter(season_passing_df,Season==2016 & Attempts >= 100),
       aes(x=Success_Rate, y=Total_Clutch_EPA)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("Success Rate") + ylab("Total Clutch EPA") + theme_bw() +
  labs(title="Relationship Between Clutch EPA and Success Rate for Passing in 2016 \n(min 100 attempts)")

# Air yards and airWPA in 2017

ggplot(filter(season_passing_df,Season==2017 & Attempts >= 100),
       aes(x=Total_Comp_AirYards, y=airWPA_Comp)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("Air Yards (Completions)") + ylab("airWPA") + theme_bw() +
  labs(title="Relationship Between Air Yards (Completions) and airWPA for Passing in 2017 \n(min 100 attempts)",
       caption= "Data from nflscrapR")

ggplot(filter(season_passing_df,Season==2017 & Attempts >= 100),
       aes(x=PACR, y=airWPA_Comp)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("PACR") + ylab("airWPA") + theme_bw() +
  labs(title="Relationship Between PACR and airWPA for Passing in 2017 \n(min 100 attempts)",
       caption= "Data from nflscrapR")

ggplot(filter(season_passing_df,Season==2017 & Attempts >= 100),
       aes(x=PACR, y=airWPA_per_Att)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("PACR") + ylab("airWPA per Attempt") + theme_bw() +
  labs(title="Relationship Between PACR and airWPA per Attempt for Passing in 2017 \n(min 100 attempts)",
       caption= "Data from nflscrapR")

ggplot(filter(season_passing_df,Season==2017 & Attempts >= 100),
       aes(x=PACR, y=yacWPA_per_Att)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("PACR") + ylab("yacWPA per Attempt") + theme_bw() +
  labs(title="Relationship Between PACR and yacWPA per Attempt for Passing in 2017 \n(min 100 attempts)",
       caption= "Data from nflscrapR")


ggplot(filter(season_passing_df,Season==2017 & Attempts >= 100),
       aes(x=PACR, y=WPA_per_Att)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("PACR") + ylab("WPA per Attempt") + theme_bw() +
  labs(title="Relationship Between PACR and WPA per Attempt for Passing in 2017 \n(min 100 attempts)",
       caption= "Data from nflscrapR")


ggplot(filter(season_passing_df,Season==2017 & Attempts >= 100),
       aes(x=aPACR, y=airWPA_per_Att)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("aPACR") + ylab("airWPA per Attempt") + theme_bw() +
  labs(title="Relationship Between aPACR and airWPA per Attempt for Passing in 2017 \n(min 100 attempts)",
       caption= "Data from nflscrapR")

ggplot(filter(season_passing_df,Season==2017 & Attempts >= 100),
       aes(x=aPACR, y=yacWPA_per_Att)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("aPACR") + ylab("yacWPA per Attempt") + theme_bw() +
  labs(title="Relationship Between aPACR and yacWPA per Attempt for Passing in 2017 \n(min 100 attempts)",
       caption= "Data from nflscrapR")


ggplot(filter(season_passing_df,Season==2017 & Attempts >= 100),
       aes(x=aPACR, y=WPA_per_Att)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("aPACR") + ylab("WPA per Attempt") + theme_bw() +
  labs(title="Relationship Between aPACR and WPA per Attempt for Passing in 2017 \n(min 100 attempts)",
       caption= "Data from nflscrapR")

# Yards after catch and yacWPA in 2017 receivers:
ggplot(filter(season_receiving_df, Season==2017 & Targets >= 25),
       aes(x=Total_Caught_YAC, y=yacWPA_Rec)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("Total Yards After Catch") + ylab("yacWPA") + theme_bw() +
  labs(title="Relationship Between Yards After Catch and yacWPA for Receiving in 2017 \n(min 25 targets)",
       caption= "Data from nflscrapR")



# Success Rate versus airEPA based Success Rate

ggplot(filter(season_passing_df,Season==2016 & Attempts >= 100),
       aes(x=air_Comp_Success_Rate, y=Success_Rate)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("airEPA Completions Success Rate") + ylab("Success Rate") + theme_bw() +
  labs(title="Relationship Between Success Rate and airEPA Completions Success Rate for Passing in 2016 \n(min 100 attempts)")

ggplot(filter(season_passing_df,Season==2017 & Attempts >= 100),
       aes(x=air_Comp_Success_Rate, y=Air_TDs)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("airEPA Completions Success Rate") + ylab("airTDs") + theme_bw() +
  labs(title="Relationship Between airTDs and airEPA Completions Success Rate for Passing in 2017 \n(min 100 attempts)")

ggplot(filter(season_passing_df,Season==2017 & Attempts >= 25),
       aes(x=air_Success_Rate, y=Success_Rate)) + geom_text(aes(label=Player_Name)) +
  xlab("airEPA Success Rate") + ylab("Success Rate") + theme_bw() +
  labs(title="Relationship Between Success Rate and airEPA Success Rate for Passing in 2017 \n(min 25 attempts)")


ggplot(filter(season_passing_df,Season==2016 & Attempts >= 100),
       aes(x=air_Success_Rate, y=Success_Rate)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("airEPA Success Rate") + ylab("Success Rate") + theme_bw() +
  labs(title="Relationship Between Success Rate and airEPA Success Rate for Passing in 2016 \n(min 100 attempts)")



# Using the season_rushing_df:

ggplot(filter(season_rushing_df,Season==2016 & Carries >= 50),
       aes(x=Success_Rate, y=Total_Clutch_EPA)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("Success Rate") + ylab("Total Clutch EPA") + theme_bw() +
  labs(title="Relationship Between Clutch EPA and Success Rate for Rushing in 2016 \n(min 50 attempts)")

ggplot(filter(season_rushing_df,Season==2017 & Carries >= 25),
       aes(y=Success_Rate, x=EPA_per_Car)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  ylab("Success Rate") + xlab("EPA per Carry") + theme_bw() +
  labs(title="Relationship Between Success Rate and EPA per Carry and for Rushing in 2017 \n(min 25 attempts)",
       caption= "Data from nflscrapR")


# Using the season_receiving_df:

ggplot(filter(season_receiving_df, Season==2017 & Receptions >= 25),
       aes(x=EPA_Rec_Perc, y=Total_Clutch_EPA)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("EPA Weighted Reception Percentage") + ylab("Total Clutch EPA") + theme_bw() +
  labs(title="Relationship Between Clutch EPA and EPA Weighted Reception Percentage for Receiving in 2017 \n(min 25 receptions)")


ggplot(filter(season_receiving_df, Season==2016 & Receptions >= 25),
       aes(x=EPA_Rec_Perc, y=Total_Clutch_EPA)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("EPA Weighted Reception Percentage") + ylab("Total Clutch EPA") + theme_bw() +
  labs(title="Relationship Between Clutch EPA and EPA Weighted Reception Percentage for Receiving in 2016 \n(min 25 receptions)")

ggplot(filter(season_receiving_df, Season==2017 & Targets >= 25),
       aes(x=Raw_AirYards_per_Target, y=Caught_airEPA_per_Target)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("Air Yards per Target") + ylab("Caught airEPA per Target") + theme_bw() +
  labs(title="Relationship Between Caught airEPA per Target and Air Yards per Target for Receiving in 2017 \n(min 25 targets)")


ggplot(filter(season_receiving_df, Season==2016 & Targets >= 50),
       aes(x=AirYards_per_Target, y=airEPA_per_Target)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("Air Yards per Target") + ylab("airEPA per Target") + theme_bw() +
  labs(title="Relationship Between airEPA per Target and Air Yards per Target for Receiving in 2016 \n(min 50 targets)")

ggplot(filter(season_receiving_df, Season==2016 & Targets >= 50),
       aes(x=Rec_Percentage, y=yacEPA_per_Rec)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("Reception Percentage") + ylab("yacEPA per Reception") + theme_bw() +
  labs(title="Relationship Between yacEPA per Reception and Reception Percentage for Receiving in 2016 \n(min 50 targets)")

# Jay Cutler and Ryan Tannehill

ggplot(filter(season_passing_df, Player_Name %in% c("J.Cutler","R.Tannehill"))) +
  geom_line(aes(x=Season,y=Comp_Perc,color=Player_Name),size=2) +
  ylab("Completion %") + theme_bw() +
  labs(title="Cutler vs Tannehill: Completion %")

ggplot(filter(season_passing_df, Player_Name %in% c("J.Cutler","R.Tannehill"))) +
  geom_line(aes(x=Season,y=EPA_Comp_Perc,color=Player_Name),size=2) +
  ylab("EPA Weighted-Completion %") + theme_bw() +
  labs(title="Cutler vs Tannehill: EPA Weighted-Completion %")


ggplot(filter(season_passing_df, Player_Name %in% c("J.Cutler","R.Tannehill"))) +
  geom_line(aes(x=Season,y=Success_Rate,color=Player_Name),size=2) +
  ylab("Success Rate") + theme_bw() +
  labs(title="Cutler vs Tannehill: Success Rate")

ggplot(filter(season_passing_df, Player_Name %in% c("J.Cutler","R.Tannehill"))) +
  geom_line(aes(x=Season,y=air_Comp_Success_Rate,color=Player_Name),size=2) +
  ylab("Air Completion Success Rate") + theme_bw() +
  labs(title="Cutler vs Tannehill: Air Completion Success Rate")

ggplot(filter(season_passing_df, Player_Name %in% c("J.Cutler","R.Tannehill"))) +
  geom_line(aes(x=Season,y=airEPA_per_Comp,color=Player_Name),size=2) +
  ylab("Air EPA per Completion") + theme_bw()


