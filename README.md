# Aplikasi CLI Manajemen Distribusi dan Export UMKM

Aplikasi sederhana berbasis Command Line Interface (CLI) untuk mengatur distribusi dan manajemen ekspor UMKM. Dibangun menggunakan bahasa Dart dengan penerapan struktur data dan pemrograman berorientasi objek (OOP), seperti double linked list, binary tree, serta koleksi bawaan Dart seperti list, set, dan map.

---

## Struktur Project

```

.
├── bin/           # Entry point aplikasi (main.dart)
├── lib/           # Kode sumber utama aplikasi
├── pubspec.yaml   # Konfigurasi project dan dependencies
└── README.md      # Dokumentasi project ini

````

---

## Environment

- Dart SDK versi: `^3.5.4`

---

## Dependencies

```yaml
dependencies:
  dart_console: ^4.1.1
  cli_table: ^1.0.2
  # path: ^1.8.0

dev_dependencies:
  lints: ^4.0.0
  test: ^1.24.0
````

---

## Cara Instalasi

1. Pastikan Dart SDK sudah terinstall versi minimal 3.5.4.
   Bisa cek dengan:

   ```bash
   dart --version
   ```

2. Clone repository ini atau download source code.

3. Jalankan perintah untuk install dependencies:

   ```bash
   dart pub get
   ```

---

## Cara Menjalankan Aplikasi

1. Buka terminal/cmd di folder project.

2. Jalankan aplikasi dari folder `bin` dengan perintah:

   ```bash
   dart run bin/main.dart
   ```

3. Gunakan navigasi menu dengan tombol panah atas/bawah.

4. Tekan `ENTER` untuk memilih opsi menu.

5. Tekan `BACKSPACE` untuk keluar dari aplikasi.

---

## Fitur Utama

* Manajemen history dengan struktur data double linked list
* Navigasi data produk UMKM dengan binary tree
* Penggunaan list, set, dan map bawaan Dart untuk manajemen data
* Tampilan tabel rapi menggunakan `cli_table`
* Input dan output interaktif menggunakan `dart_console`

---

## Catatan

* Pastikan terminal mendukung input karakter khusus (panah, backspace, dll).
* Gunakan terminal yang kompatibel untuk hasil terbaik.

---

Kalau ada bug atau mau kontribusi, langsung aja fork dan bikin PR

---

© 2025 - Aplikasi CLI Export UMKM by Ridho

