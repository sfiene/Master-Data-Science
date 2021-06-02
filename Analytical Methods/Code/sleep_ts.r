getwd()
setwd("C:\\users\\optim\\desktop")

library(tidyverse)
library(fpp2)

# Clean Data and prepare for time series analysis
sleep <- read.csv("mysleepdata.csv", header = T, sep = ";")
sleep$Wake.up <- NULL
sleep$Sleep.Notes <- NULL
sleep$Heart.rate <- NULL
sleep$Time.in.bed <- NULL
sleep$End <- NULL
sleep <- separate(sleep, Start, c("Start_Date", "Start_Time"), sep = " ")
sleep$Start_Time <- NULL
names <- c("Start","Quality" , "Steps")
colnames(sleep) <- names
sleep <- separate(sleep, Quality, c("Quality" , "Percentage"), sep = "%")
sleep$Percentage <- NULL
sleep %>%
  mutate(Start = lubridate::ymd(Start),
         Quality = as.double(Quality),
         Steps = as.double(Steps)) -> sleep
head(sleep)
str(sleep)

# Create Time Series and Plot for analysis
sleep_ts <- ts(sleep, start = 2018 , frequency = 365)
autoplot(sleep_ts[,"Quality"])
ggAcf(sleep_ts[,"Quality"], lag.max = 96)

autoplot(sleep_ts[,"Steps"])
ggAcf(sleep_ts[,"Steps"], lag.max = 96)

autoplot(sleep_ts[,"Steps"], series = "Steps") +
  geom_smooth()

autoplot(sleep_ts[,"Quality"], series = "Quality") +
  geom_smooth()
