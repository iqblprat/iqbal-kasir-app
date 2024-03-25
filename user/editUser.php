<?php
include '../config/db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id = $_POST['id'];
    $nama = $_POST['nama'];
    $role = $_POST['role'];
    $username = $_POST['username'];
    $password = $_POST['password'];

    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    $sql = "UPDATE iqbal_tb_user SET iqbal_nama='$nama', iqbal_id_role='$role', iqbal_username='$username', iqbal_password='$hashed_password' WHERE iqbal_id_user='$id'";

    if (mysqli_query($conn, $sql)) {
        echo "<script>alert('Data berhasil diperbarui!');
                      window.location.href='user.php';
                      </script>";
    } else {
        echo "<script>alert('Data gagal diperbarui. Error: " . mysqli_error($conn) . "');
                      window.location.href='editUser.php?id=$id';
                      </script>";
    }
} else {
    echo "<script>alert('Tidak valid.');
                  window.location.href='editUser.php?id=$id';
                  </script>";
}
?>