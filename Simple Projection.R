global_temp <- read.csv("global_temperature.csv", sep = ",", head = TRUE)
View(global_temp)
plot(global_temp$year, global_temp$degrees_celsius,
     type = "l", col = "forestgreen",
     xlab = "YEAR", ylab = "TEMPERATURE")

library(forecast)
library(ggplot2)

global_temp_ts <- ts(global_temp$degrees_celsius,
                     start = global_temp$year[1])
temperature_forecast <- forecast(ets(global_temp_ts), h=50)
autoplot(temperature_forecast)