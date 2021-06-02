
# Linear Regression
getwd()
setwd("C:\\Users\\optim\\Downloads")
getwd()

# Load data and build train and test data
load("psub.RData")
dtrain <- subset(psub,ORIGRANDGROUP >= 500)
dtest <- subset(psub,ORIGRANDGROUP < 500)
model <- lm(log(PINCP, base=10) ~ AGEP + SEX + COW + SCHL, data=dtrain)
dtest$predLogPINCP <- predict(model, newdata=dtest)
dtrain$predLogPINCP <- predict(model, newdata=dtrain)

library(ggplot2)

# Plotting log income as a function of predicted log income
ggplot(data=dtest,aes(x=predLogPINCP,y=log(PINCP,base = 10))) +
  geom_point(alpha= 0.2, color='black') +
  geom_smooth(aes(x=predLogPINCP, y=log(PINCP, base=10)), color='black') +
  geom_line(aes(x=log(PINCP,base=10), y=log(PINCP,base=10)), color='blue', linetype=2) +
  scale_x_continuous(limits=c(4,5)) +
  scale_y_continuous(limits=c(3.5,5.5))

# Plotting residuals income as a function of predicted log income
ggplot(data=dtest, aes(x=predLogPINCP,y=predLogPINCP-log(PINCP,base=10))) +
  geom_point(alpha=0.2,color='black') +
  geom_smooth(aes(x=predLogPINCP,y=predLogPINCP-log(PINCP,base=10)), color='black')



# Logistic Regression
# load data
load("NatalRiskData.rdata")
train <- sdata[sdata$ORIGRANDGROUP<=5,]
test <- sdata[sdata$ORIGRANDGROUP>5,]

# build logistic regression model formula
complications <- c("ULD_MECO", "ULD_PRECIP", "ULD_BREECH")
riskfactors <- c("URF_DIAB", "URF_CHYPER", "URF_PHYPER", "URF_ECLAM")
y <- "atRisk"
x <- c("PWGT",
       "UPREVIS",
       "CIG_REC",
       "GESTREC3",
       "DPLURAL",
       complications,
       riskfactors)
fmla <- paste(y, paste(x, collapse="+"), sep="~")

# fitting model
print(fmla)
model <- glm(fmla, data=train, family=binomial(link = "logit"))

# apply model
train$pred <- predict(model, newdata=train, type='response')
test$pred <- predict(model, newdata=test, type='response')

# plot
ggplot(train, aes(x=pred, color=atRisk, linetype=atRisk)) +
  geom_density()

# exploring model trade-offs
install.packages('ROCR')
install.packages("grid")
library(ROCR)
library(grid)

predObj <- prediction(train$pred, train$atRisk)
precObj <- performance(predObj, measure = "prec")
recObj <- performance(predObj, measure = "rec")

precision <- (precObj@y.values)[[1]]
prec.x <- (precObj@x.values)[[1]]
recall <- (recObj@y.values)[[1]]

rocFrame <- data.frame(threshold=prec.x, precision=precision, recall=recall)
rocFrame

nplot <- function(plist) {
  n <- length(plist)
  grid.newpage()
  pushViewport(viewport(layout=grid.layout(n,1)))
  vplayout=function(x,y) {viewport(layout.pos.row=x, layout.pos.col=y)}
  for (i in 1:n) {
    print(plist[[i]], xp=vplayout(i,1))
  }
}
pnull <- mean(as.numeric(train$atRisk))
p1 <- ggplot(rocFrame, aes(x=threshold)) +
  geom_line(aes(y=precision/pnull)) +
  coord_cartesian(xlim = c(0,0.05),ylim=c(0,10))

p2 <- ggplot(rocFrame, aes(x=threshold)) +
  geom_line(aes(y=recall)) +
  coord_cartesian(xlim = c(0,0.05))
nplot(list(p1,p2))

# evaluated choese model
ctab.test <- table(pred=test$pred>0.02, atRisk=test$atRisk)
ctab.test

precision <- ctab.test[2,2]/sum(ctab.test[2,1])
precision

recall <- ctab.test[2,2]/sum(ctab.test[,2])
recall

enrich <- precision/mean(as.numeric(test$atRisk))
enrich

# model coefficients
coefficients(model)

# model summary
summary(model)

# calculate deviance residuals
pred <- predict(model, newdata=train, type='response')
llcomponents <- function(y,py) {y*log(py) + (1-y)*log(1-py)}
edev <- sign(as.numeric(train$atRisk) - pred) * sqrt(-2*llcomponents(as.numeric(train$atRisk), pred))
summary(edev)

# computing deviance
loglikelihood <- function(y,py){
  sum(y*log(py) + (1-y)*log(1-py))
}

pnull <- mean(as.numeric(train$atRisk))
null.dev <- -2*loglikelihood(as.numeric(train$atRisk), pnull)

pnull
null.dev

pred <- predict(model, newdata=train, type='response')
resid.dev <- -2*loglikelihood(as.numeric(train$atRisk), pred)

resid.dev

model$deviance

testy <- as.numeric(test$atRisk)
testpred <- predict(model, newdata=test, type='response')

pnull.test <- mean(testy)
null.dev.test <- -2*loglikelihood(testy, pnull.test)
resid.dev.test <- -2*loglikelihood(testy, testpred)

pnull.test
null.dev.test
resid.dev.test

# calculating significance of fit
df.null <- dim(train)[[1]] - 1
df.model <- dim(train)[[1]] - length(model$coefficients)

df.null                
df.model

delDev <- null.dev - resid.dev
deldf <- df.null - df.model
p <- pchisq(delDev, deldf, lower.tail = F)

delDev
deldf
p

# calculating pseudo r-squared
pr2 <- 1-(resid.dev/null.dev)
print(pr2)

pr2.test <- 1-(resid.dev.test/null.dev.test)
print(pr2.test)

# AIC
aic <- 2*(length(model$coefficients) - loglikelihood(as.numeric(train$atRisk), pred))

aic
