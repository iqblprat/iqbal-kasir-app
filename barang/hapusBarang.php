<?php
include '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $id = $_GET['id'];

    $sql = "DELETE FROM iqbal_tb_barang WHERE iqbal_id_barang ='$id'";

    if (mysqli_query($conn, $sql)) {
        echo "<script>alert('Data berhasil dihapus!');
                      window.location.href='barang.php';
                      </script>";
    } else {
        echo "<script>alert('Data gagal dihapus. Error: " . mysqli_error($conn) . "');
                      window.location.href='barang.php';
                      </script>";
    }
} else {
    echo "<script>alert('Tidak valid.');
                  window.location.href='barang.php';
                  </script>";
}

?>