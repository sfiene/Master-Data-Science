library(plyr)
library(arules)
library(arulesViz)

ap <- read.csv("apirori.csv")
df_ap <- ddply(ap, c("TID", "items_bought"), function(df1)paste(df1$items_bought, collapse = ","))
df_ap$TID <- NULL
df_ap$items_bought <- NULL
colnames(df_ap <- c("items_bought"))
write.csv(df_ap, "dfap.csv", quote = FALSE, row.names = TRUE)

txn = read.transactions(file = "dfap.csv", rm.duplicates = TRUE, format = "basket", sep = ",", cols = 1)
txn@itemInfo$labels <- gsub("\"","",txn@itemInfo$labels)

basket_rules <- apriori(txn, parameter = list(sup = 0.6, conf = 0.8, target = "rules"))

inspect(txn)
length(txn)

image(txn)
itemFrequencyPlot(txn, support = 0.1)