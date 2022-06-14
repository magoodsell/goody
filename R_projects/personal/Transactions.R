#############
# 2021 transactions
#############

pacman::p_load(tidyverse, lubridate)

# reading data in 

trans <- read_csv("C:/Users/matth/Documents/Projects/goody/Data/transactions_2021.csv")

View(trans)


##############
# wrangling data
##############


# not working 
trans$Date <- as.Date.character(trans$Date, tryFormats = "%Y/%m/%d")

# changes Data from character to Date
trans$Date <- mdy(trans$Date)

trans_2021 <- trans %>% 
  select(-c(Labels, Notes)) %>% 
  mutate(year = year(Date)) %>%   
  mutate(month = month(Date)) %>% 
  mutate(week_of_year = week(Date)) %>% 
  filter(.$Date >= '2021-01-01') %>% 
  # str_replace_all(.$`Account Name`, '®', '') %>% 
  mutate(`Account Name` = case_when(`Account Name` == "Wells Fargo Everyday Checking" ~ "Checking"
                                    #, `Account Name` == "Wells Fargo Way2Save Savings" ~ "Way2Save Savings"
                                    , TRUE ~ `Account Name`))
  # case when to change the account name to shorter names 
  # filter(Date >= '1/01/2021')
  
  
## 
# min data
## 
min_date <- min(trans$Date)

min_2021 <- min(trans_2021$Date)

# month and week, transaction type, show by category, account name, 

##
# Graphing Data
##

trans_2021 %>% ggplot(aes(x = fct_infreq(`Account Name`), y = Amount )) + 
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90)) + 
  theme_bw()

trans_2021 %>% ggplot(aes(x=`Transaction Type`, y = Amount)) + 
  geom_col()

trans_2021 %>% 
  filter(`Transaction Type` == 'debit') %>% 
  summarise(debit_sum = sum(Amount))


