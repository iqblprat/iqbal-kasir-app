<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="../assets/css/style.css" rel="stylesheet">
        <link rel="stylesheet" href="../assets/icon/css/all.css" rel="stylesheet">
        <title>Edit Data Barang</title>
    </head>
<body>
    <div class="container">
        <h2 class="mt-3"><b>Edit Data Barang</b></h2>
        <hr>
        <a href="barang.php" class="btn btn-outline-secondary my-2"><i class="fa-solid fa-arrow-left"></i> Kembali</a>
        <?php
        include '../config/db.php';

        if (isset($_GET['id'])) {
            $id = $_GET['id'];

            $sql = "SELECT * FROM iqbal_tb_barang WHERE iqbal_id_barang = '$id'";
            $result = mysqli_query($conn, $sql);
            $row = mysqli_fetch_assoc($result);

            if ($row) {
                $nama = $row['iqbal_nama_barang'];
                $harga = $row['iqbal_harga_barang'];
                $stok = $row['iqbal_stok_barang'];

                ?>
                <form action="editBarang.php" method="POST">
                    <input type="hidden" name="id" value="<?php echo $id; ?>">
                    <div class="form-group my-2">
                        <label for="nama">Nama Barang</label>
                        <input type="text" name="nama" value="<?php echo $nama; ?>" class="form-control" required>
                    </div>
                    <div class="form-group my-2">
                        <label for="harga">Harga Barang (IDR)</label>
                        <div class="input-group">
                            <span class="input-group-text">Rp</span>
                            <input type="number" name="harga" value="<?php echo $harga; ?>" class="form-control" aria-label="" required>
                            <span class="input-group-text">,00</span>
                        </div>
                    </div>
                    <div class="form-group my-2">
                        <label for="harga">Stok Barang</label>
                        <input type="number" name="stok" value="<?php echo $stok; ?>" class="form-control" required>
                    </div>
                    <button type="submit" class="btn btn-outline-primary"><i class="fa-solid fa-floppy-disk"></i> Simpan</button>
                </form>
                <?php
            } else {
                echo "Data barang tidak ditemukan.";
            }
        } else {
            echo "ID barang tidak ditemukan.";
        }
        ?>
    </div>
</body>
</html>
