
# Loading in the data
dat <- hoopR::load_mbb_team_box(seasons = 2022)

# getting only the current seasons information
dat$game_date <- as.Date.character(dat$game_date)
dat <- dat %>% dplyr::filter(game_date >= '2021-11-09' & 'game_date' <= '2022-03-09')


# the parameters for the function. 
team_1_test <- 'Jackson State'

team_1_opp_name <- 'Jackson State'


# Getting the  data
team_1_dat <- dat %>% 
  filter(team_short_display_name == team_1_test) %>% 
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

View(team_1_dat)

team_1_dat <- team_1_dat %>% 
  mutate(twos = fg_made - threes_made) %>% 
  mutate(points_from_twos = twos * 2) %>% 
  mutate(points_from_threes = threes_made * 3) %>% 
  mutate(points_from_ft = ft_made * 1) %>% 
  mutate(points = points_from_twos + points_from_threes + points_from_ft) %>% 
  select('school', 'team_name', 'points', 'game_id')



team_1_opponents <- dat %>% 
  filter(opponent_name == team_1_opp_name) %>% 
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

View(team_1_opponents)

# joining the two datasets together
team_1_final_dat <- team_1_dat %>%  bind_cols(team_1_opponents)

View(team_1_final_dat)

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

View(team_1_final_dat)

##########
# Logistic Regression Model

## Model's
team_1_lm <- glm(result == 'W' ~ opp_points, data = team_1_final_dat, family = binomial)
summary(team_1_lm)

## Creating the visual
beta_1 <- team_1_lm$coefficients[1]
beta_2 <- team_1_lm$coefficients[2]

plot(result=='W' ~ opp_points, data = team_1_final_dat, main=paste(team_1_test, "2022 logistics Regression"))
curve(exp(beta_1 + beta_2*x)/(1+exp(beta_1 + beta_2*x)), add = TRUE) 


# calculating the odds of the team winning
## Getting ppg
team_1_ppg <- mean(team_1_final_dat$points) 

team_2_ppg <- 86.7

## Team 1 prediction odds
team_1_odds <- predict(team_1_lm, data.frame(opp_points=team_2_ppg), type='response')

team_1_odds

#############
#Testing section 2
#############

team_1= 'Rutgers_ScarletKnights'
team_2 = 'Bryant_Bulldogs'

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


teams_dat['school'][teams_dat['school'] == "TexasA&MCC"] <- 'Texas A&M-CC'
teams_dat['school'][teams_dat['school'] == "SDakotaState"] <- 'S Dakota State'
teams_dat$school <- gsub("([a-z])([A-Z])","\\1 \\2",teams_dat$school)
teams_dat['school'][teams_dat['school'] == "Connecticut"] <- 'UConn'
teams_dat['school'][teams_dat['school'] == "Southern California"] <- 'USC'
teams_dat['school'][teams_dat['school'] == "Saint Peters"] <- "Saint Peter's"
teams_dat['school'][teams_dat['school'] == "New Mexico State"] <- "New Mexico St"
teams_dat['school'][teams_dat['school'] == "Saint Marys"] <- "Saint Mary's"
# teams_dat['school'][teams_dat['school'] == "Jackson State"] <- "J'Ville St" # ? I think Jackson State is good


### getting team 1
team_1_name <- teams_dat %>% 
  filter(teams_x == team_1) %>% 
  select(school)

assign('test', team_1_name$school)

#%>% 
  .$school[1]

### Getting team 2
team_2_name <- teams_dat %>% 
  filter(teams_x == team_2) %>% 
  .$school[1]
