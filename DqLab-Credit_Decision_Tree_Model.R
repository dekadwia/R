#pada decision tree model, akan dibandingkan antara class variable dengan model yg kita rancang

library(readxl)
library(C50)
library(reshape2)
setwd("D:")
#Mempersiapkan data
dataCreditRating <- read_excel("credit_scoring_dqlab.xlsx")
dataCreditRating$risk_rating <- as.factor(dataCreditRating$risk_rating) 


#Melakukan konversi kolom risk_rating menjadi factor
dataCreditRating$risk_rating <- as.factor (dataCreditRating$risk_rating)

#Melihat struktur setelah konversi
str(dataCreditRating)

#Membuat Input column 
input_column <- c("durasi_pinjaman_bulan", "jumlah_tanggungan")

datafeed <- dataCreditRating[,input_column]

#Membuat porsi index acak untuk training dan testing data set
set.seed(100)
indeks_training_set <- sample (900,800)

#Membuat dan menampilkan training dan testing set
input_training_set <- datafeed[indeks_training_set,]
class_training_set <- dataCreditRating[indeks_training_set,]$risk_rating
input_testing_set <- datafeed[-indeks_training_set,]

#Membuat Model C5.0
risk_rating_model <- C5.0(input_training_set, class_training_set,
                          control = C5.0Control(label="Risk Rating"))

#Summary
summary(risk_rating_model)

#Plot model
plot(risk_rating_model)

#menggunakan model untuk prediksi testing set
predict(risk_rating_model, input_testing_set)

#menyimpan hasil prediksi testing set ke dalam kolom hasil_prediksi
input_testing_set$risk_rating <- dataCreditRating[-indeks_training_set,]$risk_rating
input_testing_set$hasil_prediksi <- predict(risk_rating_model, input_testing_set)
print(input_testing_set)

#membuat confusion matrix
dcast(hasil_prediksi ~ risk_rating, data=input_testing_set)

#Menghitung jumlah prediksi yang benar
nrow(input_testing_set[input_testing_set$risk_rating==
                         input_testing_set$hasil_prediksi,])

#Menghitung jumlah prediksi yang salah
nrow(input_testing_set[input_testing_set$risk_rating!=
                         input_testing_set$hasil_prediksi,])

#Membuat data frame pengajuan kredit baru
aplikasi_baru <- data.frame(jumlah_tanggungan = c(6,5,2), 
                            durasi_pinjaman_bulan = c(12,24,12))

#Prediksi aplikasi baru
predict (risk_rating_model, aplikasi_baru)



