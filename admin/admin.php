<?php
    session_start();
    
    if(isset($_SESSION['username'])){
        include '../config/db.php';
    } else {
        header("location: ../index.php");
        exit();
    }
?>

<?php
    $pageTitle = "Admin"; 
    include '../layouts/header.php'; 
?>

    <h4 class="mt-2">Anda sudah berhasil login sebagai Admin</h4>

<?php include '../layouts/footer.php'; ?>