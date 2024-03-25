<?php
session_start();

include '../config/db.php';

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $barang_id = $_POST['id'];
    $nama_barang = $_POST['nama'];
    $harga_barang = $_POST['harga'];
    
    $qty = 1;
    
    $sql_stok = "SELECT iqbal_stok_barang FROM iqbal_tb_barang WHERE iqbal_id_barang = $barang_id";
    $result_stok = mysqli_query($conn, $sql_stok);
    $row_stok = mysqli_fetch_assoc($result_stok);
    $stok_barang = $row_stok['iqbal_stok_barang'];

    if ($stok_barang > 0) {
        $index = false;
        if(isset($_SESSION['keranjang'])) {
            foreach ($_SESSION['keranjang'] as $key => $item) {
                if ($item['id'] == $barang_id) {
                    if (($item['qty'] + 1) <= $stok_barang) {
                        $_SESSION['keranjang'][$key]['qty'] += 1;
                    } else {
                        echo "<script>alert('Jumlah barang melebihi stok yang tersedia');</script>";
                    }
                    $index = true;
                    break;
                }
            }
        }

        if(!$index) {
            if ($qty <= $stok_barang) {
                $_SESSION['keranjang'][] = array(
                    'id' => $barang_id,
                    'nama' => $nama_barang,
                    'harga' => $harga_barang,
                    'qty' => $qty
                );
            } else {
                echo "<script>alert('Jumlah barang melebihi stok yang tersedia');</script>";
            }
        }
    } else {
        echo "<script>alert('Stok barang habis');</script>";
    }
}

if(isset($_GET['hapus'])) {
    $hapus_id = $_GET['hapus'];
    foreach ($_SESSION['keranjang'] as $key => $item) {
        if ($item['id'] == $hapus_id) {
            unset($_SESSION['keranjang'][$key]);
            break;
        }
    }
}

if(isset($_GET['clear'])) {
    unset($_SESSION['keranjang']);
    header("Location: formTambahTransaksi.php");
    exit;
}

$keyword = '';
if(isset($_GET['keyword'])) {
    $keyword = $_GET['keyword'];
    $sql = "SELECT * FROM iqbal_tb_barang WHERE iqbal_nama_barang LIKE '%$keyword%'";
} else {
    $sql = "SELECT * FROM iqbal_tb_barang";
}

$result = mysqli_query($conn, $sql);
if (!$result){
    die("Error: ". $sql . "<br>". mysqli_error($conn));
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../assets/icon/css/all.css">
    <title>Tambah Transaksi</title>
    <style>
        body {
            padding-top: 2px;
        }
        .container {
            position: relative;
        }
        .barang-container {
            border: 1px solid #ccc;
            padding: 10px;
            padding-top: 0px;
            margin-bottom: 20px;
            border-radius: 8px;
            overflow-y: auto;
            max-height: 300px;
        }
        .keranjang-container {
            border: 1px solid #ccc;
            padding: 10px;
            border-radius: 8px;
            margin-top: 20px;
        }
        .fixed-header {
            position: sticky;
            top: 0;
            background-color: #fff;
            z-index: 999;
            padding: 10px;
            margin-left: -10px;
            margin-right: -10px;
            border-bottom: 1px solid #ccc;
        }
        .barang-container::-webkit-scrollbar {
            width: 8px;
        }
        .barang-container::-webkit-scrollbar-thumb {
            background-color: #888;
            border-radius: 4px;
        }
    </style>
</head>
<body class="mb-4">
<div class="container">
    <h2 class="mt-3"><i class="fa-solid fa-boxes-packing"></i> <b>Tambah Transaksi</b></h2>
    <hr>
    <a href="transaksi.php" class="btn btn-outline-secondary my-2"><i class="fa-solid fa-arrow-left"></i> Kembali</a>
    <div class="barang-container">
        <div class="fixed-header">
            <h4><b>Pilih Barang</b></h4>
            <div class="row">
                <div class="col-md-12">
                    <form action="" method="GET" class="mb-3">
                        <div class="input-group">
                            <input type="text" name="keyword" class="form-control" value="<?php echo $keyword; ?>" placeholder="Cari berdasarkan nama barang">
                            <button type="submit" class="btn btn-outline-primary"><i class="fa-solid fa-magnifying-glass"></i></button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <table class="table table-hover">
            <tr class="text-center">
                <th class="text-center" width="5%">No</th>
                <th>Nama Barang</th>
                <th>Harga</th>
                <th>Stok</th>
                <th width="20%">Tindakan</th>
            </tr>
            <?php 
            $no = 1;
            foreach ($result as $row):
            ?>
                <tr>
                    <td class="text-center"><?= $no++ ?></td>
                    <td><?= $row['iqbal_nama_barang'] ?></td>
                    <td>Rp <?= number_format($row['iqbal_harga_barang'], 2, ',', '.') ?></td>
                    <td class="text-center"><?= $row['iqbal_stok_barang']?></td>
                    <td class="text-center">
                        <form action="" method="POST">
                            <input type="hidden" name="id" value="<?= $row['iqbal_id_barang'] ?>">
                            <input type="hidden" name="nama" value="<?= $row['iqbal_nama_barang'] ?>">
                            <input type="hidden" name="harga" value="<?= $row['iqbal_harga_barang'] ?>">
                            <button type="submit" class="btn btn-outline-success"><i class="fa-solid fa-basket-shopping"></i> Tambah</button>
                        </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </table>
    </div>
    <form action="tambahTransaksi.php" method="POST">
        <div class="keranjang-container">
            <h4><b>Detail Keranjang</b></h4>
            <?php if(isset($_SESSION['keranjang']) && count($_SESSION['keranjang']) > 0): ?>
                <table class="table table-hover">
                    <tr>
                        <th>Nama Barang</th>
                        <th>Harga</th>
                        <th>Qty</th>
                        <th>Subtotal</th>
                        <th>Aksi</th>
                    </tr>
                    <?php 
                    $total = 0;
                    foreach ($_SESSION['keranjang'] as $item): 
                        $subtotal = $item['harga'] * $item['qty'];
                        $total += $subtotal;
                    ?>
                        <tr>
                            <td><?= $item['nama'] ?></td>
                            <td>Rp <?= number_format($item['harga'], 2, ',', '.') ?></td>
                            <td><?= $item['qty'] ?></td>
                            <td>Rp <?= number_format($subtotal, 2, ',', '.') ?></td>
                            <td>
                                <a href="?hapus=<?= $item['id'] ?>" class="btn btn-outline-danger btn-sm"><i class="fa-solid fa-delete-left"></i> Hapus</a>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                    <tr>
                        <td class="text-end" colspan="3"><b>Total</b></td>
                        <td colspan="2"><b>Rp <?= number_format($total, 2, ',', '.') ?></b></td>
                    </tr>
                </table>
                <a href="?clear" class="btn btn-outline-danger" onclick="return confirm('Apakah anda yakin akan mengosongkan keranjang?')"><i class="fa-solid fa-eraser"></i> Clear Keranjang</a>
                <button type="submit" class="btn btn-outline-success float-end" onclick="return confirm('Apakah Anda yakin ingin melanjutkan proses checkout? Semua barang yang telah dimasukkan ke dalam keranjang akan dibeli.')"><i class="fa-solid fa-cart-plus"></i> Checkout</button>
            <?php else: ?>
                <p>Keranjang masih kosong.</p>
            <?php endif; ?>
        </div>
    </form>
</div>
</body>
</html>