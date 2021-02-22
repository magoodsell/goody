pacman::p_load(tidyverse, ggrepel)

# Downloading data
pt <- read_csv("RBDC_Pole_test.csv")
pthv <- read_csv("RBDC_PT_HV.csv")

# Viewing
View(pt)
View(pthv)

pt %>% 
  mutate(id = row_number()) %>% 
  #group_by(Radius, Resolution) %>% 
  ggplot(aes(id, `Distance 1`)) +
  #geom_line() +
  geom_point(color="blue", size=2) +
  #geom_point(aes(x=Resolution), color="blue", size=2) + # tried to add dots that correspond to Res.
  geom_line() +
  geom_vline(xintercept = c(16,32,48,64,80,96,112,138,154,170,186,202,218,234), color="firebrick") +
  # facet_grid(~Radius)
  geom_text(aes(label=Resolution), nudge_y = .005) +
  #geom_text_repel(aes(label= Resolution)) +
  # geom_label_repel(aes(label= Resolution), nudge_y = .005) +
  labs(title = "Distance by resolution", 
       x="Resolution number by index \nRed line indicates new Radius", 
       y="Method 1 distance") +
  theme_bw()
