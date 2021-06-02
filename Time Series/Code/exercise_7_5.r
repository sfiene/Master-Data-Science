library(fpp2)

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

# plot forecasr
autoplot(books) +
  autolayer(fc, series = "Fitted fc") +
  autolayer(fc2, series = "Fitted fc2") +
  xlab("Day") + 
  ylab("Number of books sold")
