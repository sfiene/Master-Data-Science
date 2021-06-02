
#8A
auto.arima(austa)
checkresiduals(auto.arima(austa))
autoplot(forecast(auto.arima(austa)))

#8B
autoplot(forecast(Arima(austa, c(0,1,1), include.drift = F)))

autoplot(forecast(Arima(austa, c(0,1,0), include.drift = F)))

#8C
autoplot(forecast(Arima(austa, c(2,1,3), include.drift = T)))

autoplot(forecast(Arima(austa, c(2,0,3), include.drift = T, include.constant = T)))

#8D
autoplot(forecast(Arima(austa, c(0,0,1), include.constant = T)))

autoplot(forecast(Arima(austa, c(0,0,0), include.constant = T)))

#8E
autoplot(forecast(Arima(austa, c(0,2,1), include.constant = F)))
