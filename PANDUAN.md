# Panduan menyiapkan Kelas Arka (website sendiri)

Website ini bisa dibuka Arka tanpa akun apa pun. Isinya ada dua bagian:

- **Database (Supabase, gratis)** untuk menyimpan pelajaran, pesan, dan nilai Arka. Bagian ini dibuat oleh Mama.
- **Hosting (GitHub Pages, gratis)** supaya website punya alamat sendiri. Mama cukup membuat tempatnya, sisanya Claude yang mengisi.

Kira-kira butuh 15 menit.

---

## Bagian A: Database (Supabase)

1. Buka **https://supabase.com**, tekan **Start your project**, lalu daftar (paling mudah pakai akun GitHub atau email).
2. Tekan **New project**.
   - Name: `kelas-arka`
   - Database Password: buat bebas dan simpan (tidak perlu dikirim ke Claude).
   - Region: **Southeast Asia (Singapore)**
   - Tekan **Create new project**, lalu tunggu sekitar 1–2 menit.
3. Di menu kiri, buka **SQL Editor**, lalu tekan **New query**.
   Buka file `setup.sql`, salin **semua** isinya, tempel di sana, lalu tekan **Run**.
   Kalau muncul "Success. No rows returned", berarti berhasil. Langkah ini sekaligus mengisi 5 pelajaran kelas 3.
4. Buat akun login Mama:
   **Authentication → Users → Add user → Create new user**
   Isi email dan kata sandi Mama, centang **Auto Confirm User**, lalu tekan **Create user**.
   Email dan kata sandi ini yang dipakai untuk membuka "Halaman Mama" di website. Jangan dikirim ke Claude.
5. Supaya orang lain tidak bisa daftar:
   **Authentication → Sign In / Providers** (di beberapa tampilan namanya **Settings**), lalu matikan **Allow new users to sign up** dan tekan **Save**.
6. Buka **Project Settings → API** (atau **Data API**), lalu salin dua hal ini dan kirim ke Claude di thread:
   - **Project URL**, contohnya `https://abcdxyz.supabase.co`
   - **anon public key**, berupa tulisan panjang yang diawali `eyJ...`

   Kunci *anon public* ini memang dibuat untuk dipasang di website, jadi aman dibagikan. Yang **jangan** dikirim adalah kunci **service_role**.

## Bagian B: Alamat website (GitHub Pages)

1. Masuk ke **https://github.com** dengan akun Mama.
2. Buka **https://github.com/new**
   - Repository name: `kelas-arka`
   - Pilih **Public**. GitHub Pages gratis hanya untuk repo publik. Isinya hanya kode tampilan, sedangkan nilai Arka tetap aman di database.
   - Tekan **Create repository**.
3. Pastikan Claude boleh mengakses repo itu: buka https://claude.ai/connect-github lalu izinkan repo `kelas-arka`.
4. Kabari Claude di thread: "repo sudah dibuat".

Setelah itu Claude akan mengunggah website dan menyalakan GitHub Pages. Alamatnya nanti seperti:
**https://christinaadewii-gitcollab.github.io/kelas-arka/**

---

## Cara Arka memakai

- Buka alamat website di browser HP, tablet, atau laptop.
- Supaya muncul ikon seperti aplikasi: di Android (Chrome) pilih menu ⋮ → **Tambahkan ke layar utama**. Di iPhone/iPad (Safari) pilih **Bagikan → Tambah ke Layar Utama**.
- Tidak perlu login. Nilai otomatis terkirim ke Mama.

## Cara Mama memakai

- Buka website yang sama, lalu tekan **🔒 Untuk Mama** di bawah dan masuk dengan email serta kata sandi dari langkah A4.
- Di sana Mama bisa melihat nilai, menambah atau mengubah pelajaran, dan menulis pesan untuk Arka.
- Tekan **Keluar** kalau Mama memakai perangkat Arka, supaya Arka tidak masuk ke Halaman Mama.
