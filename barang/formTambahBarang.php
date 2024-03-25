<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/icon/css/all.css" rel="stylesheet">
    <title>Tambah Data Barang</title>
</head>
<body>
<div class="container" method="POST">
        <h2 class="mt-3">Tambah Data Barang</h2>
        <hr>
        <a href="barang.php" class="btn btn-outline-secondary my-2"><i class="fa-solid fa-arrow-left"></i> Kembali</a>
        <form action="tambahBarang.php" method="POST" width="75%">
            <div class="form-group my-2">
                <label for="barang">Nama Barang</label>
                <input type="text" name="nama" placeholder="Masukkan Nama Barang" class="form-control" required>
            </div>
            <div class="form-group my-2">
                <label for="harga">Harga Barang (IDR)</label>
                <div class="input-group">
                    <span class="input-group-text">Rp</span>
                    <input type="number" name="harga" class="form-control" aria-label="" required>
                    <span class="input-group-text">,00</span>
                </div>
            </div>
            <div class="form-group my-2">
                <label for="harga">Stok Barang</label>
                <input type="number" name="stok" placeholder="Masukkan Stok Barang" class="form-control" required>
            </div>            
            <button type="submit" class="btn btn-outline-success" value="tambah"><i class="fa-regular fa-square-plus"></i> Tambah</button>
        </form>
    </div>
</body>
</html>