// Mengambil elemen-elemen dari HTML
const overlaySukses = document.getElementById('transaction-added'); // Elemen overlay sukses
const okButton = document.querySelector('.ok-btn'); // Tombol 'OK' di overlay sukses
const formnya = document.querySelector('form'); // Formulir utama
const container = document.querySelector(".page-container"); // Elemen utama untuk efek blur


// Menyembunyikan overlay sukses ketika tombol 'OK' diklik
okButton.addEventListener('click', function () {
    overlaySukses.classList.add('hidden'); // Menyembunyikan overlay sukses
    container.classList.remove('blurred'); // Menghilangkan efek blur
});
