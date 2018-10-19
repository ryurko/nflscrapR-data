# Next using the devtools package, install `nflscrapR` from GitHub:
# devtools::install_github(repo = "maksimhorowitz/nflscrapR")

# Load the package:
library(nflscrapR)

# Access tidyverse
# install.packages("tidyverse")
library(tidyverse)

# Let's work with season-level data this time, could use the 
# scrape_season_play_by_play() function to do this:
# pbp_18 <- scrape_season_play_by_play(2018)
# But this takes awhile, instead can directly access data I've already scraped:
pbp_18 <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2018.csv")

# Let's recreate the figure Brian Burke tweets out, with team EPA per game. 





# Great package to use for this plot is ggrepel,
# install.packages("ggrepel")
library(ggrepel)




# Let's focus on some ways of measuring QB performance, one popular
# EPA-based metric is the Success Rate. This is simply the percentage
# of plays with positive EPA. We'll focus on QBs and compare their EPA per
# dropback against their dropback success rate:

# -----------------------------------------------------------------------------
# OPTIONAL PART FOR THOSE CURIOUS ABOUT SUCCESS RATE DEFINITION:
# Maybe there's a problem with this definition of success rate - what about
# the fractional values close to 0? Do we really care about those? Let's 
# look at the EPA distribution for these dropbacks:

# -----------------------------------------------------------------------------

# But wait, each passing play is made up of air yards and yards after catch -
# and nflscrapR actually estimates the EPA and WPA for both! Let's plot the 
# QB air and yac EPA per completion on x and y axis, maybe there's some
# structure...


# ----------------------------------------------------------------------------
# Can look at other seasons going back to 2009 by replacing the year in
# the following code:
# pbp_X <- read_csv("https://raw.githubusercontent.com/ryurko/nflscrapR-data/master/play_by_play_data/regular_season/reg_pbp_2018.csv")

