#Membaca data
pelanggan <- read.delim("Customer Segmentation.txt", 
                      stringsAsFactors = FALSE)

#konversi karakter menjadi matrix
pelanggan_matrix <- data.matrix(pelanggan[c("Jenis.Kelamin", "Profesi", 
                                            "Tipe.Residen")])

#menggabungkan 2 data
pelanggan <- data.frame(pelanggan, pelanggan_matrix)


#mengisi data master
Jenis.Kelamin <- unique(pelanggan[c("Jenis.Kelamin", "Jenis.Kelamin.1")])
Profesi <- unique(pelanggan[c("Profesi", "Profesi.1")])
Tipe.Residen <- unique(pelanggan[c("Tipe.Residen", "Tipe.Residen.1")])
Profesi
#normalisasi data
pelanggan$NilaiBelanjaSetahun <- pelanggan$NilaiBelanjaSetahun/1000000

#Field used
field_yang_digunakan = c("Jenis.Kelamin.1", "Umur", "Profesi.1", 
                         "Tipe.Residen.1","NilaiBelanjaSetahun")

#Segementasi K-Means
set.seed(100)

#Pembentukan 3 Cluster
segmentasi <- kmeans(x=pelanggan[field_yang_digunakan], centers = 5, nstart =25)

#Print hasil
segmentasi

#segmentasi cluster
pelanggan$cluster <- segmentasi$cluster

#jumlah data pada masing-masing cluster
length(which(pelanggan$cluster==1))
length(which(pelanggan$cluster==2))
length(which(pelanggan$cluster==3))
length(which(pelanggan$cluster==4))
length(which(pelanggan$cluster==5))

#melihat nilai means dari masing2 cluster
segmentasi$centers

#membandingkan SSE dengan perubahan cluster
set.seed(100)
kmeans(x=pelanggan[field_yang_digunakan], centers = 3, nstart =25)
kmeans(x=pelanggan[field_yang_digunakan], centers = 4, nstart =25)
kmeans(x=pelanggan[field_yang_digunakan], centers = 6, nstart =25)
kmeans(x=pelanggan[field_yang_digunakan], centers = 7, nstart =25)
kmeans(x=pelanggan[field_yang_digunakan], centers = 8, nstart =25)

#melihat available components
#Vector dari cluster untuk tiap titik data
segmentasi$cluster
#Merupakan informasi titik centroid dari tiap cluster,seperti pada bagian "Analisa Hasil Cluster Means"
segmentasi$centers
#Total Sum of Squares (SS) untuk seluruh titik data
segmentasi$totss
#Total Sum of Squares per cluster
segmentasi$withinss
#Total penjumlahan dari tiap SS dari withinss
segmentasi$tot.withinss
#Perbedaan nilai antara totss dan tot.withinss
segmentasi$betweenss
#Jumlah titik data pada tiap cluster
segmentasi$size
#Jumlah iterasi luar yang digunakan oleh kmeans
segmentasi$iter
#Nilai integer yang menunjukkan indikator masalah pada algoritma
segmentasi$ifault




