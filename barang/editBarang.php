<?php
include '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id = $_POST['id'];
    $nama = $_POST['nama'];
    $harga = $_POST['harga'];
    $stok = $_POST['stok'];

    $sql = "UPDATE iqbal_tb_barang SET iqbal_nama_barang='$nama', iqbal_harga_barang='$harga', iqbal_stok_barang='$stok' WHERE iqbal_id_barang='$id'";

    if (mysqli_query($conn, $sql)) {
        echo "<script>alert('Data berhasil diperbarui!');
                      window.location.href='barang.php';
                      </script>";
    } else {
        echo "<script>alert('Data gagal diperbarui. Error: " . mysqli_error($conn) . "');
                      window.location.href='editBarang.php?id=$id';
                      </script>";
    }
} else {
    echo "<script>alert('Tidak valid.');
                  window.location.href='editBarang.php?id=$id';
                  </script>";
}
?>
