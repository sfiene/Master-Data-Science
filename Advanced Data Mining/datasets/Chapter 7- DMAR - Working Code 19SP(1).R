#JK Data - You need to set your own working directory in the next line
setwd("C:\\Users\\optim\\OneDrive\\Scott\\Schoolwork\\Advanced Data Mining")
getwd()
#The parameters are set for tab-delimited files. These can be changed.
dataset1<-read.table(file="ticdata2000-training-v2.txt",header=TRUE,sep="\t",na.strings="*",stringsAsFactors=FALSE)
dataset1 #This gives you a glace at the data#
dataset2<-read.table(file="ticeval2000-validation-v2.txt",header=TRUE,sep="\t",na.strings="*",stringsAsFactors=FALSE)
dataset2
summary(dataset1)
str(dataset1)

#Exploring the data
library(Hmisc)
describe(dataset1)

correl1a <- as.data.frame(cor(dataset1[1:85],dataset1[86],method = "spearman"))
correl1b <- cbind(rownames(correl1a),correl1a)
correl1a
correl1b
correl1 <- correl1b[order(- abs((correl1b$CARAVAN))), ]
correl2a <- as.data.frame(cor(dataset1[1:85],dataset1[86],method = "pearson"))
correl2b <- cbind(rownames(correl2a),correl2a)
correl2 <- correl2b[order(- abs((correl2b$CARAVAN))), ]
correl1
correl2
plot(correl1)
plot(correl2)

prop.table(table(dataset1$MOSTYPE, dataset1$CARAVAN),1)

#The following makes four variables explicitly categorical 
dataset1$MOSTYPE <- as.factor(dataset1$MOSTYPE)
dataset1$MGEMLEEF <- as.factor(dataset1$MGEMLEEF)
dataset1$MOSHOOFD <- as.factor(dataset1$MOSHOOFD)
dataset1$PWAPART <- as.factor(dataset1$PWAPART)
dataset2$MOSTYPE <- as.factor(dataset2$MOSTYPE)
dataset2$MGEMLEEF <- as.factor(dataset2$MGEMLEEF)
dataset2$MOSHOOFD <- as.factor(dataset2$MOSHOOFD)
dataset2$PWAPART <- as.factor(dataset2$PWAPART)

prop.table(table(dataset1$MOSTYPE,dataset1$CARAVAN),1)
### removing religious variables from dataset
dataset1 <- dataset1[ ,-c(6:9)]
dataset2 <- dataset2[ ,-c(6:9)]

cust.logit <- glm(CARAVAN~. ,data = dataset1, family=binomial(link="logit"))
summary(cust.logit)
library(ROCR)
## RP model
library(rpart)
library(rpart.plot)
library(caret)
cust.rp<- rpart(CARAVAN~ ., data=dataset1)
cust.rp

rpart.plot(cust.rp)
cust.rp$cptable
printcp(cust.rp)
cust.rp$variable.importance
cust4.var.imp<-varImp(cust.rp, UseModel=rpart)
hist(cust4.var.imp$Overall)

cust4a <- cbind(rownames(cust4.var.imp),cust4.var.imp)
cust4 <- cust4a[order(-cust4a$Overall), ]
cust4

cust.rp.predict<-predict(cust.rp, type = "matrix", newdata = dataset2)
cust.rp.prob.rocr<-prediction(cust.rp.predict,dataset2$CARAVAN)
cust.rp.perf<-performance(cust.rp.prob.rocr,"tpr","fpr")
plot(cust.rp.perf,main="ROC curve on RPart",colorize=T)
##Bagging Model###

library(ipred)
cust.ip<-bagging(CARAVAN ~ ., data=dataset1, coob=TRUE)
cust.ip
cust.ip.prob<-predict(cust.ip, type="prob", newdata = dataset2)
cust.ip.prob
custip4.var.imp<-varImp(cust.ip)
hist(custip4.var.imp$Overall)

custip4a <- cbind(rownames(custip4.var.imp),custip4.var.imp)
custip4 <-custip4a[order(-custip4a$Overall), ]
custip4

cust.ip.prob.rocr<-prediction(cust.ip.prob, dataset2$CARAVAN)
cust.ip.perf<-performance(cust.ip.prob.rocr,"tpr","fpr")
plot(cust.ip.perf,main="ROC curve on Bagging",colorize=T)
## SVM ###
library(e1071)
cust.svm <-svm(CARAVAN ~ ., data=dataset1, method="C-classification", kernel="radial", cost=10, gamma=0.1, cross=0, fitted=TRUE,probability=TRUE)
cust.svm.feature.weights = t(cust.svm$coefs) %*% cust.svm$SV
cust.svm.feature.weights
custsvmt <- data.frame(t(cust.svm.feature.weights))
custsvma <- cbind(rownames(custsvmt),custsvmt)
custsvm <- custsvma[order(-abs(custsvma$t.cust.svm.feature.weights.)),]
custsvm
hist(cust.svm.feature.weights)

cust.svm.prob<-predict(cust.svm, type="prob", newdata = dataset2, probability=TRUE)
cust.svm.prob.rocr<-prediction(cust.svm.prob, dataset2$CARAVAN)
cust.svm.perf<-performance(cust.svm.prob.rocr,"tpr","fpr")
plot(cust.svm.perf,main="ROC curve on SVM",colorize=T)
### LR Classification ###
cust.logit<-glm(CARAVAN ~ ., data=dataset1, family = binomial(link="logit"))
summary(cust.logit)

custlogit.var.imp<-varImp(cust.logit,useModel=glm)
custlogita <- cbind(rownames(custlogit.var.imp),custlogit.var.imp)
custlogit <- custlogita[order(-custlogita$Overall), ]
custlogit

cust.logit.prob<-predict(cust.logit, type="response", newdata = dataset2)
cust.logit.prob.rocr<-prediction(cust.logit.prob, dataset2$CARAVAN)
cust.logit.perf<-performance(cust.logit.prob.rocr,"tpr","fpr")
plot(cust.logit.perf,main="ROC curve on LR",colorize=T)
### plotting ROC #####
ppi <- 300
png(filename="ROC curve without religion variables.png", width=6*ppi,height=6*ppi,res=ppi)
plot(cust.rp.perf,col=2,main="ROC curve without religion variables")
legend(0.5,0.5,c('rpart','bagging','svm','logitisc'),2:5)
plot(cust.ip.perf,col=3,add=TRUE)
plot(cust.svm.perf,col=4,add=TRUE)
plot(cust.logit.perf,col=5,add=TRUE)
dev.off()

### plotting Recall ####
cust.rp.perf.cr<-performance(cust.rp.prob.rocr,"rec","rpp")
cust.ip.perf.cr<-performance(cust.ip.prob.rocr,"rec","rpp")
cust.svm.perf.cr<-performance(cust.svm.prob.rocr,"rec","rpp")
cust.logit.perf.cr<-performance(cust.logit.prob.rocr,"rec","rpp")
ppi <- 300
png(filename="Cummulative curve without religion variables.png", width=6*ppi,height=6*ppi,res=ppi)
plot(cust.rp.perf.cr,col=2,main="Cummulative curve without religion variables")
legend(0.5,0.5,c('rpart','bagging','svm','logitisc'),2:5)
plot(cust.ip.perf.cr,col=3,add=TRUE)
plot(cust.svm.perf.cr,col=4,add=TRUE)
plot(cust.logit.perf.cr,col=5,add=TRUE)
dev.off()
#### plotting accuracy of prediction
cust.rp.perf.acc<-performance(cust.rp.prob.rocr,"acc")
cust.ip.perf.acc<-performance(cust.ip.prob.rocr,"acc")
cust.svm.perf.acc<-performance(cust.svm.prob.rocr,"acc")
cust.logit.perf.acc<-performance(cust.logit.prob.rocr,"acc")
ppi <- 300
png(filename="Accuracy vesus Cut-off without religion variables.png", width=6*ppi,height=6*ppi,res=ppi)
plot(cust.rp.perf.acc,col=2,main="Accuracy vesus Cut-off without religion variables")
legend(0.5,0.5,c('rpart','bagging','svm','logitisc'),2:5)
plot(cust.ip.perf.acc,col=3,add=TRUE)
plot(cust.svm.perf.acc,col=4,add=TRUE)
plot(cust.logit.perf.acc,col=5,add=TRUE)
dev.off()

time.rp <- system.time(
  {cust.rp <- rpart(CARAVAN~. , data=dataset1)
  cust.rp.pred <- predict(cust.rp,type="matrix",newdata=dataset2)
  cust.rp.prob.rocr <- prediction(cust.rp.pred, dataset2$CARAVAN)})
time.rp

# Cross Validation - RP
control <-rpart.control(xval=5)
cust.rp2 <- rpart(CARAVAN~., data=dataset1, control = rpart.control(xval = 5)) 
cust.rp2

rpart.plot(cust.rp2)
cust.rp2$cptable
printcp(cust.rp2)
cust.rp2$variable.importance
cust42.var.imp<-varImp(cust.rp2, UseModel=rpart)
hist(cust42.var.imp$Overall)

cust4a2 <- cbind(rownames(cust42.var.imp),cust42.var.imp)
cust42 <- cust4a2[order(-cust4a2$Overall), ]
cust42

cust.rp.predict2<-predict(cust.rp2, type = "matrix", newdata = dataset2)
cust.rp.prob.rocr2<-prediction(cust.rp.predict2,dataset2$CARAVAN)
cust.rp.perf2<-performance(cust.rp.prob.rocr2,"tpr","fpr")
plot(cust.rp.perf2,main="ROC curve on RPart",colorize=T)

