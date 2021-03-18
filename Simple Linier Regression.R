# Mengimpor dataset
dataset = read.csv('Daftar_gaji.csv')

# Membagi dataset menjadi Training set and Test set
# install.packages('caTools') <-- jika belum mempunyai library nya hapus tanda #
library(caTools)
set.seed(123)
split = sample.split(dataset$Gaji, SplitRatio = 2/3)
training_set = subset(dataset, split == TRUE)
test_set = subset(dataset, split == FALSE)

# Feature Scaling
# training_set = scale(training_set)
# test_set = scale(test_set)

# Fitting Simple Linear Regression ke Training set
regressor = lm(Gaji ~ Tahun_bekerja, data = training_set)

# Memprediksi hasil test set
y_pred = predict(regressor, newdata = test_set)

# Visualising the Training set results
library(ggplot2)
ggplot() +
  geom_point(aes(x = training_set$Tahun_bekerja, y = training_set$Gaji), colour = 'red') +
  geom_line(aes(x = training_set$Tahun_bekerja, y = predict(regressor, newdata = training_set)), colour = 'blue') +
  ggtitle('Gaji vs Tahun bekerja (Training set)') +
  xlab('Tahun bekerja') +
  ylab('Gaji')

# Visualising the Test set results
library(ggplot2)
ggplot() +
  geom_point(aes(x = test_set$Tahun_bekerja, y = test_set$Gaji), colour = 'red') +
  geom_line(aes(x = training_set$Tahun_bekerja, y = predict(regressor, newdata = training_set)), colour = 'blue') +
  ggtitle('Gaji vs Tahun bekerja (Test set)') +
  xlab('Tahun bekerja') +
  ylab('Gaji')

# Analisis statistik model regresi
summary(regressor)
