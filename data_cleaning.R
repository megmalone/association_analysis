library(dplyr)

# Data prep

data <- read.csv("")

menu <- unique(data[,c(1,2)]) # Returns all items "on the menu" and their format

orders <- data[,c(1,3)] # Remove item type

# Group orders by number and put all item into one value "items"
orders_comb <- orders %>%
  group_by(orderNumber) %>% 
  summarise(items = paste(order, collapse=","))

# Association analysis

library(arules)

items <- orders_comb[,2] #Col containing items only
# read.transactions wasn't accepting a df, so I made it a csv
write.table(items, "items.csv", sep = ",", row.names = F, col.names = F)

# Then, also, I had to manually data -> columns and save the file again as a .csv before importing it
# Seems like this worked, but one error: 1: In readLines(file, encoding = encoding) :
# incomplete final line found on 'items.csv'
# 2: In asMethod(object) : removing duplicated items in transactions
# These also appeared when I ran the grocery set from class, though?
transactions <- read.transactions("items.csv", sep = ",") # Read into a transaction dataset
summary(transactions)