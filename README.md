# CrashArena - Roblox Hangar & Cyber City Arena 🏎️💥

CrashArena adalah game arena pertarungan mobil fiksi ilmiah di Roblox. Repositori ini berisi skrip permainan dan pemetaan struktur game tree yang disinkronkan secara real-time menggunakan **Rojo**.

---

## 📁 Struktur Repositori

Untuk memudahkan pemeliharaan (*maintenance*) dan penambahan fitur baru, repositori ini ditata dengan bersih:

*   **`scripts/`**: Seluruh skrip Lua aktif yang dipetakan ke dalam game.
    *   **`Workspace/`**: Skrip yang berjalan langsung di dunia visual (Lobby & Arena).
        *   `Lobby/ShowcaseCar/VehicleRotator.lua`: Menganimasikan mobil pajangan agar berputar konstan.
        *   `Dev_Arena_CyberCity/`: Berisi skrip interaktif pintu gerbang / portal teleportasi.
    *   **`ServerStorage/`**: Skrip game server, termasuk aset peta cadangan.
        *   `Maps/Arena_CyberCity/Obstacles/`: Rintangan interaktif di arena:
            *   `NeonRamp_NW/` & `NeonRamp_SE/`: Skrip Booster Pad untuk meluncurkan mobil.
            *   `CentralLaserHazards/`: Skrip Laser berputar yang memberikan damage pada player.
            *   `Barrel_Hub_*/` & `Barrel_Stunt_*/`: Skrip ledakan tong berbasis fisika.
*   **`tools/`**: Skrip utilitas internal untuk ekstraksi dan sinkronisasi awal.
*   **`default.project.json`**: Konfigurasi sinkronisasi Rojo dengan opsi aman `ignoreUnknownInstances` agar tidak merusak visual map Anda di Studio.
*   **`tree.json`**: Representasi lengkap pohon hierarki game (*game tree*) sebagai panduan arsitektur.

---

## 🚀 Panduan Pengembangan & Auto-Sync (Rojo)

Proyek ini telah dikonfigurasi dengan **Rojo** agar Anda dapat mengedit kode menggunakan editor eksternal (seperti VS Code) dan langsung menyinkronkannya ke Roblox Studio secara instan.

### Memulai Sinkronisasi:
1.  Buka repositori ini di VS Code.
2.  Jalankan server Rojo dengan menekan **Ctrl + Shift + P**, ketik `Rojo: Start Server`, lalu pilih `default.project.json`.
3.  Buka proyek Anda di **Roblox Studio**, masuk ke tab **Plugins** -> buka panel **Rojo** -> klik **Connect**.
4.  Setiap kali Anda menekan tombol **Save (Ctrl + S)** pada file skrip di VS Code, kodenya akan langsung ter-update secara otomatis di Roblox Studio!

---

## 🛠️ Tips Menambahkan Fitur Baru

Untuk menambahkan fitur baru agar kode tetap rapi dan mudah dirawat:
1.  **Gunakan ModuleScripts:** Jika membuat sistem game besar (seperti sistem skor, pemilihan mobil, atau sistem ronde), letakkan kode modular di `ReplicatedStorage` atau `ServerScriptService` agar reusable.
2.  **Pertahankan Skrip di Folder yang Tepat:** Selalu simpan file skrip `.lua` baru Anda di bawah folder `scripts/Workspace/` atau `scripts/ServerStorage/` sesuai dengan lokasinya di Roblox Studio agar Rojo mendeteksinya secara otomatis.
3.  **Gunakan Git Workflow:** Lakukan commit kecil setelah berhasil menyelesaikan satu fitur, misalnya:
    ```bash
    git add .
    git commit -m "feat: Menambahkan sistem power-up kecepatan"
    git push origin main
    ```

---

Selamat mengembangkan **CrashArena**! Proyek ini sudah siap untuk di-scale menjadi game yang sangat besar dan seru! 🚗💨
