getwd()
setwd("C:\\Users\\optim\\Desktop")
getwd()

# Load data and split 90% into train and 10% into test
spamD <- read.table("spamD.tsv", header = T, sep = '\t')
head(spamD)
summary(spamD)
spamTrain <- subset(spamD, spamD$rgroup>=10)
spamTest <- subset(spamD, spamD$rgroup<10)

# Binary classification where TRUE corresponds to spam documents
spamVars <- setdiff(colnames(spamD), list('rgroup','spam'))
spamVars
spamFormula <- as.formula(paste('spam=="spam"', paste(spamVars,collapse = ' + '), sep=' ~ '))
spamFormula

# function to calculate log likelihood(deviance)
loglikelihood <- function(y, py) {
  pysmooth <- ifelse(py==0, 1e-12,
                     ifelse(py==1, 1-1e-12, py))
  
  sum(y * log(pysmooth) + (1-y) * log(1 - pysmooth))
}

# Functon to calculate and return various measures on the model
# Normalized deviance, prediction accuracy, f1(a product of  precision and recall)

accuracyMeasures <- function(pred, truth, name="model") {
  dev.norm <- -2 * loglikelihood(as.numeric(truth), pred) / length(pred)
  ctable <- table(truth=truth, pred = (pred>0.5))
  accuracy <- sum(diag(ctable))/sum(ctable)
  precision <- ctable[2,2]/sum(ctable[,2])
  recall <- ctable[2,2]/sum(ctable[2,])
  f1 <- precision*recall
  data.frame(model=name, accuracy=accuracy, f1=f1, dev.norm)
}

# install rpart library
install.packages('rpart')
library(rpart)

# fit decision tree model
treemodel <- rpart(spamFormula, spamTrain)

# evaluate decision tree
accuracyMeasures(predict(treemodel, newdata=spamTrain),
                 spamTrain$spam=='spam', name='tree, training')

accuracyMeasures(predict(treemodel, newdata=spamTest),
                 spamTest$spam=='spam', name='tree, test')
