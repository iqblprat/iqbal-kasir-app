<?php
include '../config/db.php';

if($_SERVER['REQUEST_METHOD'] == 'POST'){
    $nama = $_POST['nama'];
    $role = $_POST['role'];
    $username = $_POST['username'];
    $password = $_POST['password'];

    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    $sql = "INSERT INTO iqbal_tb_user (iqbal_nama, iqbal_id_role, iqbal_username, iqbal_password) VALUES ('$nama', '$role', '$username', '$hashed_password')";

    if (mysqli_query($conn, $sql)) {
        echo "<script>alert('Data berhasil ditambahkan!');
                      window.location.href='user.php';
                      </script>";
    } else {
        echo "<script>alert('Data gagal ditambahkan. Error: " . mysqli_error($conn) . "');
                      window.location.href='formTambahUser.php';
                      </script>";
    }
}
?>
