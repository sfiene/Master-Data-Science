# Exercise 6.2
# part a -- plot time series
autoplot(plastics) + ylab("Sales of product A")

# part b -- classical multiplicative decomp
fit <- decompose(plastics, type="multiplicative")
autoplot(fit)

# part d -- compute and plot seasonal adjusted
fit %>% seasadj() %>%
  autoplot() + ylab("Seasonally adjusted data")

# part e -- change and recomputer
plastics2 <- plastics
plastics2[31] <- plastics2[31] + 500
fit2 <- decompose(plastics2, type = "multiplicative")
autoplot(fit2)
fit2 %>% seasadj() %>%
  autoplot() + ylab("Seasonally adjusted data")

# part f -- outlier
plastics3 <- plastics
plastics3[59] <- plastics3[59] + 500
fit3 <- decompose(plastics3, type='multiplicative')
autoplot(fit3)
fit3 %>% seasadj() %>%
  autoplot() + ylab("Seasonally adjusted data")
