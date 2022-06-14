########
# Creating a timeline of the Doctrine and Covenants and exploring other visuals
########

# loading packages needed
pacman::p_load(tidyverse, vistime)


# loading Data 
docandcov <- readxl::read_excel("Data/D&C Chronological Order.xlsx")
View(docandcov)

vistime(docandcov, col.event = "Year", col.group = "Section Number",
        col.start = "Year", col.end = "Year" , title = "Chronology of Sections")
# getting error - think in order to use this package I will need to add in columns. 


# making Month a factor
docandcov$Month <- factor(docandcov$Month, levels = c('January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December', 'Unknown'))

# visualizing by the count of revelations by month
docandcov %>% 
  ggplot(aes(Month)) +
  geom_bar() + 
  geom_text(stat='count', aes(label=..count..), vjust=-0.5) +
  theme(axis.text.x = element_text(angle=90))


# visualizing the count of revelations by state
docandcov %>% 
  ggplot(aes(x = fct_infreq(State))) +
  geom_bar() +  
  geom_text(stat='count', aes(label=..count..), vjust=-0.2) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle=90)) + 
  labs(title = 'Revelation Count by State', x = 'State', y = '')

# take above visual and put it a table  
  
  