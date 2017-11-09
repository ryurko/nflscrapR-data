library(tidyverse)

# Using the season_passing_df, view the relationship between
# passing Success Rate and Clutch EPA in 2017:

ggplot(filter(season_passing_df,Season==2017, Attempts >=100),
       aes(x=Success_Rate, y=Total_Clutch_EPA)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("Success Rate") + ylab("Total Clutch EPA") + theme_bw() +
  labs(title="Relationship Between Clutch EPA and Success Rate for Passing in 2017 \n(min 25 attempts)")

# View EPA per drive:
ggplot(filter(season_passing_df, Season == 2017, Attempts >=50),
       aes(x = Success_Rate, y = EPA_per_Drive)) + geom_text(aes(label=Player_Name)) +
  xlab("Success Rate") + ylab("EPA per Drive") + theme_bw() + geom_smooth(method = "lm") +
  labs(title="Relationship Between EPA per Drive and Success Rate for Passing in 2017 \n(min 50 attempts)",
       caption = "Data from nflscrapR")

ggplot(filter(season_receiving_df, Season == 2017, Targets >=25),
       aes(x = Targets_per_Drive, y = EPA_per_Drives)) + geom_text(aes(label=Player_Name)) +
  xlab("Targets per Drive") + ylab("EPA per Drive") + theme_bw() + geom_hline(yintercept = 0,color="red",
                                                                              linetype="dashed") +
  labs(title="Relationship Between EPA per Drive and Targets per Drive for Receiving in 2017 \n(min 25 targets)",
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

# Success Rate versus airEPA based Success Rate

ggplot(filter(season_passing_df,Season==2016 & Attempts >= 100),
       aes(x=air_Comp_Success_Rate, y=Success_Rate)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("airEPA Completions Success Rate") + ylab("Success Rate") + theme_bw() +
  labs(title="Relationship Between Success Rate and airEPA Completions Success Rate for Passing in 2016 \n(min 100 attempts)")

ggplot(filter(season_passing_df,Season==2017 & Attempts >= 25),
       aes(x=air_Comp_Success_Rate, y=Success_Rate)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("airEPA Completions Success Rate") + ylab("Success Rate") + theme_bw() +
  labs(title="Relationship Between Success Rate and airEPA Completions Success Rate for Passing in 2017 \n(min 25 attempts)")

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

ggplot(filter(season_receiving_df, Season==2016 & Receptions >= 25),
       aes(x=EPA_Rec_Perc, y=Total_Clutch_EPA)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("EPA Weighted Reception Percentage") + ylab("Total Clutch EPA") + theme_bw() +
  labs(title="Relationship Between Clutch EPA and EPA Weighted Reception Percentage for Receiving in 2016 \n(min 25 receptions)")

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


