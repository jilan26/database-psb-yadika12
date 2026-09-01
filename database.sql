-- =========================================================
-- Database Sistem PSB (Penerimaan Siswa Baru)
-- SMK Yadika 12
-- Jurusan: DKV (Desain Komunikasi Visual) & TKJ (Teknik Komputer Jaringan)
-- =========================================================

CREATE DATABASE IF NOT EXISTS db_psb_yadika12;
USE db_psb_yadika12;

-- -------------------------------------
-- Tabel Jurusan
-- -------------------------------------
CREATE TABLE jurusan (
    id_jurusan INT AUTO_INCREMENT PRIMARY KEY,
    kode_jurusan VARCHAR(10) NOT NULL,
    nama_jurusan VARCHAR(100) NOT NULL,
    deskripsi TEXT,
    kuota INT DEFAULT 40,
    terisi INT DEFAULT 0
);

INSERT INTO jurusan (kode_jurusan, nama_jurusan, deskripsi, kuota, terisi) VALUES
('DKV', 'Desain Komunikasi Visual', 'Program keahlian yang mempelajari desain grafis, ilustrasi, fotografi, videografi, dan multimedia kreatif.', 40, 0),
('TKJ', 'Teknik Komputer dan Jaringan', 'Program keahlian yang mempelajari perakitan komputer, instalasi jaringan, konfigurasi server, dan keamanan jaringan.', 40, 0);

-- -------------------------------------
-- Tabel Admin
-- -------------------------------------
CREATE TABLE admin (
    id_admin INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- password default: admin123 (sudah di-hash pakai password_hash bcrypt)
INSERT INTO admin (username, password, nama_lengkap) VALUES
('admin', '$2b$12$RsFvLWCxeJUZdISWI09QmeR77aySK0QJEMRwSsyBc7CPaL4fCovgq', 'Administrator PSB');

-- -------------------------------------
-- Tabel Operator
-- -------------------------------------
CREATE TABLE operator (
    id_operator INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    nama_lengkap VARCHAR(100) NOT NULL,
    id_jurusan INT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_jurusan) REFERENCES jurusan(id_jurusan)
);

INSERT INTO operator (username, password, nama_lengkap, id_jurusan) VALUES
('operator1', '$2b$12$RsFvLWCxeJUZdISWI09QmeR77aySK0QJEMRwSsyBc7CPaL4fCovgq', 'Operator Jurusan', NULL);

-- -------------------------------------
-- Tabel Calon Siswa (akun pendaftar)
-- -------------------------------------
CREATE TABLE calon_siswa (
    id_siswa INT AUTO_INCREMENT PRIMARY KEY,
    no_pendaftaran VARCHAR(20) NOT NULL UNIQUE,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- -------------------------------------
-- Tabel Biodata Pendaftaran
-- -------------------------------------
CREATE TABLE biodata (
    id_biodata INT AUTO_INCREMENT PRIMARY KEY,
    id_siswa INT NOT NULL,
    nama_lengkap VARCHAR(100),
    tempat_lahir VARCHAR(50),
    tanggal_lahir DATE,
    jenis_kelamin ENUM('Laki-laki','Perempuan'),
    agama VARCHAR(30),
    alamat TEXT,
    no_hp VARCHAR(20),
    nama_ayah VARCHAR(100),
    nama_ibu VARCHAR(100),
    no_hp_ortu VARCHAR(20),
    asal_sekolah VARCHAR(100),
    nisn VARCHAR(20),
    id_jurusan INT,
    foto VARCHAR(255),
    status_verifikasi ENUM('menunggu','diterima','ditolak') DEFAULT 'menunggu',
    catatan_verifikasi TEXT,
    catatan_bukti TEXT,
    nilai_rapor DECIMAL(5,2) DEFAULT NULL,
    nilai_cbt DECIMAL(5,2) DEFAULT NULL,
    nilai_prestasi DECIMAL(5,2) DEFAULT NULL,
    afiliasi_kategori VARCHAR(60) DEFAULT NULL,
    nilai_afiliasi DECIMAL(5,2) DEFAULT NULL,
    file_afiliasi VARCHAR(255) DEFAULT NULL,
    nilai_saw DECIMAL(6,3) DEFAULT NULL,
    tanggal_saw TIMESTAMP NULL DEFAULT NULL,
    berkas_lengkap_valid TINYINT(1) DEFAULT 0,
    tanggal_berkas_valid TIMESTAMP NULL DEFAULT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (id_siswa) REFERENCES calon_siswa(id_siswa),
    FOREIGN KEY (id_jurusan) REFERENCES jurusan(id_jurusan)
);

-- -------------------------------------
-- Tabel Berkas Upload
-- -------------------------------------
CREATE TABLE berkas (
    id_berkas INT AUTO_INCREMENT PRIMARY KEY,
    id_siswa INT NOT NULL,
    jenis_berkas VARCHAR(50) NOT NULL, -- KK, Akta, Ijazah/SKL, Pas Foto
    nama_file VARCHAR(255) NOT NULL,
    status ENUM('menunggu','valid','tidak_valid') DEFAULT 'menunggu',
    keterangan TEXT,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_siswa) REFERENCES calon_siswa(id_siswa)
);

-- -------------------------------------
-- Tabel Pengaturan Konten Landing Page (dikelola admin)
-- -------------------------------------
CREATE TABLE pengaturan (
    id_pengaturan INT PRIMARY KEY DEFAULT 1,
    hero_judul VARCHAR(200) DEFAULT 'Penerimaan Siswa Baru',
    hero_deskripsi TEXT,
    tentang_isi TEXT,
    foto_gedung VARCHAR(255),
    sambutan_isi TEXT,
    nama_kepala_sekolah VARCHAR(100) DEFAULT 'Kepala Sekolah SMK Yadika 12',
    foto_kepala_sekolah VARCHAR(255),
    file_brosur VARCHAR(255),
    no_whatsapp VARCHAR(20),
    visi TEXT,
    misi TEXT,
    instagram_url VARCHAR(255),
    youtube_url VARCHAR(255),
    facebook_url VARCHAR(255),
    alamat_sekolah VARCHAR(255),
    maps_embed_url VARCHAR(500),
    video_profil_url VARCHAR(255),
    tahun_ajaran VARCHAR(20) DEFAULT '2027/2028',
    hero_badge VARCHAR(50) DEFAULT 'AKREDITASI A',
    nama_yayasan VARCHAR(150) DEFAULT 'YAYASAN ABDI KARYA',
    kuota_ppdb INT DEFAULT 0,
    ambang_batas_saw DECIMAL(4,3) DEFAULT 0,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO pengaturan (id_pengaturan, hero_judul, hero_deskripsi, tentang_isi, sambutan_isi, nama_kepala_sekolah, no_whatsapp, visi, misi, instagram_url, youtube_url, facebook_url, alamat_sekolah, maps_embed_url, video_profil_url, tahun_ajaran, hero_badge, nama_yayasan, kuota_ppdb, ambang_batas_saw) VALUES
(1,
'Penerimaan Siswa Baru',
'SMK Yadika 12 membuka pendaftaran untuk 2 program keahlian unggulan: Desain Komunikasi Visual (DKV) dan Teknik Komputer Jaringan (TKJ). Daftarkan dirimu sekarang dan mulai langkah menuju masa depan cerah.',
'SMK Yadika 12 adalah sekolah menengah kejuruan yang berkomitmen mencetak lulusan siap kerja, siap kuliah, dan siap berwirausaha. Didukung tenaga pengajar berpengalaman dan fasilitas praktik yang memadai, sekolah ini menjadi pilihan tepat untuk membentuk generasi yang kreatif dan kompeten di bidang teknologi dan desain.',
'Kami mengundang putra-putri terbaik untuk bergabung bersama SMK Yadika 12. Di sini, kalian tidak hanya akan belajar teori, tetapi juga praktik langsung yang membentuk keterampilan nyata. Mari bersama membangun masa depan yang lebih cerah melalui pendidikan kejuruan yang berkualitas.',
'Kepala Sekolah SMK Yadika 12',
'6281234567890',
'Menjadi lembaga pendidikan kejuruan yang unggul, kompetitif, dan berkarakter dalam menghasilkan lulusan yang siap kerja, siap kuliah, dan siap berwirausaha di era teknologi dan industri kreatif.',
'Menyelenggarakan pembelajaran berbasis kompetensi dan praktik industri
Membentuk karakter siswa yang disiplin, jujur, dan bertanggung jawab
Mengembangkan kerja sama dengan dunia usaha dan dunia industri (DUDI)
Meningkatkan kompetensi tenaga pendidik secara berkelanjutan',
'https://instagram.com/smkyadika12',
'https://youtube.com/@smkyadika12',
'https://facebook.com/smkyadika12',
'JL. RAYA LIMO NO. 20 RT.001 RW.007 KEC. LIMO, Kec. Limo, Kota Depok, Prov. Jawa Barat',
'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d... (ganti dengan link embed peta sekolah Anda)',
'',
'2027/2028',
'AKREDITASI A',
'YAYASAN ABDI KARYA',
80,
0.5
);

-- -------------------------------------
-- Tabel Fasilitas (dikelola admin)
-- -------------------------------------
CREATE TABLE fasilitas (
    id_fasilitas INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    deskripsi VARCHAR(255),
    foto VARCHAR(255),
    urutan INT DEFAULT 0
);

INSERT INTO fasilitas (nama, deskripsi, urutan) VALUES
('Lab. Komputer & Jaringan', 'Ruang praktik perakitan komputer dan konfigurasi jaringan', 1),
('Studio Desain DKV', 'Ruang praktik desain grafis, fotografi, dan multimedia', 2),
('Perpustakaan', 'Ruang baca dan referensi belajar siswa', 3),
('Aula Serbaguna', 'Tempat kegiatan sekolah dan acara siswa', 4),
('Lapangan Olahraga', 'Sarana kegiatan olahraga dan upacara', 5),
('Musala Sekolah', 'Tempat ibadah warga sekolah', 6);

-- -------------------------------------
-- Tabel Guru / Tenaga Pengajar (dikelola admin)
-- -------------------------------------
CREATE TABLE guru (
    id_guru INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    jabatan VARCHAR(100),
    foto VARCHAR(255),
    urutan INT DEFAULT 0
);

INSERT INTO guru (nama, jabatan, urutan) VALUES
('Ketua Program DKV', 'Ketua Kompetensi Keahlian DKV', 1),
('Ketua Program TKJ', 'Ketua Kompetensi Keahlian TKJ', 2),
('Waka Kesiswaan', 'Wakil Kepala Bidang Kesiswaan', 3),
('Waka Kurikulum', 'Wakil Kepala Bidang Kurikulum', 4);

-- -------------------------------------
-- Tabel Rincian Biaya (dikelola admin)
-- -------------------------------------
CREATE TABLE biaya (
    id_biaya INT AUTO_INCREMENT PRIMARY KEY,
    nama_biaya VARCHAR(150) NOT NULL,
    jumlah DECIMAL(12,0) NOT NULL DEFAULT 0,
    keterangan VARCHAR(255),
    id_jurusan INT NULL,
    urutan INT DEFAULT 0,
    FOREIGN KEY (id_jurusan) REFERENCES jurusan(id_jurusan)
);

INSERT INTO biaya (nama_biaya, jumlah, keterangan, id_jurusan, urutan) VALUES
('Formulir Pendaftaran', 100000, 'Dibayarkan saat mendaftar', NULL, 1),
('Uang Pangkal', 2500000, 'Dibayarkan sekali di awal masuk', NULL, 2),
('SPP Bulanan', 350000, 'Dibayarkan setiap bulan', NULL, 3),
('Seragam & Perlengkapan', 750000, 'Seragam sekolah, praktik, dan atribut', NULL, 4);

-- -------------------------------------
-- Tabel Ekstrakurikuler (dikelola admin)
-- -------------------------------------
CREATE TABLE ekstrakurikuler (
    id_ekskul INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    deskripsi VARCHAR(255),
    foto VARCHAR(255),
    urutan INT DEFAULT 0
);

INSERT INTO ekstrakurikuler (nama, deskripsi, urutan) VALUES
('Paskibra', 'Melatih kedisiplinan, kepemimpinan, dan baris-berbaris', 1),
('Futsal', 'Kegiatan olahraga futsal untuk siswa putra dan putri', 2),
('Pramuka', 'Kegiatan kepramukaan wajib untuk membentuk karakter', 3),
('Seni Musik & Band', 'Wadah bakat musik dan tampil di acara sekolah', 4),
('English Club', 'Melatih kemampuan bahasa Inggris secara aktif', 5),
('Desain & Fotografi', 'Eksplorasi kreativitas visual di luar jam DKV', 6);

-- -------------------------------------
-- Tabel Slider Gambar Hero (dikelola admin)
-- -------------------------------------
CREATE TABLE hero_slide (
    id_slide INT AUTO_INCREMENT PRIMARY KEY,
    tipe ENUM('foto','video') DEFAULT 'foto',
    foto VARCHAR(255),
    video_url VARCHAR(255),
    urutan INT DEFAULT 0
);

-- =========================================================
-- Modul Penilaian & Seleksi (Metode SAW)
-- =========================================================

-- -------------------------------------
-- Tabel Kriteria SAW (dikelola admin)
-- -------------------------------------
CREATE TABLE kriteria (
    id_kriteria INT AUTO_INCREMENT PRIMARY KEY,
    kode VARCHAR(20) NOT NULL,
    nama VARCHAR(100) NOT NULL,
    bobot DECIMAL(4,2) NOT NULL DEFAULT 0.25,
    jenis ENUM('benefit','cost') DEFAULT 'benefit',
    urutan INT DEFAULT 0
);

INSERT INTO kriteria (kode, nama, bobot, jenis, urutan) VALUES
('RAPOR', 'Nilai Rapor (Semester 1-6)', 0.30, 'benefit', 1),
('CBT', 'Nilai Tes Masuk (CBT)', 0.35, 'benefit', 2),
('PRESTASI', 'Prestasi Akademik', 0.20, 'benefit', 3),
('AFILIASI', 'Afiliasi', 0.15, 'benefit', 4);

-- -------------------------------------
-- Tabel Nilai Rapor per Semester
-- -------------------------------------
CREATE TABLE rapor (
    id_rapor INT AUTO_INCREMENT PRIMARY KEY,
    id_siswa INT NOT NULL,
    semester TINYINT NOT NULL,
    nilai_rata DECIMAL(5,2),
    file_rapor VARCHAR(255),
    UNIQUE KEY unik_siswa_semester (id_siswa, semester),
    FOREIGN KEY (id_siswa) REFERENCES calon_siswa(id_siswa)
);

-- -------------------------------------
-- Tabel Bank Soal CBT (Pilihan Ganda)
-- -------------------------------------
CREATE TABLE soal_cbt (
    id_soal INT AUTO_INCREMENT PRIMARY KEY,
    pertanyaan TEXT NOT NULL,
    pilihan_a VARCHAR(255) NOT NULL,
    pilihan_b VARCHAR(255) NOT NULL,
    pilihan_c VARCHAR(255) NOT NULL,
    pilihan_d VARCHAR(255) NOT NULL,
    jawaban_benar ENUM('a','b','c','d') NOT NULL,
    urutan INT DEFAULT 0
);

INSERT INTO soal_cbt (pertanyaan, pilihan_a, pilihan_b, pilihan_c, pilihan_d, jawaban_benar, urutan) VALUES
('Hasil dari 12 + 8 x 2 adalah...', '40', '28', '20', '32', 'b', 1),
('Ibu kota Provinsi Jawa Barat adalah...', 'Bogor', 'Bekasi', 'Bandung', 'Depok', 'c', 2),
('Sinonim dari kata "cerdas" adalah...', 'Pandai', 'Malas', 'Lambat', 'Bodoh', 'a', 3),
('1 KB sama dengan berapa byte?', '100 byte', '1000 byte', '1024 byte', '1 byte', 'c', 4),
('Proklamasi Kemerdekaan Indonesia dibacakan pada tanggal...', '17 Agustus 1944', '17 Agustus 1945', '20 Mei 1945', '10 November 1945', 'b', 5);

-- -------------------------------------
-- Tabel Hasil Tes CBT (satu baris per siswa)
-- -------------------------------------
CREATE TABLE hasil_cbt (
    id_siswa INT PRIMARY KEY,
    jumlah_benar INT DEFAULT 0,
    total_soal INT DEFAULT 0,
    nilai DECIMAL(5,2) DEFAULT 0,
    waktu_selesai TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_siswa) REFERENCES calon_siswa(id_siswa)
);

-- -------------------------------------
-- Tabel Prestasi Akademik (sertifikat)
-- -------------------------------------
CREATE TABLE prestasi (
    id_prestasi INT AUTO_INCREMENT PRIMARY KEY,
    id_siswa INT NOT NULL,
    nama_prestasi VARCHAR(150) NOT NULL,
    tingkat ENUM('Sekolah','Kabupaten/Kota','Provinsi','Nasional','Internasional') DEFAULT 'Sekolah',
    file_sertifikat VARCHAR(255),
    dibuat_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_siswa) REFERENCES calon_siswa(id_siswa)
);
