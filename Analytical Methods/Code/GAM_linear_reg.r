library(mgcv)
library(ggplot2)
getwd()
setwd("C:\\users\\optim\\downloads")
getwd()
load("NatalBirthData.rdata")

# applying linear regression with and without GAM
train <- sdata[sdata$ORIGRANDGROUP<=5,]
test <- sdata[sdata$ORIGRANDGROUP>5,]
head(train)

form.lin <- as.formula("DBWT ~ PWGT + WTGAIN + MAGER + UPREVIS")
linmodel <- lm(form.lin, data=train)
summary(linmodel)

# build GAM with same variables
form.glin <- as.formula("DBWT ~ s(PWGT) + s(WTGAIN) +
                        s(MAGER) + s(UPREVIS)")
glinmodel <- gam(form.glin, data=train)
glinmodel$converged
summary(glinmodel)

# plot GAM results
terms <- predict(glinmodel, type='terms')
tframe <- cbind(DBWT = train$DBWT,
                as.data.frame(terms))
colnames(tframe) <- gsub('[()]', '', colnames(tframe))
pframe <- cbind(tframe, train[,c("PWGT", "WTGAIN", "MAGER", "UPREVIS")])

p1 <- ggplot(pframe, aes(x=PWGT)) +
  geom_point(aes(y=scale(sPWGT, scale=F))) +
  geom_smooth(aes(y=scale(DBWT, scale=F)))

p2 <- ggplot(pframe, aes(x=WTGAIN)) +
  geom_point(aes(y=scale(sWTGAIN, scale=F))) +
  geom_smooth(aes(y=scale(DBWT, scale=F)))

p3 <- ggplot(pframe, aes(x=MAGER)) +
  geom_point(aes(y=scale(sMAGER, scale=F))) +
  geom_smooth(aes(y=scale(DBWT, scale=F)))

p4 <- ggplot(pframe, aes(x=UPREVIS)) +
  geom_point(aes(y=scale(sUPREVIS, scale=F))) +
  geom_smooth(aes(y=scale(DBWT, scale=F)))

p1
p2
p3
p4

# checking performance
pred.lin <- predict(linmodel, newdata=test)
pred.glin <- predict(glinmodel, newdata=test)
cor(pred.lin, test$DBWT)^2
cor(pred.glin, test$DBWT)^2
