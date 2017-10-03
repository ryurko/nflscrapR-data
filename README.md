# nflscrapR Data Files

Within the data folder are 3 folders containing .csv files to download.  To download a dataset, click on it then right click on the Download button to save the file.

# Season Play-by-play

* [2009 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/data/season_play_by_play/pbp_2009.csv)
* [2010 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/data/season_play_by_play/pbp_2010.csv)
* [2011 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/data/season_play_by_play/pbp_2011.csv)
* [2012 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/data/season_play_by_play/pbp_2012.csv)
* [2013 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/data/season_play_by_play/pbp_2013.csv)
* [2014 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/data/season_play_by_play/pbp_2014.csv)
* [2015 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/data/season_play_by_play/pbp_2015.csv)
* [2016 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/data/season_play_by_play/pbp_2016.csv)
* [2017 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/data/season_play_by_play/pbp_2017.csv)


The season_play_by_play folder contains play-by-play datasets for each regular season game in each season from 2009-2016.  The files are separated by season. Each dataset contains 100 columns (see the nflscrapR game_play_by_play() and season_play_by_play() function documentation for descriptions).

# Season and Game Player Stats

* [Season-Player Passing Stats](https://github.com/ryurko/nflscrapR-data/blob/master/data/season_player_stats/season_passing_df.csv)
* [Season-Player Receiving Stats](https://github.com/ryurko/nflscrapR-data/blob/master/data/season_player_stats/season_receiving_df.csv)
* [Season-Player Rushing Stats](https://github.com/ryurko/nflscrapR-data/blob/master/data/season_player_stats/season_rushing_df.csv)

* [Game-Player Passing Stats](https://github.com/ryurko/nflscrapR-data/blob/master/data/game_player_stats/game_passing_df.csv)
* [Game-Player Receiving Stats](https://github.com/ryurko/nflscrapR-data/blob/master/data/game_player_stats/game_receiving_df.csv)
* [Game-Player Rushing Stats](https://github.com/ryurko/nflscrapR-data/blob/master/data/game_player_stats/game_rushing_df.csv)


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
24. Total_WPA - total win probability added from pass attempts
25. Win_Success_Rate - percentage of pass attempts with positive WPA
26. WPA_per_Att - WPA per pass attempt
27. WPA_per_Comp - WPA per completion
28. WPA_Comp_Perc - completion percentage weighted by the WPA for each play
29. Total_Clutch_EPA - total EPA from pass attempts weighted by each play's WPA
30. airEPA_Comp - total EPA in the air for completed passes
31. airEPA_Incomp - total EPA that could've been from incomplete passes
32. Total_airEPA - total EPA in the air from all passes
33. airEPA_per_Att - total airEPA per pass attempt
34. airEPA_per_Comp - total airEPA from completions per completion
35. air_Success_Rate - percentage of pass attempts with positive airEPA
36. air_Comp_Success - percentage of pass attempts with positive airEPA for completions

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
22. Total_WPA - total win probability added from all targets
23. Win_Success_Rate - percentage of targets with positive WPA
24. WPA_per_Target - WPA per target
25. WPA_per_Rec - WPA per reception
26. WPA_Rec_Perc - reception percentage weighted by the WPA for each play
27. Total_Clutch_EPA - total EPA from targets weighted by each play's WPA
28. AirYards_per_Target - air yards per target
29. airEPA_per_Target - airEPA per target providing the value of the air yards
30. yacEPA_Rec - EPA from yards after catch for receptions
31. yacEPA_Drop - the cost of dropping/missing the pass
32. Total_yacEPA - total EPA from yards after catch including cost of drops
33. yacEPA_per_Target - total EPA from yards after catch per target
34. yacEPA_per_Rec - total EPA from yards after catch per reception
35. yac_Success_Rate - percentage of targets with positive yacEPA
36. yac_Rec_Success_Rate - percentage of targets with positive yacEPA for receptions

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
13. Total_WPA - total win probability added from all carries
14. Win_Success_Rate - percentage of carries with positive WPA
15. WPA_per_Car - WPA per carry
16. WPA_Ratio - ratio of WPA for carries with positive WPA to total WPA
17. Total_Clutch_EPA - total EPA from carries weighted by each play's WPA

