# Access tidyverse
# install.packages("tidyverse")
library(tidyverse)

# Load season level passing and receiving level stats:
season_passing_df <- read_csv("data/season_player_stats/season_passing_df.csv")
season_receiving_df <- read_csv("data/season_player_stats/season_receiving_df.csv")

# Create datasets for each just with the player id, name, attempts, and 
# the various forms of pacr then tidy 

passing_pacr_df <- season_passing_df %>%
  filter(Attempts >= 100) %>%
  select(Passer_ID, Player_Name, Season, PACR, epa_PACR, wpa_PACR) %>%
  gather(stat, value, -Passer_ID, -Player_Name, -Season) %>%
  spread(Season, value)

receiving_racr_df <- season_receiving_df %>%
  filter(Targets >= 25) %>%
  select(Receiver_ID, Player_Name, Season, RACR, epa_RACR, wpa_RACR) %>%
  gather(stat, value, -Receiver_ID, -Player_Name, -Season) %>% 
  spread(Season, value)

library(ggrepel)

passing_pacr_df %>%
  filter(stat == "PACR") %>%
  ggplot(aes(x = `2016`, y = `2017`)) + 
  geom_point() +
  geom_text_repel(aes(label = Player_Name)) + 
  geom_smooth(method = "lm") +
  theme_bw() +
  labs(x = "PACR 2016",
       y = "PACR 2017",
       title = "Relationship Between PACR in 2016 and 2017",
       caption = "Data courtesy of nflscrapR")


passing_pacr_df %>%
  filter(stat == "epa_PACR") %>%
  ggplot(aes(x = `2016`, y = `2017`)) + 
  geom_point() +
  geom_text_repel(aes(label = Player_Name)) + 
  geom_smooth(method = "lm") +
  theme_bw() +
  labs(x = "epaPACR 2016",
       y = "epaPACR 2017",
       title = "Relationship Between epaPACR in 2016 and 2017",
       caption = "Data courtesy of nflscrapR")


passing_pacr_df %>%
  filter(stat == "wpa_PACR") %>%
  ggplot(aes(x = `2016`, y = `2017`)) + 
  geom_point() +
  geom_text_repel(aes(label = Player_Name)) + 
  geom_smooth(method = "lm") +
  theme_bw() +
  labs(x = "wpaPACR 2016",
       y = "wpaPACR 2017",
       title = "Relationship Between wpaPACR in 2016 and 2017",
       caption = "Data courtesy of nflscrapR")


