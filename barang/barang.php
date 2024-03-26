<?php 
// session_start();
$pageTitle = "Data Barang";
// if (isset($_SESSION['LOGIN'])){

// }
include '../layouts/header.php'; 
?>

    <h2 class="mt-3"><i class="fa-solid fa-box"></i> <b>Barang</b></h2>
    <hr>
    <?php 
    include '../config/db.php';

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
    <div class="row">
        <div class="col-md-6">
            <form action="" method="GET" class="mb-3">
                <div class="input-group">
                    <input type="text" name="keyword" class="form-control" value="<?php echo $keyword; ?>" placeholder="Cari berdasarkan nama barang">
                    <button type="submit" class="btn btn-outline-primary"><i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
            </form>
        </div>
        <div class="col-md-6">
            <a href="formTambahBarang.php" class="btn btn-outline-success mb-3 float-end"><i class="fa-regular fa-square-plus"></i> Tambah Data</a>
        </div>
    </div>
    <table class="table table-hover">
        <tr class="text-center">
            <th class="text-center" width="5%">No</th>
            <th>Nama Barang</th>
            <th>ID Barang</th>
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
                <td><?= ucwords($row['iqbal_nama_barang']) ?></td>
                <td class="text-center">B-<?= $row['iqbal_id_barang'] ?></td>
                <td>Rp <?= number_format($row['iqbal_harga_barang'], 2, ',', '.') ?></td>
                <td class="text-center"><?= $row['iqbal_stok_barang']?></td>
                <td class="text-center">
                    <a href="formEditBarang.php?id=<?= $row['iqbal_id_barang'] ?>" class="btn btn-outline-warning"><i class="fa-solid fa-pen-to-square"></i> Edit</a>
                    <a href="hapusBarang.php?id=<?= $row['iqbal_id_barang'] ?>" class="btn btn-outline-danger ml-1" onclick="return confirm('Apakah anda yakin akan mengapus data ini?')"><i class="fa-solid fa-trash"></i> Hapus</a>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>

<?php include '../layouts/footer.php'; ?>