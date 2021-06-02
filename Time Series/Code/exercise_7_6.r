library(fpp2)

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

autoplot(books) +
  autolayer(holt_fc, series = "Holt paperback") +
  autolayer(holt_fc2, series = "Holt hardback") +
  xlab("Day") +
  ylab("Number of books sold")

autoplot(books) +
  autolayer(ses_fc, series = "SES paperback") +
  autolayer(ses_fc2, series = "SES hardback") +
  xlab("Day") +
  ylab("Number of books sold")

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
