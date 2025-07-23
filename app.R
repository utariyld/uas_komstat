# install.packages(c("shiny", "shinydashboard", "ggplot2", "dplyr", "psych", "car", "DT", "knitr", "rmarkdown", "tseries", "lmtest", "leaflet", "officer", "flextable", "scales"))

library(shiny)
library(shinydashboard)
library(ggplot2)
library(dplyr)
library(psych) 
library(car)  
library(DT)   
library(knitr)
library(rmarkdown)
library(tseries) 
library(lmtest)
library(leaflet)
library(officer)
library(flextable)
library(scales)
library(tinytex)
library(grid)

custom_css <- "
  @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
  
  /* Warna Dasar dengan Palet Modern */
  :root {
    --primary-green: #10B981; /* Emerald-500 - Hijau modern yang vibrant */
    --secondary-green: #065F46; /* Emerald-900 - Hijau gelap untuk kontras */
    --light-green: #D1FAE5; /* Emerald-100 - Hijau sangat terang */
    --accent-green: #34D399; /* Emerald-400 - Hijau accent */
    
    --primary-pink: #EC4899; /* Pink-500 - Pink modern yang vibrant */
    --secondary-pink: #BE185D; /* Pink-700 - Pink gelap */
    --light-pink: #FCE7F3; /* Pink-100 - Pink sangat terang */
    --accent-pink: #F472B6; /* Pink-400 - Pink accent */
    
    --text-primary: #1F2937; /* Gray-800 */
    --text-secondary: #6B7280; /* Gray-500 */
    --text-light: #9CA3AF; /* Gray-400 */
    --white: #FFFFFF;
    --surface: #F9FAFB; /* Gray-50 */
    --border-light: #E5E7EB; /* Gray-200 */
    
    --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
    --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06);
    --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1), 0 10px 10px -5px rgba(0, 0, 0, 0.04);
  }

  /* Body dan Layout Umum */
  body {
    font-family: 'Inter', system-ui, -apple-system, sans-serif;
    background: var(--surface);
    color: var(--text-primary);
  }

  /* Header Dashboard dengan Gradient Modern */
  .main-header .logo {
    font-family: 'Inter', sans-serif;
    font-weight: 700;
    font-size: 20px;
    color: var(--white);
    background: var(--primary-green) !important;
    border: none;
    box-shadow: var(--shadow-md);
    transition: all 0.3s ease;
  }
  
  .main-header .navbar {
    background: var(--primary-green) !important;
    border: none;
    box-shadow: var(--shadow-lg);
  }
  
  .main-header .navbar .sidebar-toggle {
    color: var(--white);
    border: none;
    transition: all 0.2s ease;
  }
  
  .main-header .navbar .sidebar-toggle:hover {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 8px;
  }

  /* Sidebar Modern dengan Glass Effect */
  .main-sidebar {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    border-right: 1px solid var(--border-light);
    box-shadow: var(--shadow-xl);
  }
  
  .sidebar-menu > li.header {
    background: var(--primary-green);
    color: var(--white);
    font-weight: 600;
    font-size: 14px;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    padding: 15px 20px;
    margin: 0;
    border-radius: 0;
  }
  
  .sidebar-menu li a {
    font-size: 15px;
    font-weight: 500;
    color: var(--text-primary);
    border-left: 4px solid transparent;
    margin: 2px 8px;
    border-radius: 12px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    padding: 12px 16px;
  }
  
  .sidebar-menu li a:hover {
    background: var(--light-green);
    color: var(--primary-green);
    border-left-color: var(--primary-pink);
    transform: translateX(4px);
    box-shadow: var(--shadow-md);
  }
  
  .sidebar-menu li.active > a {
    background: var(--light-green);
    color: var(--primary-green);
    border-left-color: var(--primary-pink);
    font-weight: 600;
    box-shadow: var(--shadow-md);
  }
  
  .sidebar-menu .treeview-menu > li > a {
    margin-left: 20px;
    font-size: 14px;
    opacity: 0.8;
  }

  /* Box Components dengan Design System Modern */
  .box {
    border-radius: 16px;
    border: 1px solid var(--border-light);
    box-shadow: var(--shadow-md);
    transition: all 0.3s ease;
    overflow: hidden;
    background: var(--white);
  }
  
  .box:hover {
    box-shadow: var(--shadow-lg);
    transform: translateY(-2px);
  }
  
  .box.box-solid.box-primary > .box-header {
    background: var(--primary-green) !important;
    color: var(--white);
    border: none !important;
    padding: 20px 24px;
  }
  
  .box.box-solid.box-primary {
    border: 1px solid var(--border-light);
  }
  
  .box-title {
    font-weight: 600;
    font-size: 18px;
    color: var(--white);
    letter-spacing: -0.025em;
  }
  
  .box-body {
    padding: 24px;
    background: var(--white);
  }

  /* Cards dan Content Areas */
  .content-wrapper {
    background: var(--surface);
    min-height: 100vh;
  }
  
  .content {
    padding: 20px;
  }

  /* Input dan Form Elements */
  .form-control {
    border: 2px solid var(--border-light);
    border-radius: 12px;
    padding: 12px 16px;
    font-size: 14px;
    transition: all 0.2s ease;
    background: var(--white);
  }
  
  .form-control:focus {
    border-color: var(--primary-green);
    box-shadow: 0 0 0 3px rgba(16, 185, 129, 0.1);
    outline: none;
  }
  
  .form-group label {
    font-weight: 500;
    color: var(--text-primary);
    margin-bottom: 8px;
    font-size: 14px;
  }

  /* Buttons dengan Gradient dan Hover Effects */
  .btn {
    font-weight: 500;
    border-radius: 12px;
    padding: 12px 24px;
    font-size: 14px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    border: none;
    cursor: pointer;
    text-transform: none;
    letter-spacing: 0.025em;
  }
  
  .btn-primary {
    background: var(--primary-green);
    color: var(--white);
    box-shadow: var(--shadow-md);
  }
  
  .btn-primary:hover, .btn-primary:focus {
    background: primary-green;
    transform: translateY(-2px);
    box-shadow: var(--shadow-lg);
    color: var(--white);
  }
  
  .btn-success {
    background: primary-green;
    color: var(--white);
    box-shadow: var(--shadow-md);
  }
  
  .btn-info {
    background: primary-green;
    color: var(--white);
    box-shadow: var(--shadow-md);
  }
  
  .btn:disabled {
    opacity: 0.6;
    cursor: not-allowed;
    transform: none;
  }

  /* File Input Modern */
  .form-group.shiny-input-container.shiny-input-container-file {
    background: var(--light-green);
    border: 2px dashed var(--primary-green);
    border-radius: 16px;
    padding: 20px;
    text-align: center;
    transition: all 0.3s ease;
  }
  
  .form-group.shiny-input-container.shiny-input-container-file:hover {
    border-color: var(--primary-pink);
    background: var(--light-pink);
  }
  
  .form-group.shiny-input-container.shiny-input-container-file .btn {
    background: var(--primary-green);
    border: none;
    color: var(--white);
    font-weight: 500;
  }

  /* Output Areas */
  .shiny-text-output {
    background: var(--light-green);
    border: 1px solid var(--border-light);
    border-radius: 12px;
    padding: 20px;
    font-family: 'Inter', monospace;
    font-size: 14px;
    line-height: 1.6;
    color: var(--text-primary);
    white-space: pre-wrap;
    word-wrap: break-word;
    max-height: 300px;
    overflow-y: auto;
    box-shadow: var(--shadow-sm);
  }
  
  .shiny-text-output::-webkit-scrollbar {
    width: 6px;
  }
  
  .shiny-text-output::-webkit-scrollbar-track {
    background: var(--border-light);
    border-radius: 3px;
  }
  
  .shiny-text-output::-webkit-scrollbar-thumb {
    background: var(--primary-green);
    border-radius: 3px;
  }

  /* Typography Modern */
  h1, h2, h3, h4, h5, h6 {
    color: var(--text-primary);
    font-weight: 600;
    letter-spacing: -0.025em;
  }
  
  h4 {
    font-size: 16px;
    margin: 24px 0 12px 0;
    color: var(--secondary-green);
  }
  
  p {
    color: var(--text-secondary);
    line-height: 1.6;
    margin-bottom: 16px;
  }
  
  hr {
    border: none;
    height: 1px;
    background: var(--primary-green);
    margin: 24px 0;
    opacity: 0.3;
  }

  /* Table Styling */
  .dataTables_wrapper {
    border-radius: 12px;
    overflow: hidden;
    box-shadow: var(--shadow-md);
  }
  
  table.dataTable {
    border-collapse: separate;
    border-spacing: 0;
  }
  
  table.dataTable thead th {
    background: var(--primary-green);
    color: var(--white);
    font-weight: 600;
    padding: 16px;
    border: none;
  }
  
  table.dataTable tbody td {
    padding: 12px 16px;
    border-bottom: 1px solid var(--border-light);
  }
  
  table.dataTable tbody tr:hover {
    background: var(--light-green);
  }

  /* Tab Panels */
  .nav-tabs {
    border-bottom: 2px solid var(--border-light);
    margin-bottom: 20px;
  }
  
  .nav-tabs > li > a {
    border: none;
    border-radius: 12px 12px 0 0;
    font-weight: 500;
    color: var(--text-secondary);
    margin-right: 4px;
    transition: all 0.2s ease;
  }
  
  .nav-tabs > li.active > a,
  .nav-tabs > li.active > a:hover,
  .nav-tabs > li.active > a:focus {
    background: var(--primary-green);
    color: var(--white);
    border: none;
  }
  
  .nav-tabs > li > a:hover {
    background: var(--light-green);
    color: var(--primary-green);
    border: none;
  }

  /* Animations dan Transitions */
  @keyframes fadeInUp {
    from {
      opacity: 0;
      transform: translateY(20px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }
  
  .box {
    animation: fadeInUp 0.5s ease-out;
  }
  
  /* Responsive Design */
  @media (max-width: 768px) {
    .box-body {
      padding: 16px;
    }
    
    .content {
      padding: 12px;
    }
    
    .btn {
      padding: 10px 20px;
      font-size: 13px;
    }
  }

  /* Loading States */
  .shiny-output-error {
    background: primary-green;
    border: 1px solid #F87171;
    color: #DC2626;
    border-radius: 12px;
    padding: 16px;
    font-weight: 500;
  }
  
  /* Custom Scrollbar untuk seluruh aplikasi */
  ::-webkit-scrollbar {
    width: 8px;
    height: 8px;
  }
  
  ::-webkit-scrollbar-track {
    background: var(--surface);
  }
  
  ::-webkit-scrollbar-thumb {
    background: var(--primary-green);
    border-radius: 4px;
  }
  
  ::-webkit-scrollbar-thumb:hover {
    background: var(--secondary-green);
  }
"

ui <- dashboardPage(
  dashboardHeader(title = "✨ NusaAnalytics",
                  titleWidth = 280,
                  tags$li(class = "dropdown",
                          tags$style(HTML(custom_css))
                  )),
  dashboardSidebar(
    width = 280, 
    sidebarMenu(
      menuItem("Beranda", tabName = "beranda", icon = icon("home")),
      menuItem("Metadata Data", tabName = "metadata", icon = icon("info-circle")), # New: Metadata Tab
      menuItem("Manajemen Data", tabName = "manajemen_data", icon = icon("database")),
      menuItem("Eksplorasi Data", tabName = "eksplorasi", icon = icon("chart-line")),
      menuItem("Uji Asumsi", tabName = "uji_asumsi", icon = icon("flask")),
      menuItem("Statistik Inferensial", icon = icon("calculator"),
               menuSubItem("Uji Beda Rata-rata", tabName = "uji_rata_rata"),
               menuSubItem("Uji Proporsi & Varians", tabName = "uji_prop_var")),
      menuItem("ANOVA", tabName = "anova", icon = icon("balance-scale")),
      menuItem("Regresi Linear", tabName = "regresi", icon = icon("chart-area"))
      
    )
  ),
  dashboardBody(
    tabItems(
      # --- Beranda ---
      tabItem(tabName = "beranda",
              fluidRow(
                box(title = "🎯 Selamat Datang di NusaAnalytics", status = "primary", solidHeader = TRUE, width = 12,
                    div(style = "text-align: center; padding: 20px;",
                        h3("Platform Analisis Data Statistik Sosial & Spasial", style = "color: #065F46; margin-bottom: 20px;"),
                        p("Dashboard interaktif untuk analisis kerentanan sosial di Indonesia menggunakan data statistik resmi dan visualisasi yang informatif.", 
                          style = "font-size: 16px; color: #6B7280; margin-bottom: 30px;")
                    )
                )
              ),
              fluidRow(
                box(title = "📋 Data Tersedia", status = "primary", solidHeader = TRUE, width = 6,
                    div(style = "padding: 15px;",
                        h4("Dataset Bawaan:", style = "color: #EC4899; margin-bottom: 15px;"),
                        div(style = "background: linear-gradient(135deg, #D1FAE5 0%, #FCE7F3 100%); padding: 15px; border-radius: 12px; margin-bottom: 10px;",
                            strong("📊 SoVI Data"), br(),
                            span("Data Social Vulnerability Index dengan 17 variabel sosio-ekonomi dari SUSENAS dan proyeksi penduduk BPS.", style = "color: #6B7280; font-size: 14px;")
                        )
                    )
                ),
                box(title = "📊 Fitur Utama", status = "primary", solidHeader = TRUE, width = 6,
                    div(style = "padding: 15px;",
                        div(style = "background: linear-gradient(135deg, #FCE7F3 0%, #D1FAE5 100%); padding: 15px; border-radius: 12px; margin-bottom: 10px;",
                            strong("📁 Manajemen Data Terintegrasi"), br(),
                            span("Pemrosesan dan kategorisasi variabel serta penanganan data hilang dari dataset bawaan.", style = "color: #6B7280; font-size: 14px;")
                        ),
                        div(style = "background: linear-gradient(135deg, #FCE7F3 0%, #D1FAE5 100%); padding: 15px; border-radius: 12px; margin-bottom: 10px;",
                            strong("📈 Eksplorasi Data Visual"), br(),
                            span("Visualisasi data menggunakan histogram, boxplot, scatter plot, bar plot, dan peta interaktif.", style = "color: #6B7280; font-size: 14px;")
                        ),
                        div(style = "background: linear-gradient(135deg, #FCE7F3 0%, #D1FAE5 100%); padding: 15px; border-radius: 12px; margin-bottom: 10px;",
                            strong("🧪 Uji Asumsi Statistik"), br(),
                            span("Uji normalitas (Jarque-Bera) dan homogenitas varians (Levene) untuk validasi sebelum analisis lanjutan.", style = "color: #6B7280; font-size: 14px;")
                        ),
                        div(style = "background: linear-gradient(135deg, #FCE7F3 0%, #D1FAE5 100%); padding: 15px; border-radius: 12px; margin-bottom: 10px;",
                            strong("📉 Analisis Inferensial"), br(),
                            span("Uji-t, uji proporsi, uji varians, dan ANOVA satu dan dua arah untuk melihat perbedaan kelompok.", style = "color: #6B7280; font-size: 14px;")
                        ),
                        div(style = "background: linear-gradient(135deg, #FCE7F3 0%, #D1FAE5 100%); padding: 15px; border-radius: 12px;",
                            strong("🔗 Regresi Linear Berganda"), br(),
                            span("Analisis hubungan multivariat lengkap dengan pengujian asumsi residual: normalitas, multikolinearitas (VIF), homoskedastisitas, dan autokorelasi (Durbin-Watson).", style = "color: #6B7280; font-size: 14px;")
                        )
                    )
                )
              )
      ),
      
      
      # --- Metadata Data ---
      tabItem(tabName = "metadata",
              fluidRow(
                box(title = "📝 Informasi Metadata Data Aktif", status = "primary", solidHeader = TRUE, width = 12,
                    p("Bagian ini menampilkan ringkasan detail mengenai dataset yang saat ini Anda gunakan di NusaAnalytics. Memahami metadata sangat penting untuk memastikan data Anda siap untuk analisis lebih lanjut."),
                    h4("Detail Kolom:"),
                    p("Tabel interaktif ini memberikan informasi rinci per kolom, termasuk nama kolom, tipe data, dan penjelasan mengenai variabel. Informasi ini krusial dalam pemahaman data."),
                    DTOutput("column_details_table"),
                    
                    h4("Catatan Penting:"),
                    p("Metadata ini adalah langkah awal untuk memahami data Anda. Untuk eksplorasi lebih mendalam seperti distribusi variabel, korelasi, atau visualisasi lanjutan, silakan kunjungi menu 'Eksplorasi Data'.")
                )
              )
      ),
      
      # --- Manajemen Data ---
      tabItem(tabName = "manajemen_data",
              fluidRow(
                box(title = "Manajemen Data", status = "primary", solidHeader = TRUE, width = 12,
                    uiOutput("var_categorize_ui"), # UI untuk memilih variabel yang akan dikategorikan
                    selectInput("cat_method", "Metode Kategorisasi:",
                                choices = c("Lebar Interval Sama" = "equal_width",
                                            "Frekuensi Interval Sama" = "equal_frequency")),
                    actionButton("categorize_data", "Kategorikan Data", class = "btn-primary"),
                    br(), br(),
                    h4("Preview Data setelah Manajemen:"),
                    DTOutput("managed_data_preview"),
                    h4("Interpretasi Manajemen Data:"),
                    verbatimTextOutput("interpretasi_manajemen"),
                    downloadButton("download_managed_data", "Download Data Termodifikasi (CSV)", class = "btn-info")
                )
              )
      ),
      
      # --- Eksplorasi Data ---
      tabItem(tabName = "eksplorasi",
              fluidRow(
                box(title = "Statistik Deskriptif", status = "primary", solidHeader = TRUE, width = 6,
                    uiOutput("var_desc_stat_ui"),
                    actionButton("run_desc_stat", "Tampilkan Statistik", class = "btn-primary"),
                    br(), br(),
                    verbatimTextOutput("deskriptif_output"),
                    h4("Interpretasi Statistik Deskriptif:"),
                    verbatimTextOutput("interpretasi_deskriptif"),
                    downloadButton("download_desc_stat", "Download Statistik (PDF)", class = "btn-info"), # Changed to PDF
                    downloadButton("download_desc_stat_word", "Download Statistik (Word)", class = "btn-info") # Added Word
                ),
                box(title = "Visualisasi Data", status = "primary", solidHeader = TRUE, width = 6,
                                selectInput("plot_type", "Pilih Jenis Grafik:",
                        choices = c("Histogram", "Boxplot", "Scatter Plot", "Bar Plot", "Peta Jarak")), # Added Map and Distance Map
                    uiOutput("plot_vars_ui"),
                    actionButton("generate_plot", "Buat Grafik", class = "btn-primary"),
                    br(), br(),
                    # Conditional output for map or plot
                    conditionalPanel(
                      condition = "input.plot_type == 'Peta'",
                      leafletOutput("data_map")
                    ),
                    conditionalPanel(
                      condition = "input.plot_type == 'Peta Jarak'",
                      leafletOutput("distance_map")
                    ),
                    conditionalPanel(
                      condition = "input.plot_type != 'Peta' && input.plot_type != 'Peta Jarak'",
                      plotOutput("data_plot")
                    ),
                    h4("Interpretasi Visualisasi:"),
                    verbatimTextOutput("interpretasi_visualisasi"),
                    downloadButton("download_plot", "Download Grafik (JPG)", class = "btn-info") # Changed to JPG
                )
              )
      ),
      
      # --- Uji Asumsi ---
      tabItem(tabName = "uji_asumsi",
              fluidRow(
                box(title = "Uji Normalitas", status = "primary", solidHeader = TRUE, width = 6,
                    uiOutput("var_normalitas_ui"),
                    actionButton("run_normalitas", "Lakukan Uji Normalitas", class = "btn-primary"),
                    br(), br(),
                    verbatimTextOutput("normalitas_output"),
                    h4("Interpretasi Uji Normalitas:"),
                    verbatimTextOutput("interpretasi_normalitas"),
                    downloadButton("download_normalitas", "Download Hasil Normalitas (PDF)", class = "btn-info"),
                    downloadButton("download_normalitas_word", "Download Hasil Normalitas (Word)", class = "btn-info")
                ),
                box(title = "Uji Homogenitas", status = "primary", solidHeader = TRUE, width = 6,
                    p("Uji ini menguji asumsi homogenitas varians antar kelompok menggunakan Levene's Test."),
                    uiOutput("var_homogenitas_ui"),
                    actionButton("run_homogenitas", "Lakukan Uji Homogenitas", class = "btn-primary"),
                    br(), br(),
                    h4("Hasil Uji Homogenitas:"),
                    verbatimTextOutput("homogenitas_output"),
                    h4("Interpretasi Uji Homogenitas:"),
                    verbatimTextOutput("interpretasi_homogenitas"),
                    downloadButton("download_homogenitas", "Download Hasil Homogenitas (PDF)", class = "btn-info"),
                    downloadButton("download_homogenitas_word", "Download Hasil Homogenitas (Word)", class = "btn-info")
                )
              )
      ),
      
      # --- Uji Beda Rata-rata ---
      tabItem(tabName = "uji_rata_rata",
              fluidRow(
                box(title = "Uji Beda Rata-rata 1 Kelompok", status = "primary", solidHeader = TRUE, width = 6,
                    uiOutput("var_t_test_1_ui"),
                    numericInput("mu_t_test_1", "Nilai Hipotesis (Mu):", value = 0),
                    actionButton("run_t_test_1", "Lakukan Uji", class = "btn-primary"),
                    br(), br(),
                    verbatimTextOutput("t_test_1_output"),
                    h4("Interpretasi Uji Beda Rata-rata 1 Kelompok:"),
                    verbatimTextOutput("interpretasi_t_test_1"),
                    downloadButton("download_t_test_1", "Download Hasil (PDF)", class = "btn-info"),
                    downloadButton("download_t_test_1_word", "Download Hasil (Word)", class = "btn-info")
                ),
                box(title = "Uji Beda Rata-rata 2 Kelompok", status = "primary", solidHeader = TRUE, width = 6,
                    selectInput("t_test_2_type", "Tipe Uji:", choices = c("Independen", "Berpasangan")),
                    uiOutput("var_t_test_2_ui"),
                    checkboxInput("var_equal", "Asumsi Varians Sama (untuk Independen)", TRUE),
                    actionButton("run_t_test_2", "Lakukan Uji", class = "btn-primary"),
                    br(), br(),
                    verbatimTextOutput("t_test_2_output"),
                    h4("Interpretasi Uji Beda Rata-rata 2 Kelompok:"),
                    verbatimTextOutput("interpretasi_t_test_2"),
                    downloadButton("download_t_test_2", "Download Hasil (PDF)", class = "btn-info"),
                    downloadButton("download_t_test_2_word", "Download Hasil (Word)", class = "btn-info")
                )
              )
      ),
      
      # --- Uji Proporsi & Varians ---
      tabItem(tabName = "uji_prop_var",
              fluidRow(
                box(title = "Uji Proporsi 1 Kelompok", status = "primary", solidHeader = TRUE, width = 6,
                    uiOutput("var_prop_test_1_ui"),
                    numericInput("p_prop_test_1", "Proporsi Hipotesis (p):", value = 0.5, min = 0, max = 1),
                    actionButton("run_prop_test_1", "Lakukan Uji", class = "btn-primary"),
                    br(), br(),
                    verbatimTextOutput("prop_test_1_output"),
                    h4("Interpretasi Uji Proporsi 1 Kelompok:"),
                    verbatimTextOutput("interpretasi_prop_test_1"),
                    downloadButton("download_prop_test_1", "Download Hasil (PDF)", class = "btn-info"),
                    downloadButton("download_prop_test_1_word", "Download Hasil (Word)", class = "btn-info")
                ),
                box(title = "Uji Proporsi 2 Kelompok", status = "primary", solidHeader = TRUE, width = 6,
                    uiOutput("var_prop_test_2_ui"),
                    actionButton("run_prop_test_2", "Lakukan Uji", class = "btn-primary"),
                    br(), br(),
                    verbatimTextOutput("prop_test_2_output"),
                    h4("Interpretasi Uji Proporsi 2 Kelompok:"),
                    verbatimTextOutput("interpretasi_prop_test_2"),
                    downloadButton("download_prop_test_2", "Download Hasil (PDF)", class = "btn-info"),
                    downloadButton("download_prop_test_2_word", "Download Hasil (Word)", class = "btn-info")
                )
              ),
              fluidRow(
                box(title = "Uji Varians 1 Kelompok (Chi-squared)", status = "primary", solidHeader = TRUE, width = 6,
                    uiOutput("var_var_test_1_ui"),
                    numericInput("sigma_var_test_1", "Varians Hipotesis (Sigma^2):", value = 1),
                    actionButton("run_var_test_1", "Lakukan Uji", class = "btn-primary"),
                    br(), br(),
                    verbatimTextOutput("var_test_1_output"),
                    h4("Interpretasi Uji Varians 1 Kelompok:"),
                    verbatimTextOutput("interpretasi_var_test_1"),
                    downloadButton("download_var_test_1", "Download Hasil (PDF)", class = "btn-info"),
                    downloadButton("download_var_test_1_word", "Download Hasil (Word)", class = "btn-info")
                ),
                box(title = "Uji Varians 2 Kelompok (F-test)", status = "primary", solidHeader = TRUE, width = 6,
                    uiOutput("var_var_test_2_ui"),
                    actionButton("run_var_test_2", "Lakukan Uji", class = "btn-primary"),
                    br(), br(),
                    verbatimTextOutput("var_test_2_output"),
                    h4("Interpretasi Uji Varians 2 Kelompok:"),
                    verbatimTextOutput("interpretasi_var_test_2"),
                    downloadButton("download_var_test_2", "Download Hasil (PDF)", class = "btn-info"),
                    downloadButton("download_var_test_2_word", "Download Hasil (Word)", class = "btn-info")
                )
              )
      ),
      
      # --- ANOVA ---
      tabItem(tabName = "anova",
              fluidRow(
                box(title = "ANOVA Satu Arah", status = "primary", solidHeader = TRUE, width = 6,
                    uiOutput("anova_1_way_ui"),
                    actionButton("run_anova_1_way", "Lakukan ANOVA Satu Arah", class = "btn-primary"),
                    br(), br(),
                    verbatimTextOutput("anova_1_way_output"),
                    h4("Interpretasi ANOVA Satu Arah:"),
                    verbatimTextOutput("interpretasi_anova_1_way"),
                    downloadButton("download_anova_1_way", "Download Hasil (PDF)", class = "btn-info"),
                    downloadButton("download_anova_1_way_word", "Download Hasil (Word)", class = "btn-info")
                ),
                box(title = "ANOVA Dua Arah", status = "primary", solidHeader = TRUE, width = 6,
                    uiOutput("anova_2_way_ui"),
                    actionButton("run_anova_2_way", "Lakukan ANOVA Dua Arah", class = "btn-primary"),
                    br(), br(),
                    verbatimTextOutput("anova_2_way_output"),
                    h4("Interpretasi ANOVA Dua Arah:"),
                    verbatimTextOutput("interpretasi_anova_2_way"),
                    downloadButton("download_anova_2_way", "Download Hasil (PDF)", class = "btn-info"),
                    downloadButton("download_anova_2_way_word", "Download Hasil (Word)", class = "btn-info")
                )
              )
      ),
      
      # --- Regresi Linear Berganda ---
      tabItem(tabName = "regresi",
              fluidRow(
                box(title = "Regresi Linear Berganda", status = "primary", solidHeader = TRUE, width = 12,
                    uiOutput("reg_vars_ui"),
                    actionButton("run_regresi", "Jalankan Regresi", class = "btn-primary"),
                    br(), br(),
                    verbatimTextOutput("regresi_output"),
                    h4("Uji Asumsi Regresi:"),
                    tabsetPanel(
                      tabPanel("Normalitas Residual",
                               plotOutput("reg_norm_plot"),
                               verbatimTextOutput("reg_norm_test_output"),
                               h4("Interpretasi Normalitas Residual:"),
                               verbatimTextOutput("interpretasi_reg_norm")),
                      tabPanel("Homoskedastisitas",
                               plotOutput("reg_homo_plot"),
                               verbatimTextOutput("reg_homo_test_output"),
                               h4("Interpretasi Homoskedastisitas:"),
                               verbatimTextOutput("interpretasi_reg_homo")),
                      tabPanel("Multikolinearitas (VIF)",
                               verbatimTextOutput("reg_vif_output"),
                               h4("Interpretasi Multikolinearitas:"),
                               verbatimTextOutput("interpretasi_reg_vif")),
                      tabPanel("Autokorelasi (Durbin-Watson)",
                               verbatimTextOutput("reg_dw_output"),
                               h4("Interpretasi Autokorelasi:"),
                               verbatimTextOutput("interpretasi_reg_dw"))
                    ),
                    h4("Interpretasi Model Regresi:"),
                    verbatimTextOutput("interpretasi_regresi"),
                    downloadButton("download_regresi", "Download Hasil Regresi (PDF)", class = "btn-info"), # Changed to PDF
                    downloadButton("download_regresi_word", "Download Hasil Regresi (Word)", class = "btn-info") # Added Word
                )
              )
              
      )
    )
  )
)

  server <- function(input, output, session) {
    
    # --- Data Reaktif ---
    data_r <- reactiveVal(NULL) # Untuk menyimpan data yang aktif (awal atau upload)
    
    # Load distance data globally
    distance_data <- reactive({
      tryCatch({
        dist_df <- read.csv("distance.csv", row.names = 1)
        return(dist_df)
      }, error = function(e) {
        showNotification(paste("Error loading distance data:", e$message), type = "error")
        return(NULL)
      })
    })
    
    # Function to convert distance matrix to coordinates using MDS
    distance_to_coordinates <- function(dist_matrix, dimensions = 2) {
      # Ensure the matrix is symmetric and has no negative values
      dist_matrix[is.na(dist_matrix)] <- 0
      
      # Convert to distance object
      if (!inherits(dist_matrix, "dist")) {
        dist_matrix <- as.dist(dist_matrix)
      }
      
      # Apply classical multidimensional scaling
      mds_result <- cmdscale(dist_matrix, k = dimensions, eig = TRUE)
      
      # Extract coordinates
      coordinates <- as.data.frame(mds_result$points)
      colnames(coordinates) <- c("longitude", "latitude")
      
      # Add district codes as row names
      coordinates$district_id <- as.numeric(rownames(coordinates))
      
      # Scale coordinates to a reasonable geographic range
      # Normalize to approximately fit Indonesian archipelago bounds
      coordinates$longitude <- scales::rescale(coordinates$longitude, to = c(95, 141))
      coordinates$latitude <- scales::rescale(coordinates$latitude, to = c(-11, 6))
      
      return(coordinates)
    }
    
    # --- Fungsi untuk membuat bobot spasial ---
    create_spatial_weights <- function(distance_matrix, method = "gaussian", bandwidth = NULL) {
      if (!inherits(distance_matrix, "matrix")) {
        distance_matrix <- as.matrix(distance_matrix)
      }
      
      n <- nrow(distance_matrix)
      W <- matrix(0, nrow = n, ncol = n)
      
      if (method == "gaussian") {
        if (is.null(bandwidth)) {
          # Estimate bandwidth if not provided (e.g., median of non-zero distances)
          non_zero_distances <- distance_matrix[distance_matrix > 0]
          if (length(non_zero_distances) > 0) {
            bandwidth <- median(non_zero_distances) / 2 # Heuristic
          } else {
            stop("Bandwidth must be provided or derivable for Gaussian method.")
          }
        }
        for (i in 1:n) {
          for (j in 1:n) {
            if (i != j) {
              W[i, j] <- exp(-0.5 * (distance_matrix[i, j]^2) / (bandwidth^2))
            }
          }
        }
      } else if (method == "fixed_distance") {
        if (is.null(bandwidth)) {
          stop("Bandwidth (fixed distance threshold) must be provided for fixed_distance method.")
        }
        for (i in 1:n) {
          for (j in 1:n) {
            if (i != j && distance_matrix[i, j] <= bandwidth) {
              W[i, j] <- 1
            }
          }
        }
      } else {
        stop("Metode bobot spasial tidak dikenal. Pilih 'gaussian' atau 'fixed_distance'.")
      }
      
      # Normalisasi baris (row-standardization)
      row_sums <- rowSums(W)
      W <- W / ifelse(row_sums == 0, 1, row_sums) # Hindari pembagian dengan nol
      
      return(W)
    }
    
    # Implementasi FGWC
    fgwc_clustering <- function(data, distance_matrix, k = 3, m = 2, max_iter = 100, tolerance = 1e-4, 
                                spatial_method = "gaussian", bandwidth = NULL, lambda = 0.5) {
      n <- nrow(data)
      p <- ncol(data)
      
      # Initialize membership matrix U
      set.seed(123)
      U <- matrix(runif(n * k), nrow = n, ncol = k)
      U <- U / rowSums(U)  # Normalize
      
      # Initialize cluster centers V
      V <- matrix(0, nrow = k, ncol = p)
      
      # Create spatial weights
      W <- create_spatial_weights(distance_matrix, method = spatial_method, bandwidth = bandwidth)
      
      # If no spatial weights, use identity
      if(is.null(W) || all(W == 0)) { # Perbaikan: cek juga jika semua bobot 0
        W <- diag(n)
        lambda <- 0  # No spatial penalty
        cat("No effective spatial weights available, using standard fuzzy c-means\n")
      }
      
      # FGWC iterations
      for(iter in 1:max_iter) {
        U_old <- U
        
        # Update cluster centers V
        for(i in 1:k) {
          numerator <- colSums((U[, i]^m) * data)
          denominator <- sum(U[, i]^m)
          if(denominator > 0) {
            V[i, ] <- numerator / denominator
          } else {
            V[i, ] <- colMeans(data)  # Fallback
          }
        }
        
        # Update membership matrix U with spatial constraint
        for(i in 1:n) {
          distances <- numeric(k)
          
          for(j in 1:k) {
            # Feature space distance
            feature_dist <- sqrt(sum((data[i, ] - V[j, ])^2))
            
            # Spatial constraint: weighted average of neighbors' membership to cluster j
            if(lambda > 0 && !is.null(W) && !all(W[i, ] == 0)) { # Pastikan ada bobot spasial untuk baris ini
              spatial_constraint <- sum(W[i, ] * U[, j])
              # Combine feature distance with spatial constraint
              distances[j] <- feature_dist * (1 + lambda * (1 - spatial_constraint))
            } else {
              distances[j] <- feature_dist
            }
          }
          
          # Update membership values
          for(j in 1:k) {
            if(distances[j] == 0) {
              U[i, ] <- 0
              U[i, j] <- 1
              break
            } else {
              sum_term <- sum((distances[j] / distances)^(2/(m-1)))
              if(is.finite(sum_term) && sum_term > 0) {
                U[i, j] <- 1 / sum_term
              } else {
                U[i, j] <- 1 / k  # Fallback
              }
            }
          }
          
          # Normalize membership (ensure sum = 1)
          row_sum <- sum(U[i, ])
          if(row_sum > 0) {
            U[i, ] <- U[i, ] / row_sum
          } else {
            U[i, ] <- rep(1/k, k)  # Equal membership if all zero
          }
        }
        
        # Check convergence
        if(sum((U - U_old)^2) < tolerance) {
          cat("FGWC converged after", iter, "iterations\n")
          break
        }
      }
      
      # Get hard cluster assignments
      clusters <- apply(U, 1, which.max)
      
      # Calculate objective function value (optional)
      obj_value <- 0
      for(i in 1:n) {
        for(j in 1:k) {
          feature_dist <- sum((data[i, ] - V[j, ])^2)
          if(lambda > 0 && !is.null(W) && !all(W[i, ] == 0)) { # Pastikan ada bobot spasial untuk baris ini
            spatial_penalty <- lambda * sum(W[i, ] * (U[, j] - U[i, j])^2)
            obj_value <- obj_value + (U[i, j]^m) * (feature_dist + spatial_penalty)
          } else {
            obj_value <- obj_value + (U[i, j]^m) * feature_dist
          }
        }
      }
      
      return(list(
        clusters = clusters,
        centers = V,
        membership = U,
        iterations = iter,
        objective = obj_value,
        spatial_lambda = lambda,
        spatial_method = spatial_method,
        bandwidth = bandwidth
      ))
    }
    
    
    # Memuat data default saat aplikasi dimulai
    observeEvent(TRUE, {
      tryCatch({
        # Load default data (SoVI by default)
        sovi_data <- read.csv("sovi_data.csv")
        data_r(sovi_data)
        showNotification("Data 'sovi_data.csv' dimuat sebagai default.", type = "message")
      }, error = function(e) {
        showNotification(paste("Error loading default data (sovi_data.csv):", e$message), type = "error")
        data_r(NULL) # Reset data jika ada error
      })
    }, once = TRUE) # Hanya dijalankan sekali saat inisialisasi
    
    # Observer untuk memuat dataset default yang dipilih
    observeEvent(input$load_default_data, {
      req(input$default_dataset)
      tryCatch({
        if (input$default_dataset == "sovi") {
          df <- read.csv("sovi_data.csv")
          data_r(df)
          showNotification("Dataset SoVI Data berhasil dimuat!", type = "success")
        } else if (input$default_dataset == "distance") {
          df <- read.csv("distance.csv")
          data_r(df)
          showNotification("Dataset Distance Data berhasil dimuat!", type = "success")
        }
      }, error = function(e) {
        showNotification(paste("Error loading dataset:", e$message), type = "error")
        data_r(NULL) # Reset data jika ada error
      })
    })
    
    # Observer untuk mengunggah data baru
    observeEvent(input$upload_file, {
      req(input$upload_file)
      tryCatch({
        df <- read.csv(input$upload_file$datapath, header = input$header)
        data_r(df)
        showNotification("Data berhasil diunggah!", type = "success")
      }, error = function(e) {
        showNotification(paste("Error membaca file:", e$message), type = "error")
        data_r(NULL) # Reset data jika ada error
      })
    })
    
    # --- UI Dinamis untuk Pemilihan Variabel ---
    # Ini akan diperbarui setiap kali data_r() berubah (data diunggah atau dimanipulasi)
    observe({
      req(current_data()) # Pastikan ada data sebelum membuat UI dinamis
      df <- current_data() # Menggunakan current_data() untuk mendapatkan data terbaru
      cols <- names(df)
      numeric_cols <- cols[sapply(df, is.numeric)]
      
      # Dapatkan variabel yang bisa dijadikan faktor (termasuk variabel kategorik hasil kategorisasi)
      factor_like_cols <- names(df)[sapply(df, function(x) {
        is.factor(x) || is.character(x) || 
          (is.numeric(x) && length(unique(x[!is.na(x)])) <= 10) # Numerik dengan sedikit unique values
      })]
      # Tambahkan variabel kategorik yang dibuat dari kategorisasi (yang berakhiran "_cat")
      cat_vars_from_management <- names(df)[grepl("_cat$", names(df))]
      factor_like_cols <- unique(c(factor_like_cols, cat_vars_from_management))

    # Manajemen Data
    output$var_categorize_ui <- renderUI({
      tagList( 
        selectInput("cat_var_name", "Pilih Variabel Kontinu untuk Dikategorikan:", choices = numeric_cols),
        numericInput("cat_num_bins", "Jumlah Kategori (Bins):", value = 3, min = 2)
      )
    })
    
    # Eksplorasi Data
    output$var_desc_stat_ui <- renderUI({
      selectInput("desc_stat_var", "Pilih Variabel untuk Statistik Deskriptif:", choices = cols)
    })
    
    output$plot_vars_ui <- renderUI({
      plot_type <- input$plot_type
      if (plot_type == "Histogram" || plot_type == "Boxplot") {
        selectInput("plot_var_x", "Pilih Variabel (Numerik):", choices = numeric_cols)
      } else if (plot_type == "Scatter Plot") {
        tagList(
          selectInput("plot_var_x", "Variabel X (Numerik):", choices = numeric_cols),
          selectInput("plot_var_y", "Variabel Y (Numerik):", choices = numeric_cols)
        )
      } else if (plot_type == "Bar Plot") {
        selectInput("plot_var_x", "Pilih Variabel (Kategorik/Diskret):", choices = cols)
      } else if (plot_type == "Peta") {
        tagList(
          p("Untuk visualisasi peta, pastikan data Anda memiliki kolom 'latitude' dan 'longitude'."),
          selectInput("map_var_lat", "Kolom Latitude:", choices = numeric_cols),
          selectInput("map_var_lon", "Kolom Longitude:", choices = numeric_cols),
          selectInput("map_var_color", "Variabel Warna (Opsional):", choices = c("None", cols), selected = "None")
        )
      } else if (plot_type == "Peta Jarak") {
        tagList(
          p("Visualisasi matriks jarak menggunakan Multidimensional Scaling (MDS) untuk mengkonversi data jarak menjadi koordinat geografis."),
          p("Data jarak akan dikonversi menjadi koordinat 2D dan ditampilkan sebagai peta interaktif."),
          selectInput("distance_color_var", "Variabel Warna untuk Titik (Opsional):", 
                     choices = c("None", if(!is.null(current_data()) && nrow(current_data()) > 0) names(current_data()) else c()), 
                     selected = "None"),
          numericInput("distance_point_size", "Ukuran Titik:", value = 10, min = 1, max = 50),
          checkboxInput("show_labels", "Tampilkan Label District:", value = TRUE)
        )
      }
    })
    
    # Uji Asumsi
    output$var_normalitas_ui <- renderUI({
      selectInput("norm_var", "Pilih Variabel untuk Uji Normalitas:", choices = numeric_cols)
    })
    output$var_homogenitas_ui <- renderUI({
      tagList(
        selectInput("homo_var_response", "Variabel Respon (Numerik):", 
                    choices = numeric_cols,
                    selected = if(length(numeric_cols) > 0) numeric_cols[1] else NULL),
        selectInput("homo_var_group", "Variabel Grup (Kategorik):", 
                    choices = factor_like_cols,
                    selected = if(length(factor_like_cols) > 0) factor_like_cols[1] else NULL)
      )
    })
    
    # Uji Beda Rata-rata
    output$var_t_test_1_ui <- renderUI({
      selectInput("t_test_1_var", "Pilih Variabel Numerik:", choices = numeric_cols)
    })
    output$var_t_test_2_ui <- renderUI({
      if (input$t_test_2_type == "Independen") {
        tagList(
          selectInput("t_test_2_var_response", "Variabel Respon (Numerik):", 
                      choices = numeric_cols,
                      selected = if(length(numeric_cols) > 0) numeric_cols[1] else NULL),
          selectInput("t_test_2_var_group", "Variabel Grup (Kategorik):", 
                      choices = factor_like_cols,
                      selected = if(length(factor_like_cols) > 0) factor_like_cols[1] else NULL)
        )
      } else { 
        tagList(
          selectInput("t_test_2_var1", "Variabel 1 (Numerik):", choices = numeric_cols),
          selectInput("t_test_2_var2", "Variabel 2 (Numerik):", choices = numeric_cols)
        )
      }
    })
    
    # Uji Proporsi & Varians
    output$var_prop_test_1_ui <- renderUI({
      selectInput("prop_test_1_var", "Pilih Variabel (Biner/Kategorik):", choices = factor_like_cols)
    })
    output$var_prop_test_2_ui <- renderUI({
      tagList(
        selectInput("prop_test_2_var_cat", "Variabel Kategori (Biner/Kategorik):", 
                    choices = factor_like_cols,
                    selected = if(length(factor_like_cols) > 0) factor_like_cols[1] else NULL),
        selectInput("prop_test_2_var_group", "Variabel Grup (Kategorik):", 
                    choices = factor_like_cols, 
                    selected = if(length(factor_like_cols) > 0) factor_like_cols[1] else NULL)
      )
    })
    output$var_var_test_1_ui <- renderUI({
      selectInput("var_test_1_var", "Pilih Variabel Numerik:", choices = numeric_cols)
    })
    output$var_var_test_2_ui <- renderUI({
      tagList(
        selectInput("var_test_2_var_response", "Variabel Respon (Numerik):", 
                    choices = numeric_cols,
                    selected = if(length(numeric_cols) > 0) numeric_cols[1] else NULL),
        selectInput("var_test_2_var_group", "Variabel Grup (Kategorik):", 
                    choices = factor_like_cols, 
                    selected = if(length(factor_like_cols) > 0) factor_like_cols[1] else NULL)
      )
    })
    
    # ANOVA
    output$anova_1_way_ui <- renderUI({
      tagList(
        selectInput("anova_1_resp", "Variabel Respon (Numerik):", 
                    choices = numeric_cols,
                    selected = if(length(numeric_cols) > 0) numeric_cols[1] else NULL),
        selectInput("anova_1_group", "Variabel Grup (Kategorik):", 
                    choices = factor_like_cols,
                    selected = if(length(factor_like_cols) > 0) factor_like_cols[1] else NULL)
      )
    })
    output$anova_2_way_ui <- renderUI({
      tagList(
        selectInput("anova_2_resp", "Variabel Respon (Numerik):", 
                    choices = numeric_cols,
                    selected = if(length(numeric_cols) > 0) numeric_cols[1] else NULL),
        selectInput("anova_2_factor1", "Variabel Faktor 1 (Kategorik):", 
                    choices = factor_like_cols,
                    selected = if(length(factor_like_cols) > 0) factor_like_cols[1] else NULL),
        selectInput("anova_2_factor2", "Variabel Faktor 2 (Kategorik):",
                    choices = factor_like_cols,
                    selected = if(length(factor_like_cols) > 0) factor_like_cols[1] else NULL)
      )
    })
    
    # Regresi
    output$reg_vars_ui <- renderUI({
      tagList(
        selectInput("reg_dependent", "Variabel Dependen:", choices = numeric_cols),
        selectizeInput("reg_independent", "Variabel Independen:", choices = numeric_cols, multiple = TRUE)
      )
    })
  })
  
  # --- Metadata Data Server ---
  current_dataset_name_r <- reactiveVal("Belum ada dataset dimuat")
  
  # Modifikasi bagian memuat data default
  observeEvent(TRUE, {
    tryCatch({
      # Load default data (SoVI by default)
      sovi_data <- read.csv("sovi_data.csv")
      data_r(sovi_data)
      current_dataset_name_r("SoVI Data (Default)") # Update nama dataset
      showNotification("Data 'sovi_data.csv' dimuat sebagai default.", type = "message")
    }, error = function(e) {
      showNotification(paste("Error loading default data (sovi_data.csv):", e$message), type = "error")
      data_r(NULL) # Reset data jika ada error
      current_dataset_name_r("Error memuat dataset default") # Update nama dataset
    })
  }, once = TRUE)
  
  # Modifikasi observer untuk memuat dataset default yang dipilih
  observeEvent(input$load_default_data, {
    req(input$default_dataset)
    tryCatch({
      if (input$default_dataset == "sovi") {
        df <- read.csv("sovi_data.csv")
        data_r(df)
        current_dataset_name_r("SoVI Data") # Update nama dataset
        showNotification("Dataset SoVI Data berhasil dimuat!", type = "success")
      } else if (input$default_dataset == "distance") {
        df <- read.csv("distance.csv")
        data_r(df)
        current_dataset_name_r("Distance Data") # Update nama dataset
        showNotification("Dataset Distance Data berhasil dimuat!", type = "success")
      }
    }, error = function(e) {
      showNotification(paste("Error loading dataset:", e$message), type = "error")
      data_r(NULL) # Reset data jika ada error
      current_dataset_name_r(paste("Error memuat", input$default_dataset)) # Update nama dataset
    })
  })
  
  # Modifikasi observer untuk mengunggah data baru
  observeEvent(input$upload_file, {
    req(input$upload_file)
    tryCatch({
      df <- read.csv(input$upload_file$datapath, header = input$header)
      data_r(df)
      current_dataset_name_r(input$upload_file$name) 
      showNotification("Data berhasil diunggah!", type = "success")
    }, error = function(e) {
      showNotification(paste("Error membaca file:", e$message), type = "error")
      data_r(NULL) 
      current_dataset_name_r("Error mengunggah file") 
    })
  })
  
  output$active_dataset_name <- renderText({
    current_dataset_name_r()
  })
  
  output$metadata_str <- renderPrint({
    req(data_r()) 
    str(data_r())
  })
  
  output$metadata_summary <- renderPrint({
    req(data_r())
    summary(data_r())
  })
  
  output$column_details_table <- renderDT({
    req(data_r())
    df <- data_r()
    
    deskripsi <- c(
      "Kode wilayah/kabupaten",
      "Persentase penduduk usia di bawah 5 tahun",
      "Persentase penduduk perempuan",
      "Persentase penduduk usia 65 tahun ke atas",
      "Persentase rumah tangga dengan kepala keluarga perempuan",
      "Rata-rata jumlah anggota rumah tangga",
      "Persentase rumah tangga tanpa listrik",
      "Persentase penduduk usia 15 tahun ke atas dengan pendidikan rendah",
      "Persentase pertumbuhan jumlah penduduk",
      "Persentase penduduk miskin",
      "Persentase penduduk yang tidak bisa membaca dan menulis",
      "Persentase rumah tangga yang tidak pernah mengikuti pelatihan bencana",
      "Persentase rumah tangga di daerah rawan bencana",
      "Persentase rumah tangga yang menyewa rumah",
      "Persentase rumah tangga tanpa saluran pembuangan",
      "Persentase rumah tangga dengan akses air ledeng",
      "Jumlah total penduduk"
    )
    
    if (length(deskripsi) != ncol(df)) {
      deskripsi <- rep(NA, ncol(df))  # atau tampilkan pesan kesalahan jika perlu
    }
    
    col_details <- data.frame(
      "Nama Kolom" = names(df),
      "Tipe Data" = sapply(df, class),
      "Deskripsi" = deskripsi,
      stringsAsFactors = FALSE
    )
    
    datatable(col_details, options = list(pageLength = 10, scrollX = TRUE))
  })
  
  
  # --- Manajemen Data Server ---
  managed_data <- reactiveVal(NULL) # Data yang sudah dimanipulasi
  
  observeEvent(input$categorize_data, {
    req(data_r(), input$cat_var_name, input$cat_num_bins, input$cat_method)
    
    df <- current_data() 
    var_name <- input$cat_var_name
    num_bins <- input$cat_num_bins
    cat_method <- input$cat_method
    
    # Memeriksa apakah variabel yang dipilih adalah numerik
    if (!is.numeric(df[[var_name]])) {
      showNotification("Variabel yang dipilih harus numerik untuk dikategorikan.", type = "warning")
      return()
    }
    # Memeriksa jumlah kategori minimal
    if (num_bins < 2) {
      showNotification("Jumlah kategori minimal 2.", type = "warning")
      return()
    }
    
    # Melakukan kategorisasi berdasarkan metode yang dipilih
    if (cat_method == "equal_width") {
      # Metode Lebar Interval Sama
      df[[paste0(var_name, "_cat")]] <- cut(df[[var_name]], breaks = num_bins, include.lowest = TRUE, ordered_result = TRUE)
      interpretasi_text <- paste0("Variabel '", var_name, "' telah berhasil dikategorikan menjadi ", num_bins, " kelompok baru dengan nama '", var_name, "_cat' menggunakan metode 'Lebar Interval Sama'.\n\nInterpretasi: Metode ini membagi rentang nilai variabel menjadi interval dengan lebar yang sama. Ini berguna ketika Anda ingin memastikan bahwa setiap kategori mencakup rentang nilai yang seragam.")
    } else if (cat_method == "equal_frequency") {
      # Metode Frekuensi Interval Sama (menggunakan kuantil)
      breaks_quantile <- unique(quantile(df[[var_name]], probs = seq(0, 1, by = 1/num_bins), na.rm = TRUE))
      # Memastikan setidaknya ada dua batas unik untuk fungsi cut
      if (length(breaks_quantile) < 2) {
        showNotification("Tidak cukup variasi data untuk membuat kategori frekuensi yang sama dengan jumlah bin yang diminta.", type = "warning")
        return()
      }
      df[[paste0(var_name, "_cat")]] <- cut(df[[var_name]], breaks = breaks_quantile, include.lowest = TRUE, ordered_result = TRUE)
      interpretasi_text <- paste0("Variabel '", var_name, "' telah berhasil dikategorikan menjadi ", num_bins, " kelompok baru dengan nama '", var_name, "_cat' menggunakan metode 'Frekuensi Interval Sama'.\n\nInterpretasi: Metode ini berusaha agar setiap kategori memiliki jumlah observasi (data point) yang relatif sama. Ini berguna ketika Anda ingin distribusi data yang lebih merata di antara kategori.")
    }
    
    # Menyimpan data yang dimanipulasi di reactiveVal terpisah
    managed_data(df)
    # Menampilkan interpretasi hasil kategorisasi
    output$interpretasi_manajemen <- renderText({ interpretasi_text })
  })
  
  current_data <- reactive({
    if(is.null(managed_data())){
      return (data_r()) 
    } else {
      return(managed_data()) 
    }
  })
  
  output$managed_data_preview <- renderDT({
    req(current_data())
    current_data() 
  })
  
  output$download_managed_data <- downloadHandler(
    filename = function() {
      paste("data_termodifikasi_", Sys.Date(), ".csv", sep="")
    },
    content = function(file) {
      req(current_data())
      write.csv(current_data(), file, row.names = FALSE)
    }
  )
  
  # --- Eksplorasi Data Server ---
  output$deskriptif_output <- renderPrint({
    req(current_data(), input$desc_stat_var) 
    df <- current_data()
    var_name <- input$desc_stat_var
    if (!var_name %in% names(df)) return(cat("Variabel tidak ditemukan."))
    
    if (is.numeric(df[[var_name]])) {
      summary_output <- capture.output(summary(df[[var_name]]))
      paste(summary_output, collapse = "\n")
    } else {
      table_output <- capture.output(table(df[[var_name]]))
      paste(table_output, collapse = "\n")
    }
  })
  
  interpretasi_deskriptif_content <- reactive({
    req(current_data(), input$desc_stat_var)
    df <- current_data()
    var_name <- input$desc_stat_var
    if (!var_name %in% names(df)) return("Pilih variabel untuk interpretasi.")
    
    if (is.numeric(df[[var_name]])) {
      s_val <- summary(df[[var_name]])
      paste0("Statistik deskriptif untuk variabel '", var_name, "' menunjukkan:\n",
             "- Nilai minimum: ", round(s_val[1], 2), "\n",
             "- Kuartil pertama (Q1): ", round(s_val[2], 2), "\n",
             "- Median: ", round(s_val[3], 2), "\n",
             "- Rata-rata: ", round(s_val[4], 2), "\n",
             "- Kuartil ketiga (Q3): ", round(s_val[5], 2), "\n",
             "- Nilai maksimum: ", round(s_val[6], 2), "\n\n",
             "Interpretasi: Nilai-nilai ini memberikan gambaran tentang sebaran, tendensi sentral, dan rentang data. Median lebih baik untuk data miring, sedangkan rata-rata untuk data simetris. Jarak antara Q1 dan Q3 (IQR) menunjukkan sebaran data di tengah.")
    } else {
      t_val <- table(df[[var_name]])
      paste0("Distribusi frekuensi untuk variabel '", var_name, "':\n",
             paste(names(t_val), t_val, sep = ": ", collapse = "\n"), "\n\n",
             "Interpretasi: Ini berguna untuk memahami distribusi data kategorik.")
    }
  })
  
  output$interpretasi_deskriptif <- renderText({
    interpretasi_deskriptif_content()
  })
  
  
  render_report <- function(temp_file, output_format, content_func, interpretation_func = NULL, title = "Laporan Analisis") {
    tempReport <- file.path(tempdir(), "report.Rmd")
    
    report_content <- c(
      "---",
      paste0("title: \"", title, "\""),
      paste0("date: \"", Sys.Date(), "\""),
      paste0("output: ", output_format),
      "---",
      "",
      "### Hasil Output:",
      "",
      "```",
      content_func(), # Call content function to get output
      "```",
      ""
    )
    
    if (!is.null(interpretation_func)) {
      interpretation_output <- interpretation_func()
      
      report_content <- c(report_content,
                          "### Interpretasi:",
                          "",
                          interpretation_output, # Use the evaluated interpretation
                          "")
    }
    
    writeLines(report_content, tempReport)
    
    # Render the Rmd
    rmarkdown::render(tempReport, output_format = output_format, output_file = file, clean = TRUE, quiet = TRUE)
  }
  
  output$download_desc_stat <- downloadHandler(
    filename = function() {
      paste0("statistik_deskriptif_", Sys.Date(), ".pdf")
    },
    content = function(file) {
      req(current_data(), input$desc_stat_var, interpretasi_deskriptif_content())
      
      df <- current_data()
      var_name <- input$desc_stat_var
      
      hasil <- if (is.numeric(df[[var_name]])) {
        capture.output(summary(df[[var_name]]))
      } else {
        capture.output(table(df[[var_name]]))
      }
      
      interpretasi <- interpretasi_deskriptif_content()
      title <- paste("Statistik Deskriptif untuk", var_name)
      
      pdf(file, width = 8.5, height = 11)
      plot.new()
      text(0.5, 0.95, title, font = 2, cex = 1.5)
      text(0, 0.85, "Hasil:", font = 2, adj = c(0, 1), cex = 1.2)
      text(0, 0.8, paste(hasil, collapse = "\n"), adj = c(0, 1), cex = 1)
      text(0, 0.6, "Interpretasi:", font = 2, adj = c(0, 1), cex = 1.2)
      text(0, 0.55, interpretasi, adj = c(0, 1), cex = 1)
      dev.off()
    }
  )
  
  
  output$download_desc_stat_word <- downloadHandler(
    filename = function() {
      paste0("statistik_deskriptif_", Sys.Date(), ".docx")
    },
    content = function(file) {
      req(current_data(), input$desc_stat_var, interpretasi_deskriptif_content())
      
      df <- current_data()
      var_name <- input$desc_stat_var
      
      hasil <- if (is.numeric(df[[var_name]])) {
        capture.output(summary(df[[var_name]]))
      } else {
        capture.output(table(df[[var_name]]))
      }
      
      interpretasi <- interpretasi_deskriptif_content()
      title <- paste("Statistik Deskriptif untuk", var_name)
      
      doc <- officer::read_docx() %>%
        body_add_par(title, style = "heading 1") %>%
        body_add_par("Hasil:", style = "heading 2") %>%
        body_add_par(paste(hasil, collapse = "\n"), style = "Normal") %>%
        body_add_par("Interpretasi:", style = "heading 2") %>%
        body_add_par(interpretasi, style = "Normal")
      
      print(doc, target = file)
    }
  )
  
  
  data_plot_obj <- reactiveVal(NULL)
  observeEvent(input$generate_plot, {
    req(current_data(), input$plot_type) 
    df <- current_data()
    plot_type <- input$plot_type
    p <- NULL
    interpretasi <- ""
    
    if (plot_type == "Histogram" || plot_type == "Boxplot") {
      req(input$plot_var_x)
      var_x <- input$plot_var_x
      if (!is.numeric(df[[var_x]])) {
        interpretasi <- "Variabel harus numerik untuk Histogram."
      } else {
        p <- ggplot(df, aes_string(x = var_x)) +
          geom_histogram(bins = 30, fill = "steelblue", color = "black") +
          labs(title = paste("Histogram", var_x), x = var_x, y = "Frekuensi") +
          theme_minimal()
        interpretasi <- paste0("Histogram menunjukkan distribusi frekuensi variabel '", var_x, "'. Bentuk histogram (simetris, miring, bimodal) mengindikasikan karakteristik sebaran data.")
      }
    } else if (plot_type == "Boxplot") {
      req(input$plot_var_x)
      var_x <- input$plot_var_x
      if (!is.numeric(df[[var_x]])) {
        interpretasi <- "Variabel harus numerik untuk Boxplot."
      } else {
        p <- ggplot(df, aes_string(y = var_x)) +
          geom_boxplot(fill = "lightgreen", color = "darkgreen") +
          labs(title = paste("Boxplot", var_x), y = var_x) +
          theme_minimal()
        interpretasi <- paste0("Boxplot untuk variabel '", var_x, "' menunjukkan median, kuartil, dan keberadaan outlier. Panjang kotak menunjukkan rentang interkuartil (IQR), sementara garis di tengah adalah median.")
      }
    } else if (plot_type == "Scatter Plot") {
      req(input$plot_var_x, input$plot_var_y)
      var_x <- input$plot_var_x
      var_y <- input$plot_var_y
      if (!is.numeric(df[[var_x]]) || !is.numeric(df[[var_y]])) {
        interpretasi <- "Kedua variabel harus numerik untuk Scatter Plot."
      } else {
        p <- ggplot(df, aes_string(x = var_x, y = var_y)) +
          geom_point(color = "purple", alpha = 0.6) +
          geom_smooth(method = "lm", color = "darkblue", se = FALSE) +
          labs(title = paste("Scatter Plot", var_x, "vs", var_y), x = var_x, y = var_y) +
          theme_minimal()
        interpretasi <- paste0("Scatter plot menunjukkan hubungan antara variabel '", var_x, "' dan '", var_y, "'. Pola titik dan garis regresi menunjukkan arah (positif/negatif) dan kekuatan hubungan antara kedua variabel.")
      }
    } else if (plot_type == "Bar Plot") {
      req(input$plot_var_x)
      var_x <- input$plot_var_x
      # Ensure the variable is treated as categorical for bar plots
      df_temp <- df
      df_temp[[var_x]] <- as.factor(df_temp[[var_x]])
      
      p <- ggplot(df_temp, aes_string(x = var_x)) +
        geom_bar(fill = "lightblue", color = "darkblue") +
        labs(title = paste("Bar Plot", var_x), x = var_x, y = "Count") +
        theme_minimal()
      interpretasi <- paste0("Bar plot menunjukkan frekuensi atau jumlah data untuk setiap kategori dalam variabel '", var_x, "'. Ini berguna untuk memvisualisasikan distribusi data kategorik.")
    } else if (plot_type == "Peta") {
      req(input$map_var_lat, input$map_var_lon)
      lat_col <- input$map_var_lat
      lon_col <- input$map_var_lon
      color_col <- input$map_var_color
      
      if (!is.numeric(df[[lat_col]]) || !is.numeric(df[[lon_col]])) {
        interpretasi <- "Kolom Latitude dan Longitude harus numerik untuk visualisasi peta."
      } else {
        # Initialize leaflet map
        m <- leaflet(df) %>%
          addTiles() # Add default OpenStreetMap tiles
        
        # Add coloring if a color variable is selected
        if (color_col != "None" && color_col %in% names(df)) {
          colorData <- df[[color_col]]
          pal <- colorFactor("viridis", domain = colorData) # Use viridis palette
          m <- m %>%
            addCircles(lng = ~get(lon_col), lat = ~get(lat_col),
                       radius = 500, # Example radius, adjust as needed
                       color = ~pal(colorData),
                       fillOpacity = 0.8,
                       popup = ~paste("Lat:", get(lat_col), "<br>", "Lon:", get(lon_col), "<br>", color_col, ":", get(color_col))) %>%
            addLegend("bottomright", pal = pal, values = colorData, title = color_col)
        } else {
          m <- m %>%
            addMarkers(lng = ~get(lon_col), lat = ~get(lat_col),
                       popup = ~paste("Lat:", get(lat_col), "<br>", "Lon:", get(lon_col)))
        }
        
        output$data_map <- renderLeaflet({ m })
        interpretasi <- paste0("Peta interaktif menunjukkan distribusi geografis data menggunakan kolom '", lat_col, "' dan '", lon_col, "'. ",
                               if (color_col != "None" && color_col %in% names(df)) paste0("Titik-titik diwarnai berdasarkan variabel '", color_col, "'.") else "Titik-titik menunjukkan lokasi data.")
      }
    } else if (plot_type == "Peta Jarak") {
      req(distance_data())
      
      tryCatch({
        # Get distance matrix
        dist_matrix <- distance_data()
        
        # Convert distance matrix to coordinates using MDS
        coordinates <- distance_to_coordinates(dist_matrix)
        
        # Get color variable if selected
        color_var <- input$distance_color_var
        point_size <- input$distance_point_size
        show_labels <- input$show_labels
        
        # Initialize map
        m <- leaflet(coordinates) %>%
          addTiles() %>%
          setView(lng = mean(coordinates$longitude), lat = mean(coordinates$latitude), zoom = 5)
        
        # Prepare data for visualization
        map_data <- coordinates
        
        # Add SoVI data if available and color variable selected
        if (color_var != "None" && !is.null(current_data()) && nrow(current_data()) > 0) { # Menggunakan current_data()
          sovi_df <- current_data() # Menggunakan current_data()
          if ("DISTRICTCODE" %in% names(sovi_df) && color_var %in% names(sovi_df)) {
            # Match districts with coordinates
            sovi_subset <- sovi_df[sovi_df$DISTRICTCODE %in% coordinates$district_id, ]
            if (nrow(sovi_subset) > 0) {
              # Merge color data
              map_data <- merge(coordinates, sovi_subset[c("DISTRICTCODE", color_var)], 
                              by.x = "district_id", by.y = "DISTRICTCODE", all.x = TRUE)
              
              # Create color palette
              color_values <- map_data[[color_var]]
              color_values <- color_values[!is.na(color_values)]
              
              if (length(color_values) > 0) {
                if (is.numeric(color_values)) {
                  pal <- colorNumeric("viridis", domain = color_values)
                  m <- m %>%
                    addCircleMarkers(lng = ~longitude, lat = ~latitude,
                                   radius = point_size,
                                   color = ~pal(get(color_var)),
                                   fillOpacity = 0.8,
                                   popup = ~paste("District:", district_id, 
                                                "<br>Lat:", round(latitude, 4), 
                                                "<br>Lon:", round(longitude, 4),
                                                "<br>", color_var, ":", get(color_var))) %>%
                    addLegend("bottomright", pal = pal, values = ~get(color_var), title = color_var)
                } else {
                  pal <- colorFactor("viridis", domain = color_values)
                  m <- m %>%
                    addCircleMarkers(lng = ~longitude, lat = ~latitude,
                                   radius = point_size,
                                   color = ~pal(get(color_var)),
                                   fillOpacity = 0.8,
                                   popup = ~paste("District:", district_id, 
                                                "<br>Lat:", round(latitude, 4), 
                                                "<br>Lon:", round(longitude, 4),
                                                "<br>", color_var, ":", get(color_var))) %>%
                    addLegend("bottomright", pal = pal, values = ~get(color_var), title = color_var)
                }
              } else {
                m <- m %>%
                  addCircleMarkers(lng = ~longitude, lat = ~latitude,
                                 radius = point_size,
                                 color = "blue",
                                 fillOpacity = 0.8,
                                 popup = ~paste("District:", district_id, 
                                              "<br>Lat:", round(latitude, 4), 
                                              "<br>Lon:", round(longitude, 4)))
              }
            } else {
              m <- m %>%
                addCircleMarkers(lng = ~longitude, lat = ~latitude,
                               radius = point_size,
                               color = "blue",
                               fillOpacity = 0.8,
                               popup = ~paste("District:", district_id, 
                                            "<br>Lat:", round(latitude, 4), 
                                            "<br>Lon:", round(longitude, 4)))
            }
          } else {
            # Color variable not found, use default
            m <- m %>%
              addCircleMarkers(lng = ~longitude, lat = ~latitude,
                             radius = point_size,
                             color = "blue",
                             fillOpacity = 0.8,
                             popup = ~paste("District:", district_id, 
                                          "<br>Lat:", round(latitude, 4), 
                                          "<br>Lon:", round(longitude, 4)))
          }
        } else {
          # No color variable selected
          m <- m %>%
            addCircleMarkers(lng = ~longitude, lat = ~latitude,
                           radius = point_size,
                           color = "blue",
                           fillOpacity = 0.8,
                           popup = ~paste("District:", district_id, 
                                        "<br>Lat:", round(latitude, 4), 
                                        "<br>Lon:", round(longitude, 4)))
        }
        
        # Add labels if requested
        if (show_labels) {
          m <- m %>%
            addLabelOnlyMarkers(lng = ~longitude, lat = ~latitude,
                              label = ~as.character(district_id),
                              labelOptions = labelOptions(noHide = TRUE, direction = "top", textOnly = TRUE))
        }
        
        output$distance_map <- renderLeaflet({ m })
        
        interpretasi <- paste0("Peta jarak menampilkan visualisasi matriks jarak (", nrow(dist_matrix), "x", ncol(dist_matrix), 
                               ") yang dikonversi menjadi koordinat 2D menggunakan Multidimensional Scaling (MDS). ",
                               "Setiap titik merepresentasikan satu district, dengan jarak antar titik yang mencerminkan ",
                               "similaritas dalam data asli. ",
                               if (color_var != "None") paste0("Titik-titik diwarnai berdasarkan variabel '", color_var, "' dari data SoVI. ") else "",
                               "Interpretasi: Titik-titik yang berdekatan memiliki karakteristik yang serupa, ",
                               "sedangkan yang berjauhan memiliki karakteristik berbeda berdasarkan matriks jarak.")
      }, error = function(e) {
        interpretasi <- paste("Error dalam membuat peta jarak:", e$message)
        showNotification(interpretasi, type = "error")
      })
    }
    
    data_plot_obj(p) # Store ggplot object (will be NULL if map is generated)
    output$interpretasi_visualisasi <- renderText({ interpretasi })
  })
  
  output$data_plot <- renderPlot({
    req(input$plot_type != "Peta" && input$plot_type != "Peta Jarak") # Only render ggplot if not a map
    req(data_plot_obj())
    data_plot_obj()
  })
  
  output$download_plot <- downloadHandler(
    filename = function() {
      paste("grafik_", input$plot_type, "_", Sys.Date(), ".jpg", sep="") # Changed to JPG
    },
    content = function(file) {
      req(data_plot_obj(), input$plot_type != "Peta", input$plot_type != "Peta Jarak")
      ggplot2::ggsave(file, plot = data_plot_obj(), device = "jpeg", width = 10, height = 7, units = "in", dpi = 300) # Changed to JPEG
    }
  )
  
  # --- Uji Asumsi Server (Normalitas) ---
  normalitas_test_output <- reactiveVal(NULL)
  interpretasi_normalitas_text <- reactiveVal("")
  
  observeEvent(input$run_normalitas, {
    req(current_data(), input$norm_var) # Menggunakan current_data()
    df <- current_data()
    var <- df[[input$norm_var]]
    
    if (!is.numeric(var)) {
      interpretasi_normalitas_text("Variabel harus numerik untuk uji normalitas.")
      normalitas_test_output("Variabel yang dipilih tidak numerik.")
      return()
    }
    
    test_result <- if (length(var) > 3 && length(var) <= 5000) {
      shapiro.test(var)
    } else {
      tseries::jarque.bera.test(var)
    }
    normalitas_test_output(capture.output(print(test_result)))
    
    p_value <- test_result$p.value
    interpretasi <- paste0("Uji Normalitas (", ifelse(length(var) > 5000, "Jarque-Bera", "Shapiro-Wilk"), ") untuk variabel '", input$norm_var, "' menghasilkan nilai p sebesar ", round(p_value, 4), ".\n\n")
    if (p_value < 0.05) {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p kurang dari 0.05, kita menolak hipotesis nol (H0) bahwa data berdistribusi normal. Ini menunjukkan bahwa data tidak berdistribusi normal.")
    } else {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p lebih besar dari atau sama dengan 0.05, kita gagal menolak hipotesis nol (H0). Ini menunjukkan bahwa data berdistribusi normal.")
    }
    interpretasi_normalitas_text(interpretasi)
  })
  
  output$normalitas_output <- renderPrint({
    req(normalitas_test_output())
    cat(paste(normalitas_test_output(), collapse = "\n"))
  })
  
  output$interpretasi_normalitas <- renderText({
    req(interpretasi_normalitas_text())
    interpretasi_normalitas_text()
  })
  
  output$download_normalitas <- downloadHandler(
    filename = function() {
      paste0("uji_normalitas_", Sys.Date(), ".pdf")
    },
    content = function(file) {
      req(input$norm_var, normalitas_test_output(), interpretasi_normalitas_text())
      
      pdf(file, width = 8.5, height = 11)
      plot.new()
      title_text <- paste("Hasil Uji Normalitas untuk", input$norm_var)
      text(0.5, 0.95, title_text, cex = 1.5, font = 2)
      
      # Hasil uji
      hasil <- capture.output(normalitas_test_output())
      hasil_text <- paste(hasil, collapse = "\n")
      text(0, 0.85, paste("Hasil Uji:\n", hasil_text), adj = c(0, 1))
      
      # Interpretasi
      interpretasi <- interpretasi_normalitas_text()
      text(0, 0.5, paste("Interpretasi:\n", interpretasi), adj = c(0, 1))
      
      dev.off()
    }
  )
  
  output$download_normalitas_word <- downloadHandler(
    filename = function() {
      paste0("uji_normalitas_", Sys.Date(), ".docx")
    },
    content = function(file) {
      req(input$norm_var, normalitas_test_output(), interpretasi_normalitas_text())
      
      hasil <- capture.output(normalitas_test_output())
      interpretasi <- interpretasi_normalitas_text()
      
      doc <- read_docx()
      
      doc <- doc %>%
        body_add_par(paste("Hasil Uji Normalitas untuk Variabel:", input$norm_var), style = "heading 1") %>%
        body_add_par("Hasil Uji Statistik:", style = "heading 2") %>%
        body_add_par(paste(hasil, collapse = "\n"), style = "Normal") %>%
        body_add_par("Interpretasi:", style = "heading 2") %>%
        body_add_par(interpretasi, style = "Normal")
      
      print(doc, target = file)
    }
  )
  
  
  # --- Uji Asumsi Server (Homogenitas) ---
  homogenitas_test_output <- reactiveVal(NULL)
  interpretasi_homogenitas_text <- reactiveVal("")
  
  observeEvent(input$run_homogenitas, {
    req(current_data(), input$homo_var_response, input$homo_var_group)
    df <- current_data()
    response_var <- df[[input$homo_var_response]]
    group_var <- as.factor(df[[input$homo_var_group]])
    
    if (!is.numeric(response_var)) {
      interpretasi_homogenitas_text("Variabel respon harus numerik.")
      homogenitas_test_output(list(error = "Input variabel tidak sesuai."))
      return()
    }
    
    if (is.null(group_var) || all(is.na(group_var))) {
      interpretasi_homogenitas_text("Variabel grup tidak valid atau mengandung semua nilai NA.")
      homogenitas_test_output(list(error = "Variabel grup tidak valid."))
      return()
    }
    
    if (length(levels(group_var)) < 2) {
      interpretasi_homogenitas_text("Variabel grup harus memiliki setidaknya dua kategori.")
      homogenitas_test_output(list(error = "Variabel grup tidak valid."))
      return()
    }
    
    test_result <- car::leveneTest(response_var ~ group_var)
    
    df1 <- test_result$Df[1] 
    df2 <- test_result$Df[2] 
    f_value <- test_result$`F value`[1] 
    p_value <- test_result$`Pr(>F)`[1]
    
    homogenitas_test_output(list(
      df1 = df1,
      df2 = df2,
      f_value = f_value,
      p_value = p_value,
      raw_output = capture.output(print(test_result))
    ))
    
    interpretasi <- paste0("Uji Homogenitas (Levene's Test) untuk variabel respon '", input$homo_var_response, "' berdasarkan grup '", input$homo_var_group, "' menghasilkan nilai p sebesar ", round(p_value, 4), ".\n\n")
    if (p_value < 0.05) {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p kurang dari 0.05, kita menolak hipotesis nol (H0) bahwa varians homogen. Ini menunjukkan bahwa varians antar kelompok tidak homogen.")
    } else {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p lebih besar dari atau sama dengan 0.05, kita gagal menolak hipotesis nul (H0). Ini menunjukkan bahwa varians antar kelompok adalah homogen.")
    }
    interpretasi_homogenitas_text(interpretasi)
  })
  
  output$homogenitas_output <- renderPrint({
    req(homogenitas_test_output())
    output_data <- homogenitas_test_output()
    
    if (!is.null(output_data$error)) {
      cat(output_data$error)
    } else {
      cat("Hasil Uji Homogenitas:\n")
      cat("Levene's Test for Homogeneity of Variance (center = median)\n")
      cat(sprintf("%-10s %-10s %-10s\n", "Df1", "Df2", "F value", "Pr(>F)"))
      cat(sprintf("%-10.0f %-10.0f %-10.3f %-10.3f\n", output_data$df1, output_data$df2, output_data$f_value, output_data$p_value))
    }
  })
  
  output$interpretasi_homogenitas <- renderText({
    req(interpretasi_homogenitas_text())
    interpretasi_homogenitas_text()
  })
  
  output$download_homogenitas <- downloadHandler(
    filename = function() {
      paste0("uji_homogenitas_", Sys.Date(), ".pdf")
    },
    content = function(file) {
      req(input$homo_var_response, homogenitas_test_output(), interpretasi_homogenitas_text())
      
      hasil <- capture.output(homogenitas_test_output())
      interpretasi <- interpretasi_homogenitas_text()
      
      pdf(file, width = 8.5, height = 11)
      plot.new()
      title_text <- paste("Hasil Uji Homogenitas untuk", input$homo_var_response)
      text(0.5, 0.95, title_text, cex = 1.5, font = 2)
      
      # Hasil uji
      text(0, 0.85, "Hasil Uji:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.8, paste(hasil, collapse = "\n"), adj = c(0, 1), cex = 1)
      
      # Interpretasi
      text(0, 0.6, "Interpretasi:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.55, interpretasi, adj = c(0, 1), cex = 1)
      
      dev.off()
    }
  )
  
  
  output$download_homogenitas_word <- downloadHandler(
    filename = function() {
      paste0("uji_homogenitas_", Sys.Date(), ".docx")
    },
    content = function(file) {
      req(input$homo_var_response, homogenitas_test_output(), interpretasi_homogenitas_text())
      
      hasil <- capture.output(homogenitas_test_output())
      interpretasi <- interpretasi_homogenitas_text()
      
      doc <- officer::read_docx()
      
      doc <- doc %>%
        body_add_par(paste("Hasil Uji Homogenitas untuk", input$homo_var_response), style = "heading 1") %>%
        body_add_par("Hasil Uji Statistik:", style = "heading 2") %>%
        body_add_par(paste(hasil, collapse = "\n"), style = "Normal") %>%
        body_add_par("Interpretasi:", style = "heading 2") %>%
        body_add_par(interpretasi, style = "Normal")
      
      print(doc, target = file)
    }
  )
  
  # --- Uji Beda Rata-rata Server (t-test 1 Kelompok) ---
  t_test_1_output_val <- reactiveVal(NULL)
  interpretasi_t_test_1_text <- reactiveVal("")
  
  observeEvent(input$run_t_test_1, {
    req(current_data(), input$t_test_1_var, input$mu_t_test_1) # Menggunakan current_data()
    df <- current_data()
    var <- df[[input$t_test_1_var]]
    mu <- input$mu_t_test_1
    
    if (!is.numeric(var)) {
      interpretasi_t_test_1_text("Variabel harus numerik untuk uji t 1 kelompok.")
      t_test_1_output_val("Variabel yang dipilih tidak numerik.")
      return()
    }
    
    test_result <- t.test(var, mu = mu)
    t_test_1_output_val(capture.output(print(test_result)))
    
    p_value <- test_result$p.value
    interpretasi <- paste0("Uji Beda Rata-rata 1 Kelompok (One-Sample t-test) untuk variabel '", input$t_test_1_var, "' dengan nilai hipotesis (Mu) ", mu, " menghasilkan nilai p sebesar ", round(p_value, 4), ".\n\n")
    if (p_value < 0.05) {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p kurang dari 0.05, kita menolak hipotesis nol (H0). Ini menunjukkan ada perbedaan signifikan antara rata-rata sampel dan nilai hipotesis.")
    } else {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p lebih besar dari atau sama dengan 0.05, kita gagal menolak hipotesis nol (H0). Ini menunjukkan tidak ada perbedaan signifikan antara rata-rata sampel dan nilai hipotesis.")
    }
    interpretasi_t_test_1_text(interpretasi)
  })
  
  output$t_test_1_output <- renderPrint({
    req(t_test_1_output_val())
    cat(paste(t_test_1_output_val(), collapse = "\n"))
  })
  
  output$interpretasi_t_test_1 <- renderText({
    req(interpretasi_t_test_1_text())
    interpretasi_t_test_1_text()
  })
  
  output$download_t_test_1 <- downloadHandler(
    filename = function() { paste0("uji_t_1_kelompok_", Sys.Date(), ".pdf") },
    content = function(file) {
      req(input$t_test_1_var, t_test_1_output_val(), interpretasi_t_test_1_text())
      hasil <- capture.output(t_test_1_output_val())
      interpretasi <- interpretasi_t_test_1_text()
      title <- paste("Hasil Uji T 1 Kelompok untuk", input$t_test_1_var)
      
      pdf(file, width = 8.5, height = 11)
      plot.new()
      text(0.5, 0.95, title, cex = 1.5, font = 2)
      
      text(0, 0.85, "Hasil Uji:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.8, paste(hasil, collapse = "\n"), adj = c(0, 1), cex = 1)
      
      text(0, 0.6, "Interpretasi:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.55, interpretasi, adj = c(0, 1), cex = 1)
      dev.off()
    }
  )
  
  
  output$download_t_test_1_word <- downloadHandler(
    filename = function() { paste0("uji_t_1_kelompok_", Sys.Date(), ".docx") },
    content = function(file) {
      req(input$t_test_1_var, t_test_1_output_val(), interpretasi_t_test_1_text())
      hasil <- capture.output(t_test_1_output_val())
      interpretasi <- interpretasi_t_test_1_text()
      title <- paste("Hasil Uji T 1 Kelompok untuk", input$t_test_1_var)
      
      doc <- officer::read_docx() %>%
        body_add_par(title, style = "heading 1") %>%
        body_add_par("Hasil Uji:", style = "heading 2") %>%
        body_add_par(paste(hasil, collapse = "\n"), style = "Normal") %>%
        body_add_par("Interpretasi:", style = "heading 2") %>%
        body_add_par(interpretasi, style = "Normal")
      
      print(doc, target = file)
    }
  )
  
  
  # --- Uji Beda Rata-rata Server (t-test 2 Kelompok) ---
  t_test_2_output_val <- reactiveVal(NULL)
  interpretasi_t_test_2_text <- reactiveVal("")
  
  observeEvent(input$run_t_test_2, {
    req(current_data(), input$t_test_2_type) 
    df <- current_data()
    test_type <- input$t_test_2_type
    
    test_result <- NULL
    if (test_type == "Independen") {
      req(input$t_test_2_var_response, input$t_test_2_var_group)
      response_var <- df[[input$t_test_2_var_response]]
      group_var <- as.factor(df[[input$t_test_2_var_group]])
      
      if (!is.numeric(response_var) || !is.factor(group_var) || length(levels(group_var)) != 2) {
        interpretasi_t_test_2_text("Untuk uji independen: variabel respon harus numerik dan variabel grup harus kategorik dengan tepat 2 level.")
        t_test_2_output_val("Input variabel tidak sesuai.")
        return()
      }
      
      test_result <- t.test(response_var ~ group_var, var.equal = input$var_equal)
      interpretasi_base <- paste0("Uji Beda Rata-rata 2 Kelompok Independen (Independent Samples t-test) untuk '", input$t_test_2_var_response, "' berdasarkan grup '", input$t_test_2_var_group, "' (asumsi varians ", ifelse(input$var_equal, "sama", "tidak sama"), ") menghasilkan nilai p sebesar ", round(test_result$p.value, 4), ".\n\n")
    } else { # Berpasangan
      req(input$t_test_2_var1, input$t_test_2_var2)
      var1 <- df[[input$t_test_2_var1]]
      var2 <- df[[input$t_test_2_var2]]
      
      if (!is.numeric(var1) || !is.numeric(var2)) {
        interpretasi_t_test_2_text("Untuk uji berpasangan: kedua variabel harus numerik.")
        t_test_2_output_val("Input variabel tidak sesuai.")
        return()
      }
      
      test_result <- t.test(var1, var2, paired = TRUE)
      interpretasi_base <- paste0("Uji Beda Rata-rata 2 Kelompok Berpasangan (Paired Samples t-test) untuk '", input$t_test_2_var1, "' dan '", input$t_test_2_var2, "' menghasilkan nilai p sebesar ", round(test_result$p.value, 4), ".\n\n")
    }
    
    t_test_2_output_val(capture.output(print(test_result)))
    
    p_value <- test_result$p.value
    if (p_value < 0.05) {
      interpretasi <- paste0(interpretasi_base, "Interpretasi: Karena nilai p kurang dari 0.05, kita menolak hipotesis nol (H0). Ini menunjukkan ada perbedaan signifikan antara rata-rata kedua kelompok.")
    } else {
      interpretasi <- paste0(interpretasi_base, "Interpretasi: Karena nilai p lebih besar dari atau sama dengan 0.05, kita gagal menolak hipotesis nol (H0). Ini menunjukkan tidak ada perbedaan signifikan antara rata-rata kedua kelompok.")
    }
    interpretasi_t_test_2_text(interpretasi)
  })
  
  output$t_test_2_output <- renderPrint({
    req(t_test_2_output_val())
    cat(paste(t_test_2_output_val(), collapse = "\n"))
  })
  
  output$interpretasi_t_test_2 <- renderText({
    req(interpretasi_t_test_2_text())
    interpretasi_t_test_2_text()
  })
  
  output$download_t_test_2 <- downloadHandler(
    filename = function() {
      paste0("uji_t_2_kelompok_", input$t_test_2_type, "_", Sys.Date(), ".pdf")
    },
    content = function(file) {
      req(input$t_test_2_type, t_test_2_output_val(), interpretasi_t_test_2_text())
      hasil <- capture.output(t_test_2_output_val())
      interpretasi <- interpretasi_t_test_2_text()
      title <- paste("Hasil Uji T 2 Kelompok (", input$t_test_2_type, ")")
      
      pdf(file, width = 8.5, height = 11)
      plot.new()
      text(0.5, 0.95, title, cex = 1.5, font = 2)
      
      text(0, 0.85, "Hasil Uji:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.8, paste(hasil, collapse = "\n"), adj = c(0, 1), cex = 1)
      
      text(0, 0.6, "Interpretasi:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.55, interpretasi, adj = c(0, 1), cex = 1)
      dev.off()
    }
  )
  
  
  output$download_t_test_2_word <- downloadHandler(
    filename = function() {
      paste0("uji_t_2_kelompok_", input$t_test_2_type, "_", Sys.Date(), ".docx")
    },
    content = function(file) {
      req(input$t_test_2_type, t_test_2_output_val(), interpretasi_t_test_2_text())
      hasil <- capture.output(t_test_2_output_val())
      interpretasi <- interpretasi_t_test_2_text()
      title <- paste("Hasil Uji T 2 Kelompok (", input$t_test_2_type, ")")
      
      doc <- officer::read_docx() %>%
        body_add_par(title, style = "heading 1") %>%
        body_add_par("Hasil Uji:", style = "heading 2") %>%
        body_add_par(paste(hasil, collapse = "\n"), style = "Normal") %>%
        body_add_par("Interpretasi:", style = "heading 2") %>%
        body_add_par(interpretasi, style = "Normal")
      
      print(doc, target = file)
    }
  )
  
  
  
  # --- Uji Proporsi & Varians Server ---
  # Proporsi 1 Kelompok
  prop_test_1_output_val <- reactiveVal(NULL)
  interpretasi_prop_test_1_text <- reactiveVal("")
  
  observeEvent(input$run_prop_test_1, {
    req(current_data(), input$prop_test_1_var, input$p_prop_test_1)
    df <- current_data()
    var <- df[[input$prop_test_1_var]]
    p_hyp <- input$p_prop_test_1
    
    if (is.factor(var) && length(levels(var)) == 2) {
      x <- sum(var == levels(var)[2]) 
      n <- length(var)
    } else if (is.numeric(var) && all(var %in% c(0, 1))) {
      x <- sum(var == 1)
      n <- length(var)
    } else {
      interpretasi_prop_test_1_text("Variabel harus biner (0/1) atau kategorik dengan 2 level untuk uji proporsi.")
      prop_test_1_output_val("Variabel tidak sesuai.")
      return()
    }
    
    if (n == 0) {
      interpretasi_prop_test_1_text("Tidak ada data valid untuk uji proporsi.")
      prop_test_1_output_val("Tidak ada data.")
      return()
    }
    
    test_result <- prop.test(x, n, p = p_hyp)
    prop_test_1_output_val(capture.output(print(test_result)))
    
    p_value <- test_result$p.value
    interpretasi <- paste0("Uji Proporsi 1 Kelompok untuk variabel '", input$prop_test_1_var, "' dengan proporsi hipotesis ", p_hyp, " menghasilkan nilai p sebesar ", round(p_value, 4), ".\n\n")
    if (p_value < 0.05) {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p kurang dari 0.05, kita menolak hipotesis nol (H0). Ini menunjukkan proporsi sampel berbeda signifikan dari proporsi hipotesis.")
    } else {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p lebih besar dari atau sama dengan 0.05, kita gagal menolak hipotesis nol (H0). Ini menunjukkan proporsi sampel tidak berbeda signifikan dari propotesis hipotesis.")
    }
    interpretasi_prop_test_1_text(interpretasi)
  })
  
  output$prop_test_1_output <- renderPrint({
    req(prop_test_1_output_val())
    cat(paste(prop_test_1_output_val(), collapse = "\n"))
  })
  
  output$interpretasi_prop_test_1 <- renderText({
    req(interpretasi_prop_test_1_text())
    interpretasi_prop_test_1_text()
  })
  
  output$download_prop_test_1 <- downloadHandler(
    filename = function() {
      paste0("uji_proporsi_1_kelompok_", Sys.Date(), ".pdf")
    },
    content = function(file) {
      req(input$prop_test_1_var, prop_test_1_output_val(), interpretasi_prop_test_1_text())
      hasil <- capture.output(prop_test_1_output_val())
      interpretasi <- interpretasi_prop_test_1_text()
      title <- paste("Hasil Uji Proporsi 1 Kelompok untuk", input$prop_test_1_var)
      
      pdf(file, width = 8.5, height = 11)
      plot.new()
      text(0.5, 0.95, title, cex = 1.5, font = 2)
      
      text(0, 0.85, "Hasil Uji:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.8, paste(hasil, collapse = "\n"), adj = c(0, 1), cex = 1)
      
      text(0, 0.6, "Interpretasi:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.55, interpretasi, adj = c(0, 1), cex = 1)
      dev.off()
    }
  )
  
  
  output$download_prop_test_1_word <- downloadHandler(
    filename = function() {
      paste0("uji_proporsi_1_kelompok_", Sys.Date(), ".docx")
    },
    content = function(file) {
      req(input$prop_test_1_var, prop_test_1_output_val(), interpretasi_prop_test_1_text())
      hasil <- capture.output(prop_test_1_output_val())
      interpretasi <- interpretasi_prop_test_1_text()
      title <- paste("Hasil Uji Proporsi 1 Kelompok untuk", input$prop_test_1_var)
      
      doc <- officer::read_docx() %>%
        body_add_par(title, style = "heading 1") %>%
        body_add_par("Hasil Uji:", style = "heading 2") %>%
        body_add_par(paste(hasil, collapse = "\n"), style = "Normal") %>%
        body_add_par("Interpretasi:", style = "heading 2") %>%
        body_add_par(interpretasi, style = "Normal")
      
      print(doc, target = file)
    }
  )
  
  
  # Proporsi 2 Kelompok
  prop_test_2_output_val <- reactiveVal(NULL)
  interpretasi_prop_test_2_text <- reactiveVal("")
  
  observeEvent(input$run_prop_test_2, {
    req(current_data(), input$prop_test_2_var_cat, input$prop_test_2_var_group)
    df <- current_data()
    cat_var <- df[[input$prop_test_2_var_cat]]
    group_var <- as.factor(df[[input$prop_test_2_var_group]])
    
    if (length(levels(group_var)) != 2) {
      interpretasi_prop_test_2_text("Variabel grup harus memiliki tepat 2 kategori untuk uji proporsi 2 kelompok.")
      prop_test_2_output_val("Variabel grup tidak valid.")
      return()
    }
    
    if (!is.factor(cat_var) || length(levels(cat_var)) != 2) {
      interpretasi_prop_test_2_text("Variabel kategori harus biner (0/1) atau kategorik dengan 2 level untuk uji proporsi 2 kelompok.")
      prop_test_2_output_val("Variabel kategori tidak valid.")
      return()
    }
    
    counts <- table(cat_var, group_var)
    
    if (nrow(counts) != 2 || ncol(counts) != 2) {
      interpretasi_prop_test_2_text("Tabel kontingensi yang dihasilkan tidak 2x2. Pastikan kedua variabel biner/kategorik 2-level.")
      prop_test_2_output_val("Tabel kontingensi tidak valid.")
      return()
    }
    
    test_result <- prop.test(counts)
    prop_test_2_output_val(capture.output(print(test_result)))
    
    p_value <- test_result$p.value
    interpretasi <- paste0("Uji Proporsi 2 Kelompok untuk variabel kategori '", input$prop_test_2_var_cat, "' berdasarkan grup '", input$prop_test_2_var_group, "' menghasilkan nilai p sebesar ", round(p_value, 4), ".\n\n")
    if (p_value < 0.05) {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p kurang dari 0.05, kita menolak hipotesis nol (H0). Ini menunjukkan ada perbedaan signifikan antara proporsi kedua kelompok.")
    } else {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p lebih besar dari atau sama dengan 0.05, kita gagal menolak hipotesis nol (H0). Ini menunjukkan tidak ada perbedaan signifikan antara proporsi kedua kelompok.")
    }
    interpretasi_prop_test_2_text(interpretasi)
  })
  
  output$prop_test_2_output <- renderPrint({
    req(prop_test_2_output_val())
    cat(paste(prop_test_2_output_val(), collapse = "\n"))
  })
  
  output$interpretasi_prop_test_2 <- renderText({
    req(interpretasi_prop_test_2_text())
    interpretasi_prop_test_2_text()
  })
  
  output$download_prop_test_2 <- downloadHandler(
    filename = function() {
      paste0("uji_proporsi_2_kelompok_", Sys.Date(), ".pdf")
    },
    content = function(file) {
      req(input$prop_test_2_var_cat, prop_test_2_output_val(), interpretasi_prop_test_2_text())
      hasil <- capture.output(prop_test_2_output_val())
      interpretasi <- interpretasi_prop_test_2_text()
      title <- paste("Hasil Uji Proporsi 2 Kelompok untuk", input$prop_test_2_var_cat)
      
      pdf(file, width = 8.5, height = 11)
      plot.new()
      text(0.5, 0.95, title, cex = 1.5, font = 2)
      
      text(0, 0.85, "Hasil Uji:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.8, paste(hasil, collapse = "\n"), adj = c(0, 1), cex = 1)
      
      text(0, 0.6, "Interpretasi:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.55, interpretasi, adj = c(0, 1), cex = 1)
      dev.off()
    }
  )
  
  
  output$download_prop_test_2_word <- downloadHandler(
    filename = function() {
      paste0("uji_proporsi_2_kelompok_", Sys.Date(), ".docx")
    },
    content = function(file) {
      req(input$prop_test_2_var_cat, prop_test_2_output_val(), interpretasi_prop_test_2_text())
      hasil <- capture.output(prop_test_2_output_val())
      interpretasi <- interpretasi_prop_test_2_text()
      title <- paste("Hasil Uji Proporsi 2 Kelompok untuk", input$prop_test_2_var_cat)
      
      doc <- officer::read_docx() %>%
        body_add_par(title, style = "heading 1") %>%
        body_add_par("Hasil Uji:", style = "heading 2") %>%
        body_add_par(paste(hasil, collapse = "\n"), style = "Normal") %>%
        body_add_par("Interpretasi:", style = "heading 2") %>%
        body_add_par(interpretasi, style = "Normal")
      
      print(doc, target = file)
    }
  )
  
  
  # Varians 1 Kelompok
  var_test_1_output_val <- reactiveVal(NULL)
  interpretasi_var_test_1_text <- reactiveVal("")
  
  observeEvent(input$run_var_test_1, {
    # Ubah data_r() menjadi current_data()
    req(current_data(), input$var_test_1_var, input$sigma_var_test_1)
    df <- current_data()
    var <- df[[input$var_test_1_var]]
    sigma_hyp <- input$sigma_var_test_1
    
    if (!is.numeric(var)) {
      interpretasi_var_test_1_text("Variabel harus numerik untuk uji varians 1 kelompok.")
      var_test_1_output_val("Variabel tidak sesuai.")
      return()
    }
    if (sigma_hyp <= 0) {
      interpretasi_var_test_1_text("Varians hipotesis harus positif.")
      var_test_1_output_val("Varians hipotesis tidak valid.")
      return()
    }
    
    n <- length(var)
    s_squared <- var(var, na.rm = TRUE)
    chi_squared_stat <- (n - 1) * s_squared / sigma_hyp
    p_value <- pchisq(chi_squared_stat, df = n - 1, lower.tail = FALSE) # One-tailed for greater than, often two-tailed is 2*min(p, 1-p)
    
    test_output_text <- paste0(
      "\tChi-squared test for variance\n\n",
      "data: ", input$var_test_1_var, "\n",
      "X-squared = ", round(chi_squared_stat, 4), ", df = ", n - 1, ", p-value = ", round(p_value, 4), "\n",
      "alternative hypothesis: true variance is not equal to ", sigma_hyp, "\n",
      "95 percent confidence interval:\n",
      # Approx CI for variance
      "\t", round((n-1)*s_squared/qchisq(0.975, n-1), 4), " ", round((n-1)*s_squared/qchisq(0.025, n-1), 4), "\n",
      "sample estimates:\n",
      "var of ", input$var_test_1_var, "\n",
      "\t", round(s_squared, 4)
    )
    var_test_1_output_val(test_output_text)
    
    interpretasi <- paste0("Uji Varians 1 Kelompok (Chi-squared Test) untuk variabel '", input$var_test_1_var, "' dengan varians hipotesis ", sigma_hyp, " menghasilkan nilai p sebesar ", round(p_value, 4), ".\n\n")
    if (p_value < 0.05) {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p kurang dari 0.05, kita menolak hipotesis nol (H0). Ini menunjukkan varians sampel berbeda signifikan dari varians hipotesis.")
    } else {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p lebih besar dari atau sama dengan 0.05, kita gagal menolak hipotesis nol (H0). Ini menunjukkan varians sampel tidak berbeda signifikan dari varians hipotesis.")
    }
    interpretasi_var_test_1_text(interpretasi)
  })
  
  output$var_test_1_output <- renderPrint({
    req(var_test_1_output_val())
    cat(var_test_1_output_val())
  })
  
  output$interpretasi_var_test_1 <- renderText({
    req(interpretasi_var_test_1_text())
    interpretasi_var_test_1_text()
  })
  
  output$download_var_test_1 <- downloadHandler(
    filename = function() {
      paste0("uji_varians_1_kelompok_", Sys.Date(), ".pdf")
    },
    content = function(file) {
      req(input$var_test_1_var, var_test_1_output_val(), interpretasi_var_test_1_text())
      hasil <- capture.output(var_test_1_output_val())
      interpretasi <- interpretasi_var_test_1_text()
      title <- paste("Hasil Uji Varians 1 Kelompok untuk", input$var_test_1_var)
      
      pdf(file, width = 8.5, height = 11)
      plot.new()
      text(0.5, 0.95, title, cex = 1.5, font = 2)
      
      text(0, 0.85, "Hasil Uji:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.8, paste(hasil, collapse = "\n"), adj = c(0, 1), cex = 1)
      
      text(0, 0.6, "Interpretasi:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.55, interpretasi, adj = c(0, 1), cex = 1)
      dev.off()
    }
  )
  
  
  output$download_var_test_1_word <- downloadHandler(
    filename = function() {
      paste0("uji_varians_1_kelompok_", Sys.Date(), ".docx")
    },
    content = function(file) {
      req(input$var_test_1_var, var_test_1_output_val(), interpretasi_var_test_1_text())
      hasil <- capture.output(var_test_1_output_val())
      interpretasi <- interpretasi_var_test_1_text()
      title <- paste("Hasil Uji Varians 1 Kelompok untuk", input$var_test_1_var)
      
      doc <- officer::read_docx() %>%
        body_add_par(title, style = "heading 1") %>%
        body_add_par("Hasil Uji:", style = "heading 2") %>%
        body_add_par(paste(hasil, collapse = "\n"), style = "Normal") %>%
        body_add_par("Interpretasi:", style = "heading 2") %>%
        body_add_par(interpretasi, style = "Normal")
      
      print(doc, target = file)
    }
  )
  
  
  # Varians 2 Kelompok
  var_test_2_output_val <- reactiveVal(NULL)
  interpretasi_var_test_2_text <- reactiveVal("")
  
  observeEvent(input$run_var_test_2, {
    # Ubah data_r() menjadi current_data()
    req(current_data(), input$var_test_2_var_response, input$var_test_2_var_group)
    df <- current_data()
    response_var <- df[[input$var_test_2_var_response]]
    group_var <- as.factor(df[[input$var_test_2_var_group]])
    
    if (!is.numeric(response_var) || !is.factor(group_var) || length(levels(group_var)) != 2) {
      interpretasi_var_test_2_text("Variabel respon harus numerik dan variabel grup harus kategorik dengan tepat 2 level.")
      var_test_2_output_val("Input variabel tidak sesuai.")
      return()
    }
    
    test_result <- var.test(response_var ~ group_var) # F-test for equality of variances
    var_test_2_output_val(capture.output(print(test_result)))
    
    p_value <- test_result$p.value
    interpretasi <- paste0("Uji Varians 2 Kelompok (F-test) untuk '", input$var_test_2_var_response, "' berdasarkan grup '", input$var_test_2_var_group, "' menghasilkan nilai p sebesar ", round(p_value, 4), ".\n\n")
    if (p_value < 0.05) {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p kurang dari 0.05, kita menolak hipotesis nol (H0) bahwa varians homogen. Ini menunjukkan varians kedua kelompok berbeda signifikan.")
    } else {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p lebih besar dari atau sama dengan 0.05, kita gagal menolak hipotesis nol (H0). Ini menunjukkan varians kedua kelompok adalah homogen.")
    }
    interpretasi_var_test_2_text(interpretasi)
  })
  
  output$var_test_2_output <- renderPrint({
    req(var_test_2_output_val())
    cat(paste(var_test_2_output_val(), collapse = "\n"))
  })
  
  output$interpretasi_var_test_2 <- renderText({
    req(interpretasi_var_test_2_text())
    interpretasi_var_test_2_text()
  })
  
  output$download_var_test_2 <- downloadHandler(
    filename = function() {
      paste0("uji_varians_2_kelompok_", Sys.Date(), ".pdf")
    },
    content = function(file) {
      req(input$var_test_2_var_response, var_test_2_output_val(), interpretasi_var_test_2_text())
      hasil <- capture.output(var_test_2_output_val())
      interpretasi <- interpretasi_var_test_2_text()
      title <- paste("Hasil Uji Varians 2 Kelompok untuk", input$var_test_2_var_response)
      
      pdf(file, width = 8.5, height = 11)
      plot.new()
      text(0.5, 0.95, title, cex = 1.5, font = 2)
      
      text(0, 0.85, "Hasil Uji:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.8, paste(hasil, collapse = "\n"), adj = c(0, 1), cex = 1)
      
      text(0, 0.6, "Interpretasi:", adj = c(0, 1), font = 2, cex = 1.2)
      text(0, 0.55, interpretasi, adj = c(0, 1), cex = 1)
      dev.off()
    }
  )
  
  
  output$download_var_test_2_word <- downloadHandler(
    filename = function() {
      paste0("uji_varians_2_kelompok_", Sys.Date(), ".docx")
    },
    content = function(file) {
      req(input$var_test_2_var_response, var_test_2_output_val(), interpretasi_var_test_2_text())
      hasil <- capture.output(var_test_2_output_val())
      interpretasi <- interpretasi_var_test_2_text()
      title <- paste("Hasil Uji Varians 2 Kelompok untuk", input$var_test_2_var_response)
      
      doc <- officer::read_docx() %>%
        body_add_par(title, style = "heading 1") %>%
        body_add_par("Hasil Uji:", style = "heading 2") %>%
        body_add_par(paste(hasil, collapse = "\n"), style = "Normal") %>%
        body_add_par("Interpretasi:", style = "heading 2") %>%
        body_add_par(interpretasi, style = "Normal")
      
      print(doc, target = file)
    }
  )
  
  # --- ANOVA Server ---
  # ANOVA 1 Arah
  anova_1_way_output_val <- reactiveVal(NULL)
  interpretasi_anova_1_way_text <- reactiveVal("")
  
  observeEvent(input$run_anova_1_way, {
    req(current_data(), input$anova_1_resp, input$anova_1_group) # Menggunakan current_data() dan input$anova_1_group
    df <- current_data()
    response_var <- df[[input$anova_1_resp]]
    factor_var <- as.factor(df[[input$anova_1_group]]) # Menggunakan input$anova_1_group
    
    if (!is.numeric(response_var) || !is.factor(factor_var)) {
      interpretasi_anova_1_way_text("Variabel respon harus numerik dan variabel faktor harus kategorik.")
      anova_1_way_output_val("Input variabel tidak sesuai.")
      return()
    }
    if (length(levels(factor_var)) < 2) {
      interpretasi_anova_1_way_text("Variabel faktor harus memiliki setidaknya dua kategori.")
      anova_1_way_output_val("Variabel faktor tidak valid.")
      return()
    }
    
    aov_model <- aov(response_var ~ factor_var, data = df)
    anova_1_way_output_val(capture.output(print(summary(aov_model))))
    
    # Extract p-value from ANOVA summary
    anova_summary <- summary(aov_model)
    p_value <- anova_summary[[1]]$`Pr(>F)`[1] # p-value for the factor
    
    interpretasi <- paste0("Hasil ANOVA Satu Arah untuk variabel respon '", input$anova_1_resp, "' dan variabel faktor '", input$anova_1_group, "' menghasilkan nilai p sebesar ", round(p_value, 4), ".\n\n") # Menggunakan input$anova_1_group
    if (p_value < 0.05) {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p kurang dari 0.05, kita menolak hipotesis nol (H0). Ini menunjukkan ada perbedaan signifikan pada rata-rata variabel respon di antara setidaknya dua kelompok faktor.")
    } else {
      interpretasi <- paste0(interpretasi, "Interpretasi: Karena nilai p lebih besar dari atau sama dengan 0.05, kita gagal menolak hipotesis nol (H0). Ini menunjukkan tidak ada perbedaan signifikan pada rata-rata variabel respon di antara kelompok-kelompok faktor.")
    }
    interpretasi_anova_1_way_text(interpretasi)
  })
  
  output$anova_1_way_output <- renderPrint({
    req(anova_1_way_output_val())
    cat(paste(anova_1_way_output_val(), collapse = "\n"))
  })
  
  output$interpretasi_anova_1_way <- renderText({
    req(interpretasi_anova_1_way_text())
    interpretasi_anova_1_way_text()
  })
  
  output$download_anova_1_way <- downloadHandler(
    filename = function() {
      paste0("anova_1_arah_", Sys.Date(), ".pdf")
    },
    content = function(file) {
      req(input$anova_1_resp, anova_1_way_output_val(), interpretasi_anova_1_way_text())
      hasil <- capture.output(anova_1_way_output_val())
      interpretasi <- interpretasi_anova_1_way_text()
      title <- paste("Hasil ANOVA Satu Arah untuk", input$anova_1_resp)
      
      pdf(file, width = 8.5, height = 11)
      plot.new()
      text(0.5, 0.95, title, font = 2, cex = 1.5)
      text(0, 0.85, "Hasil Uji:", font = 2, adj = c(0, 1), cex = 1.2)
      text(0, 0.8, paste(hasil, collapse = "\n"), adj = c(0, 1))
      text(0, 0.6, "Interpretasi:", font = 2, adj = c(0, 1), cex = 1.2)
      text(0, 0.55, interpretasi, adj = c(0, 1))
      dev.off()
    }
  )
  
  
  output$download_anova_1_way_word <- downloadHandler(
    filename = function() {
      paste0("anova_1_arah_", Sys.Date(), ".docx")
    },
    content = function(file) {
      req(input$anova_1_resp, anova_1_way_output_val(), interpretasi_anova_1_way_text())
      hasil <- capture.output(anova_1_way_output_val())
      interpretasi <- interpretasi_anova_1_way_text()
      title <- paste("Hasil ANOVA Satu Arah untuk", input$anova_1_resp)
      
      doc <- officer::read_docx() %>%
        body_add_par(title, style = "heading 1") %>%
        body_add_par("Hasil Uji:", style = "heading 2") %>%
        body_add_par(paste(hasil, collapse = "\n"), style = "Normal") %>%
        body_add_par("Interpretasi:", style = "heading 2") %>%
        body_add_par(interpretasi, style = "Normal")
      
      print(doc, target = file)
    }
  )
  
  # ANOVA 2 Arah
  anova_2_way_output_val <- reactiveVal(NULL)
  interpretasi_anova_2_way_text <- reactiveVal("")
  
  observeEvent(input$run_anova_2_way, {
    req(current_data(), input$anova_2_resp, input$anova_2_factor1, input$anova_2_factor2) # Menggunakan current_data() dan input$anova_2_factor1, input$anova_2_factor2
    df <- current_data()
    response_var <- df[[input$anova_2_resp]]
    factor1_var <- as.factor(df[[input$anova_2_factor1]]) # Menggunakan input$anova_2_factor1
    factor2_var <- as.factor(df[[input$anova_2_factor2]]) # Menggunakan input$anova_2_factor2
    
    if (!is.numeric(response_var) || !is.factor(factor1_var) || !is.factor(factor2_var)) {
      interpretasi_anova_2_way_text("Variabel respon harus numerik dan variabel faktor harus kategorik.")
      anova_2_way_output_val("Input variabel tidak sesuai.")
      return()
    }
    if (length(levels(factor1_var)) < 2 || length(levels(factor2_var)) < 2) {
      interpretasi_anova_2_way_text("Kedua variabel faktor harus memiliki setidaknya dua kategori.")
      anova_2_way_output_val("Variabel faktor tidak valid.")
      return()
    }
    
    aov_model <- aov(response_var ~ factor1_var * factor2_var, data = df) # Model with interaction
    anova_2_way_output_val(capture.output(print(summary(aov_model))))
    
    anova_summary <- summary(aov_model)
    p_value_f1 <- anova_summary[[1]]$`Pr(>F)`[1] # p-value for factor 1
    p_value_f2 <- anova_summary[[1]]$`Pr(>F)`[2] # p-value for factor 2
    p_value_interaction <- anova_summary[[1]]$`Pr(>F)`[3] # p-value for interaction
    
    interpretasi <- paste0("Hasil ANOVA Dua Arah untuk variabel respon '", input$anova_2_resp, "' dengan faktor '", input$anova_2_factor1, "' dan '", input$anova_2_factor2, "':\n\n")
    
    interpretasi <- paste0(interpretasi, "Interaksi (", input$anova_2_factor1, " * ", input$anova_2_factor2, "): P-value = ", round(p_value_interaction, 4), ".\n")
    if (p_value_interaction < 0.05) {
      interpretasi <- paste0(interpretasi, "  Interpretasi: Ada interaksi signifikan antara kedua faktor. Pengaruh satu faktor terhadap variabel respon bergantung pada level faktor lainnya. Analisis efek utama perlu diinterpretasikan dengan hati-hati atau dilakukan analisis interaksi lebih lanjut (misalnya, plot interaksi).\n\n")
    } else {
      interpretasi <- paste0(interpretasi, "  Interpretasi: Tidak ada interaksi signifikan antara kedua faktor. Pengaruh satu faktor terhadap variabel respon tidak bergantung pada level faktor lainnya. Kita dapat melanjutkan untuk menginterpretasikan efek utama.\n\n")
    }
    
    interpretasi <- paste0(interpretasi, "Efek Utama ", input$anova_2_factor1, ": P-value = ", round(p_value_f1, 4), ".\n")
    if (p_value_f1 < 0.05) {
      interpretasi <- paste0(interpretasi, "  Interpretasi: Ada perbedaan signifikan pada rata-rata variabel respon di antara level-level faktor '", input$anova_2_factor1, "'.\n\n")
    } else {
      interpretasi <- paste0(interpretasi, "  Interpretasi: Tidak ada perbedaan signifikan pada rata-rata variabel respon di antara level-level faktor '", input$anova_2_factor1, "'.\n\n")
    }
    
    interpretasi <- paste0(interpretasi, "Efek Utama ", input$anova_2_factor2, ": P-value = ", round(p_value_f2, 4), ".\n")
    if (p_value_f2 < 0.05) {
      interpretasi <- paste0(interpretasi, "  Interpretasi: Ada perbedaan signifikan pada rata-rata variabel respon di antara level-level faktor '", input$anova_2_factor2, "'.\n\n")
    } else {
      interpretasi <- paste0(interpretasi, "  Interpretasi: Tidak ada perbedaan signifikan pada rata-rata variabel respon di antara level-level faktor '", input$anova_2_factor2, "'.\n\n")
    }
    
    interpretasi_anova_2_way_text(interpretasi)
  })
  
  output$anova_2_way_output <- renderPrint({
    req(anova_2_way_output_val())
    cat(paste(anova_2_way_output_val(), collapse = "\n"))
  })
  
  output$interpretasi_anova_2_way <- renderText({
    req(interpretasi_anova_2_way_text())
    interpretasi_anova_2_way_text()
  })
  
  output$download_anova_2_way <- downloadHandler(
    filename = function() {
      paste0("anova_2_arah_", Sys.Date(), ".pdf")
    },
    content = function(file) {
      req(input$anova_2_resp, anova_2_way_output_val(), interpretasi_anova_2_way_text())
      hasil <- capture.output(anova_2_way_output_val())
      interpretasi <- interpretasi_anova_2_way_text()
      title <- paste("Hasil ANOVA Dua Arah untuk", input$anova_2_resp)
      
      pdf(file, width = 8.5, height = 11)
      plot.new()
      text(0.5, 0.95, title, font = 2, cex = 1.5)
      text(0, 0.85, "Hasil Uji:", font = 2, adj = c(0, 1), cex = 1.2)
      text(0, 0.8, paste(hasil, collapse = "\n"), adj = c(0, 1))
      text(0, 0.6, "Interpretasi:", font = 2, adj = c(0, 1), cex = 1.2)
      text(0, 0.55, interpretasi, adj = c(0, 1))
      dev.off()
    }
  )
  
  
  output$download_anova_2_way_word <- downloadHandler(
    filename = function() {
      paste0("anova_2_arah_", Sys.Date(), ".docx")
    },
    content = function(file) {
      req(input$anova_2_resp, anova_2_way_output_val(), interpretasi_anova_2_way_text())
      hasil <- capture.output(anova_2_way_output_val())
      interpretasi <- interpretasi_anova_2_way_text()
      title <- paste("Hasil ANOVA Dua Arah untuk", input$anova_2_resp)
      
      doc <- officer::read_docx() %>%
        body_add_par(title, style = "heading 1") %>%
        body_add_par("Hasil Uji:", style = "heading 2") %>%
        body_add_par(paste(hasil, collapse = "\n"), style = "Normal") %>%
        body_add_par("Interpretasi:", style = "heading 2") %>%
        body_add_par(interpretasi, style = "Normal")
      
      print(doc, target = file)
    }
  )
  
  
  # --- Regresi Linear Berganda Server ---
  reg_model <- reactiveVal(NULL)
  interpretasi_regresi_text <- reactiveVal("")
  reg_norm_test_output_val <- reactiveVal(NULL)
  interpretasi_reg_norm_text <- reactiveVal("")
  reg_homo_test_output_val <- reactiveVal(NULL)
  interpretasi_reg_homo_text <- reactiveVal("")
  reg_vif_output_val <- reactiveVal(NULL)
  interpretasi_reg_vif_text <- reactiveVal("")
  reg_dw_output_val <- reactiveVal(NULL)
  interpretasi_reg_dw_text <- reactiveVal("")
  
  observeEvent(input$run_regresi, {
    req(current_data(), input$reg_dependent, input$reg_independent) # Menggunakan current_data()
    df <- current_data()
    dependent_var <- input$reg_dependent
    independent_vars <- input$reg_independent
    
    if (length(independent_vars) == 0) {
      interpretasi_regresi_text("Pilih setidaknya satu variabel independen.")
      output$regresi_output <- renderPrint(cat("Pilih variabel independen."))
      return()
    }
    
    # Ensure all selected variables are numeric
    all_vars <- c(dependent_var, independent_vars)
    if (!all(sapply(df[all_vars], is.numeric))) {
      interpretasi_regresi_text("Semua variabel (dependen dan independen) harus numerik untuk regresi linear berganda.")
      output$regresi_output <- renderPrint(cat("Variabel yang dipilih bukan numerik."))
      return()
    }
    
    formula_str <- paste(dependent_var, "~", paste(independent_vars, collapse = " + "))
    model <- lm(as.formula(formula_str), data = df)
    reg_model(model)
    output$regresi_output <- renderPrint(summary(model))
    
    # Interpretasi Regresi
    s <- summary(model)
    r_squared <- s$r.squared
    adj_r_squared <- s$adj.r.squared
    f_stat <- s$fstatistic[1]
    f_p_value <- pf(f_stat, s$fstatistic[2], s$fstatistic[3], lower.tail = FALSE)
    
    interpretasi_reg_text <- paste0(
      "Model Regresi Linear Berganda:\n",
      "- Persamaan: ", formula_str, "\n",
      "- R-squared (Koefisien Determinasi): ", round(r_squared, 4), "\n",
      "- Adjusted R-squared: ", round(adj_r_squared, 4), "\n",
      "- F-statistik: ", round(f_stat, 2), " (p-value: ", round(f_p_value, 4), ")\n\n",
      "Interpretasi: R-squared menunjukkan proporsi variasi dalam variabel dependen yang dijelaskan oleh variabel independen dalam model. Adjusted R-squared lebih baik untuk membandingkan model dengan jumlah prediktor yang berbeda. Jika p-value F-statistik < 0.05, model secara keseluruhan signifikan dalam menjelaskan variasi variabel dependen. Koefisien regresi individu (lihat output summary) menunjukkan pengaruh setiap variabel independen terhadap variabel dependen, dengan p-value masing-masing menunjukkan signifikansinya."
    )
    interpretasi_regresi_text(interpretasi_reg_text)
    
    # Uji Asumsi
    residuals <- residuals(model)
    
    # Normalitas Residual
    if (length(residuals) > 3 && length(residuals) <= 5000) {
      norm_test <- shapiro.test(residuals)
      test_name_norm <- "Shapiro-Wilk Test"
    } else {
      norm_test <- tseries::jarque.bera.test(residuals)
      test_name_norm <- "Jarque-Bera Test"
    }
    reg_norm_test_output_val(capture.output(print(norm_test)))
    output$reg_norm_plot <- renderPlot({
      par(mfrow=c(1,2)) # Arrange plots side-by-side
      hist(residuals, main = "Histogram Residuals", xlab = "Residuals", col = "lightblue", border = "black")
      qqnorm(residuals, main = "Normal Q-Q Plot")
      qqline(residuals, col = "red")
      par(mfrow=c(1,1)) # Reset plot layout
    })
    p_value_norm <- norm_test$p.value
    interpretasi_norm <- paste0("Uji Normalitas Residual (", test_name_norm, "): P-value = ", round(p_value_norm, 4), ".\n")
    if (p_value_norm < 0.05) {
      interpretasi_norm <- paste0(interpretasi_norm, "Interpretasi: Residual tidak berdistribusi normal (tolak H0). Ini melanggar asumsi normalitas.")
    } else {
      interpretasi_norm <- paste0(interpretasi_norm, "Interpretasi: Residual berdistribusi normal (gagal tolak H0). Asumsi normalitas terpenuhi.")
    }
    interpretasi_reg_norm_text(interpretasi_norm)
    
    # Homoskedastisitas (Breusch-Pagan or NCV test)
    homo_test <- car::ncvTest(model)
    reg_homo_test_output_val(capture.output(print(homo_test)))
    output$reg_homo_plot <- renderPlot({
      plot(fitted(model), residuals(model),
           xlab = "Fitted values", ylab = "Residuals",
           main = "Residuals vs Fitted Values",
           pch = 19, col = "blue")
      abline(h = 0, col = "red", lty = 2)
      lines(lowess(fitted(model), abs(residuals(model))), col = "green", lwd = 2)
    })
    p_value_homo <- homo_test$p[1] # Take the p-value for the chi-squared test
    interpretasi_homo <- paste0("Uji Homoskedastisitas (Non-Constant Variance Test): P-value = ", round(p_value_homo, 4), ".\n")
    if (p_value_homo < 0.05) {
      interpretasi_homo <- paste0(interpretasi_homo, "Interpretasi: Terjadi heteroskedastisitas (tolak H0). Ini melanggar asumsi homoskedastisitas.")
    } else {
      interpretasi_homo <- paste0(interpretasi_homo, "Interpretasi: Tidak terjadi heteroskedastisitas (gagal tolak H0). Asumsi homoskedastisitas terpenuhi.")
    }
    interpretasi_reg_homo_text(interpretasi_homo)
    
    # Multikolinearitas (VIF)
    vif_result <- car::vif(model)
    reg_vif_output_val(capture.output(print(vif_result)))
    interpretasi_vif <- paste0("Uji Multikolinearitas (Variance Inflation Factor - VIF):\n", paste(capture.output(print(vif_result)), collapse = "\n"), "\n\n")
    if (any(vif_result > 10)) {
      interpretasi_vif <- paste0(interpretasi_vif, "Interpretasi: Terdapat indikasi multikolinearitas tinggi (nilai VIF > 10) untuk beberapa variabel independen. Ini dapat menyebabkan estimasi koefisien regresi menjadi tidak stabil.")
    } else {
      interpretasi_vif <- paste0(interpretasi_vif, "Interpretasi: Tidak ada indikasi multikolinearitas tinggi (semua nilai VIF < 10). Asumsi multikolinearitas terpenuhi.")
    }
    interpretasi_reg_vif_text(interpretasi_vif)
    
    # Autokorelasi (Durbin-Watson)
    dw_test <- lmtest::dwtest(model)
    reg_dw_output_val(capture.output(print(dw_test)))
    p_value_dw <- dw_test$p.value
    dw_stat <- dw_test$statistic
    interpretasi_dw <- paste0("Uji Autokorelasi (Durbin-Watson Test): Statistik DW = ", round(dw_stat, 4), ", P-value = ", round(p_value_dw, 4), ".\n")
    interpretasi_dw <- paste0(interpretasi_dw, "Interpretasi: Nilai statistik Durbin-Watson mendekati 2 menunjukkan tidak ada autokorelasi. Nilai < 2 menunjukkan autokorelasi positif, dan > 2 menunjukkan autokorelasi negatif. P-value < 0.05 biasanya menunjukkan adanya autokorelasi.\n")
    interpretasi_reg_dw_text(interpretasi_dw)
  })
  
  output$interpretasi_regresi <- renderText({
    req(interpretasi_regresi_text())
    interpretasi_regresi_text()
  })
  
  output$reg_norm_test_output <- renderPrint({
    req(reg_norm_test_output_val())
    cat(paste(reg_norm_test_output_val(), collapse = "\n"))
  })
  output$interpretasi_reg_norm <- renderText({
    req(interpretasi_reg_norm_text())
    interpretasi_reg_norm_text()
  })
  
  output$reg_homo_test_output <- renderPrint({
    req(reg_homo_test_output_val())
    cat(paste(reg_homo_test_output_val(), collapse = "\n"))
  })
  output$interpretasi_reg_homo <- renderText({
    req(interpretasi_reg_homo_text())
    interpretasi_reg_homo_text()
  })
  
  output$reg_vif_output <- renderPrint({
    req(reg_vif_output_val())
    cat(paste(reg_vif_output_val(), collapse = "\n"))
  })
  output$interpretasi_reg_vif <- renderText({
    req(interpretasi_reg_vif_text())
    interpretasi_reg_vif_text()
  })
  
  output$reg_dw_output <- renderPrint({
    req(reg_dw_output_val())
    cat(paste(reg_dw_output_val(), collapse = "\n"))
  })
  output$interpretasi_reg_dw <- renderText({
    req(interpretasi_reg_dw_text())
    interpretasi_reg_dw_text()
  })
  
  output$download_regresi <- downloadHandler(
    filename = function() {
      paste0("hasil_regresi_", Sys.Date(), ".pdf")
    },
    content = function(file) {
      req(reg_model(), interpretasi_regresi_text(),
          interpretasi_reg_norm_text(), interpretasi_reg_homo_text(),
          interpretasi_reg_vif_text(), interpretasi_reg_dw_text())
      
      summary_output <- capture.output(summary(reg_model()))
      norm_output <- capture.output({
        if (length(residuals(reg_model())) > 3 && length(residuals(reg_model())) <= 5000) {
          print(shapiro.test(residuals(reg_model())))
        } else {
          print(tseries::jarque.bera.test(residuals(reg_model())))
        }
      })
      homo_output <- capture.output(car::ncvTest(reg_model()))
      vif_output <- capture.output(car::vif(reg_model()))
      dw_output <- capture.output(lmtest::dwtest(reg_model()))
      
      all_output <- c(
        "--- Hasil Regresi Linear Berganda ---", summary_output,
        "\n--- Uji Normalitas Residual ---", norm_output,
        "\n--- Uji Homoskedastisitas ---", homo_output,
        "\n--- Uji Multikolinearitas (VIF) ---", vif_output,
        "\n--- Uji Autokorelasi (Durbin-Watson) ---", dw_output
      )
      
      all_interpretation <- c(
        "--- Interpretasi Regresi ---", interpretasi_regresi_text(),
        "\n--- Interpretasi Normalitas ---", interpretasi_reg_norm_text(),
        "\n--- Interpretasi Homoskedastisitas ---", interpretasi_reg_homo_text(),
        "\n--- Interpretasi VIF ---", interpretasi_reg_vif_text(),
        "\n--- Interpretasi Durbin-Watson ---", interpretasi_reg_dw_text()
      )
      
      pdf(file, width = 8.5, height = 11)
      plot.new()
      text(0.5, 0.95, "Hasil Regresi Linear Berganda", font = 2, cex = 1.5)
      
      text(0, 0.88, paste(all_output, collapse = "\n"), adj = c(0, 1), cex = 1)
      text(0, 0.4, paste(all_interpretation, collapse = "\n"), adj = c(0, 1), cex = 1)
      dev.off()
    }
  )
  
  
  output$download_regresi_word <- downloadHandler(
    filename = function() {
      paste0("hasil_regresi_", Sys.Date(), ".docx")
    },
    content = function(file) {
      req(reg_model(), interpretasi_regresi_text(),
          interpretasi_reg_norm_text(), interpretasi_reg_homo_text(),
          interpretasi_reg_vif_text(), interpretasi_reg_dw_text())
      
      summary_output <- capture.output(summary(reg_model()))
      norm_output <- capture.output({
        if (length(residuals(reg_model())) > 3 && length(residuals(reg_model())) <= 5000) {
          print(shapiro.test(residuals(reg_model())))
        } else {
          print(tseries::jarque.bera.test(residuals(reg_model())))
        }
      })
      homo_output <- capture.output(car::ncvTest(reg_model()))
      vif_output <- capture.output(car::vif(reg_model()))
      dw_output <- capture.output(lmtest::dwtest(reg_model()))
      
      all_output <- c(
        "--- Hasil Regresi Linear Berganda ---", summary_output,
        "\n--- Uji Normalitas Residual ---", norm_output,
        "\n--- Uji Homoskedastisitas ---", homo_output,
        "\n--- Uji Multikolinearitas (VIF) ---", vif_output,
        "\n--- Uji Autokorelasi (Durbin-Watson) ---", dw_output
      )
      
      all_interpretation <- c(
        "--- Interpretasi Regresi ---", interpretasi_regresi_text(),
        "\n--- Interpretasi Normalitas ---", interpretasi_reg_norm_text(),
        "\n--- Interpretasi Homoskedastisitas ---", interpretasi_reg_homo_text(),
        "\n--- Interpretasi VIF ---", interpretasi_reg_vif_text(),
        "\n--- Interpretasi Durbin-Watson ---", interpretasi_reg_dw_text()
      )
      
      doc <- officer::read_docx() %>%
        body_add_par("Hasil Regresi Linear Berganda", style = "heading 1") %>%
        body_add_par(paste(all_output, collapse = "\n"), style = "Normal") %>%
        body_add_par("Interpretasi:", style = "heading 2") %>%
        body_add_par(paste(all_interpretation, collapse = "\n"), style = "Normal")
      
      print(doc, target = file)
    }
  )
  
    }


# Run the application
shinyApp(ui = ui, server = server)
