pacman::p_load(tidyverse, gt, DT, kableExtra, ztable)

### Loading data ###
new_test_0.05 <- read_csv("Data/OldG_newR_TestResults_circle_rad_0.05.csv")
new_test_0.1 <- read_csv("Data/OldG_newR_TestResults_circle_rad_0.1.csv")
new_test_0.15 <- read_csv("Data/OldG_newR_TestResults_circle_rad_0.15.csv")
#mutating to identify what test circle the data is from
new_dat_0.05 <- new_test_0.05 %>% 
  mutate(test_circle = "Rad_0.05")
new_dat_0.1 <- new_test_0.1 %>% 
  mutate(test_circle = "Rad_0.1")
new_dat_0.15 <- new_test_0.15 %>% 
  mutate(test_circle = "Rad_0.15")
# binding rows of the data
new_all_dat <- bind_rows(new_dat_0.05, new_dat_0.1, new_dat_0.15) %>% 
  mutate(id = row_number()) %>% # give it an index
  rename("Search Radius" = "Radius")  
# getting better labels on the facet_grid
new_label_all_dat <- new_all_dat

new_label_all_dat$Radius <- factor(new_label_all_dat$`Search Radius`, levels =c("0.05", "0.10", "0.15"),
                                   labels = c("0.05", "0.10", "0.15"))

### Table ###


conf_wider <- new_label_all_dat %>% 
  select(-c(4:26)) %>% 
  select(-c(Gitter, Radius, id)) %>%
  group_by(Resolution, `Search Radius`, test_circle) %>%
  summarise(conf_avg = mean(Confidence))  %>% 
  pivot_wider(names_from = Resolution, values_from=conf_avg)# pivoting wider the dataset 

# filter by test_circle and then covert data types to doubles then run ztable

conf_r05 <- conf_wider %>% 
  filter(test_circle == "Rad_0.05") %>% 
  select(-test_circle)

t <- ztable(head(conf_r05))

# conf_r05$`Search Radius` <- as.integer(conf_r05$`Search Radius`)
# conf_r05$"0.001" <- as.integer(conf_r05$`Search Radius`)
# conf_r05$`Search Radius` <- as.integer(conf_r05$`Search Radius`)
# conf_r05$`Search Radius` <- as.integer(conf_r05$`Search Radius`)

conf_r1 <- conf_wider %>% 
  filter(test_circle == "Rad_0.1") %>% 
  select(-test_circle)

# testing different tables 
gt(conf_wider, rowname_col =conf_wider$`Search Radius`, groupname_col = "test_circle")

datatable(conf_wider)

# using ztable
# options(ztable.type="html")
# z=ztable(head(iris),caption="Table 1. Basic Table")
# z
test <- tibble(conf_wider)
options(ztable.type = "viewer")
test = ztable(head(conf_wider))
test %>%
  makeHeatmap(cols = c(5)) %>%
  print(caption = "Confidence")

# library(magrittr)  

options(ztable.type = "html")
ztable(head(conf_wider), caption="Confidence scores from 0 to 1")
class()


library(ztable)
library(magrittr)
#options(ztable.type="html")
z=ztable(head(iris),caption="Table 1. Basic Table")
z



#not working
conf_table <- conf %>% 
  filter(test_circle == "Rad_0.05") %>%
  select(-test_circle) #%>% 
# table(conf$Resolution, conf$`Search Radius`)

#use library(mosaic)
table <- conf_table %>% 
  round(., digits = 3) %>% 
  matrix(nrow = 3, ncol = 3, byrow = TRUE, dimnames = c(Resolution, `Search Radius`))


### Graphs ####

## bind rows of conf2 and conf

all_conf <- bind_rows(conf, conf2)

# distribution 

conf_test %>% 
  ggplot(aes(x=fct_inorder(as.factor(test_circle)), y= conf_avg, fill=test_circle)) +
  geom_boxplot() +
  geom_jitter() +
  labs(title = "Distribution of average",
       y= "Average",
       x= "Test Circle")


all_conf %>% ##test circle 0.1 gets double. need to fix that
  ggplot(aes(x=fct_inorder(as.factor(test_circle)), y= conf_avg, fill=test_circle)) +
  geom_boxplot() +
  geom_jitter() +
  labs(title = "Distribution of average",
       y= "Average",
       x= "Test Circle")

# scatter plot with factors

conf_test %>% 
  ggplot(aes(x=fct_inorder(as.factor(test_circle)), y=conf_avg)) + 
  geom_point() +
  facet_grid(`Search Radius`~Resolution, 
             labeller = label_both, 
             scales = "free") + 
  labs(title = "Average confidence",
       x= "Test circle", 
       y= "Average from 0 to 1") +
  theme(axis.text.x = element_text(angle = 90))


all_conf %>% ##test circle 0.1 gets double. need to fix that
  ggplot(aes(x=fct_inorder(as.factor(test_circle)), y=conf_avg)) + 
  geom_point() +
  facet_grid(`Search Radius`~Resolution, 
             labeller = label_both) + 
  labs(title = "Average confidence",
       x= "Test circle", 
       y= "Average from 0 to 1") +
  theme(axis.text.x = element_text(angle = 90))

