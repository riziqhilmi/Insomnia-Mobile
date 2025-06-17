import 'package:get/get.dart';

class LocalizationService extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          "mulai": "Start",
          "tentang aplikasi": "About Application",
          "hello": "Hello US",
          "buat akun baru": "Create New Account",
          "berhasil": "Successfully",
          "registrasi berhasil!": "Registration Successful!",
          "registrasi gagal coba lagi.": "Registration failed, please try again.",
          "terjadi kesalahan saat menghubungi server.": "An error occurred while contacting the server.",
          "gagal": "Failed",
          "mendaftar": "Register",
          "nama lengkap": "Full Name",
          "nama tidak boleh kosong": "Name cannot be empty",
          "nama belakang": "Last Name",
          "nama belakang tidak boleh kosong": "Last name cannot be empty",
          "jenis Kelamin": "Gender",
          "pilih jenis kelamin":"Select gender",
          "laki-laki":"Male",
          "perempuan":"Female",
          "tanggal lahir": "Date of Birth",
          "tanggal lahir wajib diisi": "Date of birth is required",
          "nomor telepon": "Phone Number",
          "telepon wajib diisi": "Phone number is required",
          "email": "Email",
          "email tidak valid": "Invalid email address",
          "kata sandi": "Password",
          "minimal 6 karakter": "Minimum 6 characters",
          "konfirmasi kata sandi": "Confirm Password",
          "kata sandi tidak cocok": "Passwords do not match",
          "daftar": "Register",
          "sudah punya akun?": "Already have an account?",
          "masuk": "Login",
          "selamat datang kembali": "Welcome back",
          "masuk ke akun anda": "Login to your account",
          "masukkan email anda": "Enter your email address",
          "masukkan kata sandi anda": "Enter your password",
          "lupa kata sandi?": "Forgot Password?",
          "belum punya akun?": "Don't have an account yet?",
          "login berhasil!": "Login Successful!",
          "login gagal": "Login Failed",
          "login gagal, silakan coba lagi": "Login failed, please try again",
          "terjadi kesalahan saat login'": "An error occurred while logging in",
          "selamat Datang 🌙":"Welcome 🌙",
          "tidurlah malam ini untuk hari esok yang lebih baik.": "Sleep tonight for a better tomorrow.",
          "statistik": "Statistics",
          "edukasi": "Education",
          "berita terkini tentang tidur": "Latest News on Sleep",
          "fitur berita masih dalam pengembangan.": "News feature is still under development.",
          "tips tidur sehat": "Healthy Sleep Tips",
          "beranda": "Home",
          "prediksi": "Prediction",
          "saya":"Me",
          "edit profil pengguna": "Edit User Profile",
          "keamanan & privasi": "Security & Privacy",
          "tentang_aplikasi": "About Application",
          "keluar akun": "Logout Account",
          "versi: 1.0.0": "version: 1.0.0",
          "insomnic adalah aplikasi yang dirancang untuk membantu pengguna memahami dan mengatasi masalah insomnia. aplikasi ini menyediakan informasi seputar pola tidur, edukasi, prediksi kualitas tidur, serta grafik statistik yang mudah dipahami.": "Insomnic is an application designed to help users understand and address insomnia issues. It provides information on sleep patterns, education, sleep quality predictions, and easy-to-understand statistical graphs.",
          "dikembangkan oleh": "Developed by",
          "tim insomnic": "Insomnic Team",
          "kontak": "Contact",
          "hak cipta": "Copyright",
          "kebijakan privasi": "Privacy Policy",
          "data pengguna tidak disimpan atau dibagikan ke pihak ketiga.": "User data is not stored or shared with third parties.",
          "tidur dan bangun di waktu yang sama setiap hari.": "Sleep and wake up at the same time every day.",
          "hindari kafein dan alkohol menjelang tidur.": "Avoid caffeine and alcohol before bedtime.",
          "ciptakan suasana kamar yang tenang, gelap, dan sejuk.": "Create a calm, dark, and cool bedroom environment.",
          "hindari penggunaan gadget 1 jam sebelum tidur.": "Avoid using gadgets 1 hour before bedtime.",
          "lakukan relaksasi seperti meditasi atau pernapasan dalam.": "Practice relaxation techniques like meditation or deep breathing.",
          "batasi tidur siang maksimal 30 menit.": "Limit naps to a maximum of 30 minutes.",
          "rutin berolahraga, tetapi hindari olahraga berat menjelang tidur.": "Exercise regularly, but avoid heavy workouts before bedtime.",
          "gunakan kasur dan bantal yang nyaman.": "Use a comfortable mattress and pillows.",
          "jika tidak bisa tidur, bangunlah dan lakukan aktivitas ringan.": "If you can't sleep, get up and do a light activity.",
          "buat rutinitas sebelum tidur, seperti membaca atau mandi air hangat.": "Establish a bedtime routine, such as reading or taking a warm bath.",
          "profil":"Profile",
          "kebiasaan":"Habit",
          "tidur":"Sleep",
          "kondisi":"Condition",
          "profil anda":"Your profile",
          "pilih tahun akademik":"Select Academic Year",
          "tahun akademik":"Academic Year",
          "tahun pertama":"First Year",
          "tahun kedua": "Second Year",
          "tahun ketiga": "Third Year",
          "mahasiswa pascasarjana":"Graduate Student",
          "klasifikasi":"Classification",
          "lanjut":"Next",
          "sebelumnya":"Previously",
          "kebiasaan tidur":"Sleeping habits",
          "kesulitan tidur":"Difficulty Sleeping",
          "pilih frekuensi":"Select Frequency",
          "tidak pernah":"Never",
          "jarang":"Seldom",
          "kadang-kadang":"Sometimes",
          "sering":"Always",
          "selalu":"Often",
          "penggunaan perangkat sebelum tidur":"Use Of Devices Before Bed",
          "kebiasaan sehari-hari":"Daily Habits",
          "klasifikasi tidur":"sleep classification",
          "konsumsi kafein":"Caffeine Consumption",
          "tips untuk anda":"Tips For You",
          "tutup":"Close",
          "kembali":"Return",
          "tingkat insomnia:":"insomnia level",
          "hasil klasifikasi":"Classified Results",
          "jarang (1-2 kali/minggu)":"Rarely (1-2 times/week)",
          "kadang-kadang (3-4/minggu)":"Sometimes (3-4/week)",
          "sering (5-6 kali/minggu)":"Frequently (5-6 times/week)",
          "setiap hari":"Everyday",
          "lama tidur (jam)":"Length of sleep (hours)",
          "pilih lama tidur":"Select Sleep Duration",
          "lebih dari 8 jam":"More than 8 hours",
          "7-8 jam":"7-8 hours",
          "6-7 jam":"6-7 hours",
          "5-6 jam":"5-6 hours",
          "4-5 jam":"4-5 hours",
          "kurang dari 4 jam":"Less than 4 hours",
          "kurang dari 5 jam":"Less than 5 hours",
          "terbangun di malam hari":"Awake at Night",
          "kualias tidur":"Sleep Quality",
          "pilih kualias tidur":"Select Sleep Quality",
          "sangat baik":"Very Good",
          "baik":"Good",
          "cukup":"Fair",
          "buruk":"Poor",
          "sangat buruk":"Very Poor",
          "kondisi mental":"Mental Condition",
          "kesulitan konsentrasi":"Difficulty Concentrating",
          "kelelahan":"Disorders",
          "ketidak hadiran kuliah":"Class Absence",
          "jarang (1-2 kali/bulan)":"Rarely (1-2 times/month)",
          "tingkat stres":"Stres Level",
          "pilih tingkat stres":"Select Stres Level",
          "tidak stress":"Not Stressed",
          "stress rendah":"Low Stress",
          "stress sedang":"Moderate Stress",
          "stress tinggi":"High Stress",
          "sangat tinggi":"Very High Stress",
          "performa akademik":"Academic Performance",
          "pilih performa": "Select Performance",
          "dibawah rata-rata":"Below Average",
          "terjadi kesalahan": "An error occurred",
          "tidak ada insomnia": "No Insomnia",
          "risiko insomnia":" Insomnia Risk",
          "hasil tidak diketahuoi": "Results are unknown",
          "tidak ada tips yang tersedia untuk hasil ini": "No tips available for this result",
          "data tidak lengkap":"Incomplete data",
          "harap isi semua field sebelum melakukan klasifikasi":"Please fill in all fields before classifying",
          "aktivitas olahraga": "Exercise Activity",


          "email tidak  boleh kosong": "Email cannot be empty",
          "email harus mengandung tanda @": "Email must contain @",
          "lupa pasword": "Forgot Password",
          "masukkan email anda untuk reset password": "Enter your email to reset password",
          "kirim": "Send",
          "masukkan email yang valid": "Please enter a valid email address",
          "permintaan reset password berhasil dikirim!": "Password reset request sent successfully!",
          "terjadi kesalahan, silakan coba lagi.":"An error occurred, please try again.",
          "terjadi kesalahan jaringan, silakan coba lagi. 000":"Network error, please try again. 000",
          "otp baru telah dikirim ke":"A new otp has been sent to",
          "verifikasi berhasil!":"Verification successful!",
          "kode verifikasi salah atau kadaluarsa.":"Verification code is incorrect or expired.",
          "gagal menghubungi server.":"Failed to contact server.",
          "terjadi kesalahan:":"An error occurred:",
          "verifikasi email":"email verification",
          "kode verifikasi telah dikirim ke":"Verification code has been sent to",
          "kirim ulang kode dalam":"Resend code in",
          "kirim ulang Kode":"Resend Code",
          "verifikasi":"Verification",
          "mohon isi kode OTP dengan lengkap": "Please fill in the OTP code completely",

          



          
          
        




         
          

          

















         







          "bahasa": "Languages",
          "pengaturan": "Settings",
          "pilih_bahasa": "Choose Languages",
          "Pilih bahasa pilihan Anda untuk melanjutkan": "Choose your preferred language to continue",
          "bantuan": "Help",
          "keluar_desk": "Are you sure want to logout?",
          "keluar": "Logout",
          "batal": "Cancel",
          "iya": "Yes",
          },
        'id_ID': {
          "mulai": "Mulai",
          "hello": "Hello ID",
          "buat akun baru": "Buat Akun Baru",
          "berhasil": "Berhasil",
          "registrasi berhasil!": "Registrasi Berhasil!",
          "registrasi gagal coba lagi.": "Registrasi gagal, silakan coba lagi.",
          "terjadi kesalahan saat menghubungi server.": "Terjadi kesalahan saat menghubungi server.",
          "gagal": "Gagal",
          "mendaftar": "Daftar",
          "nama lengkap": "Nama Lengkap",
          "nama tidak boleh kosong": "Nama tidak boleh kosong",
          "nama belakang": "Nama Belakang",
          "nama belakang tidak boleh kosong": "Nama belakang tidak boleh kosong",
          "jenis Kelamin": "Jenis Kelamin",
          "pilih jenis kelamin": "Pilih Jenis Kelamin",
          "laki-laki": "Laki-laki",
          "perempuan": "Perempuan",
          "tanggal lahir": "Tanggal Lahir",
          "tanggal lahir wajib diisi": "Tanggal lahir wajib diisi",
          "nomor telepon": "Nomor Telepon",
          "telepon wajib diisi": "Nomor telepon wajib diisi",
          "email": "Email",
          "email tidak valid": "Email tidak valid",
          "kata sandi": "Kata Sandi",
          "minimal 6 karakter": "Minimal 6 karakter",
          "konfirmasi kata sandi": "Konfirmasi Kata Sandi",
          "kata sandi tidak cocok": "Kata sandi tidak cocok",
          "daftar": "Daftar",
          "sudah punya akun?": "Sudah punya akun?",
          "masuk": "Masuk",
          "selamat datang kembali": "Selamat datang kembali",
          "masuk ke akun anda": "Masuk ke akun Anda",
          "masukkan email anda": "Masukkan email Anda",
          "masukkan kata sandi anda": "Masukkan kata sandi Anda",
          "lupa kata sandi?": "Lupa Kata Sandi?",
          "belum punya akun?": "Belum punya akun?",
          "login berhasil!": "Login Berhasil!",
          "login gagal": "Login Gagal",
          "login gagal, silakan coba lagi": "Login gagal, silakan coba lagi",
          "terjadi kesalahan saat login": "Terjadi kesalahan saat login",
          "selamat Datang 🌙": "Selamat Datang 🌙",
          "tidurlah malam ini untuk hari esok yang lebih baik.": "Tidurlah malam ini untuk hari esok yang lebih baik.",
          "statistik": "Statistik",
          "edukasi": "Edukasi",
          "berita terkini tentang tidur": "Berita Terkini tentang Tidur",
          "fitur berita masih dalam pengembangan.": "Fitur berita masih dalam pengembangan.",
          "tips tidur sehat": "Tips Tidur Sehat",
          "beranda": "Beranda",
          "prediksi": "Prediksi",
          "saya": "Saya",
          "edit profil pengguna": "Edit Profil Pengguna",
          "keamanan & privasi": "Keamanan & Privasi",
          "tentang_aplikasi": "Tentang Aplikasi",
          "keluar akun": "Keluar Akun",
          "versi: 1.0.0": "versi: 1.0.0",
          "insomnic adalah aplikasi yang dirancang untuk membantu pengguna memahami dan mengatasi masalah insomnia. aplikasi ini menyediakan informasi seputar pola tidur, edukasi, prediksi kualitas tidur, serta grafik statistik yang mudah dipahami.": "Insomnic adalah aplikasi yang dirancang untuk membantu pengguna memahami dan mengatasi masalah insomnia. Aplikasi ini menyediakan informasi seputar pola tidur, edukasi, prediksi kualitas tidur, serta grafik statistik yang mudah dipahami.",
          "dikembangkan oleh": "Dikembangkan oleh",
          "tim insomnic": "Tim Insomnic",
          "kontak": "Kontak",
          "hak cipta": "Hak Cipta",
          "kebijakan privasi": "Kebijakan Privasi",
          "data pengguna tidak disimpan atau dibagikan ke pihak ketiga.": "Data pengguna tidak disimpan atau dibagikan ke pihak ketiga.",
          "tidur dan bangun di waktu yang sama setiap hari.": "Tidur dan bangun di waktu yang sama setiap hari.",
          "hindari kafein dan alkohol menjelang tidur.": "Hindari kafein dan alkohol menjelang tidur.",
          "ciptakan suasana kamar yang tenang, gelap, dan sejuk.": "Ciptakan suasana kamar yang tenang, gelap, dan sejuk.",
          "hindari penggunaan gadget 1 jam sebelum tidur.": "Hindari penggunaan gadget 1 jam sebelum tidur.",
          "lakukan relaksasi seperti meditasi atau pernapasan dalam.": "Lakukan relaksasi seperti meditasi atau pernapasan dalam.",
          "batasi tidur siang maksimal 30 menit.": "Batasi tidur siang maksimal 30 menit.",
          "rutin berolahraga, tetapi hindari olahraga berat menjelang tidur.": "Rutin berolahraga, tetapi hindari olahraga berat menjelang tidur.",
          "gunakan kasur dan bantal yang nyaman.": "Gunakan kasur dan bantal yang nyaman.",
          "jika tidak bisa tidur, bangunlah dan lakukan aktivitas ringan.": "Jika tidak bisa tidur, bangunlah dan lakukan aktivitas ringan.",
          "buat rutinitas sebelum tidur, seperti membaca atau mandi air hangat.": "Buat rutinitas sebelum tidur, seperti membaca atau mandi air hangat.",
          "profil":"Profil",
          "kebiasaan":"Kebiasaan",
          "tidur":"Tidur",
          "kondisi":"Kondisi",
          "profil anda":"Profil Anda",
          "tahun akademik":"Tahun Akademik",
          "pilih tahun akademik":"Pilih Tahun Akademik",
          "tahun pertama":"Tahun Pertama",
          "tahun kedua":"Tahun Kedua",
          "tahun ketiga":"Tahun Ketiga",
          "mahasiswa pascasarjana":"Mahasiswa Pascasarjana",
          "klasifikasi":"Klasifikasi",
          "lanjut":"Lanjut",
          "sebelumnya":"Sebelumnya",
          "kebiasaan tidur":"Kebiasaan Tidur",
          "kesulitan tidur":"Kesulitan Tidur",
          "pilih frekuensi":"Pilih Frekuensi",
          "tidak pernah":"Tidak Pernah",
          "jarang":"Jarang",
          "kadang-kadang":"Kadang-kadang",
          "sering":"Sering",
          "selalu":"Selalu",
          "penggunaan perangkat sebelum tidur":"Penggunaan Perangkat Sebelum Tidur",
          "Kebiasaan sehari-hari":"Kebiasaan Sehari-hari",
          "klasifikasi tidur":"Klasifikasi Tidur",
          "konsumsi kafein":"Konsumsi Kafein",
          "tips untuk anda":"Tips Untuk Anda",
          "tutup":"Tutup",
          "kembali":"Kembali",
          "tingkat insomnia:":"Tingkat Insomnia:",
          "hasil klasifikasi":"Hasil Klasifikasi",
          "jarang (1-2 kali/minggu)":"Jarang (1-2 kali/minggu)",
          "kadang-kadang (3-4/minggu)":"Kadang-kadang (3-4/minggu)",
          "sering (5-6 kali/minggu)":"Sering (5-6 kali/minggu)",
          "setiap hari":"Setiap hari",
          "lama tidur (jam)":"Lama Tidur (jam)",
          "pilih lama tidur":"Pilih Lama Tidur",
          "lebih dari 8 jam":"Lebih dari 8 jam",
          "7-8 jam":"7-8 jam",
          "6-7 jam":"6-7 jam",
          "5-6 jam":"5-6 jam",
          "4-5 jam":"4-5 jam",
          "kurang dari 4 jam":"Kurang dari 4 jam",
          "kurang dari 5 jam":"Kurang dari 5 jam",
          "terbangun di malam hari":"Terbangun di Malam Hari",
          "kualias tidur":"Kualitas Tidur",
          "pilih kualias tidur":"Pilih Kualitas Tidur",
          "sangat baik":"Sangat Baik",
          "baik":"Baik",
          "cukup":"Cukup",
          "buruk":"Buruk",
          "sangat buruk":"Sangat Buruk",
          "kondisi mental":"Kondisi Mental",
          "kesulitan konsentrasi":"Kesulitan Konsentrasi",
          "kelelahan":"Kelelahan",
          "ketidak hadiran kuliah":"Ketidakhadiran Kuliah",
          "jarang (1-2 kali/bulan)":"Jarang (1-2 kali/bulan)",
          "tingkat stres":"Tingkat Stres",
          "pilih tingkat stres":"Pilih Tingkat Stres",
          "tidak stress":"Tidak Stres",
          "stress rendah":"Stres Rendah",
          "stress sedang":"Stres Sedang",
          "stress tinggi":"Stres Tinggi",
          "sangat tinggi":"Sangat Tinggi",
          "performa akademik":"Performa Akademik",
          "pilih performa": "Pilih Performa",
          "dibawah rata-rata":"Di bawah rata-rata",
          "terjadi kesalahan": "Terjadi kesalahan",
          "tidak ada insomnia": "Tidak ada insomnia",
          "risiko insomnia":"Risiko Insomnia",
          "hasil tidak diketahuoi": "Hasil tidak diketahui",
          "tidak ada tips yang tersedia untuk hasil ini": "Tidak ada tips yang tersedia untuk hasil ini",
          "data tidak lengkap":"Data tidak lengkap",
          "harap isi semua field sebelum melakukan klasifikasi":"Harap isi semua field sebelum melakukan klasifikasi",
          "aktivitas olahraga": "Aktivitas Olahraga",


          "email tidak  boleh kosong": "Email tidak boleh kosong",
          "email harus mengandung tanda @": "Email harus mengandung tanda @",
          "lupa pasword": "Lupa Password",
          "masukkan email anda untuk reset password": "Masukkan email Anda untuk reset password",
          "kirim": "Kirim",
          "masukkan email yang valid": "Masukkan email yang valid",
          "permintaan reset password berhasil dikirim!": "Permintaan reset password berhasil dikirim!",
          "terjadi kesalahan, silakan coba lagi.": "Terjadi kesalahan, silakan coba lagi.",
          "terjadi kesalahan jaringan, silakan coba lagi. 000": "Terjadi kesalahan jaringan, silakan coba lagi. 000",
          "otp baru telah dikirim ke": "OTP baru telah dikirim ke",
          "verifikasi berhasil!": "Verifikasi berhasil!",
          "kode verifikasi salah atau kadaluarsa.": "Kode verifikasi salah atau kadaluarsa.",
          "gagal menghubungi server.": "Gagal menghubungi server.",
          "terjadi kesalahan:": "Terjadi kesalahan:",
          "verifikasi email": "Verifikasi Email",
          "kode verifikasi telah dikirim ke":"Kode verifikasi telah dikirim ke",
          "kirim ulang kode dalam": "Kirim ulang kode dalam",
          "kirim ulang Kode": "Kirim ulang Kode",
          "verifikasi": "Verifikasi",
          "mohon isi kode OTP dengan lengkap": "Mohon isi kode OTP dengan lengkap",

          
          


          





         


          







          



















          "bahasa": "Bahasa",
          "pengaturan": "Pengaturan",
          "pilih_bahasa": "Pilih Bahasa",
          "Pilih bahasa pilihan Anda untuk melanjutkan": "Pilih bahasa pilihan Anda untuk melanjutkan",
          "bantuan": "Bantuan", 
          "keluar_desk": "Apakah anda yakin untuk keluar?",
          "batal": "Batal",
          "iya": "Iya",
         }
      };
}