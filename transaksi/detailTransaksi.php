<?php
session_start();
include '../config/db.php';

$id_transaksi = $_GET['id_transaksi'];

$sql_detail_transaksi = "SELECT t.*, d.*, b.iqbal_nama_barang, b.iqbal_harga_barang, t.iqbal_id_user, u.iqbal_nama 
                         FROM iqbal_tb_transaksi t 
                         INNER JOIN iqbal_tb_detail d ON t.iqbal_id_transaksi = d.iqbal_id_transaksi 
                         INNER JOIN iqbal_tb_barang b ON d.iqbal_id_barang = b.iqbal_id_barang 
                         INNER JOIN iqbal_tb_user u ON t.iqbal_id_user = u.iqbal_id_user 
                         WHERE t.iqbal_id_transaksi = '$id_transaksi'";
$result_detail_transaksi = mysqli_query($conn, $sql_detail_transaksi);

if ($result_detail_transaksi) {
    $total_harga = 0;
    $jumlah_barang = 0;
    $id_transaksi = "";
    $id_user = "";
    $tanggal_transaksi = "";
    $nama_user = "";
    while ($row = mysqli_fetch_assoc($result_detail_transaksi)) {
        $subtotal = $row['iqbal_qty'] * $row['iqbal_harga_barang'];
        $total_harga += $subtotal;
        $jumlah_barang += $row['iqbal_qty'];
        $id_transaksi = $row['iqbal_id_transaksi'];
        $id_user = $row['iqbal_id_user'];
        $tanggal_transaksi = $row['iqbal_tanggal'];
        $nama_user = $row['iqbal_nama'];
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/icon/css/all.css">
    <title>Detail Transaksi</title>
</head>
<body>
    <div class="container mt-2">
        <h2><i class="fa-solid fa-receipt"></i> Detail Transaksi</h2>
        <hr>
        <div class="row">
            <div class="col-md-6">
                <a href="transaksi.php" class="btn btn-outline-secondary my-2"><i class="fa-solid fa-arrow-left"></i> Kembali</a>
            </div>
            <div class="col-md-6">
                <a href="cetakStrukTransaksi.php" class="btn btn-outline-dark my-2 float-end"><i class="fa-solid fa-receipt"></i> Cetak Struk Transaksi</a>
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-md-4 text-start"><b>ID Transaksi:</b> <?= $id_transaksi ?></div>
            <div class="col-md-4 text-center"><b>User:</b> <?= $nama_user ?></div>
            <div class="col-md-4 text-end"><b>Tanggal Transaksi:</b> <?= $tanggal_transaksi ?></div>
        </div>
        <table class="table table-hover">
            <thead>
                <tr>
                    <th>No</th>
                    <th>Nama Barang</th>
                    <th>Harga Satuan</th>
                    <th>Qty</th>
                    <th>Subtotal</th>
                </tr>
            </thead>
            <tbody>
                <?php
                $no = 1;
                mysqli_data_seek($result_detail_transaksi, 0);
                while ($row = mysqli_fetch_assoc($result_detail_transaksi)) {
                    $subtotal = $row['iqbal_qty'] * $row['iqbal_harga_barang'];
                ?>
                    <tr>
                        <td><?= $no++ ?></td>
                        <td><?= $row['iqbal_nama_barang'] ?></td>
                        <td>Rp <?= number_format($row['iqbal_harga_barang'], 2, ',', '.') ?></td>
                        <td><?= $row['iqbal_qty'] ?></td>
                        <td>Rp <?= number_format($subtotal, 2, ',', '.') ?></td>
                    </tr>
                <?php } ?>
                <tr>
                    <td colspan="4" class="text-end"><b>Total Harga (<?= $jumlah_barang ?> barang)</b></td>
                    <td><b>Rp <?= number_format($total_harga, 2, ',', '.') ?></b></td>
                </tr>
                <tr>
                    <td colspan="4" class="text-end"><b>Total Belanja</b></td>
                    <td><b>Rp <?= number_format($total_harga, 2, ',', '.') ?></b></td>
                </tr>
                <?php
                $sql_transaksi = "SELECT * FROM iqbal_tb_transaksi WHERE iqbal_id_transaksi = '$id_transaksi'";
                $result_transaksi = mysqli_query($conn, $sql_transaksi);
                $row_transaksi = mysqli_fetch_assoc($result_transaksi);
                if ($row_transaksi) {
                ?>
                <tr>
                    <td colspan="4" class="text-end"><b>Tunai</b></td>
                    <td><b>Rp <?= number_format($row_transaksi['iqbal_tunai'], 2, ',', '.') ?></b></td>
                </tr>
                <tr>
                    <td colspan="4" class="text-end"><b>Kembalian</b></td>
                    <td><b>Rp <?= number_format($row_transaksi['iqbal_kembali'], 2, ',', '.') ?></b></td>
                </tr>
                <?php } ?>
            </tbody>
        </table>
    </div>
</body>
</html>

<?php
} else {
    echo "Error: " . $sql_detail_transaksi . "<br>" . mysqli_error($conn);
}
?>