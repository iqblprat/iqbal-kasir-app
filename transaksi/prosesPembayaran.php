<?php
session_start();
include '../config/db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if(isset($_POST['id_transaksi']) && isset($_POST['uang_diterima'])) {
        $id_transaksi = $_POST['id_transaksi'];
        $uang_diterima = $_POST['uang_diterima'];

        $sql_transaksi = "SELECT iqbal_total FROM iqbal_tb_transaksi WHERE iqbal_id_transaksi = '$id_transaksi'";
        $result_transaksi = mysqli_query($conn, $sql_transaksi);
        $row_transaksi = mysqli_fetch_assoc($result_transaksi);
        
        if($row_transaksi) {
            $total_transaksi = $row_transaksi['iqbal_total'];
            $kembalian = $uang_diterima - $total_transaksi;

            $sql_update_transaksi = "UPDATE iqbal_tb_transaksi SET iqbal_status = '1', iqbal_kembali = '$kembalian', iqbal_tunai = '$uang_diterima' WHERE iqbal_id_transaksi = '$id_transaksi'";
            mysqli_query($conn, $sql_update_transaksi);

            // header("Location: transaksi.php");
            header("Location: detailTransaksi.php?id_transaksi=$id_transaksi");
            exit;
        } else {
            echo "Transaksi tidak ditemukan.";
        }
    } else {
        echo "Parameter tidak lengkap.";
    }
}
?>
