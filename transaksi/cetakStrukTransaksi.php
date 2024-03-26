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
    <title>Struk Transaksi | ID: <?= $id_transaksi ?></title>
    <style>
        @font-face {
            font-family: 'Inconsolata';
            src: url('../assets/fonts/Inconsolata.ttf') format('truetype');
        }
        body {
            font-family: 'Inconsolata', monospace;
        }
    </style>
</head>
<body>
    <div class="container w-75">
        <h5 class="text-center my-auto"><b>GoodGet Shop</b></h5>
        <h5 class="text-center"><b>Jl. Kamarung No. 69 Kel. Citeurep Kec. Cimahi Utara <br>
            Kota Cimahi 40513</b>
        </h5>
        <hr>
        <div class="row">
            <div class="col-6">
                <b>ID Transaksi:</b> <?= $id_transaksi ?>
            </div>
            <div class="col-6 text-end">
                <b>Kasir:</b> <?= strtoupper($nama_user) ?> / <?= $id_user ?>
            </div>
        </div>
        <hr>
        <table class="table table-borderless">
            <thead>
                <tr class="">
                    <th>No</th>
                    <th>Nama Barang</th>
                    <th>Qty</th>
                    <th>Harga Satuan</th>
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
                        <td width="5%"><?= $no++ ?></td>
                        <td width="60%"><?= strtoupper($row['iqbal_nama_barang']) ?></td>
                        <td width="10%"><?= $row['iqbal_qty'] ?></td>
                        <td width="20%"><?= number_format($row['iqbal_harga_barang'], 0, '', ',') ?></td>
                        <td width="25%"><?= number_format($subtotal, 0, '', ',') ?></td>
                    </tr>
                <?php } ?>
                <tr>
                    <td colspan="4" class="text-end"><hr><b>Total Harga (<?= $jumlah_barang ?> item)</b></td>
                    <td><hr><b><?= number_format($total_harga, 0, '', '.') ?></b></td>
                </tr>
                <tr>
                    <td colspan="4" class="text-end"><b>Total Belanja</b></td>
                    <td><b><?= number_format($total_harga, 0, '', ',') ?></b></td>
                </tr>
                <?php
                $sql_transaksi = "SELECT * FROM iqbal_tb_transaksi WHERE iqbal_id_transaksi = '$id_transaksi'";
                $result_transaksi = mysqli_query($conn, $sql_transaksi);
                $row_transaksi = mysqli_fetch_assoc($result_transaksi);
                if ($row_transaksi) {
                ?>
                <tr>
                    <td colspan="4" class="text-end"><b>Tunai</b></td>
                    <td><b><?= number_format($row_transaksi['iqbal_tunai'], 0, '', ',') ?></b></td>
                </tr>
                <tr>
                    <td colspan="4" class="text-end"><b>Kembalian</b></td>
                    <td><b><?= number_format($row_transaksi['iqbal_kembali'], 0, '', ',') ?></b></td>
                </tr>
                <?php } ?>
            </tbody>
        </table>
        <hr>
        <div class="row">
            <div class="col-6">
                <b>Tgl. </b> <?= $tanggal_transaksi ?>
            </div>
            <div class="col-6 text-end">
                <b>V0.8.0</b>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-6">
                <b>Kritik & Saran:</b> iqblprat@gmail.com
            </div>
            <div class="col-6 text-end">
                <b>SMS/WA:</b> 082190502454
            </div>
        </div>
        <hr>
        <p class="text-center"><b>Terima kasih, Selamat berbelanja kembali</b></p>
    </div>
</body>
<script>
    window.print();

    window.onafterprint = function() {
        window.location.href = "detailTransaksi.php?id_transaksi=<?= $id_transaksi ?>";
    }
</script>
</html>

<?php
} else {
    echo "Error: " . $sql_detail_transaksi . "<br>" . mysqli_error($conn);
}
?>