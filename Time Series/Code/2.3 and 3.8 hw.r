#Problem 2.3 and 3.8
#Problem 2.3
#load package
library(fpp2)

#read data into R
retaildata <- readxl::read_excel("retail.xlsx", skip = 1)

#create time series
myts <- ts(retaildata[,"A3349532C"], 
           frequency = 12, start = c(1982, 4))

#plot retail data
autoplot(myts)
ggseasonplot(myts)
ggsubseriesplot(myts)
gglagplot(myts)
ggAcf(myts)

#Problem 3.8
#split data into two parts
myts.train <- window(myts, end=c(2010,12))
myts.test <- window(myts, start=2011)

#check if data split properly
autoplot(myts) +
  autolayer(myts.train, series = "Training") +
  autolayer(myts.test, series = "Test")

#calculate forecastin
fc <- snaive(myts.train)

#compare accuracy
accuracy(fc, myts.test)

#check residuals
checkresiduals(fc)
