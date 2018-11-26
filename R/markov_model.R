# This file recreates the Markov model of Goldner using data for seasons between
# 2009 and 2017:

# Access tidyverse:
library(tidyverse)

# Join together the regular season play-by-play data including a column to 
# denote the season from 2009 to 2017:
pbp_data <- map_dfr(c(2009:2017),
                    function(x) {
                      read_csv(paste0("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_",
                                      x, ".csv")) %>%
                        mutate(pbp_season = x) %>%
                        select(-fumble_recovery_2_yards)
                    })


# Define a function categorize the yards to go and yardline_100 columns, 
# following example from this R-bloggers post: https://www.r-bloggers.com/r-function-of-the-day-cut-2/
yard_cut <- function(x, lower = 1, upper, by = 5, sep = "-", above_char = "+") {
  labs <- c(paste(seq(lower, upper - by, by = by),
                  seq(lower + by - 1, upper - 1, by = by),
                  sep = sep),
            paste(upper, above_char, sep = ""))
  
  cut(floor(x), breaks = c(seq(lower, upper, by = by), Inf),
      right = FALSE, labels = labs)
}


# Remove kickoffs, PATs, and any missing play_type:
clean_pbp_data <- pbp_data %>%
  filter(!is.na(play_type),
         !is.na(ydstogo),
         !is.na(yardline_100),
         !(play_type %in% c("kickoff", "extra_point")),
         two_point_attempt == 0,
         timeout == 0,
         kickoff_attempt == 0,
         extra_point_attempt == 0,
         ydstogo > 0) %>%
  # Now create columns that cut the yardline and yards to go into factors
  # based on 5 yard increments (lumping 21+ yards to go together):
  mutate(ydstogo_group = yard_cut(ydstogo, upper = 21), 
         yardline_100_group = yard_cut(yardline_100, upper = 96)) %>%
  # Next group by the game_id and drive, creating variables that are
  # both the leads for the down, ydstogo_group, and yardline_100_group
  # as well as an indicator for the last play in the drive:
  group_by(game_id, drive) %>%
  mutate(play_index = row_number(),
         drive_length = n(),
         next_down = lead(down),
         next_ydstogo_group = lead(ydstogo_group),
         next_yardline_100_group = lead(yardline_100_group)) %>%
  ungroup() %>%
  mutate(last_play = ifelse(play_index == drive_length, 1, 0)) %>%
  # Next create variables denoting the current state, as well as the 
  # absorption state for plays that were the last play in the drive:
  unite(play_state, down, ydstogo_group, yardline_100_group, 
        sep = "--", remove = FALSE) %>%
  unite(next_play_state, next_down, next_ydstogo_group, next_yardline_100_group,
        sep = "--", remove = FALSE) %>%
  mutate(absorption_state = case_when(
    td_team == posteam & touchdown == 1 ~ "touchdown",
    field_goal_result == "made" ~ "field_goal",
    safety == 1 ~ "safety",
    field_goal_result %in% c("blocked", "missed") ~ "missed_field_goal",
    fumble_lost == 1 ~ "fumble",
    interception == 1 ~ "interception",
    fourth_down_failed == 1 ~ "turnover_on_downs",
    punt_attempt == 1 ~ "punt",
    TRUE ~ "end_of_time"
  )) %>%
  # Make the absorption state the next_play_state for the last plays of the drive:
  mutate(next_play_state = ifelse(last_play == 1, absorption_state, next_play_state))

# View the frequencies of each transient state:
transient_state_df <- clean_pbp_data %>%
  group_by(play_state) %>%
  count() %>%
  ungroup() %>%
  mutate(state_prop = n / sum(n))

summary(transient_state_df$n)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 3.0    96.0   284.0   968.8  1001.2 16473.0

# View the distribution of the frequencies:
ggplot(transient_state_df, aes(x = n)) +
  geom_histogram(fill = "darkblue") +
  theme_bw() +
  labs(x = "Frequency of state",
       y = "Count")

# Vector of the absortion states:
absorption_states <- unique(clean_pbp_data$absorption_state)

# Now create a dataframe of the transition frequencies and probabilities:
transition_df <- clean_pbp_data %>%
  group_by(play_state, next_play_state) %>%
  count() %>%
  ungroup() %>%
  group_by(play_state) %>%
  mutate(total_plays = sum(n)) %>%
  ungroup() %>%
  mutate(transition_prob = n / total_plays) %>%
  # Append rows that are just the absorptions for ease in making the 
  # complete transition matrix:
  bind_rows(data.frame(play_state = absorption_states,
                       next_play_state = absorption_states,
                       transition_prob = rep(1, length(absorption_states))))

# Create the transition matrix (as a data frame, hence why there is one more
# column than rows):
transition_matrix_df <- transition_df %>%
  select(play_state, next_play_state, transition_prob) %>%
  arrange(desc(play_state), desc(next_play_state)) %>%
  spread(next_play_state, transition_prob)
transition_matrix_df[is.na(transition_matrix_df)] <- 0

# Find the indices of absorption states:
row_absorption_i <- which(transition_matrix_df$play_state %in% absorption_states)
col_absorption_i <- which(colnames(transition_matrix_df) %in% absorption_states)

# Can now use the general form of the transition matrix for absorbing Markov
# chain with n transient states and r absorbing states to calculate the 
# absorption probabilities and expected number of plays until absorption:

# Grab the Q matrix - n x n transition matrix for transient states:
q_matrix <- as.matrix(transition_matrix_df[1:(row_absorption_i[1] - 1),
                                           2:(col_absorption_i[1] - 1)])

# Grab the R matrix - n x r transition matrix to the absorption states:
r_matrix <- as.matrix(transition_matrix_df[1:(row_absorption_i[1] - 1),
                                           col_absorption_i])

# Calculate the fundamental matrix (I - Q)^{-1} where I is n x n identity matrix:
fundamental_matrix <- solve(diag(nrow = nrow(q_matrix),
                                 ncol = nrow(q_matrix)) - q_matrix)

# Calculate the row sums to provide the expected number of plays until aborption
# for each transient state:
expected_n_plays <- rowSums(fundamental_matrix)

# Probability of reaching absorption states:
prob_absorption <- fundamental_matrix %*% r_matrix

# Now make a final data frame that mean for tidy use:
tidy_markov_football_df <- as.data.frame(prob_absorption) %>%
  mutate(play_state = rownames(prob_absorption),
         expected_n_plays = expected_n_plays) %>%
  separate(play_state, c("down",
                         "ydstogo_group", 
                         "yardline_100_group"),
           remove = FALSE, sep = "--") %>%
  # Reorder the levels of the yards group so that the 6-10 is second for both:
  mutate(ydstogo_group = fct_relevel(ydstogo_group, "6-10", after = 1),
         yardline_100_group = fct_relevel(yardline_100_group, "6-10", after = 1))
         

# What's the range of the values for expected number of plays:
summary(tidy_markov_football_df$expected_n_plays)
# Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
# 1.016   2.016   3.523   3.520   4.986   7.475

# Find maximum absorption probabilities for each absorption state:
max_prob_data <- tidy_markov_football_df[colnames(tidy_markov_football_df) %in% absorption_states] %>%
  gather(absorbing_state, absorbing_prob) %>%
  group_by(absorbing_state) %>%
  summarise(max_absorbing_prob = max(absorbing_prob)) %>%
  # add column designating this is from nflscrapR:
  mutate(prob_source = "nflscrapR") %>%
  # now append the max absorption probabilities from Goldner's paper:
  bind_rows({
    data.frame(absorbing_state = absorption_states,
               max_absorbing_prob = c(0.138, 1, 0.324,
                                      0.127, 0.803,
                                      0.210, 1, 0.207,
                                      0.067),
               prob_source = rep("Goldner", 9)) 
    })
  
# Display the differences side by side barcharts:
ggplot(max_prob_data, aes(x = absorbing_state,
                          y = max_absorbing_prob,
                          fill = prob_source)) +
  geom_bar(position = "dodge", stat = "identity") +
  scale_fill_manual(values = c("darkblue", "darkorange")) +
  scale_x_discrete(labels = c("End half/game",
                              "Field goal",
                              "Fumble",
                              "Interception",
                              "Missed field goal",
                              "Punt",
                              "Safety",
                              "Touchdown",
                              "Turnover on downs")) +
  labs(x = "Absorbing state",
       y = "Max absorption probability",
       fill = "Source",
       title = "Comparison of nflscrapR max absorption probabilities for each absorbing state with Goldner's original paper") +
  theme_bw() +
  theme(axis.text = element_text(size = 14),
        axis.title = element_text(size = 16),
        legend.title = element_text(size = 16),
        legend.text = element_text(size = 14),
        plot.title = element_text(size = 20))

# Display the expected number of plays remaining in drive based on the down,
# field position, and yards to go:
ggplot(tidy_markov_football_df, 
       aes(x = yardline_100_group,
           y = expected_n_plays,
           color = as.integer(ydstogo_group),
           group = ydstogo_group)) +
  scale_color_gradient(low = "darkblue", high = "darkorange",
                       labels = levels(tidy_markov_football_df$ydstogo_group)) +
  geom_line() +
  facet_wrap(~ down, ncol = 2,
             labeller = as_labeller(c("1" = "1st down",
                                 "2" = "2nd down",
                                 "3" = "3rd down",
                                 "4" = "4th down"))) +
  theme_bw() +
  labs(x = "Yards from opponent's endzone",
       y = "Expected number of remaining plays in drive",
       color = "Yards to go\nfor first down",
       title = "Expected number of remaining plays in drive based on field position, yards to go, and down",
       subtitle = "Based on absorbing markov chain constructed with data from 2009-2017",
       caption = "Data accessed via nflscrapR") +
  theme(strip.background = element_blank(),
        strip.text = element_text(size = 14),
        legend.text = element_text(size = 14),
        legend.title = element_text(size = 16),
        axis.text.y = element_text(size = 16),
        axis.text.x = element_text(size = 16, angle = 90),
        axis.title = element_text(size = 18),
        plot.title = element_text(size = 22),
        plot.subtitle = element_text(size = 18),
        plot.caption = element_text(size = 14))
  

