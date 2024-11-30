// Mengambil elemen-elemen dari HTML
const submitButton = document.querySelector('.submit-btn'); // Tombol 'Tambah Transaksi'
const overlayConfirm = document.getElementById('confirmation'); // Elemen overlay konfirmasi
const noButton = document.querySelector('.no-btn'); // Tombol 'No' di overlay konfirmasi
const yesButton = document.querySelector('.yes-btn'); // Tombol 'Yes' di overlay konfirmasi
const overlaySukses = document.getElementById('transaction-added'); // Elemen overlay sukses
const okButton = document.querySelector('.ok-btn'); // Tombol 'OK' di overlay sukses
const formnya = document.querySelector('form'); // Formulir utama
const container = document.querySelector(".container"); // Elemen utama untuk efek blur

// Menampilkan overlay konfirmasi ketika tombol submit diklik
submitButton.addEventListener('click', function (event) {
    event.preventDefault(); // Mencegah submit default
    overlayConfirm.classList.remove('hidden'); // Menampilkan overlay konfirmasi
    container.classList.add('blurred'); // Memberikan efek blur pada elemen utama
});

// Menyembunyikan overlay konfirmasi ketika tombol 'No' diklik
noButton.addEventListener('click', function () {
    overlayConfirm.classList.add('hidden'); // Menyembunyikan overlay konfirmasi
    container.classList.remove('blurred'); // Menghilangkan efek blur
});

// Submit form dan menampilkan overlay sukses setelah tombol 'Yes' diklik
yesButton.addEventListener('click', function (event) {
    event.preventDefault(); // Mencegah form refresh halaman
    overlayConfirm.classList.add('hidden'); // Menyembunyikan overlay konfirmasi

    // Simulasikan pengiriman data form
    setTimeout(() => {
        // Form dianggap berhasil dikirim
        overlaySukses.classList.remove('hidden'); // Menampilkan overlay sukses
    }, 100); // Berikan sedikit jeda untuk simulasi proses pengiriman

    container.classList.add('blurred'); // Tambahkan efek blur
});

// Menyembunyikan overlay sukses ketika tombol 'OK' diklik
okButton.addEventListener('click', function () {
    overlaySukses.classList.add('hidden'); // Menyembunyikan overlay sukses
    container.classList.remove('blurred'); // Menghilangkan efek blur
});
