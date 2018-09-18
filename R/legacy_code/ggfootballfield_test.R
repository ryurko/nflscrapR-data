library(nflscrapR)

# Pull the playoff game IDs for the 2017 season:
playoff_ids_2017 <- extracting_gameids(2017, playoffs = TRUE)
# Scrape the superbowl:
superbowl_18 <- game_play_by_play(playoff_ids_2017[12])

library(tidyverse)

# Install the teamcolors package:
# devtools::install_github("beanumber/teamcolors")
library(teamcolors)

# Set up the colors for the chart:
nfl_teamcolors <- teamcolors %>% filter(league == "nfl")
phi_color <- nfl_teamcolors %>%
  filter(name == "Philadelphia Eagles") %>%
  pull(primary)
ne_color <- nfl_teamcolors %>%
  filter(name == "New England Patriots") %>%
  pull(secondary)


ex_pass <- superbowl_18[2,] %>%
  select(Drive, down, yrdline100, ydstogo, Yards.Gained, AirYards, 
         YardsAfterCatch, PassLocation, PassOutcome) %>%
  mutate(pass_side = ifelse(PassLocation == "left", 1,
                            ifelse(PassLocation == "right", -1, 0)),
         field_position = 100 - yrdline100)

theme_field <- function(aspect_ratio = 68/105) {
  
  theme_basic <- ggplot2::theme(
    panel.grid.major = ggplot2::element_blank(),
    panel.grid.minor = ggplot2::element_blank(),
    axis.title       = ggplot2::element_blank(),
    axis.ticks       = ggplot2::element_blank(),
    axis.text        = ggplot2::element_blank(),
    axis.line        = ggplot2::element_blank(),
    panel.background = ggplot2::element_blank(),
    panel.border     = ggplot2::element_blank()
  )
  
  if (!is.null(aspect_ratio)) {
    return(list(theme_basic,
                ggplot2::theme(aspect.ratio = aspect_ratio)))
  }
  
  list(theme_basic)
}


field_labels <- c("", "10", "20", "30", "40", "50", "40", "30", "20", "10", "")
field_labels_data <- data.frame(field_height = c(rep(-2, length(field_labels)),
                                                rep(2, length(field_labels))),
                                field_width_marks = rep(seq(0, 100, by = 10), 2),
                                field_width_labels = rep(field_labels, 2),
                                field_label_angles = c(rep(180, length(field_labels)),
                                                       rep(0, length(field_labels))))


geom_play <- function(play_type) {
  list(
    if (str_detect(tolower(play_type), "pass")) {
      geom_curve(aes(x = field_position,
                     xend = field_position + AirYards,
                     yend = pass_side), y = 0),
        geom_segment(aes(x = field_position + AirYards,
                         xend = field_position + AirYards + YardsAfterCatch,
                         y = pass_side, yend = pass_side))
    } else {
      geom_segment(aes(x = field_position,
                       xend = field_position + Yards.Gained,
                       yend = rush_side), y = 0)
    }
  )
}


sb_rush_pass <- superbowl_18 %>%
  filter(PlayType %in% c("Pass", "Run")) %>%
  select(Drive, down, yrdline100, ydstogo, Yards.Gained, AirYards, 
         YardsAfterCatch, PassLocation, PassOutcome, RunLocation,
         PlayType) %>%
  mutate(pass_side = ifelse(PassLocation == "left", 1,
                            ifelse(PassLocation == "right", -1, 0)),
         rush_side = ifelse(RunLocation == "left", 1,
                            ifelse(RunLocation == "right", -1, 0)),
         field_position = 100 - yrdline100)


ggplot(filter(sb_rush_pass, Drive == 1)) + 
  geom_text(data = field_labels_data,
            aes(label = field_width_labels,
                y = field_height, x = field_width_marks,
                angle = field_label_angles), vjust = 1.5,
            size = 7, color = "white") +
  geom_vline(aes(xintercept = field_position + ydstogo), color = "gold",
             size = 2) +
  geom_rect(xmin = -10, xmax = 0, ymin = -4, ymax = 4, fill = phi_color) +
  geom_rect(xmin = 100, xmax = 110, ymin = -2, ymax = 2, fill = ne_color) +
  geom_curve(data = filter(sb_rush_pass, Drive == 1, PlayType == "Pass"), 
             aes(x = field_position,
                 xend = field_position + AirYards,
                 yend = pass_side), y = 0, color = "blue",
             arrow = arrow(length = unit(0.03, "npc"))) +
  geom_segment(data = filter(sb_rush_pass, Drive == 1, PlayType == "Pass"),
               aes(x = field_position + AirYards,
                   xend = field_position + AirYards + YardsAfterCatch,
                   y = pass_side, yend = pass_side), color = "blue",
               arrow = arrow(length = unit(0.03, "npc"))) +
  geom_segment(data = filter(sb_rush_pass, Drive == 1, PlayType == "Run"),
               aes(x = field_position,
                   xend = field_position + Yards.Gained,
                   yend = rush_side), y = 0, color = "red",
               arrow = arrow(length = unit(0.03, "npc"))) +
  scale_x_continuous(limits = c(-10, 110), breaks = seq(0, 100, by = 10),
                     minor_breaks = seq(5, 95, by = 10)) +
  scale_y_continuous(limits = c(-2, 2)) +
  coord_cartesian(ylim = c(-2, 2), xlim = c(-10, 110), expand = FALSE) +
  theme(aspect.ratio = 53.33 / 120,
        axis.text = element_blank(),
        axis.title = element_blank(),
        panel.grid.major.y = element_blank(),
        panel.grid.minor.y = element_blank(),
        axis.ticks = element_blank(),
        panel.grid.major.x = element_line(size = 1, linetype = 'solid',
                                        colour = "white"), 
        panel.grid.minor.x = element_line(size = 0.5, linetype = 'solid',
                                        colour = "white"),
        panel.background = element_rect(fill = "#a1d99b"),
        plot.margin = margin(0, 0, 0, 0, "cm"),
        panel.border = element_rect(size = 1, linetype = 'solid',
                                    colour = "white", fill = NA))
  
#196f0c
#a1d99b

arrow = arrow(length = unit(0.03, "npc"))