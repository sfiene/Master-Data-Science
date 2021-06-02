library(fpp2)

# part a -- time plot
autoplot(fancy) +
  xlab("Year") + ylab("Sales")

# part b -- logarithm of the data
autoplot(log(fancy)) + ylab("log Sales")

# part c -- festival dummy
festival <- cycle(fancy) ==3
festival[3] <- FALSE

# part d -- fit linear model to logarithmic data (lambda = 0)
fit <- tslm(fancy ~ trend + season + festival, lambda = 0)

# check fitted values
autoplot(fancy) + ylab("Sales") +
  autolayer(fitted(fit), series = "Fitted")

# plot residuals
autoplot(residuals(fit))
qplot(fitted(fit), residuals(fit))

#part e -- boxplots for residuals
month <- factor(cycle(residuals(fit)), labels=month.abb)
ggplot() + geom_boxplot(aes(x=month, y=residuals(fit),
                            group=month))

# part f -- coefficients
coefficients(fit)

# part g -- Breusch-Godfrey test
checkresiduals(fit)

# part h -- regression model and prediction intervals
future.festival <- rep(FALSE, 36)
future.festival[c(3, 15, 27)] <- TRUE
fit %>%
  forecast(h=36, 
           newdata=data.frame(festival = future.festival)) %>%
  autoplot
