install.packages("Boruta")
library(Boruta)

getwd()

# Structure of data
traindata <- read.csv("train_ctrUa4k.csv", header = T, stringsAsFactors = F)
traindata
str(traindata)

# Replace underscores with blank
names(traindata) <- gsub("_", "", names(traindata))
str(traindata)
summary(traindata)

# Replace missing values
traindata[traindata == ""] <- NA
traindata <- traindata[complete.cases(traindata),]

# Convert Categorical Values into factors
convert <- c(2:6, 11:13)
traindata[,convert] <- data.frame(apply(traindata[convert], 2, as.factor))

# Implement and check performance
set.seed(123)
boruta.train <- Boruta(LoanStatus~.-LoanID, data = traindata, doTrace = 2)
print(boruta.train)

# Plot importance chart
plot(boruta.train, xlab = "", xaxt = "n")
lz <- lapply(1:ncol(boruta.train$ImpHistory),function(i)
  boruta.train$ImpHistory[is.finite(boruta.train$ImpHistory[,i]),i])
lz
names(lz) <- colnames(boruta.train$ImpHistory)
Labels <- sort(sapply(lz,median))
axis(side = 1, las = 2, labels = names(Labels), at = 1:ncol(boruta.train$ImpHistory), cex.axis = 0.7)

# Tentative decision
final.boruta <-  TentativeRoughFix(boruta.train)
print(final.boruta)

# Results
getSelectedAttributes(final.boruta, withTentative = F)

# Data frame from results
boruta.df <- attStats(final.boruta)
class(boruta.df)
print(boruta.df)
