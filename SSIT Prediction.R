library(readxl)
setwd("D:")
SSIT <- read_excel("SSIT Data Nov QlikSense.xlsx", sheet = 1)

library(dplyr)
library(ggplot2)
library(ISLR)

#NC Description vs Lose Money
SSIT_Summarize <- SSIT %>%
  group_by(NCDescription) %>%
  summarize(sum_ncdescription = sum(`$`)) %>%
  arrange(desc(sum_ncdescription))

ggplot(SSIT_Summarize, aes(NCDescription, sum_ncdescription))+geom_col()

#Prediction NC number per Department
date <- format(SSIT$submit_date, format = "%m-%Y")
date
SSIT <- cbind(SSIT,date)
SSIT
NC_Prediction <- SSIT %>%
  group_by(product,date) %>%
  summarize(sum_NC = sum(Qty, na.rm = TRUE))

View(NC_Prediction)

ggplot(NC_Prediction, aes(date, sum_NC, color = product)) + geom_line(aes(group = product))

