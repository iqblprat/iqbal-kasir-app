<?php
include '../config/db.php';

if($_SERVER['REQUEST_METHOD'] == 'POST'){
    $nama = $_POST['nama'];
    $harga = $_POST['harga'];
    $stok = $_POST['stok'];

    $sql = "INSERT INTO iqbal_tb_barang (iqbal_nama_barang, iqbal_harga_barang, iqbal_stok_barang) VALUES ('$nama', '$harga', '$stok')";

    if (mysqli_query($conn, $sql)) {
        echo "<script>alert('Data berhasil ditambahkan!');
                      window.location.href='barang.php';
                      </script>";
    } else {
        echo "<script>alert('Data gagal ditambahkan. Error: " . mysqli_error($conn) . "');
                      window.location.href='formTambahBarang.php';
                      </script>";
    }
}
?>