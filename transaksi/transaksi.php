<?php
    session_start();
    
    if(isset($_SESSION['username'])){
        include '../config/db.php';
    } else {
        header("location: ../index.php");
        exit();
    }
?>

<?php
    $pageTitle = "Transaksi"; 
    include '../layouts/header.php'; 
?>

<h2 class="mt-3"><i class="fa-solid fa-cart-shopping"></i> <b>Transaksi</b></h2>
    <hr>
    <?php 
    include '../config/db.php';

    $keyword = '';
    if(isset($_GET['keyword'])) {
        $keyword = $_GET['keyword'];
        $sql = "SELECT * FROM iqbal_tb_transaksi WHERE iqbal_id_transaksi LIKE '%$keyword%'";
    } else {
        $sql = "SELECT * FROM iqbal_tb_transaksi";
    }

    $result = mysqli_query($conn, $sql);
    if (!$result){
        die("Error: ". $sql . "<br>". mysqli_error($conn));
    }
    ?>
    <div class="row">
        <div class="col-md-6">
            <form action="" method="GET" class="mb-3">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control" value="<?php echo $keyword; ?>" placeholder="Cari berdasarkan ID transaksi">
                    <button type="submit" class="btn btn-outline-primary"><i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
            </form>
        </div>
        <div class="col-md-6 text-end">
            <button type="button" class="btn btn-outline-secondary mb-3 float-start" data-bs-toggle="modal" data-bs-target="#filterModal">
                    <i class="fa-solid fa-calendar-days"></i>
            </button>
            <a href="downloadRekapTransaksi.php" class="btn btn-outline-warning mb-3 mx-2"><i class="fa-solid fa-file-excel"></i> Rekap Data Transaksi</a>
            <a href="formTambahTransaksi.php" class="btn btn-outline-success mb-3"><i class="fa-solid fa-cart-plus"></i> Tambah Transaksi</a>
        </div>
    </div>
    <table class="table table-hover" align="center">
        <tr class="text-center">
            <th class="text-center" width="5%">No</th>
            <th>ID Transaksi</th>
            <th>ID User</th>
            <th>Waktu Transaksi</th>
            <th>Status</th>
            <th width="20%">Tindakan</th>
        </tr>
        <?php 
        $no = 1;
        foreach ($result as $row):
        ?>
            <tr>
                <td class="text-center"><?= $no++ ?></td>
                <td class="text-center">T-<?= $row['iqbal_id_transaksi'] ?></td>
                <td class="text-center">U-<?= $row['iqbal_id_user'] ?></td>
                <td class="text-center"><?= $row['iqbal_tanggal'] ?></td>
                <td class="text-center">
                    <?php 
                        if ($row['iqbal_status'] == 0) {
                            echo 'Belum Selesai';
                        } elseif ($row['iqbal_status'] == 1) {
                            echo 'Selesai';
                        } else {
                            echo 'Tidak Diketahui / Error';
                        }
                    ?>
                </td>
                </td>
                <td class="text-center">
                    <a href="detailTransaksi.php?id_transaksi=<?= $row['iqbal_id_transaksi'] ?>" class="btn btn-outline-info"><i class="fa-solid fa-circle-info"></i> Detail</a>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>
<?php include '../layouts/footer.php'; ?>