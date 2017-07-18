# nflscrapR Data Files

Within the data folder are 3 folders containing .csv files to download.

# Season Play-by-play

The season_play_by_play folder contains play-by-play datasets for each regular season game in each season from 2009-2016.  The files are separated by season. Each dataset contains 89 columns (see the nflscrapR game_play_by_play() function documentation for descriptions).

# Season and Game Player Stats

The season_player_stats folder contains datasets with player statistics at the season level, while the game_player_stats contains datasets with player statistics at the game level.  There are 3 types of datasets in each folder:

1. Passing
2. Receiving
3. Rushing

Both game and season level have a Team column with the abbreviation for which team the player was on.  The game level datasets contain a column for the opponent's team.

The datasets contain traditional stats as well as expected points added (EPA) based metrics.  [See here for which stats are more predictable on a seasonal basis](http://www.stat.cmu.edu/~ryurko/pdf/greatlakes_2017.pdf) (HINT: not all yards are created equal)

# Passing Stats

1. Attempts - number of pass attempts
2. Completions - number of completed passes
3. Comp_Perc - completion percentage
4. Total_Yards - total yards gained from passing
5. Total_AirYards - total air yards thrown (both complete and incomplete passes)
6. Yards_per_Att - yards gained from passing per attempt
7. Yards_per_Comp - yards gained from passing per completion
8. AirYards_per_Att - air yards thrown per pass attempt (all pass attempts)
9. AirYards_per_Comp - air yards thrown per completion (only completed passes)
10. TimesHit - number of times the QB was knocked down (includes being hit on pass attempts)
11. Interceptions - number of interceptions
12. TDs - number of touchdowns thrown
13. Air_TDs - number of touchdowns thrown with 0 yards after catch
14. Air_TD_Rate - percentage of touchdowns thrown in the air
15. TD_to_Int - TD to INT ratio
16. Total_EPA - total expected points added from pass attempts
17. Success_Rate - percentage of pass attempts with positive EPA
18. EPA_per_Att - EPA per pass attempt
19. EPA_per_Comp - EPA per completion
20. EPA_Comp_Perc - completion percentage weighted by the EPA for each play
21. TD_per_Att - TDs thrown per pass attempt
22. Int_per_Att - INTs thrown per pass attempt
23. TD_per_Comp - TDs thrown per completion

# Receiving Stats

1. Targets - number of targets
2. Receptions - number of receptions
3. Total_Yards - total yards gained from receiving
4. Total_YAC - total yards gained after catch
5. Yards_per_Rec - yards gained per reception
6. Yards_per_Target - yards gained per target
7. YAC_per_Rec - yards gained after catch per reception
8. Rec_Percentage - reception percentage
9. Fumbles - number of fumbles
10. TDs - number of TD receptions
11. AC_TDs - number of touchdowns receptions with positive yards after catch
12. AC_TD_Rate - percentage of touchdown receptions with positive yards after catch
13. TD_to_Fumbles - number of interceptions
14. Total_EPA - total expected points added from all targets
15. Success_Rate - percentage of targets with positive EPA
16. EPA_per_Rec - EPA per reception
17. EPA_per_Target - EPA per target
18. EPA_Rec_Perc - reception percentage weighted by the EPA for each play
19. TD_per_Targets - TDs caught per target
20. Fumbles_per_Rec - fumbles per reception
21. TD_per_Rec - TDs caught per reception

# Rushing Stats

1. Carries - number of carries
2. Total_Yards - total yards gained from rushing
3. Yards_per_Car - yards gained per carry
4. Fumbles - number of fumbles
5. TDs - number of TD rushes
6. TD_to_Fumbles - number of interceptions
7. Total_EPA - total expected points added from all carries
8. Success_Rate - percentage of carries with positive EPA
9. EPA_per_Car - EPA per reception
10. EPA_Ratio - ratio of EPA for carries with positive EPA to total EPA
11. TD_per_Car - TDs per carry
12. Fumbles_per_Car - fumbles per carry

