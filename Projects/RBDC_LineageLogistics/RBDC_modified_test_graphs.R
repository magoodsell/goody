# loading packages
pacman::p_load(tidyverse)

# loading in data

test_0.09 <- read_csv("modified_TestResults_circle_rad_0.09.csv")

test_0.1 <- read_csv("modified_TestResults_circle_rad_0.10.csv")

test_0.11 <- read_csv("modified_TestResults_circle_rad_0.11.csv")

# give each circle a column of which test circle it came from. 
dat_0.09 <- test_0.09 %>% 
  mutate( test_circle = "Rad_0.09")

dat_0.1 <- test_0.1 %>% 
  mutate( test_circle = "Rad_0.1")

dat_0.11 <- test_0.11 %>% 
  mutate( test_circle = "Rad_0.11")


# binding rows of the data
all_dat <- bind_rows(dat_0.09, dat_0.1, dat_0.11) %>% 
  mutate(id = row_number()) %>% # give it an index
  rename("Search Radius" = "Radius")

# Graphs
## line graph with two lines reprsenting both methods
all_dat %>% 
  filter(test_circle == "Rad_0.09") %>% 
  ggplot(aes(id, y=`Distance 1`, group=Resolution)) +
  geom_point() + 
  geom_line() + 
  geom_smooth() +
  facet_grid(fct_inorder(as.factor(Radius))~Resolution) + 
  labs(title = "Method 1 results the imperfect circle of radius 0.09", 
       y = "Distance from dumd mean")

##### Following graphs show both methods for each test circle #####
# rad.label <- c("Radius: 0.099", "Radius: 0.1", "Radius: 0.11")
# names(rad.label) <- c("0.099", "0.1", "0.11")
## above  code not working

### getting better labels on the facet_grid
label_all_dat <- all_dat

label_all_dat$Radius <- factor(label_all_dat$`Search Radius`, levels =c("0.099", "0.01", "0.011"),
                               labels = c("0.099", " 0.010", "0.011"))

label_all_dat %>% 
  filter(test_circle == "Rad_0.09") %>%
  ggplot(aes(group=Resolution)) +
  geom_point(aes(id, y=`Distance 1`), color="blue4") + 
  geom_line(aes(id, y=`Distance 1`), color="blue4") + 
  geom_point(aes(id, y=`Distance 2`)) + 
  geom_line(aes(id, y=`Distance 2`)) +
  facet_grid(`Search Radius`~Resolution,
             labeller=label_both) + 
  labs(title = "Method 1 & 2 results from imperfect circle of radius 0.09", 
       subtitle = "Blue = Method 1",
       y = "Distance from dumd mean") +
  theme(axis.title.x = element_blank(), 
        axis.text.x = element_blank(), 
        axis.ticks.x = element_blank(), 
        strip.background = element_rect(fill="grey48"))
# create a legend to show the color - put it in the subtitle
### end of test - status: working

label_all_dat <- all_dat

label_all_dat$Radius <- factor(label_all_dat$Radius, levels =c("0.099", "0.01", "0.011"),
                               labels = c("0.099", " 0.010", "0.011"))

label_all_dat %>% 
  filter(test_circle == "Rad_0.09") %>%
  ggplot(aes(group=Resolution)) +
  geom_point(aes(id, y=`Distance 1`), color="blue4") + 
  geom_line(aes(id, y=`Distance 1`), color="blue4") + 
  geom_point(aes(id, y=`Distance 2`)) + 
  geom_line(aes(id, y=`Distance 2`)) +
  facet_grid(Radius~Resolution,
             labeller=label_both) + 
  labs(title = "Method 1 & 2 results from imperfect circle of radius 0.09", 
       subtitle = "Blue = Method 1",
       y = "Distance from dumd mean") +
  theme(axis.title.x = element_blank(), 
        axis.text.x = element_blank(), 
        axis.ticks.x = element_blank(), 
        strip.background = element_rect(fill="grey48"))

# all_dat %>% 
#   filter(test_circle == "Rad_0.09") %>%
#   ggplot(aes(group=Resolution)) +
#   geom_point(aes(id, y=`Distance 1`), color="blue4") + 
#   geom_line(aes(id, y=`Distance 1`), color="blue4") + 
#   geom_point(aes(id, y=`Distance 2`)) + 
#   geom_line(aes(id, y=`Distance 2`)) +
#   facet_grid(fct_inorder(as.factor(Radius))~Resolution,
#              labeller=label_both) + 
#   labs(title = "Method 1 & 2 results from imperfect circle of radius 0.09", 
#        subtitle = "Blue = Method 1",
#        y = "Distance from dumd mean") +
#   theme(axis.title.x = element_blank(), 
#         axis.text.x = element_blank(), 
#         axis.ticks.x = element_blank(), 
#         strip.background = element_rect(fill="grey48"))
  # create a legend to show the color - put it in the subtitle



### same graph as above but with test_circle of 0.1
# label_all_dat <- all_dat
# 
# label_all_dat$Radius <- factor(label_all_dat$Radius, levels =c("0.099", "0.01", "0.011"),
#                                labels = c("0.099", " 0.010", "0.011"))

label_all_dat %>% 
  filter(test_circle == "Rad_0.1") %>%
  ggplot(aes(group=Resolution)) +
  geom_point(aes(id, y=`Distance 1`), color="blue4") + 
  geom_line(aes(id, y=`Distance 1`), color="blue4") + 
  geom_point(aes(id, y=`Distance 2`)) + 
  geom_line(aes(id, y=`Distance 2`)) +
  facet_grid(Radius~Resolution,
             labeller=label_both, 
             scales = "free") + 
  labs(title = "Method 1 & 2 results from imperfect circle of radius 0.09", 
       subtitle = "Blue = Method 1",
       y = "Distance from dumd mean") +
  theme(axis.title.x = element_blank(), 
        axis.text.x = element_blank(), 
        axis.ticks.x = element_blank(), 
        strip.background = element_rect(fill="grey48"))

# all_dat %>% 
#   filter(test_circle == "Rad_0.1") %>% 
#   ggplot(aes(group=Resolution)) +
#   geom_point(aes(id, y=`Distance 1`), color="blue4") + 
#   geom_line(aes(id, y=`Distance 1`), color="blue4") + 
#   geom_point(aes(id, y=`Distance 2`)) + 
#   geom_line(aes(id, y=`Distance 2`)) + 
#   #geom_smooth() +
#   facet_grid(fct_inorder(as.factor(Radius))~Resolution, scales = "free") + 
#   labs(title = "Method 1 & 2 results from imperfect circle of radius 0.1") +
#   theme(axis.title.x = element_blank(), 
#         axis.text.x = element_blank(), 
#         axis.ticks.x = element_blank())

### same graph as above but with test_circle of 0.11

label_all_dat %>% 
  filter(test_circle == "Rad_0.11") %>%
  ggplot(aes(group=Resolution)) +
  geom_point(aes(id, y=`Distance 1`), color="blue4") + 
  geom_line(aes(id, y=`Distance 1`), color="blue4") + 
  geom_point(aes(id, y=`Distance 2`)) + 
  geom_line(aes(id, y=`Distance 2`)) +
  facet_grid(Radius~Resolution,
             labeller=label_both, 
             scales = "free") + 
  labs(title = "Method 1 & 2 results from imperfect circle of radius 0.09", 
       subtitle = "Blue = Method 1",
       y = "Distance from dumd mean") +
  theme(axis.title.x = element_blank(), 
        axis.text.x = element_blank(), 
        axis.ticks.x = element_blank(), 
        strip.background = element_rect(fill="grey48"))

# all_dat %>% 
#   filter(test_circle == "Rad_0.11") %>% 
#   ggplot(aes(group=Resolution)) +
#   geom_point(aes(id, y=`Distance 1`), color="blue4") + 
#   geom_line(aes(id, y=`Distance 1`), color="blue4") + 
#   geom_point(aes(id, y=`Distance 2`)) + 
#   geom_line(aes(id, y=`Distance 2`)) + 
#   #geom_smooth() +
#   facet_grid(fct_inorder(as.factor(Radius))~Resolution, scales = "free") + 
#   labs(title = "Method 1 & 2 results from imperfect circle of radius 0.11", 
#        y = "Distance from dumd mean") +
#   theme(axis.title.x = element_blank(), 
#         axis.text.x = element_blank(), 
#         axis.ticks.x = element_blank())

##### Line graph done #####

## boxplot graph to show the spread of the distribution

all_dat %>% 
  ggplot(aes(fct_inorder(as.factor(Radius)), y=`Distance 1`, color=fct_inorder(as.factor(Radius)))) +
  geom_boxplot() + 
  geom_jitter() +
  labs(title = "Overall Distribution of Method 1 by Radius and Resolution", 
       x = "Search Radius") +
  facet_grid(~Resolution, labeller = label_both) +
  theme(legend.position = "none")

### Overall distribution of method/Distance 1
all_dat %>% 
  ggplot(aes(fct_inorder(as.factor(Radius)), y=`Distance 1`, color=fct_inorder(as.factor(Radius)))) +
  geom_boxplot() + 
  geom_jitter() +
  labs(title = "Overall Distribution of Method 1 by Radius", 
       x = "Search Radius") +
  theme(legend.position = "none")

### distribution of method 2
all_dat %>% 
  ggplot(aes(fct_inorder(as.factor(Radius)), y=`Distance 2`, color=fct_inorder(as.factor(Radius)))) +
  geom_boxplot() + 
  geom_jitter() +
  labs(title = "Overall Distribution of Method 2 by Radius and Resolution", 
       x="Search Radius") +
  facet_grid(~Resolution, labeller = label_both) +
  theme(legend.position = "none")

### Overall distribution of method/Distance 2
all_dat %>% 
  ggplot(aes(fct_inorder(as.factor(Radius)), y=`Distance 2`, color=fct_inorder(as.factor(Radius)))) +
  geom_boxplot() + 
  geom_jitter() +
  labs(title = "Overall Distribution of Method 2 by Radius", 
       x = "Search Radius")


## bar plot with position dodge showing the mean of highest vote 
# extracting the vote and rounding.
#getting the proper numbers to label with  for test circle 0.01
test_9 <- all_dat %>%
  filter(test_circle == "Rad_0.09") %>% 
  group_by(Radius, Resolution) %>% 
  summarise(avg_high_vote = mean(`Highest Vote`)) %>% 
  round(., digits = 2) %>% 
  pull(avg_high_vote)
 
all_dat %>% 
  filter(test_circle == "Rad_0.09") %>% 
  group_by(Radius, Resolution) %>% 
  summarise(avg_high_vote = mean(`Highest Vote`)) %>% 
  ggplot(aes(x=fct_inorder(as.factor(Radius)), y=avg_high_vote, fill=Radius)) +
  geom_col(position = "dodge") +
  geom_text(aes(label=test_9), nudge_y = 1) +
  facet_grid(~Resolution, labeller = label_both) +
  labs(title = "Average Highest Vote by Radius and Resolution", 
       x = "Search Radius", 
       y = "Votes") +
  theme(legend.position = "position", 
        axis.title.y = element_text(size = 16), 
        axis.title.x = element_text(size = 16))
  #want to change color and order of Radius

test_1 <- all_dat %>%
  filter(test_circle == "Rad_0.1") %>% 
  group_by(Radius, Resolution) %>% 
  summarise(avg_high_vote = mean(`Highest Vote`)) %>% 
  round(., digits = 2) %>% 
  pull(avg_high_vote)

all_dat %>% 
  filter(test_circle == "Rad_0.1") %>% 
  group_by(Radius, Resolution) %>% 
  summarise(avg_high_vote = mean(`Highest Vote`)) %>% 
  ggplot(aes(x=fct_inorder(as.factor(Radius)), y=avg_high_vote, fill=Radius)) +
  geom_col(position = "dodge") +
  geom_text(aes(label=test_1), nudge_y = 1) +
  facet_grid(~Resolution, labeller = label_both) +
  labs(title = "Average Highest Vote by Radius and Resolution", 
       x = "Search Radius", 
       y = "Votes") +
  theme(legend.position = "position", 
        axis.title.y = element_text(size = 16), 
        axis.title.x = element_text(size = 16))

#getting the proper numbers to label with for test circle 0.011
test_11 <- all_dat %>%
  filter(test_circle == "Rad_0.11") %>% 
  group_by(Radius, Resolution) %>% 
  summarise(avg_high_vote = mean(`Highest Vote`)) %>% 
  round(., digits = 2) %>% 
  pull(avg_high_vote)

all_dat %>% 
  filter(test_circle == "Rad_0.11") %>%
  group_by(Radius, Resolution) %>% 
  summarise(avg_high_vote = mean(`Highest Vote`)) %>% 
  ggplot(aes(x=fct_inorder(as.factor(Radius)), y=avg_high_vote, fill=Radius)) +
  geom_col(position = "dodge") +
  geom_text(aes(label=test_11), nudge_y = 1) +
  facet_grid(~Resolution, labeller = label_both) +
  labs(title = "Average Highest Vote by Radius and Resolution", 
       x = "Search Radius", 
       y = "Votes") +
  theme(legend.position = "position", 
        axis.title.y = element_text(size = 16), 
        axis.title.x = element_text(size = 16))


# NOT WORKING # 
# all_dat %>% 
#   group_by(Radius, Resolution) %>% 
#   summarise(avg_high_vote = mean(`Highest Vote`)) %>% 
#   as.table()

## bar plot with position dodge showing the mean votes of the layers
# all_dat %>% 
#   select(-c(`Distance 1`, `Distance 2`, `Highest Vote`)) %>% 
#   pivot_longer(cols = c("Layer_Mean_1","Layer_Mean_2", "Layer_Mean_3",
#                         "Layer_Mean_4","Layer_Mean_5","Layer_Mean_6",
#                         "Layer_Mean_7","Layer_Mean_8","Layer_Mean_9"),
#                names_to="Layer", 
#                values_to = "Layer_Vote")

### have to create a new data set then pivot longer the average count 
new <- all_dat %>% 
  select(-c(`Distance 1`, `Distance 2`, `Highest Vote`, "id")) %>% 
  pivot_longer(-c(Radius, Resolution, "test_circle"),
               names_to="Layer", 
               values_to = "Layer_Vote")
## not good
# new %>% 
#   group_by(Radius, Resolution, test_circle, Layer) %>% 
#   summarise(lay_avg = mean(Layer_Vote)) %>% 
#   ggplot()+
#   geom_bar(aes(x=test_circle, y=lay_avg), stat="identity", position ="dodge") + 
#   facet_grid(Radius~Resolution)

new %>% 
  group_by(Radius, Resolution, test_circle, Layer) %>% 
  summarise(lay_avg = mean(Layer_Vote)) %>% 
  ggplot(aes(x=test_circle, y=lay_avg, group=Layer, fill=Layer))+
  geom_col(position ="dodge") + 
  facet_grid(Radius~Resolution, labeller = label_both, scales = "free") + 
  labs(title = "Average vote every box outside the highest vote",
       y="Average layer vote", 
       x="Test circle")

## don't like it. 
# new %>% 
#   group_by(Radius, Resolution, test_circle, Layer) %>% 
#   summarise(lay_avg = mean(Layer_Vote)) %>% 
#   ggplot(aes(x=lay_avg, group=Layer))+
#   geom_histogram(position ="dodge") + 
#   facet_grid(Radius~Resolution)


## table of average layered means





