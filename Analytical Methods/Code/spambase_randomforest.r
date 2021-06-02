library(randomForest)

# set pseudo-random seed to a know value to try and make randomForest run repeatable
set.seed(5123512)

# call the randomForest() function to the build the model with explanatory variables as x and the category to be predicted as y
fmodel <- randomForest(x=spamTrain[,spamVars],
                       y=spamTrain$spam,
                       #use 100 trees to be compatible with baggin example
                       ntree=100,
                       #specify that the node of a tree must have a minimum of 7 elements to be compatible
                       nodesize=7,
                       #tell the algorithm to save information to be used for calculation
                       importance=T)

# report model quality
accuracyMeasures(predict(fmodel, 
                         newdata=spamTrain[,spamVars], 
                         type='prob')[,'spam'], 
                 spamTrain$spam=='spam',
                 name = 'random forest, train')

accuracyMeasures(predict(fmodel,
                         newdata=spamTest[,spamVars],
                         type='prob')[,'spam'],
                 spamTest$spam=='spam', name='random forest, test')
