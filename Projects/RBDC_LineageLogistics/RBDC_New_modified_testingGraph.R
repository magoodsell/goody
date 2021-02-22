# Create one visualization that has each testCircle results compared to each other, identified by color.

label_all_dat %>% 
  #filter(test_circle == "Rad_0.09") %>%
  #mutate(`Search Radius` = fct_inorder(as.factor(`Search Radius`))) %>% 
  # ggplot(aes(group=Resolution)) +
  ggplot(aes(group=test_circle)) +
  geom_point(aes(test_circle, y=`Distance 1`), color="blue4") + 
  geom_line(aes(test_circle, y=`Distance 1`), color="blue4") + 
  geom_point(aes(test_circle, y=`Distance 2`)) + 
  geom_line(aes(test_circle, y=`Distance 2`)) +
  # geom_point(aes(id, y=`Distance 1`), color="blue4") + 
  # geom_line(aes(id, y=`Distance 1`), color="blue4") + 
  # geom_point(aes(id, y=`Distance 2`)) + 
  # geom_line(aes(id, y=`Distance 2`)) +
  facet_grid(`Search Radius`~Resolution,
             labeller=label_both,
             scales = "free") +
  # facet_grid(test_circle~Resolution,
  #            labeller=label_both, 
  #            scales = "free") + 
  labs(title = "Method 1 & 2 results from imperfect circle of radius 0.09", 
       subtitle = "Blue = Method 1",
       y = "Distance from dumd mean") +
  # theme(axis.title.x = element_blank(), 
  #       axis.text.x = element_blank(), 
  #       axis.ticks.x = element_blank(),
  #       axis.title.y = element_text(size = 16))
theme(axis.title.y = element_text(size = 16))


# want to show the method results for each test circle. facet_grid( Search Radius ~ Resolution)