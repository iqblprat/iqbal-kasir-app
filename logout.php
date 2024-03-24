<?php
    session_start();
    include 'config/db.php';
    $username = $_SESSION['username'];

    $updateLog = "UPDATE iqbal_tb_user SET iqbal_status = 'Logout' WHERE iqbal_username = '$username'";
    mysqli_query($conn, $updateLog);

    session_destroy();
    header("location: index.php");
?>