#Import Library
library("tidyverse")
library("broom")
library("dplyr")
library("leaps")
library("MASS")
library("caTools")
library("dplyr")

#Import Data
fat<-read.csv("fat.csv", sep=",", head=T)
attach(fat)

#Normality Test
shapiro.test(fat$body.fat)
ggdensity(fat$body.fat)

#Delete Unnecessary Column
fat1<-subset(fat, select=-c(body.fat.siri))

#Backward Method (to know what is the significant variable)
reg.bwd<-regsubsets(body.fat~., data=fat1, method="backward")
summary(reg.bwd)

#Training dan testing data
set.seed(123)
split = sample.split(fat1$body.fat, SplitRatio = 0.8)
training_set = subset(fat1, split == TRUE)
test_set = subset(fat1, split ==FALSE)

#Building Model based on significant variable
reg1<-lm(body.fat~ density+weight+ffweight, data=training_set)
summary(reg1)

#Predict the result based on model
y_pred = predict(reg1, newdata = training_set)

#Convert model prediction into data.frame
y_pred = data.frame(y_pred)

#Combine real data and prediction result
training_set2<-subset(training_set, select= body.fat)
comparison <- cbind(training_set2, y_pred)

#Calculate error between model and prediction result
comaparison <- comparison %>%
                 mutate(error = ((y_pred-body.fat)/body.fat)*100)

#Error Percentage Result
comparison %>%
  summarize(median_error = median(error))

#Model Result
#Y = 285.11 - 252.36*density + 0.16*weight - 0.20*ffweight  