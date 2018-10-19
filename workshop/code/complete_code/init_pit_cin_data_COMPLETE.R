# First install the devtools package you do not have it already:
# install.packages("devtools")

# Next using the devtools package, install `nflscrapR` from GitHub:
# devtools::install_github(repo = "maksimhorowitz/nflscrapR")

# Load the package:
library(nflscrapR)

# Access the Steelers games from this season:
pit_games <- scrape_game_ids(2018, teams = "PIT")

# Let's just pull the play-by-play data from this week's win against the Bengals:

pit_cin_pbp <- scrape_json_play_by_play(2018101401)

# Print out the first so many rows:
head(pit_cin_pbp)

# 255 variables! Let's use the tidyverse suite of packages to handle this data:
# install.packages("tidyverse")
library(tidyverse)

# We're now going to 'select' a subset of the columns, just to begin to 
# understand how to handle this data:

easy_pit_cin_pbp <- pit_cin_pbp %>%
  # First grab context about the play:
  select(posteam, defteam, drive, qtr, down, ydstogo, yardline_100,
         half_seconds_remaining, score_differential,
         # Next data on the result:
         desc, play_type, yards_gained, sp,
         # Finally the advanced metrics:
         ep, wp, epa, wpa)

# Let's compare the play-calling of the two teams:
easy_pit_cin_pbp %>%
  group_by(posteam, play_type) %>%
  count()

# Let's just focus on pass and run plays, break it down by... down:
easy_pit_cin_pbp %>%
  filter(play_type %in% c("pass", "run")) %>%
  group_by(posteam, down, play_type) %>%
  count()

# Or equivalently:
easy_pit_cin_pbp %>%
  filter(play_type == "pass" | play_type == "run") %>%
  group_by(posteam, down, play_type) %>%
  count()


# Enough with displaying tables! Let's make figures using the incredible
# ggplot2 package contained in the tidyverse suite of packages:
easy_pit_cin_pbp %>%
  filter(play_type %in% c("pass", "run")) %>%
  group_by(posteam, down, play_type) %>%
  count() %>%
  # Now let's remove that NA from the two point conversion:
  filter(!is.na(down)) %>%
  # Looking at counts really isn't appropriate, let's compare the proportions:
  group_by(posteam, down) %>%
  mutate(n_plays = sum(n),
         prop_plays = n / n_plays) %>%
  # Now actually create the chart!
  ggplot(aes(x = play_type, y = prop_plays, fill = posteam)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~down, ncol = 3) +
  labs(x = "Play type", y = "Proportion of plays")
  
# We can make this better, let's take advantage of the provided team colors
# with the dataset available in nflscrapR (courtesy of the `teamcolors` package):
data("nflteams")
pit_color <- nflteams %>%
  filter(abbr == "PIT") %>%
  pull(primary)
cin_color <- nflteams %>%
  filter(abbr == "CIN") %>%
  pull(secondary)

easy_pit_cin_pbp %>%
  filter(play_type %in% c("pass", "run")) %>%
  group_by(posteam, down, play_type) %>%
  count() %>%
  filter(!is.na(down)) %>%
  group_by(posteam, down) %>%
  mutate(n_plays = sum(n),
         prop_plays = n / n_plays) %>%
  ggplot(aes(x = play_type, y = prop_plays, fill = posteam)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~down, ncol = 3) +
  scale_fill_manual(values = c(cin_color, pit_color)) +
  labs(x = "Play type", y = "Proportion of plays",
       fill = "Team",
       title = "Comparison of Bengals and Steelers play-calling by down") +
  theme_bw() +
  theme(strip.background = element_blank(),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 18),
        legend.text = element_text(size = 12),
        strip.text = element_text(size = 14))


# What about the performance of these plays? Let's take a look at yards gained:
easy_pit_cin_pbp %>%
  filter(play_type %in% c("pass", "run")) %>%
  group_by(posteam, down, play_type) %>%
  filter(!is.na(down)) %>%
  # Now use the summarise function, generate the average yards gained:
  summarise(yards_per_play = mean(yards_gained)) %>%
  ggplot(aes(x = play_type, y = yards_per_play, fill = posteam)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~down, ncol = 3) +
  scale_fill_manual(values = c(cin_color, pit_color)) +
  labs(x = "Play type", y = "Yards per play",
       fill = "Team",
       title = "Comparison of CIN and PIT yards gained per play\nby type and down") +
  theme_bw() +
  theme(strip.background = element_blank(),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 18),
        legend.text = element_text(size = 12),
        strip.text = element_text(size = 14))
  
# Steelers offense was alot more efficient through the air compared to the
# Bengals - but one number summaries toss out alot of information. Let's look
# the distribution of values instead:
easy_pit_cin_pbp %>%
  filter(play_type %in% c("pass", "run")) %>%
  filter(!is.na(down)) %>%
  # Now use the summarise function, generate the average yards gained:
  ggplot(aes(x = play_type, y = yards_gained, fill = posteam)) +
  geom_violin() + 
  # geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~down, ncol = 3) +
  scale_fill_manual(values = c(cin_color, pit_color)) +
  labs(x = "Play type", y = "Yards per play",
       fill = "Team",
       title = "Comparison of CIN and PIT yards gained per play\nby type and down") +
  theme_bw() +
  theme(strip.background = element_blank(),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 18),
        legend.text = element_text(size = 12),
        strip.text = element_text(size = 14))

# Access the ggbeeswarm package:
# install.packages('ggbeeswarm')
library(ggbeeswarm)

# Let's add points on top:
easy_pit_cin_pbp %>%
  filter(play_type %in% c("pass", "run")) %>%
  filter(!is.na(down)) %>%
  # Now going to display distribution of yards gained:
  ggplot(aes(x = play_type, y = yards_gained, fill = posteam)) +
  geom_violin(alpha = 0.3) + 
  # Display the individual points on top of the violin plots:
  geom_beeswarm(aes(color = posteam), dodge.width = 1) +
  # Add a reference line marking 0 yards gained:
  geom_hline(yintercept = 0, linetype = "dashed", color = "darkred", 
             size = 2) +
  facet_wrap(~down, ncol = 3) +
  scale_fill_manual(values = c(cin_color, pit_color)) +
  scale_color_manual(values = c(cin_color, pit_color), guide = FALSE) +
  labs(x = "Play type", y = "Yards gained",
       fill = "Team",
       title = "Comparison of CIN and PIT yards gained by type and down") +
  theme_bw() +
  theme(strip.background = element_blank(),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 18),
        legend.text = element_text(size = 12),
        strip.text = element_text(size = 14))

# What's that single passing play?
easy_pit_cin_pbp %>%
  filter(play_type == "pass" & yards_gained > 40) %>%
  View()
  
# What's the problem with only looking at yards gained???

# Now let's look at the expected points added instead:
easy_pit_cin_pbp %>%
  filter(play_type %in% c("pass", "run")) %>%
  filter(!is.na(down)) %>%
  # Now use the summarise function, generate the average yards gained:
  ggplot(aes(x = play_type, y = epa, fill = posteam)) +
  geom_violin(alpha = 0.3) + 
  geom_beeswarm(aes(color = posteam), dodge.width = 1) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "darkred", 
             size = 2) +
  facet_wrap(~down, ncol = 3) +
  scale_fill_manual(values = c(cin_color, pit_color)) +
  scale_color_manual(values = c(cin_color, pit_color), guide = FALSE) +
  labs(x = "Play type", y = "Expected points added (EPA)",
       fill = "Team",
       title = "Comparison of CIN and PIT EPA by type and down") +
  theme_bw() +
  theme(strip.background = element_blank(),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 18),
        legend.text = element_text(size = 12),
        strip.text = element_text(size = 14))

# The most valuable plays by EPA for each team?
easy_pit_cin_pbp %>%
  group_by(posteam) %>%
  filter(play_type == "pass" & !is.na(down)) %>%
  summarise(max_epa = max(epa, na.rm = TRUE),
            max_epa_play = desc[which.max(epa)],
            ep = ep[which.max(epa)],
            down = down[which.max(epa)],
            ydstogo = ydstogo[which.max(epa)],
            yardline_100 = yardline_100[which.max(epa)]) 
  
# What about win probability added (WPA)?
easy_pit_cin_pbp %>%
  filter(play_type %in% c("pass", "run")) %>%
  filter(!is.na(down)) %>%
  # Now use the summarise function, generate the average yards gained:
  ggplot(aes(x = play_type, y = wpa, fill = posteam)) +
  geom_violin(alpha = 0.3) + 
  geom_beeswarm(aes(color = posteam), dodge.width = 1) +
  geom_hline(yintercept = 0, linetype = "dashed", color = "darkred", 
             size = 2) +
  facet_wrap(~down, ncol = 3) +
  scale_fill_manual(values = c(cin_color, pit_color)) +
  scale_color_manual(values = c(cin_color, pit_color), guide = FALSE) +
  labs(x = "Play type", y = "Win probability added (WPA)",
       fill = "Team",
       title = "Comparison of CIN and PIT WPA by type and down") +
  theme_bw() +
  theme(strip.background = element_blank(),
        axis.title = element_text(size = 14),
        axis.text = element_text(size = 10),
        plot.title = element_text(size = 18),
        legend.text = element_text(size = 12),
        strip.text = element_text(size = 14))


# The most valuable plays by EPA for each team?
easy_pit_cin_pbp %>%
  group_by(posteam) %>%
  filter(!is.na(down)) %>%
  summarise(max_wpa = max(wpa, na.rm = TRUE),
            max_wpa_play = desc[which.max(wpa)],
            wp = wp[which.max(wpa)],
            qtr = qtr[which.max(wpa)],
            down = down[which.max(wpa)],
            ydstogo = ydstogo[which.max(wpa)],
            yardline_100 = yardline_100[which.max(wpa)]) 

# Based on WPA, JuJu's catch was actually the most valuable play of the game
# for the Steelers by nearly guaranteeing their victory.

# Let's put this all together to display a win probability chart:
pit_cin_pbp %>%
  filter(!is.na(home_wp),
         !is.na(away_wp),
         timeout == 0) %>%
  select(game_seconds_remaining,
         home_wp,
         away_wp) %>%
  # Rather than having separate columns for each team's win probability,
  # we can gather them into one column:
  gather(team, wpa, -game_seconds_remaining) %>%
  ggplot(aes(x = game_seconds_remaining, y = wpa, color = team)) +
  geom_line(size = 2) +
  geom_hline(yintercept = 0.5, color = "gray", linetype = "dashed") +
  scale_color_manual(labels = c("PIT", "CIN"),
                     values = c(pit_color, cin_color),
                     guide = FALSE) +
  scale_x_reverse(breaks = seq(0, 3600, 300)) + 
  annotate("text", x = 3000, y = .80, label = "CIN", color = cin_color, size = 8) + 
  annotate("text", x = 3000, y = .20, label = "PIT", color = pit_color, size = 8) +
  geom_vline(xintercept = 900, linetype = "dashed", black) + 
  geom_vline(xintercept = 1800, linetype = "dashed", black) + 
  geom_vline(xintercept = 2700, linetype = "dashed", black) + 
  geom_vline(xintercept = 0, linetype = "dashed", black) + 
  labs(
    x = "Time Remaining (seconds)",
    y = "Win Probability",
    title = "Week 6 Win Probability Chart",
    subtitle = "Pittsburgh Steelers vs Cincinnati Bengals",
    caption = "Data from nflscrapR"
  ) + theme_bw()

# ----------------------------------------------------------------------------
# Use the nflteams data set to find your team's abbreviation then use
# the function below to scrape a dataset of their games:
# team_games_18 <- scrape_game_ids(2018, teams = "PIT")
# Pick a game_id and use the following to get the game X's play-by-play:
# game_pbp <- scrape_json_play_by_play(X)
