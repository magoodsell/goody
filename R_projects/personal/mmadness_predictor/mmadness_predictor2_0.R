
mm_predictor <- function(team_1, team_2) {
  
  # make sure the package is installed
  
  if (is.null(find.package('hoopR'))) {
    install.packages('hoopR')
  }
  library(hoopR)
  
  if (is.null(find.package('tidyverse'))) {
    install.packages('tidyverse')
  }
  library(tidyverse)
  
  # load in the data
  dat <- hoopR::load_mbb_team_box(seasons = 2022)
  dat <- dat %>% filter(game_date <= '2022-03-09')
  
  
  teams_dat <- data.frame(teams = c('Rutgers_ScarletKnights', 'NotreDame_FightingIrish', 'Wyoming_Cowboys', 'Indiana_Hoosiers'
                                    , 'WrightState_Raiders',	'Bryant_Bulldogs','TexasSouthern_Tigers',	'TexasA&MCC_Islanders'
                                    , 'Gonzaga_Bulldogs',	'GeorgiaState_Panthers','BoiseState_Broncos',	'Memphis_Tigers'
                                    ,'Connecticut_Huskies',	'NewMexicoState_Aggies','Arkansas_Razorbacks',	'Vermont_Catamounts'
                                    , 'Alabama_CrimsonTide',	'TexasTech_RedRaiders',	'MontanaState_Bobcats',	'MichiganState_Spartans'
                                    ,	'Davidson_Wildcats', 'Duke_BlueDevils',	'CalStateFullerton_Titans',	'Baylor_Bears'
                                    ,	'NorfolkState_Spartans', 'NorthCarolina_TarHeels',	'Marquette_GoldenEagles', 'SaintMarys_Gaels'
                                    ,	'UCLA_Bruins',	'Akron_Zips',	'Texas_Longhorns',	'VirginiaTech_Hokies',	'Purdue_Boilermakers'
                                    ,	'Yale_Bulldogs',	'MurrayState_Racers',	'SanFrancisco_Dons',	'Kentucky_Wildcats',	'SaintPeters_Peacocks'
                                    ,	'Arizona_Wildcats',	'SetonHall_Pirates',	'TCU_HornedFrogs',	'Houston_Cougars',	'UAB_Blazers'
                                    ,	'Illinois_FightingIllini',	'Chattanooga_Mocs',	'ColoradoState_Rams',	'Michigan_Wolverines'
                                    ,	'Tennessee_Volunteers',	'Longwood_Lancers',	'OhioState_Buckeyes',	'LoyolaChicago_Ramblers', 'Villanova_Wildcats'
                                    ,	'Delaware_FightinBlueHens',	'Kansas_Jayhawks',	'SanDiegoState_Aztecs',	'Creighton_Bluejays','Iowa_Hawkeyes'
                                    ,	'Richmond_Spiders',	'Providence_Friars',	'SDakotaState_Jackrabbits',	'LouisianaState_Tigers',	'IowaState_Cyclones'
                                    ,'Wisconsin_Badgers',	'Colgate_Raiders',	'SouthernCalifornia_Trojans',	'Miami_Hurricanes'
                                    ,	'Auburn_Tigers',	'JacksonState_Tigers'
  )) %>% 
  mutate(teams_x = teams) %>% 
  separate(teams, into = c('school', 'mascot'), sep = '_') 
  # will need to add space when there is a capital letter in name
  # teams_dat <- teams_dat %>% str_replace(teams_dat$school,'TexasA&mcc', 'Texas A&M-CC')
  teams_dat['school'][teams_dat['school'] == "TexasA&MCC"] <- 'Texas A&M-CC'
  teams_dat['school'][teams_dat['school'] == "SDakotaState"] <- 'S Dakota State'
  teams_dat$school <- gsub("([a-z])([A-Z])","\\1 \\2",teams_dat$school)
  teams_dat['school'][teams_dat['school'] == "Connecticut"] <- 'UConn'
  # teams_dat['school'][teams_dat['school'] == "Jackson State"] <- "J'Ville St" # ? I think Jackson State is good
  teams_dat['school'][teams_dat['school'] == "Southern California"] <- 'USC'
  teams_dat['school'][teams_dat['school'] == "Saint Peters"] <- "Saint Peter's"
  teams_dat['school'][teams_dat['school'] == "New Mexico State"] <- "New Mexico St"
  teams_dat['school'][teams_dat['school'] == "Saint Marys"] <- "Saint Mary's"
  teams_dat['school'][teams_dat['school'] == "Louisiana State"] <- "LSU"
  
  
  
  
  ### getting team 1
  
  # team_1_name <- teams_dat %>% 
  #   filter(teams_x == team_1) %>% 
  #   .$school[1]
  n_1 <- teams_dat %>% 
    filter(teams_x == team_1) %>% 
    select(school)
  
  assign('team_1_name', n_1$school)
  
  ### Getting team 2
  
  # team_2_name <- teams_dat %>% 
  #   filter(teams_x == team_2) %>% 
  #   .$school[1]
  n_2 <- teams_dat %>% 
    filter(teams_x == team_2) %>% 
    select(school)
  
  assign('team_2_name', n_2$school)
  
  ####### 
  # Team 1 dataset 
  
  team_1_dat <- dat %>% 
    filter(team_short_display_name == team_1_name) %>% 
    # would need to filter to only 11-09-21 to 03-09-22 to ensure it is only regular season 
    # OR filter to only season_type == 2?? not sure what 2 means exaclty
    arrange(game_date) %>% 
    select('team_short_display_name'
           , 'team_name'
           , 'field_goals_made_field_goals_attempted'
           , "three_point_field_goals_made_three_point_field_goals_attempted"
           , "free_throws_made_free_throws_attempted"
           , 'opponent_name'
           , 'season_type'
           , 'game_id'
           , 'game_date') %>% 
    rename('school' = 'team_short_display_name') %>% 
    separate(col = "three_point_field_goals_made_three_point_field_goals_attempted", into = c('threes_made', 'threes_attempted'), sep = '-') %>% 
    separate(col = 'field_goals_made_field_goals_attempted', into = c('fg_made', 'fg_attempted'), sep = '-') %>% 
    separate(col = "free_throws_made_free_throws_attempted", into = c('ft_made', 'ft_attempted'), sep = '-') 
  
  team_1_dat$fg_made <- as.numeric(team_1_dat$fg_made)
  team_1_dat$threes_made <- as.numeric(team_1_dat$threes_made)
  team_1_dat$ft_made <- as.numeric(team_1_dat$ft_made)
  
  team_1_dat <- team_1_dat %>% 
    mutate(twos = fg_made - threes_made) %>% 
    mutate(points_from_twos = twos * 2) %>% 
    mutate(points_from_threes = threes_made * 3) %>% 
    mutate(points_from_ft = ft_made * 1) %>% 
    mutate(points = points_from_twos + points_from_threes + points_from_ft) %>% 
    select('school', 'team_name', 'points', 'game_id')
  
  
  # getting gonzaga as the opponents name to get the opponents score
  team_1_opponents <- dat %>% 
    filter(opponent_name == team_1_name) %>% 
    # would need to filter to only 11-09-21 to 03-09-22 to ensure it is only regular season 
    # OR filter to only season_type == 2?? not sure what 2 means exaclty
    arrange(game_date) %>% 
    select('opponent_name'
           , 'team_short_display_name'
           , 'team_name'
           , 'field_goals_made_field_goals_attempted'
           , "three_point_field_goals_made_three_point_field_goals_attempted"
           , "free_throws_made_free_throws_attempted"
           , 'opponent_name'
           , 'season_type'
           , 'game_id'
           , 'game_date') %>% 
    rename('school' = 'team_short_display_name') %>% 
    separate(col = "three_point_field_goals_made_three_point_field_goals_attempted", into = c('threes_made', 'threes_attempted'), sep = '-') %>% 
    separate(col = 'field_goals_made_field_goals_attempted', into = c('fg_made', 'fg_attempted'), sep = '-') %>% 
    separate(col = "free_throws_made_free_throws_attempted", into = c('ft_made', 'ft_attempted'), sep = '-') 
  
  team_1_opponents$fg_made <- as.numeric(team_1_opponents$fg_made)
  team_1_opponents$threes_made <- as.numeric(team_1_opponents$threes_made)
  team_1_opponents$ft_made <- as.numeric(team_1_opponents$ft_made)
  
  team_1_opponents <- team_1_opponents %>% 
    mutate(twos = fg_made - threes_made) %>% 
    mutate(points_from_twos = twos * 2) %>% 
    mutate(points_from_threes = threes_made * 3) %>% 
    mutate(points_from_ft = ft_made * 1) %>% 
    mutate(points = points_from_twos + points_from_threes + points_from_ft) %>% 
    select('school', 'team_name', 'points', 'game_id')
  
  
  # joining the two datasets together
  team_1_final_dat <- team_1_dat %>%  bind_cols(team_1_opponents)
  
  team_1_final_dat <- team_1_final_dat %>% 
    select(school...1, team_name...2, points...3, game_id...4, school...5, points...7, game_id...8) %>% 
    rename(school = school...1) %>% 
    rename(team_name = team_name...2) %>% 
    rename(points = points...3) %>% 
    rename(game_id = game_id...4) %>% 
    rename(opponent = school...5) %>% 
    rename(opp_points = points...7) %>% 
    rename(opp_game_id = game_id...8)
  
  team_1_final_dat <- team_1_final_dat %>% 
    mutate(result = case_when(points > opp_points ~ 'W'
                              , TRUE ~ 'L')) %>% 
    mutate(binary = case_when(result == 'W'~ 1
                              , TRUE ~ 0))
  
  
  
  ############
  # Team 2 data set
  
  team_2_dat <- dat %>% 
    filter(team_short_display_name == team_2_name) %>% 
    # would need to filter to only 11-09-21 to 03-09-22 to ensure it is only regular season 
    # OR filter to only season_type == 2?? not sure what 2 means exactly
    arrange(game_date) %>% 
    select('team_short_display_name'
           , 'team_name'
           , 'field_goals_made_field_goals_attempted'
           , "three_point_field_goals_made_three_point_field_goals_attempted"
           , "free_throws_made_free_throws_attempted"
           , 'opponent_name'
           , 'season_type'
           , 'game_id'
           , 'game_date') %>% 
    rename('school' = 'team_short_display_name') %>% 
    separate(col = "three_point_field_goals_made_three_point_field_goals_attempted", into = c('threes_made', 'threes_attempted'), sep = '-') %>% 
    separate(col = 'field_goals_made_field_goals_attempted', into = c('fg_made', 'fg_attempted'), sep = '-') %>% 
    separate(col = "free_throws_made_free_throws_attempted", into = c('ft_made', 'ft_attempted'), sep = '-') 
  
  team_2_dat$fg_made <- as.numeric(team_2_dat$fg_made)
  team_2_dat$threes_made <- as.numeric(team_2_dat$threes_made)
  team_2_dat$ft_made <- as.numeric(team_2_dat$ft_made)
  
  team_2_dat <- team_2_dat %>% 
    mutate(twos = fg_made - threes_made) %>% 
    mutate(points_from_twos = twos * 2) %>% 
    mutate(points_from_threes = threes_made * 3) %>% 
    mutate(points_from_ft = ft_made * 1) %>% 
    mutate(points = points_from_twos + points_from_threes + points_from_ft) %>% 
    select('school', 'team_name', 'points', 'game_id')
  
  
  # getting gonzaga as the opponents name to get the opponents score
  team_2_opponent <- dat %>% 
    filter(opponent_name == team_2_name) %>% 
    # would need to filter to only 11-09-21 to 03-09-22 to ensure it is only regular season 
    # OR filter to only season_type == 2?? not sure what 2 means exaclty
    arrange(game_date) %>% 
    select('opponent_name'
           , 'team_short_display_name'
           , 'team_name'
           , 'field_goals_made_field_goals_attempted'
           , "three_point_field_goals_made_three_point_field_goals_attempted"
           , "free_throws_made_free_throws_attempted"
           , 'opponent_name'
           , 'season_type'
           , 'game_id'
           , 'game_date') %>% 
    rename('school' = 'team_short_display_name') %>% 
    separate(col = "three_point_field_goals_made_three_point_field_goals_attempted", into = c('threes_made', 'threes_attempted'), sep = '-') %>% 
    separate(col = 'field_goals_made_field_goals_attempted', into = c('fg_made', 'fg_attempted'), sep = '-') %>% 
    separate(col = "free_throws_made_free_throws_attempted", into = c('ft_made', 'ft_attempted'), sep = '-') 
  
  team_2_opponent$fg_made <- as.numeric(team_2_opponent$fg_made)
  team_2_opponent$threes_made <- as.numeric(team_2_opponent$threes_made)
  team_2_opponent$ft_made <- as.numeric(team_2_opponent$ft_made)
  
  team_2_opponent <- team_2_opponent %>% 
    mutate(twos = fg_made - threes_made) %>% 
    mutate(points_from_twos = twos * 2) %>% 
    mutate(points_from_threes = threes_made * 3) %>% 
    mutate(points_from_ft = ft_made * 1) %>% 
    mutate(points = points_from_twos + points_from_threes + points_from_ft) %>% 
    select('school', 'team_name', 'points', 'game_id')
  
  
  # joining the two datasets together
  team_2_final_dat <- team_2_dat %>%  bind_cols(team_2_opponent)
  
  team_2_final_dat <- team_2_final_dat %>% 
    select(school...1, team_name...2, points...3, game_id...4, school...5, points...7, game_id...8) %>% 
    rename(school = school...1) %>% 
    rename(team_name = team_name...2) %>% 
    rename(points = points...3) %>% 
    rename(game_id = game_id...4) %>% 
    rename(opponent = school...5) %>% 
    rename(opp_points = points...7) %>% 
    rename(opp_game_id = game_id...8)
  
  team_2_final_dat <- team_2_final_dat %>% 
    mutate(result = case_when(points > opp_points ~ 'W'
                              , TRUE ~ 'L')) %>% 
    mutate(binary = case_when(result == 'W'~ 1
                              , TRUE ~ 0))
  
  
  ## Logistic regression model's
  team_1_lm <- glm(result == 'W' ~ opp_points, data = team_1_final_dat, family = binomial)
  
  team_2_lm <- glm(result == 'W' ~ opp_points, data = team_2_final_dat, family = binomial)
  
  
  # calculating the odds
  ## Getting ppg
  team_1_ppg <- mean(team_1_final_dat$points)
  
  team_2_ppg <- mean(team_2_final_dat$points)
  
  
  ## Team 1 prediction odds
  team_1_odds <- predict(team_1_lm, data.frame(opp_points=team_2_ppg), type='response')
  
  ## Team 2 prediction odds
  team_2_odds <- predict(team_2_lm, data.frame(opp_points=team_1_ppg), type='response')
  
  
  # returning a winner
  winner <- if (team_1_odds > team_2_odds) {
  # winner <- if (team_1_ppg > team_2_ppg){
   # if (team_2_odds > team_1_odds){
     print('My predicted winner is:')
     print(team_1_name)
     print(team_1_odds)
     # print(team_2_odds)
   }
  # else if (team_1_odds < team_2_odds){
  #    print('My predicted winner is:')
  #    print(team_1_name)
  #    print(team_1_odds)
     # print(team_2_odds)
  # }
  # else if (team_2_odds > team_1_odds) {
  #   print('My predicted winner is:')
  #   print(team_2_name)
  #   print(team_2_odds)
  # }
  # else {
  #   print('there is a bug.')
  # }
  else {
    print('My predicted winner is:')
    print(team_2_name)
    print(team_2_odds)
  }
  
  # print(paste('Team 1,', team_1_name, ', odds are:', team_1_odds, 'and team 2s', team_2_name, ', odds are:', team_2_odds))
  
}

               #uconn
#new mexico st
# Teams 
'Rutgers_ScarletKnights', 'NotreDame_FightingIrish', 'Wyoming_Cowboys', 'Indiana_Hoosiers'
, 'WrightState_Raiders',	'Bryant_Bulldogs','TexasSouthern_Tigers',	'TexasA&MCC_Islanders'
, 'Gonzaga_Bulldogs',	'GeorgiaState_Panthers','BoiseState_Broncos',	'Memphis_Tigers'
,'Connecticut_Huskies',	'NewMexicoState_Aggies','Arkansas_Razorbacks',	'Vermont_Catamounts'
, 'Alabama_CrimsonTide',	'TexasTech_RedRaiders',	'MontanaState_Bobcats',	'MichiganState_Spartans'
,	'Davidson_Wildcats', 'Duke_BlueDevils',	'CalStateFullerton_Titans',	'Baylor_Bears'
,	'NorfolkState_Spartans', 'NorthCarolina_TarHeels',	'Marquette_GoldenEagles', 'SaintMarys_Gaels'
,	'UCLA_Bruins',	'Akron_Zips',	'Texas_Longhorns',	'VirginiaTech_Hokies',	'Purdue_Boilermakers'
,	'Yale_Bulldogs',	'MurrayState_Racers',	'SanFrancisco_Dons',	'Kentucky_Wildcats',	'SaintPeters_Peacocks'
,	'Arizona_Wildcats',	'SetonHall_Pirates',	'TCU_HornedFrogs',	'Houston_Cougars',	'UAB_Blazers'
,	'Illinois_FightingIllini',	'Chattanooga_Mocs',	'ColoradoState_Rams',	'Michigan_Wolverines'
,	'Tennessee_Volunteers',	'Longwood_Lancers',	'OhioState_Buckeyes',	'LoyolaChicago_Ramblers', 'Villanova_Wildcats'
,	'Delaware_FightinBlueHens',	'Kansas_Jayhawks',	'SanDiegoState_Aztecs',	'Creighton_Bluejays','Iowa_Hawkeyes'
,	'Richmond_Spiders',	'Providence_Friars',	'SDakotaState_Jackrabbits',	'LouisianaState_Tigers',	'IowaState_Cyclones'
,'Wisconsin_Badgers',	'Colgate_Raiders',	'SouthernCalifornia_Trojans',	'Miami_Hurricanes'
,	'Auburn_Tigers',	'JacksonState_Tigers'

# mm_predictor(team_1 = 'SanFrancisco_Dons', team_2 = 'MurrayState_Racers')
