<?php 
    include '../config/db.php';

    $keyword = '';
    if(isset($_GET['keyword'])) {
        $keyword = $_GET['keyword'];
        $sql = "SELECT * FROM iqbal_tb_transaksi WHERE iqbal_id_transaksi LIKE '%$keyword%'";
    } else {
        if(isset($_GET['startDate']) && isset($_GET['endDate'])) {
            $startDate = $_GET['startDate'];
            $endDate = $_GET['endDate'];
            $sql = "SELECT * FROM iqbal_tb_transaksi WHERE iqbal_tanggal BETWEEN '$startDate' AND '$endDate'";
        } else {
            $sql = "SELECT * FROM iqbal_tb_transaksi";
        }
    }

    $result = mysqli_query($conn, $sql);
    if (!$result){
        die("Error: ". $sql . "<br>". mysqli_error($conn));
    }
?>