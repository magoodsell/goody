# attempting to reproduce a visual inourworldindata.com

# Link - https://ourworldindata.org/rich-poor-working-hours

pacman::p_load(tidyverse)
library(zoo) # to use na.locf for missing values, except worried it will input false info

# loading data 
work_h <- read_csv("Data/annual-working-hours-vs-gdp-per-capita-pwt.csv")

View(work_h)

dat <- work_h %>% 
  filter(Year >= 1950)

####
# Visual notes - Annual working hours vs. GDP per captia
# y - working hours 
# x - GDP per captia
# each country is colored by its continent
# has a size variable as well