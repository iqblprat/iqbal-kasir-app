<?php
session_start();
include '../config/db.php';

if(isset($_GET['id_transaksi'])) {
    $id_transaksi = $_GET['id_transaksi'];

    $sql_detail_barang = "SELECT b.iqbal_nama_barang, b.iqbal_harga_barang, d.iqbal_qty, d.iqbal_subtotal 
                          FROM iqbal_tb_detail d 
                          INNER JOIN iqbal_tb_barang b ON d.iqbal_id_barang = b.iqbal_id_barang 
                          WHERE d.iqbal_id_transaksi = '$id_transaksi'";
    $result_detail_barang = mysqli_query($conn, $sql_detail_barang);

    if(mysqli_num_rows($result_detail_barang) > 0) {
        $total = 0;
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/icon/css/all.css">
    <title>Form Pembayaran</title>
</head>
<body>
    <div class="container mt-2">
        <h2><i class="fa-solid fa-money-bill-wave"></i> Form Pembayaran</h2>
        <hr>
        <!-- <a href="formTambahTransaksi.php" class="btn btn-outline-secondary my-2 disable"><i class="fa-solid fa-arrow-left"></i> Kembali</a> -->
        <table class="table table-hover">
            <tr>
                <th>Nama Barang</th>
                <th>Qty</th>
                <th>Harga Satuan</th>
                <th>Subtotal</th>
            </tr>
            <?php while ($row = mysqli_fetch_assoc($result_detail_barang)): ?>
                <tr>
                    <td><?= $row['iqbal_nama_barang'] ?></td>
                    <td><?= $row['iqbal_qty'] ?></td>
                    <td>Rp <?= number_format($row['iqbal_harga_barang'], 2, ',', '.') ?></td>
                    <td>Rp <?= number_format($row['iqbal_subtotal'], 2, ',', '.') ?></td>
                </tr>
                <?php 
                $total += $row['iqbal_subtotal'];
                ?>
            <?php endwhile; ?>
            <tr>
                <td colspan="3" class="text-end"><b>Total</b></td>
                <td colspan="3"><b>Rp <?= number_format($total, 2, ',', '.') ?></b></td>
            </tr>
            <tr>
                <td colspan="3" class="text-end"><b>Tunai</b></td>
                <td colspan="3" class="w-25">
                    <form action="prosesPembayaran.php" method="POST" onsubmit="return validatePayment()">
                        <input type="hidden" class="form-control" name="id_transaksi" value="<?= $id_transaksi ?>">
                        <div class="input-group">
                            <span class="input-group-text"><b>Rp</b></span>
                            <input type="number" name="uang_diterima" id="uang_diterima" class="form-control" aria-label="" required>
                            <span class="input-group-text"><b>,00</b></span>
                        </div>
                </td>
            </tr>
        </table>
        <button type="submit" class="btn btn-outline-success mt-2 float-end" onclick="return confirm('Apakah Anda yakin ingin melanjutkan? Pastikan uang yang diterima sudah sesuai.')">
            <i class="fa-solid fa-money-bill-1-wave"></i> Selesaikan Pembayaran
        </button>
        </form>
    </div>
    <script>
        function validatePayment() {
            var total = <?= $total ?>;
            var uangDiterima = document.getElementById('uang_diterima').value;
            
            if (uangDiterima < total) {
                alert('Tunai tidak mencukupi.');
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
<?php
    } else {
        echo "Transaksi tidak ditemukan.";
    }
} else {
    echo "Parameter id_transaksi tidak ditemukan dalam URL.";
}
?>