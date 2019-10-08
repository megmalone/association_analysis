transactions <- read.transactions("items.csv", sep = ",") # Read into a transaction dataset
summary(transactions)
itemFrequency(transactions)

# Visualize the frequency of the items
itemFrequencyPlot(transactions, support = 0.1)
itemFrequencyPlot(transactions, topN = 14)

# The apriori function learns association rules from the  transaction data set.
# Set support and confidence levels:
rules <- apriori(transactions, parameter = list(support = 0.01, confidence = 0.25, minlen = 2))
# Summarize the rule breakdown
summary(rules)
inspect(sort(rules, by = "support")[1:50])
inspect(sort(rules, by = "lift")[1:50])

entree_rules <- subset(rules, items %in% c("Filet Mignon","Pork Tenderloin", "Roast Chicken","Duck"))
inspect(sort(entree_rules, by = "lift")[1:50])
