library(fpp2)
library(GGally)

# chapter 2.1 ts object
y <- ts(c(123, 39, 78, 52, 110), start = 2012)


# chapter 2.2 time plot
autoplot(melsyd[,'Economy.Class']) +
  ggtitle('Economy class passengers: Melbourne-Sydney') +
  xlab('Year') +
  ylab('Thousands')

autoplot(a10) +
  ggtitle("Antidiabetic drug sales") +
  ylab("$ million") +
  xlab("Year")


# chapter 2.4 seasonal plots
ggseasonplot(a10, year.labels = TRUE, year.labels.left = TRUE) +
  ylab("$ million") +
  ggtitle("Seasonal plot: antodiabetic drug sales")

ggseasonplot(a10, polar=TRUE) +
  ylab("$ millions") +
  ggtitle("Polar seasonal plot: antidiabetic drug sales")


#chapter 2.5 seasonal subseries plots
ggsubseriesplot(a10) +
  ylab("$ million") +
  ggtitle("Seasonal subseries plot: antidiabetic drug sales")


# chapter 2.6 scatterplots
autoplot(elecdemand[,c("Demand", "Temperature")], facets=TRUE) +
  xlab("Year: 2014") + ylab("") +
  ggtitle("Half-hourly electricity demand: Victoria, Australia")

qplot(Temperature, Demand, data=as.data.frame(elecdemand)) +
  ylab("Demand (GW)") + xlab("Temperature (Celcius)")

autoplot(visnights[,1:5], facets = TRUE) +
  ylab("Number of visitor nights each quarter (millions)")

GGally::ggpairs(as.data.frame(visnights[,1:5]))


# chapter 2.7 lag plots
beer2 <- window(ausbeer, start=1992)
gglagplot(beer2)


#chapter 2.8 autocorrelation
ggAcf(beer2)

aelec <- window(elec, start = 1980)
autoplot(aelec) + xlab("Year") + ylab("GWh")
ggAcf(aelec, lag=48)


#chapter 2.9 white noise
set.seed(30)
y <- ts(rnorm(50))
autoplot(y) + ggtitle("White noise")
ggAcf(y)


#chapter 2.10 exercises
# problem 1
autoplot(gold)
autoplot(woolyrnq)
autoplot(gas)

frequency(gold)
frequency(woolyrnq)
frequency(gas)

which.max(gold)

# problem 2
tute1 <- read.csv("tute1.csv", header = TRUE)
View(tute1)

mytimeseries <- ts(tute1[,-1], start = 1981, frequency = 4)
autoplot(mytimeseries)
autoplot(mytimeseries, facets = TRUE)

# problem 3
retaildata <- readxl::read_excel("retail.xlsx", skip = 1)
myts <- ts(retaildata[,"A3349532C"], frequency = 12, start = c(1982, 4))
autoplot(myts)
ggseasonplot(myts)
ggsubseriesplot(myts)
gglagplot(myts)
ggAcf(myts)

#problem 4
help(bicoal)
tsdisplay(bicoal)
ggAcf(bicoal)

help(chicken)
plot(chicken)
ggAcf(chicken)

help(dole)
plot(dole)
tsdisplay(dole)
ggAcf(dole)

help(usdeaths)
plot(usdeaths)
seasonplot(usdeaths)
tsdisplay(usdeaths)
ggAcf(usdeaths)

help(lynx)
plot(lynx)
tsdisplay(lynx)
ggAcf(lynx)

help(goog)
autoplot(goog)
ggAcf(goog)

help(writing)
tsdisplay(writing)
seasonplot(writing)
ggAcf(writing)

help(fancy)
plot(fancy)
seasonplot(fancy)
ggAcf(fancy)

help(a10)
autoplot(a10)
ggseasonplot(a10)
ggAcf(a10)

help(h02)
autoplot(h02)
ggseasonplot(h02)
ggAcf(h02)

#problem 5

