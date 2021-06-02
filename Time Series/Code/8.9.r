library(fpp2)
library(urca)

#9A
autoplot(usgdp)

diff(diff(log(usgdp),12),1) %>% ur.kpss() %>% summary()

usgdp_transform <- diff(diff(log(usgdp),12),1)

usgdp_log %>% diff(h=12) %>% diff() %>% ggtsdisplay()



#9B
usgdp_taa <- auto.arima(usgdp_transform)
usgdp_taa

#9C
fit <- Arima(usgdp_transform, order=c(1,0,2), seasonal = c(2,0,4))
checkresiduals(fit)

fit2 <- Arima(usgdp_transform, order=c(2,0,2), seasonal = c(3,0,4))
checkresiduals(fit2)

fit3 <- Arima(usgdp_transform, order=c(1,1,2), seasonal = c(2,1,4))
checkresiduals(fit3)

fit4 <- Arima(usgdp_transform, order=c(1,1,1), seasonal = c(2,1,3))
checkresiduals(fit4)

fit5 <- Arima(usgdp_transform, order=c(2,1,3), seasonal = c(1,0,3))
checkresiduals(fit5)

fit %>% forecast(h=24) %>% autoplot()

fit2 %>% forecast(h=24) %>% autoplot()

fit3 %>% forecast(h=24) %>% autoplot()

fit4 %>% forecast(h=24) %>% autoplot()

fit5 %>% forecast(h=24) %>% autoplot()

#9D
checkresiduals(fit)

checkresiduals(fit3)

#9E
fit %>% forecast(h=24) %>% autoplot()

fit3 %>% forecast(h=24) %>% autoplot()

#9F
checkresiduals(ets(usgdp))
usgdp %>% forecast(h=24) %>% autoplot()
