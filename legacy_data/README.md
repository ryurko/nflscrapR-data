# nflscrapR Data Files

Within the data folder are 3 folders containing .csv files to download.  To download a play-by-play dataset, click on it then right click on the Download button, and use save link as to save the file.

For the team and player season/game stats, click on it then right click on the Raw button, , and use save link as to save the file.

# Season Play-by-play

* [2009 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_play_by_play/pbp_2009.csv)
* [2010 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_play_by_play/pbp_2010.csv)
* [2011 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_play_by_play/pbp_2011.csv)
* [2012 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_play_by_play/pbp_2012.csv)
* [2013 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_play_by_play/pbp_2013.csv)
* [2014 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_play_by_play/pbp_2014.csv)
* [2015 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_play_by_play/pbp_2015.csv)
* [2016 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_play_by_play/pbp_2016.csv)
* [2017 play-by-play](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_play_by_play/pbp_2017.csv)

The season_play_by_play folder contains play-by-play datasets for each regular season game in each season from 2009-2016.  The files are separated by season. Each dataset contains 100 columns (see the nflscrapR game_play_by_play() and season_play_by_play() function documentation for descriptions).

Through list manipulation using the do.call and rbind functions a 13 column dataframe with basic information populates directly from the NFL JSON API. These columns include the following:

"Drive" - Drive number

"sp" - Whether the play resulted in a score (any kind of score)

"qtr" - Quarter of Game

"down" - Down of the given play

"time" - Time at start of play

"yrdln" - Between 0 and 50

"ydstogo" - Yards to go for a first down

"ydsnet" - Total yards gained on a given drive

"posteam" - The team on offense

"AirYards" - Number of yards the ball was thrown in the air for both complete and incomplete pass attempts (negative means behind line of scrimmage)

"YardsAfterCatch" - Number of yards receiver gained after catch

"QBHit" - Binary: 1 if the QB was knocked to the ground else 0

"desc" - A detailed description of what occured during the play

Through string manipulation and parsing of the description column using base R and stringR, columns were added to the original dataframe allowing the user to have a detailed breakdown of the events of each play. Also provided are calculations for the expected points and win probability for each play using models built entirely on nflscrapR data. The added variables are specified below:

"Date" - Date of game

"GameID" - The ID of the specified game

"TimeSecs" - Time remaining in game in seconds

"PlayTimeDiff" - The time difference between plays in seconds

"DefensiveTeam" - The defensive team on the play (for punts the receiving team is on defense, for kickoffs the receiving team is on offense)

"TimeUnder" - Minutes remaining in half

"SideofField" - The side of the field that the line of scrimmage is on

yrdline100 - Distance to opponents endzone, ranges from 1-99 situation

GoalToGo - Binary: 1 if the play is in a goal down situation else 0

"FirstDown" - Binary: 1if the play resulted in a first down conversion else 0

"PlayAttempted" - A variable used to count the number of plays in a game (should always be equal to 1)

"Yards.Gained" - Amount of yards gained on the play

"Touchdown" - Binary: 1 if the play resulted in a TD else 0

"ExPointResult" - Result of the extra-point: Made, Missed, Blocked, Aborted

"TwoPointConv" - Result of two-point conversion: Success or Failure

"DefTwoPoint" - Result of defensive two-point conversion: Success or Failure

"Safety" - Binary: 1 if safety was recorded else 0

"Onsidekick" - Binary: 1 if the kickoff was an onside kick

"PuntResult - Result of punt: Clean or Blocked

"PlayType" - The type of play that occured, potential values are:

Kickoff, Punt

Pass, Sack, Run

Field Goal, Extra Point

Quarter End, Two Minute Warning, Half End, End of Game

No Play, QB Kneel, Spike, Timeout

"Passer" - The passer on the play if it was a pass play

"Passer_ID" - NFL GSIS player ID for the passer

"PassAttempt" - Binary: 1 if a pass was attempted else 0

"PassOutcome" - Pass Result: Complete or Incomplete Pass

"PassLength" - Categorical variable indicating the length of the pass: Short or Deep

"PassLocation" - Location of the pass: left, middle, right

"InterceptionThrown" - Binary: 1 if an interception else 0

"Interceptor" - The player who intercepted the ball

"Rusher" - The runner on the play if it was a running play

"Rusher_ID" - NFL GSIS player ID for the rusher

"RushAttempt" - Binary: 1 if a run was attempted else 0

"RunLocation" - Location of the run: left, middle, right

"RunGap" - Gap of the run: guard, tackle, end

"Receiver" - The targeted receiver of a play

"Receiver_ID" - NFL GSIS player ID for the receiver

"Reception" - Binary: 1 if a reception was recorded else 0

"ReturnResult" - Result of a punt, kickoff, interception, or fumble return: Fair Catch, Touchback, Touchdown

"Returner" - The punt or kickoff returner

"BlockingPlayer" - The player who blocked the extra point, field goal, or punt

"Tackler1" - The primary tackler on the play

"Tackler2" - The secondary tackler on the play

"FieldGoalResult" - Outcome of a fieldgoal: No Good, Good, Blocked

"FieldGoalDistance" - Field goal length in yards

"Fumble" - Binary: 1 if a fumble occured else no

"RecFumbTeam" - Team that recovered the fumble

"RecFumbPlayer" - Player that recovered the fumble

"Sack" - Binary: 1 if a sack was recorded else 0

"Challenge.Replay" - Binary: 1 if play was reviewed by the replay official else 0

"ChalReplayResult" - Result of the replay review: Upheld or Reversed

"Accepted.Penalty" - Binary: 1 if penalty was accepted else 0

"PenalizedTeam" - The penalized team on the play

"PenaltyType" - Type of penalty on the play, alues include:

Unnecessary Roughness, Roughing the Passer

Illegal Formation, Defensive Offside

Delay of Game, False Start, Illegal Shift

Illegal Block Above the Waist, Personal Foul

Unnecessary Roughness, Illegal Blindside Block

Defensive Pass Interference, Offensive Pass Interference

Fair Catch Interference, Unsportsmanlike Conduct

Running Into the Kicker, Illegal Kick

Illegal Contact, Defensive Holding

Illegal Motion, Low Block

Illegal Substitution, Neutral Zone Infraction

Ineligible Downfield Pass, Roughing the Passer

Illegal Use of Hands, Defensive Delay of Game

Defensive 12 On-field, Offensive Offside

Tripping, Taunting, Chop Block

Interference with Opportunity to Catch, Illegal Touch Pass

Illegal Touch Kick, Offside on Free Kick

Intentional Grounding, Horse Collar

Illegal Forward Pass, Player Out of Bounds on Punt

Clipping, Roughing the Kicker, Ineligible Downfield Kick

Offensive 12 On-field, Disqualification

"PenalizedPlayer" - The penalized player

"Penalty.Yards" - The number of yards that the penalty resulted in

"PosTeamScore" - The score of the possession team (offensive team)

"DefTeamScore" - The score of the defensive team

"ScoreDiff" - The difference in score between the offensive and defensive teams (offensive.score - def.score)

"AbsScoreDiff" - Absolute value of the score differential

"HomeTeam" - The home team

"AwayTeam" - The away team

"Timeout_Indicator" - Binary: 1 if a timeout was charge else 0

"Timeout_Team" - Team charged with penalty (None if no timeout)

"posteam_timeouts_pre" - Number of timeouts remaining for possession team at the start of the play

"HomeTimeouts_Remaining_Pre" - Number of timeouts remaining for home team at the start of the play

"AwayTimeouts_Remaining_Pre" - Number of timeouts remaining for away team at the start of the play

"HomeTimeouts_Remaining_Post" - Number of timeouts remaining for home team at the end of the play (handles loss of timeout from lost challenge)

"AwayTimeouts_Remaining_Post" - Number of timeouts remaining for away team at the end of the play (handles loss of timeout from lost challenge)

"No_Score_Prob" - Probability of no score occurring within the half

"Opp_Field_Goal_Prob" - Probability of the defensive team scoring a field goal next

"Opp_Safety_Prob" - Probability of the defensive team scoring a safety next

"Opp_Touchdown_Prob" - Probability of the defensive team scoring a touchdown next

"Field_Goal_Prob" - Probability of the possession team scoring a field goal next

"Safety_Prob" - Probability of the possession team scoring a safety next

"Touchdown_Prob" - Probability of the possession team scoring a touchdown next

"ExPoint_Prob" - Probability of the possession team making the PAT

"TwoPoint_Prob" - Probability of the possession team converting the two-point conversion

"ExpPts" - The expected points for the possession team at the start of the play

"EPA" - Expected points added with respect to the possession team considering the result of the play

"airEPA" - Expected points added from air yards

"yacEPA" - Expected points added from yards after catch

"Home_WP_pre" - The win probability for the home team at the start of the play

"Away_WP_pre" - The win probability for the away team at the start of the play

"Home_WP_post" - The win probability for the home team at the end of the play

"Away_WP_post" - The win probability for the away team at the end of the play

"Win_Prob" - The win probability added for team with possession

"WPA" - The win probability added with respect to the possession team

# Season and Game Player Stats

* [Season-Player Passing Stats](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_player_stats/season_passing_df.csv)
* [Season-Player Receiving Stats](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_player_stats/season_receiving_df.csv)
* [Season-Player Rushing Stats](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_player_stats/season_rushing_df.csv)

* [Game-Player Passing Stats](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/game_player_stats/game_passing_df.csv)
* [Game-Player Receiving Stats](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/game_player_stats/game_receiving_df.csv)
* [Game-Player Rushing Stats](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/game_player_stats/game_rushing_df.csv)

# Season and Game Team Stats

* [Season-Team Passing Stats](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_team_stats/team_season_passing_df.csv)
* [Season-Team Receiving Stats](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_team_stats/team_season_receiving_df.csv)
* [Season-Team Rushing Stats](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/season_team_stats/team_season_rushing_df.csv)

* [Game-Team Passing Stats](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/game_team_stats/game_passing_df.csv)
* [Game-Team Receiving Stats](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/game_team_stats/game_receiving_df.csv)
* [Game-Team Rushing Stats](https://github.com/ryurko/nflscrapR-data/blob/master/legacy_data/game_team_stats/game_rushing_df.csv)


The season_player_stats folder contains datasets with player statistics at the season level, while the game_player_stats contains datasets with player statistics at the game level.  There are 3 types of datasets in each folder:

1. Passing
2. Receiving
3. Rushing

Both game and season level have a Team column with the abbreviation for which team the player was on.  The game level datasets contain a column for the opponent's team.

The season_team_stats and game_team_stats folders contain the same statistics but at the team level, with the first player list being the most prevalent player.

The datasets contain traditional stats as well as expected points added (EPA) based metrics.  [See here for which stats are more predictable on a seasonal basis](http://www.stat.cmu.edu/~ryurko/pdf/greatlakes_2017.pdf) (HINT: not all yards are created equal)

# Passing Stats

1. Attempts - number of pass attempts
2. Completions - number of completed passes
3. Comp_Perc - completion percentage
4. Total_Yards - total yards gained from passing
5. Total_Raw_AirYards - total air yards thrown (both complete and incomplete passes)
6. Yards_per_Att - yards gained from passing per attempt
7. Yards_per_Comp - yards gained from passing per completion
8. Raw_AirYards_per_Att - air yards thrown per pass attempt (all pass attempts)
9. Comp_AirYards_per_Comp - air yards thrown per completion (only completed passes)
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
37. Drives - number of drives involved in
38. Total_Comp_AirYards - total air yards from completions

# Receiving Stats

1. Targets - number of targets
2. Receptions - number of receptions
3. Total_Yards - total yards gained from receiving
4. Total_Raw_YAC - total of yards after catch (YAC) as well as yards missed from incomplete passes
5. Yards_per_Rec - yards gained per reception
6. Yards_per_Target - yards gained per target
7. Caught_YAC_per_Rec - yards gained after catch per reception
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
37. Total_Caught_YAC - total yards gained after catch for receptions
38. Total_Dropped_YAC - total yards missed from incomplete passes


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

