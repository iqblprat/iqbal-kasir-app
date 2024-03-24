<?php
include '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $id = $_GET['id'];

    $sql = "SELECT * FROM iqbal_tb_user WHERE iqbal_id_user ='$id'";
    $result = mysqli_query($conn, $sql);
    $row = mysqli_fetch_assoc($result);

    if ($row['iqbal_id_role'] == 1) {
        echo "<script>alert('Penghapusan data user dengan role Admin tidak diizinkan.');
              window.location.href='user.php';
              </script>";
        exit();
    }

    $sql = "DELETE FROM iqbal_tb_user WHERE iqbal_id_user ='$id'";
    if (mysqli_query($conn, $sql)) {
        echo "<script>alert('Data berhasil dihapus!');
                      window.location.href='user.php';
                      </script>";
    } else {
        echo "<script>alert('Data gagal dihapus. Error: " . mysqli_error($conn) . "');
                      window.location.href='user.php';
                      </script>";
    }
} else {
    echo "<script>alert('Tidak valid.');
                  window.location.href='user.php';
                  </script>";
}
?>
