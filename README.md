# Aplikasi Analisis Statistik Interaktif

## Perubahan yang Telah Dilakukan

### 1. Pembatasan Upload Data
- **Dihapus**: Fitur upload file CSV dari pengguna
- **Alasan**: Keamanan dan konsistensi data
- **Dampak**: Pengguna hanya dapat menggunakan dataset yang telah tersedia di sistem

### 2. Dataset yang Tersedia
- **SoVI Data** (`sovi_data.csv`): Dataset utama untuk analisis
- **Distance Data** (`distance.csv`): Dataset matriks jarak (511x511 data point)

### 3. **[BARU] Visualisasi Peta Jarak**
Implementasi baru yang memungkinkan penggunaan data distance untuk visualisasi peta di menu eksplorasi data:

#### Fitur Peta Jarak:
- **Multidimensional Scaling (MDS)**: Konversi matriks jarak 511x511 menjadi koordinat geografis 2D
- **Visualisasi Interaktif**: Peta leaflet dengan titik-titik yang merepresentasikan district
- **Pewarnaan Berdasarkan Variabel**: Integrasi dengan data SoVI untuk mewarnai titik berdasarkan variabel tertentu
- **Kontrol Interaktif**:
  - Pilihan variabel warna dari data SoVI
  - Pengaturan ukuran titik (1-50)
  - Toggle untuk menampilkan/menyembunyikan label district
- **Popup Informatif**: Menampilkan informasi district, koordinat, dan nilai variabel yang dipilih

#### Cara Menggunakan Peta Jarak:
1. Buka menu "Eksplorasi Data"
2. Pilih "Peta Jarak" dari dropdown "Pilih Jenis Grafik"
3. Pilih variabel warna (opsional) dari data SoVI
4. Atur ukuran titik sesuai preferensi
5. Centang/hilangkan centang "Tampilkan Label District"
6. Klik "Buat Grafik"

#### Interpretasi Peta Jarak:
- **Posisi Titik**: Dihasilkan dari algoritma MDS berdasarkan similaritas dalam matriks jarak
- **Jarak Antar Titik**: Mencerminkan similaritas - titik yang berdekatan memiliki karakteristik serupa
- **Pewarnaan**: Jika variabel dipilih, gradasi warna menunjukkan nilai variabel tersebut
- **Koordinat**: Dinormalisasi ke rentang geografis Indonesia (95-141° BT, -11-6° LU)

### 4. Fitur Download yang Tersedia
- **Format PDF**: Untuk semua jenis analisis statistik
- **Format Word (DOCX)**: Untuk semua jenis analisis statistik
- **Format JPG**: Untuk grafik (tidak termasuk peta interaktif)
- **Fitur download meliputi**:
  - Statistik deskriptif
  - Hasil uji normalitas
  - Hasil uji homogenitas
  - Hasil uji t-test (1 sampel dan 2 sampel)
  - Hasil uji proporsi
  - Hasil uji variance
  - Hasil ANOVA (1-way dan 2-way)
  - Hasil analisis regresi

### 5. Paket R yang Diperlukan
```r
install.packages(c(
  "shiny", "shinydashboard", "ggplot2", "dplyr", 
  "psych", "car", "DT", "knitr", "rmarkdown", 
  "tseries", "lmtest", "leaflet", "officer", "flextable", "scales"
), repos='https://cran.r-project.org/', dependencies=TRUE)
```

**Paket Baru yang Ditambahkan:**
- `scales`: Untuk normalisasi koordinat MDS

### 6. Cara Menjalankan Aplikasi
```r
# Di R console atau RStudio
shiny::runApp("app.R")
```

### 7. Fitur Keamanan
- Data tidak dapat diupload oleh pengguna
- Hanya dataset terverifikasi yang dapat digunakan
- Sistem menggunakan dataset internal untuk konsistensi

### 8. Format Download
- **PDF**: Menggunakan `rmarkdown` dengan output `pdf_document`
- **Word**: Menggunakan `rmarkdown` dengan output `word_document`
- **JPG**: Untuk grafik ggplot2 (histogram, boxplot, scatter plot, bar plot)
- Setiap download mengandung:
  - Hasil output analisis
  - Interpretasi statistik
  - Metadata (tanggal, judul analisis)

## Struktur File
```
├── app.R              # File utama aplikasi Shiny
├── sovi_data.csv      # Dataset SoVI (513 district)
├── distance.csv       # Dataset matriks jarak (511x511)
└── README.md          # Dokumentasi ini
```

## Teknologi yang Digunakan
- **R Shiny**: Framework aplikasi web
- **shinydashboard**: UI dashboard
- **officer**: Pembuatan dokumen Word
- **flextable**: Tabel dalam dokumen Word
- **rmarkdown**: Rendering dokumen PDF/Word
- **ggplot2**: Visualisasi data
- **DT**: Tabel interaktif
- **leaflet**: Peta interaktif
- **scales**: Normalisasi data koordinat
- **cmdscale()**: Multidimensional Scaling (MDS) untuk konversi matriks jarak

## Algoritma Multidimensional Scaling (MDS)

### Bagaimana MDS Bekerja:
1. **Input**: Matriks jarak 511x511 (simetris)
2. **Proses**: Algoritma `cmdscale()` mencari konfigurasi titik dalam ruang 2D yang mempertahankan jarak relatif sebisa mungkin
3. **Output**: Koordinat (x,y) untuk setiap dari 511 district
4. **Normalisasi**: Koordinat dipetakan ke rentang geografis Indonesia untuk visualisasi yang realistis

### Interpretasi Hasil MDS:
- **Stress**: Ukuran seberapa baik representasi 2D mempertahankan jarak asli
- **Preservasi Jarak**: Jarak Euclidean antar titik dalam peta mendekati jarak asli dalam matriks
- **Clustering**: District dengan karakteristik serupa akan berkelompok secara visual

## Catatan Penting
1. Dataset `distance.csv` berukuran besar (4.2MB) dengan 511 baris dan 511 kolom
2. **[BARU]** Implementasi MDS memungkinkan visualisasi spasial dari data jarak tanpa koordinat geografis asli
3. Aplikasi telah dioptimalkan untuk performa dengan dataset besar
4. Semua fitur download telah diimplementasi dan siap digunakan
5. Sistem keamanan mencegah upload data eksternal
6. **[BARU]** Peta jarak memberikan insight visual tentang similaritas antar district berdasarkan matriks jarak

## Troubleshooting

### Jika Peta Jarak Tidak Muncul:
1. Pastikan file `distance.csv` ada di direktori yang sama dengan `app.R`
2. Periksa apakah semua paket R sudah terinstall
3. Cek console R untuk pesan error
4. Pastikan data SoVI terdapat kolom `DISTRICTCODE` untuk integrasi pewarnaan

### Performa:
- Proses MDS untuk matriks 511x511 mungkin membutuhkan beberapa detik
- Rendering peta dengan 511 titik optimal untuk browser modern
- Untuk performa terbaik, batasi penggunaan label jika diperlukan