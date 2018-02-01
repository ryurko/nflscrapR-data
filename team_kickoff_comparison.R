library(tidyverse)

pbp_data <- bind_rows(read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2009.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2010.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2011.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2012.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2013.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2014.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2015.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2016.csv"),
                      read_csv("https://raw.github.com/ryurko/nflscrapR-data/master/data/season_play_by_play/pbp_2017.csv"))

# Only look at kickoffs:

kickoff_plays <- pbp_data %>%
  filter(PlayType == "Kickoff", !is.na(DefensiveTeam)) %>%
  select(Season, DefensiveTeam, desc, EPA, WPA, Fumble) %>%
  rename(Team = DefensiveTeam) %>%
  mutate(Team = ifelse(Team == "JAC", "JAX",
                       ifelse(Team == "SD", "LAC", 
                              ifelse(Team == "STL", "LA", Team))),
         EPA = -1 * EPA,
         WPA = -1 * WPA,
         onside = ifelse(stringr::str_detect(desc, "onside"), 1, 0)) %>%
  select(-desc)

# Summarise each team's performance by taking the average and sum:

all_kickoff_summary <- kickoff_plays %>%
  group_by(Season, Team) %>%
  summarise(Ave_EPA = mean(EPA, na.rm = TRUE),
            Total_EPA = sum(EPA, na.rm = TRUE),
            Ave_WPA = mean(WPA, na.rm = TRUE),
            Total_WPA = sum(WPA, na.rm = TRUE)) %>%
  arrange(desc(Total_EPA))

# Without onside kicks:
only_kickoff_summary <- kickoff_plays %>%
  filter(onside == 0) %>%
  group_by(Season, Team) %>%
  summarise(Ave_EPA = mean(EPA, na.rm = TRUE),
            Total_EPA = sum(EPA, na.rm = TRUE),
            Ave_WPA = mean(WPA, na.rm = TRUE),
            Total_WPA = sum(WPA, na.rm = TRUE)) %>%
  arrange(desc(Total_EPA))

# Exclude fumbles:
all_kickoff_summary_no_fum <- kickoff_plays %>%
  filter(Fumble == 0) %>%
  group_by(Season, Team) %>%
  summarise(Ave_EPA = mean(EPA, na.rm = TRUE),
            Total_EPA = sum(EPA, na.rm = TRUE),
            Ave_WPA = mean(WPA, na.rm = TRUE),
            Total_WPA = sum(WPA, na.rm = TRUE)) %>%
  arrange(desc(Total_EPA))

# Without onside kicks:
only_kickoff_summary_no_fum <- kickoff_plays %>%
  filter(onside == 0, Fumble == 0) %>%
  group_by(Season, Team) %>%
  summarise(Ave_EPA = mean(EPA, na.rm = TRUE),
            Total_EPA = sum(EPA, na.rm = TRUE),
            Ave_WPA = mean(WPA, na.rm = TRUE),
            Total_WPA = sum(WPA, na.rm = TRUE)) %>%
  arrange(desc(Total_EPA))

# Kickoff performance in 2017:
all_kickoff_summary_17 <- all_kickoff_summary %>%
  filter(Season == 2017)
only_kickoff_summary_17 <- only_kickoff_summary %>%
  filter(Season == 2017)

all_kickoff_summary_17_no_fum <- all_kickoff_summary_no_fum %>%
  filter(Season == 2017)
only_kickoff_summary_17_no_fum <- only_kickoff_summary_no_fum %>%
  filter(Season == 2017)


library(ggrepel)

ggplot(all_kickoff_summary_17, aes(x = Total_EPA, y = Total_WPA)) + 
  geom_point() +
  geom_text_repel(aes(label = Team), size = 4) + theme_bw() +
  xlab("Total Expected Points Added") + ylab("Total Win Probability Added") +
  geom_hline(yintercept = 0, color="darkorange4",linetype="dashed") +
  geom_vline(xintercept = 0,color="darkorange4",linetype="dashed") +
  geom_hline(yintercept = 1, color="darkslateblue",linetype="dashed") +
  labs(title = "Team Kickoff Performance with Total WPA against Total EPA in 2017 (including onside kicks)")

ggplot(only_kickoff_summary_17, aes(x = Total_EPA, y = Total_WPA)) + 
  geom_point() + 
  geom_text_repel(aes(label = Team), size = 4) + theme_bw() +
  xlab("Total Expected Points Added") + ylab("Total Win Probability Added") +
  geom_hline(yintercept = 0, color="darkorange4",linetype="dashed") +
  geom_vline(xintercept = 0,color="darkorange4",linetype="dashed") +
  geom_hline(yintercept = 1, color="darkslateblue",linetype="dashed") +
  labs(title = "Team Kickoff Performance with Total WPA against Total EPA in 2017 (excluding onside kicks)")

ggplot(only_kickoff_summary_17_no_fum, aes(x = Total_EPA, y = Total_WPA)) + 
  geom_point() + 
  geom_text_repel(aes(label = Team), size = 4) + theme_bw() +
  xlab("Total Expected Points Added") + ylab("Total Win Probability Added") +
  geom_hline(yintercept = 0, color="darkorange4",linetype="dashed") +
  geom_vline(xintercept = 0,color="darkorange4",linetype="dashed") +
  geom_hline(yintercept = 1, color="darkslateblue",linetype="dashed") +
  labs(title = "Team Kickoff Performance with Total WPA against Total EPA in 2017 (excluding onside kicks and fumbles)")

