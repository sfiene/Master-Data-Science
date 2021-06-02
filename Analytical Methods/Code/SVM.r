# good SVM example spiral
install.packages("kernlab")
library(kernlab)
data('spirals')
sc <- specc(spirals, centers = 2)
s <- data.frame(x=spirals[,1],y=spirals[,2],class=as.factor(sc))

library(ggplot2)

ggplot(data=s) +
  geom_text(aes(x=x, y=y, label=class, color=class)) +
  coord_fixed() +
  theme_bw() +
  theme(legend.position = 'none')

# poor SVM choice
set.seed(2335246L)
s$group <- sample.int(100,size=dim(s)[[1]],replace=T)
sTrain <- subset(s,group>10)
sTest <- subset(s,group<=10)
mSVMV <- ksvm(class~x+y,data=sTrain,kernel='vanilladot')
sTest$predSVMV <- predict(mSVMV,newdata=sTest,type='response')
ggplot() +
  geom_text(data=sTest,aes(x=x,y=y,
                           label=predSVMV),size=12) +
  geom_text(data=s,aes(x=x,y=y,
                       label=class,color=class),alpha=0.7) +
  coord_fixed() +
  theme_bw() + theme(legend.position='none')

# SVM with good kernel
mSVMG <- ksvm(class~x+y,data=sTrain,kernel='rbfdot')
sTest$predSVMG <- predict(mSVMG,newdata=sTest,type='response')
ggplot() +
  geom_text(data=sTest,aes(x=x,y=y,  label=predSVMG),size=12) +
  geom_text(data=s,aes(x=x,y=y,
                       label=class,color=class),alpha=0.7) +
  coord_fixed() +
  theme_bw() + theme(legend.position='none')

# spambase with GLM
setwd("C:\\users\\optim\\desktop")
spamD <- read.table('spamD.tsv',header=T,sep='\t')
spamTrain <- subset(spamD,spamD$rgroup>=10)
spamTest <- subset(spamD,spamD$rgroup<10)
spamVars <- setdiff(colnames(spamD),list('rgroup','spam'))
spamFormula <- as.formula(paste('spam=="spam"',
                                paste(spamVars,collapse=' + '),sep=' ~ '))
spamModel <- glm(spamFormula,family=binomial(link='logit'),
                 data=spamTrain)
spamTest$pred <- predict(spamModel,newdata=spamTest,
                          type='response')
print(with(spamTest,table(y=spam,glPred=pred>=0.5)))

# applying SVM to spambase
library('kernlab')
spamFormulaV <- as.formula(paste('spam',
                                 paste(spamVars,collapse=' + '),sep=' ~ '))
svmM <- ksvm(spamFormulaV,data=spamTrain,
             kernel='rbfdot',
             C=10,
             prob.model=T,cross=5,
             class.weights=c('spam'=1,'non-spam'=10)
)
spamTest$svmPred <- predict(svmM,newdata=spamTest,type='response')
print(with(spamTest,table(y=spam,svmPred=svmPred)))

print(svmM)

# shifting decision point
sameCut <- sort(spamTest$pred)[length(spamTest$pred)-162]
print(with(spamTest,table(y=spam,glPred=pred>sameCut)))
