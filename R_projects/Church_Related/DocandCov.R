########
# Creating a timeline of the Doctring and Covenants
########

# loading packages needed
pacman::p_load(tidyverse, vistime)


# loading Data 
docandcov <- readxl::read_excel("Data/D&C Chronological Order.xlsx")
View(docandcov)

vistime(docandcov, col.event = "Year", col.group = "Section Number",
        col.start = "Year", col.end = "Year" , title = "Chronology of Sections")
# getting error - think in order to use this package I will need to add in columns. 

docandcov %>% 
  ggplot(aes(Month)) +
  geom_bar()
