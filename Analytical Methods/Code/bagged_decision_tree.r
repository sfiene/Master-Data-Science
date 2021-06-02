# bootstrap samples same size as training set
ntrain <- dim(spamTrain)[1]
n <- ntrain
ntree <- 100

#  build bootstrap by sampling row indicies of spamTrain with replacement
samples <- sapply(1:ntree,
                  FUN=function(iter) {sample(1:ntrain, size = n, replace=T)})

# train individual decision tree and return in a list
treelist <- lapply(1:ntree, FUN=function(iter) {samp <- samples[,iter];
rpart(spamFormula, spamTrain[samp,])})

# predict.bag assumes underlying cluster and returns decision probabilities
predict.bag <- function(treelist, newdata) {
  preds <- sapply(1:length(treelist),
                  FUN=function(iter) {
                    predict(treelist[[iter]], newdata=newdata)})
  predsums <- rowSums(preds)
  predsums/length(treelist)
}

# evaluate bagged decision trees
accuracyMeasures(predict.bag(treelist, newdata=spamTrain),
                 spamTrain$spam=='spam', name='bagging, training')

accuracyMeasures(predict.bag(treelist, newdata=spamTest),
                 spamTest$spam=='spam', name='bagging, test')
