<?php 
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'iqbal_db_kasir';

$conn = mysqli_connect($host, $username, $password, $database);

if (!$conn){
    echo 'Gagal Koneksi ke database.';
} else {
    // Koneksi Berhasil
}
?>