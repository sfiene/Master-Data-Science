# call importance on spam model
varImp <- importance(fmodel)

# importance function returns a matrix of importance
varImp[1:10,]

# plot importance variable
varImpPlot(fmodel, type = 1)

# fitting with fewer variable
# sort varibales by importance
selVars <- names(sort(varImp[,1], decreasing = T))[1:25]
fsel <- randomForest(x=spamTrain[,selVars], y=spamTrain$spam,
                     ntree=100,
                     nodesize = 7,
                     importance=T)

accuracyMeasures(predict(fsel,
                         newdata=spamTrain[,selVars],
                         type='prob')[,'spam'],
                 spamTrain$spam=='spam',
                 name = 'RF small, train')

accuracyMeasures(predict(fsel,
                         newdata=spamTest[selVars],
                         type='prob')[,'spam'],
                 spamTest$spam=='spam',
                 name='RF small, test')

