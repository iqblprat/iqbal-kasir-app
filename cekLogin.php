<?php
session_start();
include "config/db.php";

$username = $_POST['username'];
$password = $_POST['password'];

$sql = "SELECT * FROM iqbal_tb_user WHERE iqbal_username = '$username'";
$query = mysqli_query($conn, $sql);

if (mysqli_num_rows($query) != 0) {
    $data = mysqli_fetch_array($query);

    if (password_verify($password, $data['iqbal_password'])) {
        $updateLog = "UPDATE iqbal_tb_user SET iqbal_status = 'Login' WHERE iqbal_username = '$username'";
        $update = mysqli_query($conn, $updateLog);

        $_SESSION['username'] = $data['iqbal_username'];
        $_SESSION['password'] = $data['iqbal_password'];
        $_SESSION['iqbal_id_user'] = $data['iqbal_id_user'];
        
        if ($data['iqbal_id_role'] == '1') {
            $_SESSION['iqbal_id_role'] = '1';
            $_SESSION['LOGIN'] = "LOGIN";
            header("location: admin/admin.php");
        } elseif ($data['iqbal_id_role'] == '2') {
            $_SESSION['iqbal_id_role'] = '2';
            $_SESSION['LOGIN'] = "LOGIN";
            header("location: petugas/petugas.php");
        }
    } else {
        echo "<br>Password salah";
        echo "<a href=index.php> Kembali</a>";
    }
} else {
    echo "<br>Login gagal";
    echo "<a href=index.php> Kembali</a>";
}
?>