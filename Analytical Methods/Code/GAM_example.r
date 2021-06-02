# preparing artificial problem
set.seed(602957)

x <- rnorm(1000)
noise <- rnorm(1000, sd=1.5)

y <- 3*sin(2*x) + cos(0.75*x) - 1.5*(x^2) + noise

select <- runif(1000)
frame <- data.frame(y=y, x=x)

train <- frame[select > 0.1,]
test <- frame[select <= 0.1,]

# linear regression applied to example
lin.model <- lm(y ~ x, data = train)
summary(lin.model)

# calculate RMSE
resid.lin <- train$y-predict(lin.model)
sqrt(mean(resid.lin^2))

install.packages("mgcv")
library(mgcv)

# GAM applied to example
glin.model <- gam(y~s(x), data=train)
glin.model$converged
summary(glin.model)

# calculate RMSE
resid.glin <- train$y-predict(glin.model)
sqrt(mean(resid.glin^2))

# comparing linear regression and GAM performance
actual <- test$y
pred.lin <- predict(lin.model, newdata=test)
pred.glin <- predict(glin.model, newdata=test)
resid.lin <- actual-pred.lin
resid.glin <- actual-pred.glin

# compare RMSE between model
sqrt(mean(resid.lin^2))
sqrt(mean(resid.glin^2))

# compare R squared
cor(actual, pred.lin) ^2
cor(actual, pred.glin) ^2

# plot
plot(glin.model)

# extract a learned spline from GAM
sx <- predict(glin.model, type = 'terms')
summary(sx)

xframe <- cbind(train, sx=sx[,1])

library(ggplot2)
ggplot(xframe, aes(x=x)) + 
  geom_point(aes(y=y), alpha=0.4) +
  geom_line(aes(y=sx))
