# Loading in packages
library(tidyverse)
library(tidytuesdayR)

# Loading in data
tuesdata <- tidytuesdayR::tt_load(2020, week = 21)

vb_matches <- tuesdata$vb_matches

# Exploring data

View(vb_matches)
dat <- vb_matches %>% 
  separate(score, into = c("game_1", "game_2", "game_3"), sep = ",")

# questions:
does hieght increase number of blocks 
Do the younger do better against the older

