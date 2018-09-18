# Script for getting all passing plays by non-QBs

# First access the nflWAR package which is using data from
# nflscrapR (first need to install the devtools package)

# install.packages("devtools")
devtools::install_github("ryurko/nflWAR")

# Access nflWAR

library(nflWAR)

# Access tidyverse
# install.packages("tidyverse")

library(tidyverse)

# Get the 2017 data and add the positions:
pbp_2017 <- get_pbp_data(2017) %>%
  add_positions(2017)

# Get the names of QBs:

qb_names <- pbp_2017 %>%
  filter(Passer_Position == "QB" & !is.na(Passer)) %>%
  pull(Passer) %>%
  unique()

# Filter the dataset to be all passes where Passer is missing or not in this list of names:
non_qb_passes <- pbp_2017 %>%
  filter((is.na(Passer) & PlayType == "Pass") | (!is.na(Passer) & !(Passer %in% qb_names))) %>%
  # Add the wp_success variable:
  mutate(wp_success = as.factor(ifelse(WPA > 0, 1, 0)))

# Compare distributions of Non-QB throws based on whether or not the play was successful:
ggplot(non_qb_passes, aes(y = WPA, x = wp_success, fill = wp_success)) + 
  scale_x_discrete(labels = c("No", "Yes")) +
  geom_violin(alpha = .6) + 
  geom_boxplot(width = .2, fill = "white") +
  geom_rug(aes(color = wp_success)) + theme_bw() + 
  coord_flip() +
  scale_color_manual(values = c("darkblue", "darkorange"), guide = FALSE) +
  scale_fill_manual(labels = c("No", "Yes"), 
                    values = c("darkblue", "darkorange"), "WPA > 0?", guide = FALSE) +
  labs(title = "WPA Distibrutions for Non-QB Pass Attempts by Success Indicator",
       x = "WPA > 0?",
       y = "Win Probability Added")

# Compare the airWPA of these throws - this gives the hypothetical WPA from the distance travelled in the
# air (ignoring the actual result of the play - point was to see if/how the success depends on the distance)
# - and we see plenty of overlap here but still more successful plays seem to be associated with longer attempts:
ggplot(non_qb_passes, aes(y = airWPA, x = wp_success, fill = wp_success)) + 
  scale_x_discrete(labels = c("No", "Yes")) +
  geom_violin(alpha = .6) + 
  geom_boxplot(width = .2, fill = "white") +
  geom_rug(aes(color = wp_success)) + theme_bw() + 
  coord_flip() +
  scale_color_manual(values = c("darkblue", "darkorange"), guide = FALSE) +
  scale_fill_manual(labels = c("No", "Yes"), 
                    values = c("darkblue", "darkorange"), "WPA > 0?", guide = FALSE) +
  labs(title = "airWPA Distibrutions for Non-QB Pass Attempts by Success Indicator",
       x = "WPA > 0?",
       y = "Win Probability Added through the Air (regardless of result)")

# View the plays in descending order of WPA: 
non_qb_passes %>% arrange(desc(WPA)) %>% View()

# Just get the top five descriptions and WPA values (along with airWPA):
non_qb_passes %>% arrange(desc(WPA)) %>% slice(1:5) %>% select(desc, WPA, airWPA)

# And here's the code for getting the Super Bowl and generating the chart:

# Access nflscrapR (update it if you need to)
# devtools::install_github("maksimhorowitz/nflscrapR")
library(nflscrapR)

# Install the teamcolors package:
devtools::install_github("beanumber/teamcolors")
library(teamcolors)

# Set up the colors for the chart:
nfl_teamcolors <- teamcolors %>% filter(league == "nfl")
phi_color <- nfl_teamcolors %>%
  filter(name == "Philadelphia Eagles") %>%
  pull(primary)
ne_color <- nfl_teamcolors %>%
  filter(name == "New England Patriots") %>%
  pull(secondary)

# Pull the playoff game IDs for the 2017 season:
playoff_ids_2017 <- extracting_gameids(2017, playoffs = TRUE)
# Scrape the superbowl:
superbowl_18 <- game_play_by_play(playoff_ids_2017[12])

ggplot(data = dplyr::filter(superbowl_18, 
                            !is.na(TimeSecs), 
                            !is.na(Home_WP_pre), 
                            !is.na(Away_WP_pre),
                            PlayType != "Timeout" & PlayType != "Quarter End" &
                              PlayType != "Half End"  & 
                              PlayType != "Two Minute Warning"),
       aes(x = TimeSecs)) + 
  geom_hline(yintercept = 0.5, color = "black") + 
  geom_line(aes(y = Away_WP_pre), color = phi_color, size = 2) + 
  geom_line(aes(y = Home_WP_pre), color = ne_color, size = 2) + 
  annotate("text", x = 3000, y = 0.1, label = "NE", color = ne_color, size = 8) + 
  annotate("text", x = 3000, y = 0.9, label = "PHI", color = phi_color, size = 8) + 
  scale_x_reverse(breaks = seq(0, 3600, 300)) + ylim(c(0,1))+ 
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Super Bowl LII Win Probability Chart",
    subtitle = "Philadelphia Eagles vs. New England Patriots",
    caption = "Data from nflscrapR"
  ) + theme_bw()









