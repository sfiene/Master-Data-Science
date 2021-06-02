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
