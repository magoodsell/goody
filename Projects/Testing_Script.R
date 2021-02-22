pacman::p_load(patchwork, tidyverse)
ash <- c(84, 80, 66, 90, 84, 81) 
matt <- c(72, 76, 86, 91, 71, 72)
categories <- c("dreams", "joy", "self", "people", "work", "structure")

sum(ash) 
sum(matt) 

left <- boxplot(ash)
right <- boxplot(matt)

left+right

ash <- data.frame(ash)
ash <- ash %>% rename(Score = ash) %>% 
  mutate(Category = categories) %>% 
  relocate(Category, .before = Score)

matt <- data.frame(matt)
matt <- matt %>% rename(Score = matt) %>% 
  mutate(Category = categories) %>% 
  relocate(Category, .before = Score)

left <- ggplot(ash) +
  geom_col(aes(x=Category, y=Score))

right <- ggplot(matt) +
  geom_col(aes(x=Category, y=Score))

test <- ggplot(matt, aes(x=Category, y=Score)) +
  geom_col()

(left+right)/test

