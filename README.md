# Toko App

Aplikasi Flutter sederhana untuk latihan autentikasi dan navigasi dengan
`go_router`.

## Fitur

- Login dengan username dan password non-kosong (data autentikasi lokal/dummy).
- Route guard yang mengarahkan pengguna yang belum login ke halaman login.
- Daftar produk, halaman detail berdasarkan ID, dan halaman tidak ditemukan.
- Setelah login, aplikasi mengembalikan pengguna ke halaman yang semula diminta.

## Menjalankan aplikasi

```sh
flutter pub get
flutter run
```

Username dan password apa pun yang tidak kosong dapat digunakan. Status login
disimpan di memori dan akan dihapus ketika aplikasi ditutup.

## Pengujian

```sh
flutter analyze
flutter test
```
"# flutter-praktikum-p9-" 
