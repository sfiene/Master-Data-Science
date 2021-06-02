# Load Library and set random forest
library(caret)
library(randomForest)
set.seed(123)
control <- rfeControl(functions=rfFuncs, method="cv", number = 10)

# Implement random forest
rfe.train <- rfe(traindata[,2:12], traindata[,13], sizes=1:12, rfeControl = control)
rfe.train

# Plot RFE algorithm
plot(rfe.train, type = c('g', 'o'), cex = 1.0, col = 1:11)

# Extract chosen feature
predictors(rfe.train)
