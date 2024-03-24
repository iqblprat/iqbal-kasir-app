<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../assets/icon/css/all.css">
    <title>Tambah Transaksi</title>
</head>
<body>
<div class="container">
    <h2 class="mt-3"><i class="fa-solid fa-boxes-packing"></i> <b>Tambah Data Transaksi</b></h2>
    <hr>
    <a href="transaksi.php" class="btn btn-outline-secondary my-2"><i class="fa-solid fa-arrow-left"></i> Kembali</a>
    <form action="tambahTransaksi.php" method="POST">
        <div class="row">
            <div class="col-6">
                <div class="form-group my-2">
                    <label for="tanggal">Tanggal</label>
                    <input type="datetime-local" name="tanggal" class="form-control" required>
                </div>
            </div>
            <div class="col-6">
                <div class="form-group my-2">
                    <label for="id">User</label>
                    <input type="text" class="form-control" readonly>
                </div>
            </div>
        </div>
        <div class="form-group my-2">
            <label for="total">Total Bayar</label>
            <input type="text" name="total" placeholder="Masukkan Nomimal Total" class="form-control" required>
        </div>
        <div class="form-group my-2">
            <label for="tunai">Tunai</label>
            <input type="text" name="tunai" placeholder="Masukkan Nominal Tunai" class="form-control" required>
        </div>
        <div class="form-group my-2">
            <label for="kembali">Kembali</label>
            <input type="text" name="kembali" placeholder="Masukkan Nominal Kembali" class="form-control" required>
        </div>             
        <button type="submit" class="btn btn-outline-success" value="tambah">Tambah</button>
    </form>
</div>
<script>
    var tanggalInput = document.querySelector('input[type="datetime-local"]');

    var now = new Date();

    var tahun = now.getFullYear();
    var bulan = String(now.getMonth() + 1).padStart(2, '0');
    var tanggal = String(now.getDate()).padStart(2, '0');
    var jam = String(now.getHours()).padStart(2, '0');
    var menit = String(now.getMinutes()).padStart(2, '0');
    var tanggalWaktu = tahun + '-' + bulan + '-' + tanggal + 'T' + jam + ':' + menit;

    tanggalInput.value = tanggalWaktu;
</script>
</body>
</html>