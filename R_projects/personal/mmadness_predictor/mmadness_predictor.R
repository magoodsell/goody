# https://shiny.byui.edu/MarchMadness/

# Create a function with two inputs that will predict the winner of a game. 

# simple verison ideas 
  # do it based of record. 
  # use a logisitc regression 

# complex one. 
  # do a multiple logistic regression 
    # have weighted inputs such as: 
      # points per game
      # points against
      # history in tournament 
      # history against team
      # current season information given more weight. 

# Have a dataset inside the function so I will filter the dataset down on only those two teamss
# idea for a logistic regression: 
  # have wins and losses as the y 
  # have a variable like points scored as an x 
  # then to find the probability of each teams win by input the opponents points allowed
  # then compare the two probabilities and choose a winner. 
# test on last years bracket. 


# data set would be of each game for each team that way I can get if the team won or lost and the stats of the game. 
  # perform a logistic regression on that


pacman::p_load(ncaahoopR)

game <- season_boxscore('Arizona', season = '2020-21', aggregate = 'average')


# testing the get_boxscore function. returns list of two
test <- get_boxscore(401025813)
test

# testing get_pbp_game



gonzaga <- data.frame(
  game_result = c('w','w','w','w','w','w','L','w','L','w','w','w','w','w','w','w','w','w','w','w','w','w','w','w','w','w','L','w','w')
  , points = c(97,86,84,92,107,83,81,64,91,80,69,95,93,117,110,115,78,89,104,92,90,89,74,86,81,89,57,81,82)
  , opp_points = c(63,74,57,50,54,63,84,55,91,55,55,49,63,83,84,83,62,55,72,62,57,51,58,66,69,73,67,71,69)
  #, opp_name =  c('Dixie State', )
)

georgia_state <- data.frame(
  game_result = c('w','w','L','w','w','L','L','w','L','w','L','L','L','L','L','w','w','L','w','w','w','w','w','w','w','w','w','w')
  , points = c(97,83,78,77,74,59,77,80,50,92,62,63,65,60,68,68,73,63,69,61,58,79,58,82,65,65,71,80)
  , opp_points = c(37,64,94,59,66,94,83,51,79,44,72,70,74,61,72,64,62,67,62,50,49,63,49,70,58,62,66,71)
) 

gonzaga %>% mutate(binary = case_when(game_result == 'w' ~ 1, 
                                      TRUE ~ 0))
georgia_state %>% mutate(binary = case_when(game_result == 'w'~ 1, 
                                             TRUE ~ 0))

gonzaga_lm <- glm(game_result == 'w' ~ opp_points, data = gonzaga, family = binomial)

summary(gonzaga_lm)

plot(game_result=='w' ~ opp_points, data = gonzaga)
curve(exp(12.87070 - 0.14789*x)/(1+exp(12.87070 - 0.14789*x)), add = TRUE)


georgia_lm <- glm(game_result == 'w' ~ opp_points, data = georgia_state, family = binomial)
summary(georgia_lm)

plot(game_result=='w'~opp_points, data = georgia_state)
curve(exp(22.1397 - 0.32178*x)/(1+exp(22.1397 - 0.32178*x)), add = TRUE)

# Calculating the points per game
gon_avg <- mean(gonzaga$points) 

gs_avg <- mean(georgia_state$points)

# calculate the probability of the other team winning based on their ppg against the logistic regression for the opposing team

## Gonzaga's logistic regression curve
gon_odds <- predict(gonzaga_lm, data.frame(opp_points=gs_avg), type='response')
gon_odds
## Georgia States logistic regression curve
gs_odds <- predict(georgia_lm, data.frame(opp_points=gon_avg), type='response')
gs_odds

if (gon_odds > gs_odds){
  print('Gonzaga has the higher percentage of winning')
  # print('Gonzagas odds:') gon_odds
  print("Gonzaga's odds:")
  gon_odds
} else {
  print('Georgia State has the higher precentage of winning')
  print("Georgia States odds:")
  gs_odds
}


#Putting it all into a function. 

predictor <- function(team_1, team_2){
  
  team_1 <- gonzaga
  
  team_2 <- georgia_state
  
  # Generating Data 
  team_1_data <- data.frame(
    game_result = c('w','w','w','w','w','w','L','w','L','w','w','w','w','w','w','w','w','w','w','w','w','w','w','w','w','w','L','w','w')
    , points = c(97,86,84,92,107,83,81,64,91,80,69,95,93,117,110,115,78,89,104,92,90,89,74,86,81,89,57,81,82)
    , opp_points = c(63,74,57,50,54,63,84,55,91,55,55,49,63,83,84,83,62,55,72,62,57,51,58,66,69,73,67,71,69)
    #, opp_name =  c('Dixie State', )
  )
  
  team_2_data <- data.frame(
    game_result = c('w','w','L','w','w','L','L','w','L','w','L','L','L','L','L','w','w','L','w','w','w','w','w','w','w','w','w','w')
    , points = c(97,83,78,77,74,59,77,80,50,92,62,63,65,60,68,68,73,63,69,61,58,79,58,82,65,65,71,80)
    , opp_points = c(37,64,94,59,66,94,83,51,79,44,72,70,74,61,72,64,62,67,62,50,49,63,49,70,58,62,66,71)
  ) 
  
  # Creating the logistics regressions
  
  ## Mutating to get the data to work
  team_1_data %>% mutate(binary = case_when(game_result == 'w' ~ 1, 
                                        TRUE ~ 0))
  team_2_data %>% mutate(binary = case_when(game_result == 'w'~ 1, 
                                              TRUE ~ 0))
  ## Logistic regression model's
  team_1_lm <- glm(game_result == 'w' ~ opp_points, data = team_1_data, family = binomial)
  
  team_2_lm <- glm(game_result == 'w' ~ opp_points, data = team_2_data, family = binomial)
 
  
  # calculating the odds 
  ## Getting ppg
  gon_avg <- mean(team_1_data$points) 
  
  gs_avg <- mean(team_2_data$points)
  
  
  ## Gonzaga's logistic regression curve
  gon_odds <- predict(team_1_lm, data.frame(opp_points=gs_avg), type='response')
  # gon_odds
  ## Georgia States logistic regression curve
  gs_odds <- predict(team_2_lm, data.frame(opp_points=gon_avg), type='response')
  # gs_odds
  # returning a winner
  winner <- if (gon_odds > gs_odds){
                print('Gonzaga has the higher percentage of winning')
                # print('Gonzagas odds:') gon_odds
                print("Gonzaga's odds:")
                print(gon_odds)
                }
                else {
                  print('Georgia State has the higher precentage of winning')
                  print("Georgia States odds:")
                  print(gs_odds)
                }
  # return winner
  
}

predictor(team_1 = gonzaga, team_2 = georgia_state)

hoopR::load_mbb_pbp(2022)

dat <- hoopR::load_mbb_team_box(seasons = 2022)
View(dat)

# this is the what I need
dat2 <- hoopR::espn_mbb_scoreboard(2022)
# dat2 <- hoopR::espn_mbb_scoreboard(season = '20211109')

View(dat2)

dat_game <- dat2 %>% select('matchup', 'season', 'game_id', 'home_team_name', 'home_team_full', 'home_score', 'away_team_name', 'away_team_full', 'away_score' )
View(dat_game)



###########
# Testing something out
###########

dat_game_gon <- dat %>% 
  filter(team_short_display_name == 'Georgia State') %>% 
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

dat_game_gon$fg_made <- as.numeric(dat_game_gon$fg_made)
dat_game_gon$threes_made <- as.numeric(dat_game_gon$threes_made)
dat_game_gon$ft_made <- as.numeric(dat_game_gon$ft_made)

dat_game_gon <- dat_game_gon %>% 
  mutate(twos = fg_made - threes_made) %>% 
  mutate(points_from_twos = twos * 2) %>% 
  mutate(points_from_threes = threes_made * 3) %>% 
  mutate(points_from_ft = ft_made * 1) %>% 
  mutate(points = points_from_twos + points_from_threes + points_from_ft) %>% 
  select('school', 'team_name', 'points', 'game_id')


# getting gonzaga as the opponents name to get the opponents score
dat_game_gon_opponent <- dat %>% 
  filter(opponent_name == 'Georgia State') %>% 
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

dat_game_gon_opponent$fg_made <- as.numeric(dat_game_gon_opponent$fg_made)
dat_game_gon_opponent$threes_made <- as.numeric(dat_game_gon_opponent$threes_made)
dat_game_gon_opponent$ft_made <- as.numeric(dat_game_gon_opponent$ft_made)

dat_game_gon_opponent <- dat_game_gon_opponent %>% 
  mutate(twos = fg_made - threes_made) %>% 
  mutate(points_from_twos = twos * 2) %>% 
  mutate(points_from_threes = threes_made * 3) %>% 
  mutate(points_from_ft = ft_made * 1) %>% 
  mutate(points = points_from_twos + points_from_threes + points_from_ft) %>% 
  select('school', 'team_name', 'points', 'game_id')


# joining the two datasets together
final_dat <- dat_game_gon %>%  bind_cols(dat_game_gon_opponent)
View(final_dat)         

final_dat <- final_dat %>% 
  select(school...1, team_name...2, points...3, game_id...4, school...5, points...7, game_id...8) %>% 
  rename(school = school...1) %>% 
  rename(team_name = team_name...2) %>% 
  rename(points = points...3) %>% 
  rename(game_id = game_id...4) %>% 
  rename(opponent = school...5) %>% 
  rename(opp_points = points...7) %>% 
  rename(opp_game_id = game_id...8)

final_dat <- final_dat %>% 
  mutate(result = case_when(points > opp_points ~ 'W'
                            , TRUE ~ 'L')) %>% 
  mutate(binary = case_when(result == 'W'~ 1
                            , TRUE ~ 0))

view(final_dat)





