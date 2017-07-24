library(tidyverse)
library(ggplot2)

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

ggplot(filter(season_passing_df,Season==2016 & Attempts >= 100),
       aes(x=air_Success_Rate, y=Success_Rate)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("airEPA Completions Success Rate") + ylab("Success Rate") + theme_bw() +
  labs(title="Relationship Between Success Rate and airEPA Success Rate for Passing in 2016 \n(min 100 attempts)")

# Using the season_rushing_df:

ggplot(filter(season_rushing_df,Season==2016 & Carries >= 50),
       aes(x=Success_Rate, y=Total_Clutch_EPA)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("Success Rate") + ylab("Total Clutch EPA") + theme_bw() +
  labs(title="Relationship Between Clutch EPA and Success Rate for Rushing in 2016 \n(min 50 attempts)")

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

