#Membaca Data
library(readxl)
SSIT <- read_excel("SSIT Data Nov QlikSense.xlsx", sheet = 1)

#Install Library
library(dplyr)
library(ggplot2)
str(SSIT)

#Loss Money due to scrap
loss_Qty <- SSIT["$"]
loss_Qty

total_loss_Qty <- sum(loss_Qty)
total_loss_Qty

#NC Description vs Lose Money
SSIT_Summarize <- SSIT %>%
  group_by(NCDescription) %>%
  summarize(sum_ncdescription = sum(`$`)) %>%
  arrange(desc(sum_ncdescription))

ggplot(SSIT_Summarize, aes(NCDescription, sum_ncdescription))+geom_col()

#Prediction NC number per Department
NC_Prediction <- SSIT %>%
  group_by(product) %>%
  summarize(sum_NC = sum(Qty))

NC_Prediction
ggplot(NC_Prediction, aes(product, sum_NC)) +
  geom_col()


