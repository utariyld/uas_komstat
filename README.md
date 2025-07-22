# Aplikasi Analisis Statistik Interaktif

## Perubahan yang Telah Dilakukan

### 1. Pembatasan Upload Data
- **Dihapus**: Fitur upload file CSV dari pengguna
- **Alasan**: Keamanan dan konsistensi data
- **Dampak**: Pengguna hanya dapat menggunakan dataset yang telah tersedia di sistem

### 2. Dataset yang Tersedia
- **SoVI Data** (`sovi_data.csv`): Dataset utama untuk analisis
- **Distance Data** (`distance.csv`): Dataset matriks jarak (511x511 data point)

### 3. Fitur Download yang Tersedia
- **Format PDF**: Untuk semua jenis analisis statistik
- **Format Word (DOCX)**: Untuk semua jenis analisis statistik
- **Fitur download meliputi**:
  - Statistik deskriptif
  - Hasil uji normalitas
  - Hasil uji homogenitas
  - Hasil uji t-test (1 sampel dan 2 sampel)
  - Hasil uji proporsi
  - Hasil uji variance
  - Hasil ANOVA (1-way dan 2-way)
  - Hasil analisis regresi

### 4. Paket R yang Diperlukan
```r
install.packages(c(
  "shiny", "shinydashboard", "ggplot2", "dplyr", 
  "psych", "car", "DT", "knitr", "rmarkdown", 
  "tseries", "lmtest", "leaflet", "officer", "flextable"
), repos='https://cran.r-project.org/', dependencies=TRUE)
```

### 5. Cara Menjalankan Aplikasi
```r
# Di R console atau RStudio
shiny::runApp("app.R")
```

### 6. Fitur Keamanan
- Data tidak dapat diupload oleh pengguna
- Hanya dataset terverifikasi yang dapat digunakan
- Sistem menggunakan dataset internal untuk konsistensi

### 7. Format Download
- **PDF**: Menggunakan `rmarkdown` dengan output `pdf_document`
- **Word**: Menggunakan `rmarkdown` dengan output `word_document`
- Setiap download mengandung:
  - Hasil output analisis
  - Interpretasi statistik
  - Metadata (tanggal, judul analisis)

## Struktur File
```
├── app.R              # File utama aplikasi Shiny
├── sovi_data.csv      # Dataset SoVI
├── distance.csv       # Dataset matriks jarak
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

## Catatan Penting
1. Dataset `distance.csv` berukuran besar (>2MB) dengan 511 baris dan 511 kolom
2. Aplikasi telah dioptimalkan untuk performa dengan dataset besar
3. Semua fitur download telah diimplementasi dan siap digunakan
4. Sistem keamanan mencegah upload data eksternal