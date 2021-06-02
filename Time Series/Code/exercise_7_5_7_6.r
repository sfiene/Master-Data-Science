library(fpp2)

# Exercise 7.5
# plot books
books
autoplot(books) +
  xlab("Day") + ylab("Number of books sold")

# create forecast for paper and hardback
fc <- ses(books[,1], h=4)
fc2 <- ses(books[,2], h=4)

fc
fc2

# compute RMSE for both paperback and hardback
round(accuracy(fc), 2)
round(accuracy(fc2), 2)

# plot forecast
autoplot(books) +
  autolayer(fc, series = "Fitted fc") +
  autolayer(fc2, series = "Fitted fc2") +
  xlab("Day") + 
  ylab("Number of books sold")

# Exercise 7.6
# create holt fc for paperback and hardback
holt_fc <- holt(books[,1], h=4)
holt_fc2 <- holt(books[,2], h=4)
ses_fc <- ses(books[,1], h=4)
ses_fc2 <- ses(books[,2], h=4)

# compare accuracy between Holt and SES
round(accuracy(holt_fc), 2)
round(accuracy(holt_fc2), 2)

round(accuracy(ses_fc), 2)
round(accuracy(ses_fc2), 2)

# plot holt forecast
autoplot(books) +
  autolayer(holt_fc, series = "Holt paperback") +
  autolayer(holt_fc2, series = "Holt hardback") +
  xlab("Day") +
  ylab("Number of books sold")

# ses forecasst for comparison
autoplot(books) +
  autolayer(ses_fc, series = "SES paperback") +
  autolayer(ses_fc2, series = "SES hardback") +
  xlab("Day") +
  ylab("Number of books sold")

# calculate and compare RMSE
e1 <- tsCV(books[,1], ses, h=1)
e2 <- tsCV(books[,2], ses, h=1)
e3 <- tsCV(books[,1], holt, h=1)
e4 <- tsCV(books[,2], holt, h=1)
e1
e2
e3
e4

mean(sqrt(e1^2), na.rm = TRUE)
round(accuracy(ses_fc), 2)

mean(sqrt(e2^2), na.rm = TRUE)
round(accuracy(ses_fc2), 2)

mean(sqrt(e3^2), na.rm = TRUE)
round(accuracy(holt_fc), 2)

mean(sqrt(e4^2), na.rm = TRUE)
round(accuracy(holt_fc2), 2)
