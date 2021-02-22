# loading packages
pacman::p_load(tidyverse)

# reading in files
rad_0.09 <- read_csv("circle_rad_0.09.csv")

rad_0.1 <- read_csv("circle_rad_0.10.csv")

rad_0.11 <- read_csv("circle_rad_0.11.csv")

# cleaning data & need to add column to specify what circle when I join
circle_1 <- rad_0.09 %>% 
  .[-c(1, 14, 27, 40, 53, 66, 79, 92, 105, 118),] %>% 
  #.[is.na(.)] = 0 
  #case_when(`Distance 2` == NA ~ 0, other ~ TRUE)
  #mutate(`Distance 2` = if_else(NA, 0, TRUE))
  #replace_na(.$`Distance 2`, 0)
  mutate(circle = "0.09")

## doesn't work, makes whole column a 0 
##dat$`Distance 2` <- replace_na(0)
View(circle_1)

circle_2 <- rad_0.1 %>% 
  mutate(circle = "0.1") #add column

circle_3 <- rad_0.11 %>% 
  mutate(circle = "0.11") #add column


# bind rows on circle column

all_dat <- bind_rows(circle_1, circle_2, circle_3) %>% 
  mutate(id = row_number())

# Graphs

all_dat %>% 
  filter(circle == "0.09") %>% 
  ggplot(aes(id, `Distance 1`, group=Resolution)) +
  geom_point() +
  geom_line() +
  geom_smooth() + 
  facet_grid(fct_inorder(as.factor(Radius))~Resolution, scales = "free") +
  labs(title = "Distance 1 over the different circles")

all_dat %>% 
  filter(circle == "0.09") %>% 
  ggplot(aes(fct_inorder(as.factor(Radius)), `Distance 1`, color=fct_inorder(as.factor(Radius)))) +
  geom_boxplot() +  
  #geom_boxplot(outlier.color = )
  geom_jitter() + 
  labs(title = "Distance 1 over the different circles", 
       x = "Radius",
       fill = "Radius") +
 facet_grid(~Resolution, scales = "free")

# create a bar graph with postion =dodge for the average high vote count

all_dat %>% 
  group_by()

# create line chart with two lines for each method
# create a table to see how the mean of the votes do from the high vote. 
# create a bar graph with poistion=dodge for the average high vote count 
# create a distribution chart of both methods. 