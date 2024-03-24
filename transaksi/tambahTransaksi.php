<?php
session_start();
include '../config/db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $keranjang = isset($_SESSION['keranjang']) ? $_SESSION['keranjang'] : array();
    
    $total = 0;
    foreach ($keranjang as $item) {
        $subtotal = $item['harga'] * $item['qty'];
        $total += $subtotal;
    }
    
    $id_user = $_SESSION['iqbal_id_user'];

    $sql_transaksi = "INSERT INTO iqbal_tb_transaksi (iqbal_id_user, iqbal_total, iqbal_status) VALUES ('$id_user', '$total', '0')";
    $result_transaksi = mysqli_query($conn, $sql_transaksi);

    if ($result_transaksi) {
        $id_transaksi_baru = mysqli_insert_id($conn);

        foreach ($keranjang as $item) {
            $id_barang = $item['id'];
            $qty = $item['qty'];
            $subtotal_barang = $item['harga'] * $qty;

            $sql_detail = "INSERT INTO iqbal_tb_detail (iqbal_id_transaksi, iqbal_id_barang, iqbal_qty, iqbal_subtotal) VALUES ('$id_transaksi_baru', '$id_barang', '$qty', '$subtotal_barang')";
            $result_detail = mysqli_query($conn, $sql_detail);
            if (!$result_detail) {
                echo "Error: " . $sql_detail . "<br>" . mysqli_error($conn);
                exit;
            }
        }

        unset($_SESSION['keranjang']);
        // header("Location: transaksi.php");
        header("Location: formPembayaran.php?id_transaksi=$id_transaksi_baru");
        exit;
    } else {
        echo "Error: " . $sql_transaksi . "<br>" . mysqli_error($conn);
    }
}
?>
