[README.md](https://github.com/user-attachments/files/31700192/README.md)
# Sistem PSB SMK Yadika 12

Sistem Penerimaan Siswa Baru (PSB) untuk SMK Yadika 12 dengan 2 jurusan: DKV dan TKJ.

## Aktor / Role
1. Calon Siswa - daftar akun, isi biodata, upload berkas, pantau status
2. Admin - kelola data pendaftar, verifikasi kelulusan, kelola jurusan, kelola akun operator, kelola konten beranda (hero, tentang sekolah, sambutan kepala sekolah, fasilitas, tenaga pengajar)
3. Operator - verifikasi kelengkapan berkas calon siswa

## Modul Penilaian & Seleksi (Metode SAW)
Admin dan operator kini memiliki menu **Penilaian & Seleksi** untuk memproses seleksi calon siswa menggunakan metode **SAW (Simple Additive Weighting)**:

- **Penilaian** -> satu halaman dengan dua tab:
  - Tab **"Daftar Penilaian Siswa"**: daftar calon siswa terverifikasi (dengan status kelengkapan berkas), klik "Input Nilai" untuk membuka form penilaian per siswa
    - **Nilai Rapor**: input nilai rata-rata untuk semester 1-6, masing-masing bisa disertai upload foto/scan rapor
    - **Nilai Tes Masuk (CBT)**: otomatis terisi begitu calon siswa mengerjakan tes CBT online
    - **Prestasi Akademik**: tambahkan prestasi (nama, tingkat Sekolah/Kab-Kota/Provinsi/Nasional/Internasional) beserta upload sertifikat; nilai diambil otomatis dari tingkat tertinggi
    - **Afiliasi**: pilih kategori afiliasi (Tidak Ada / Rekomendasi Yayasan / Saudara Kandung Alumni / Anak Guru-Karyawan) beserta upload bukti opsional; skor otomatis mengikuti kategori
  - Tab **"Bank Soal CBT"**: kelola bank soal pilihan ganda untuk tes masuk (maksimal 30 soal), bisa tambah/edit/hapus, tiap soal punya 4 pilihan dan 1 kunci jawaban
- **Proses SAW** -> jalankan perhitungan normalisasi matriks dan skor akhir untuk seluruh calon siswa sekali klik. Status **Diterima/Ditolak juga otomatis ditetapkan** pada langkah ini berdasarkan skor SAW tertinggi, kuota tiap jurusan, dan nilai ambang batas minimum (lihat menu Pengaturan) — tidak ada input manual
- **Hasil dan Ranking** -> daftar calon siswa terurut dari skor SAW tertinggi, dikelompokkan per jurusan (kartu terpisah, bukan satu tabel panjang), bisa difilter per jurusan. Status di sini bersifat **hanya tampilan** (read-only) karena sudah ditetapkan otomatis oleh Proses SAW
- **Laporan** -> daftar peringkat dikelompokkan per jurusan, ditampilkan sebagai form per siswa (Peringkat, Nama, No. Pendaftaran, Skor SAW, Status Kelulusan). Saat dicetak/disimpan sebagai PDF lewat dialog print browser, otomatis muncul kop surat resmi (yayasan, nama sekolah, kompetensi keahlian, alamat) beserta blok tanda tangan Kepala Sekolah di bagian bawah — tampilan di layar tetap ringkas tanpa kop tersebut

## Pengaturan (Admin)
Menu **Pengaturan** menggabungkan tiga hal dalam satu halaman bertab, khusus admin:
- **Tab Umum** -> atur Tahun Ajaran, Kuota Penerimaan Siswa Baru, dan **Nilai Ambang Batas Minimum (Nilai Preferensi V)**. Calon siswa dengan skor SAW di bawah ambang batas ini otomatis Tidak Diterima walau rankingnya masih masuk kuota jurusan. Isi 0 untuk menonaktifkan ambang batas (hanya pakai kuota & ranking)
- **Tab Kriteria & Bobot** -> atur bobot dan jenis (benefit/cost) untuk 4 kriteria SAW (Rapor, CBT, Prestasi, Afiliasi); total bobot harus 1.00
- **Tab Akun Panitia** -> tambah/hapus akun operator (panitia PPDB), bisa ditugaskan ke jurusan tertentu atau semua jurusan

## Status Berkas Lengkap Valid (Otomatis)
Sistem sekarang secara otomatis mendeteksi kapan seluruh berkas wajib (Kartu Keluarga, Akta Kelahiran, Ijazah/SKL, Pas Foto) milik seorang calon siswa sudah diverifikasi **valid** oleh operator. Begitu status tersebut tercapai:
- Badge **"Lengkap Valid"** muncul otomatis di kolom Berkas pada tab Daftar Penilaian Siswa
- Item checklist **"Semua Berkas Diverifikasi Valid"** di dashboard siswa otomatis tercentang
- Muncul notifikasi banner khusus di dashboard siswa yang memberi tahu bahwa berkasnya sudah lengkap dan tinggal menunggu hasil seleksi

Status ini diperbarui otomatis setiap kali operator mengubah status salah satu berkas lewat menu Verifikasi Berkas (yang sekarang tampil dikelompokkan per siswa dalam kartu terpisah, lengkap dengan opsi bagi operator untuk mengunggah/mengganti berkas atas nama siswa) — tidak perlu tindakan manual tambahan.

Calon siswa mengerjakan tes CBT langsung di tab **"2. Tes CBT"** pada menu **Nilai & Prestasi** (menu Tes CBT terpisah sudah digabung ke sini) — soal pilihan ganda, hanya bisa dikerjakan satu kali, nilai otomatis dihitung dan masuk ke sistem penilaian.

Selain itu, calon siswa juga bisa mengisi sendiri data penilaiannya lewat menu **Nilai & Prestasi** di dashboard mereka — persis seperti form yang dipakai admin/operator: input nilai rapor semester 1-6 beserta upload file, tambah prestasi akademik beserta sertifikat, dan pilih kategori afiliasi beserta bukti pendukung. Data yang diisi siswa ini otomatis tersinkron dengan yang dilihat admin/operator di menu Penilaian, jadi kedua pihak bisa saling melengkapi/mengoreksi data yang sama.

## Sidebar Bertingkat (Grup Collapsible)
Sidebar di semua panel (admin, operator, calon siswa) sekarang dikelompokkan menjadi beberapa grup menu dengan ikon, mirip aplikasi admin modern:
- **Admin**: Dashboard | Pendaftaran (Data Pendaftar, Verifikasi Pendaftaran) | Seleksi & SAW (Penilaian, Proses SAW, Hasil & Ranking) | Laporan | Data Master (Jurusan, Guru, Biaya, Ekstrakurikuler) | Konten Website (Konten Beranda, Slider Hero, Fasilitas) | Pengaturan | Keluar
- **Operator**: Dashboard | Verifikasi (Verifikasi Berkas) | Seleksi & SAW | Laporan | Keluar
- **Calon Siswa**: Dashboard | Pendaftaran (Formulir Biodata, Upload Berkas) | Nilai & Prestasi (termasuk Tes CBT) | Keluar

Klik judul grup untuk membuka/menutup isinya. Grup yang berisi halaman yang sedang aktif akan otomatis terbuka saat halaman dimuat.

## Dashboard Baru Admin & Operator
Dashboard admin kini menampilkan kartu statistik bergaya ikon (Total Pendaftar, Menunggu Verifikasi, Terverifikasi, Sudah Dinilai, Sudah Diproses SAW, Kuota Kelulusan Terisi), tabel **Alur Kerja** yang memandu langkah-langkah seleksi dari Data Pendaftar sampai Laporan, serta tabel **Pendaftar Terbaru**. Dashboard operator mendapat tampilan serupa yang disesuaikan dengan tugas verifikasi berkas dan akses ke modul penilaian.

## Mode Gelap & Mode Terang
Terdapat tombol ikon bulan/matahari di navbar (halaman publik) dan sidebar (panel siswa/admin/operator) untuk beralih antara Mode Terang dan Mode Gelap. Pilihan tema disimpan otomatis di browser pengguna (localStorage) sehingga tetap konsisten setiap kali membuka halaman lain atau kembali lagi nanti.

## Tema Biru Muda & Diagram Dashboard
Seluruh tampilan sistem (tombol, badge, aksen, sidebar panel) menggunakan palet biru muda (sky blue). Dashboard admin, operator, dan calon siswa masing-masing dilengkapi diagram interaktif (Chart.js) yang otomatis mengikuti data terbaru dari database:
- **Dashboard Admin**: grafik batang status pendaftar per jurusan, dan donut chart distribusi status verifikasi keseluruhan.
- **Dashboard Operator**: grafik batang status berkas per jenis dokumen, dan donut chart distribusi status berkas.
- **Dashboard Calon Siswa**: donut chart kelengkapan berkas persyaratan, serta daftar progres tahapan pendaftaran (biodata, upload berkas, verifikasi, hasil kelulusan).

Diagram dimuat lewat CDN Chart.js sehingga perangkat yang membuka sistem perlu koneksi internet agar grafik tampil.

## Konten Landing Page yang Bisa Diedit dari Admin
Login sebagai admin, lalu buka menu:
- **Kelola Konten Beranda** -> ubah judul & deskripsi hero, teks badge hero (mis. "AKREDITASI A"), tahun ajaran yang ditampilkan, isi "Tentang Sekolah" + foto gedung, isi sambutan kepala sekolah + foto, visi & misi sekolah, nomor WhatsApp kontak, link Instagram/YouTube/Facebook, video profil sekolah (YouTube), alamat & link embed Google Maps, serta upload file brosur PDF
- **Kelola Slider Hero** -> tambah/hapus slide berupa **foto** atau **video YouTube** yang tampil bergantian otomatis (auto-slide 5 detik) di bagian paling atas landing page, lengkap tombol panah kiri/kanan dan indikator titik. Slide video diputar otomatis tanpa suara sebagai latar bergerak (mirip banner sekolah).
- **Kelola Fasilitas** -> tambah/hapus kartu fasilitas (nama, deskripsi, foto, urutan tampil)
- **Kelola Guru** -> tambah/hapus kartu tenaga pengajar (nama, jabatan, foto, urutan tampil)
- **Kelola Biaya** -> tambah/hapus rincian biaya pendaftaran (nama biaya, jumlah, jurusan terkait, keterangan)
- **Kelola Ekstrakurikuler** -> tambah/hapus kartu ekstrakurikuler (nama, deskripsi, foto, urutan tampil)

Bagian hero paling atas kini berupa slider gambar full-width dengan overlay gelap, badge kuning, judul besar, dan dua tombol aksi—mirip tampilan landing page sekolah modern. Jika belum ada gambar slider yang diunggah, otomatis ditampilkan latar gradasi biru sebagai fallback agar tetap rapi. Landing page juga otomatis menampilkan tombol "Unduh Brosur PSB" beserta popup brosur saat pertama dibuka, tabel "Rincian Biaya Pendaftaran", bagian "Visi & Misi", video sambutan sekolah dari YouTube, peta lokasi sekolah, ikon media sosial (Instagram/YouTube/Facebook/WhatsApp) di footer, serta tombol WhatsApp mengambang di pojok kanan bawah. Bagian video, peta, dan ikon sosial media hanya tampil jika datanya sudah diisi lewat menu Kelola Konten Beranda.

Semua foto diunggah otomatis ke folder `uploads/konten/`. Jika foto belum diunggah, halaman akan menampilkan gambar placeholder sementara agar tampilan tetap rapi.

## Notifikasi Kelulusan & Bukti Penerimaan (Calon Siswa)
Setelah admin mengubah status verifikasi seorang pendaftar menjadi **Diterima** lewat menu Verifikasi Pendaftaran, calon siswa yang bersangkutan akan otomatis melihat notifikasi selamat di dashboard mereka beserta tombol **"Cetak Bukti Diterima (PDF)"**. Halaman bukti ini berisi data diri, jurusan yang diterima, dan tanda tangan kepala sekolah, lalu dapat disimpan sebagai file PDF melalui dialog cetak browser (pilih "Save as PDF" / "Simpan sebagai PDF" pada saat mencetak). Jika status pendaftar Ditolak, akan muncul notifikasi berbeda beserta catatan dari panitia.

Admin juga dapat mengelola bukti ini dari sisi admin: buka menu **Data Pendaftar** atau **Detail Pendaftar**, lalu klik **"Cetak Bukti"** / **"Edit & Cetak Bukti"** (tombol hanya muncul untuk pendaftar berstatus Diterima). Di halaman tersebut admin dapat menambahkan/mengedit catatan khusus (misalnya info jadwal daftar ulang) yang akan ikut tampil di lembar bukti sebelum mencetaknya.

## Cara Instalasi (XAMPP/Laragon)
1. Salin folder `psb-yadika12` ke folder htdocs (XAMPP) atau www (Laragon)
2. Buka phpMyAdmin, buat database baru lalu import file `database.sql`
3. Sesuaikan koneksi database di `config/koneksi.php` jika perlu
4. Beri izin folder `uploads/berkas` dan `uploads/konten` agar bisa ditulis (chmod 755/777 di server Linux)
5. Akses melalui browser: http://localhost/psb-yadika12/

## Akun Default
- Admin -> username: admin, password: admin123
- Operator -> username: operator1, password: admin123
- Calon Siswa -> daftar akun baru melalui halaman daftar.php

## Struktur Folder
- config/       -> koneksi database
- includes/     -> fungsi bantuan (helper, sesi, keamanan)
- assets/       -> css
- siswa/        -> halaman untuk calon siswa
- admin/        -> halaman untuk admin
- operator/     -> halaman untuk operator
- uploads/      -> tempat penyimpanan berkas yang diunggah
- database.sql  -> struktur & data awal database
