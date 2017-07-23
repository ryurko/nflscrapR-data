library(tidyverse)
library(ggplot2)

# Using the season_passing_df, view the relationship between
# passing Success Rate and Clutch EPA in 2016:

ggplot(filter(season_passing_df,Season==2016 & Attempts >= 100),
       aes(x=Success_Rate, y=Total_Clutch_EPA)) + geom_text(aes(label=Player_Name)) +
  geom_smooth(method="lm") +
  xlab("Success Rate") + ylab("Total Clutch EPA") + theme_bw() +
  labs(title="Relationship Between Clutch EPA and Success Rate for Passing in 2016 \n(min 100 attempts)")

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
