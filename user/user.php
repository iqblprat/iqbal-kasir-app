<?php 
$pageTitle = "Data User";
include '../layouts/header.php'; 
?>
    <h2 class="mt-3"><i class="fa-solid fa-user"></i> <b>User</b></h2>
    <hr>
    <?php 
    include '../config/db.php';

    $keyword = '';
    if(isset($_GET['keyword'])) {
        $keyword = $_GET['keyword'];
        $sql = "SELECT * FROM iqbal_tb_user WHERE iqbal_nama LIKE '%$keyword%'";
    } else {
        $sql = "SELECT * FROM iqbal_tb_user";
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
                    <input type="text" name="keyword" class="form-control" value="<?php echo $keyword; ?>" placeholder="Cari berdasarkan nama">
                    <button type="submit" class="btn btn-outline-primary"><i class="fa-solid fa-magnifying-glass"></i></button>
                </div>
            </form>
        </div>
        <div class="col-md-6">
            <a href="formTambahUser.php" class="btn btn-outline-success mb-3 float-end"><i class="fa-solid fa-user-plus"></i> Tambah Data</a>
        </div>
    </div>
    <table class="table table-hover" align="center">
        <tr class="text-center">
            <th class="text-center" width="5%">No</th>
            <th>Nama</th>
            <th>Role</th>
            <th>Username</th>
            <th>Password</th>
            <th>Status</th>
            <th width="20%">Tindakan</th>
        </tr>
        <?php 
        $no = 1;
        foreach ($result as $row):
        ?>
            <tr>
                <td class="text-center"><?= $no++ ?></td>
                <td class="text-center"><?= $row['iqbal_nama']?></td>
                <td class="text-center">
                    <?php 
                        if ($row['iqbal_id_role'] == 1) {
                            echo 'Admin';
                        } elseif ($row['iqbal_id_role'] == 2) {
                            echo 'Petugas/Kasir';
                        } else {
                            echo 'Role Tidak Diketahui';
                        }
                    ?>
                </td>
                <td class="text-center"><?= $row['iqbal_username']?></td>
                <td class="text-center">Password Ter-enkripsi</td>
                <td class="text-center"><?= $row['iqbal_status']?></td>
                <td class="text-center">
                    <a href="formEditUser.php?id=<?= $row['iqbal_id_user'] ?>" class="btn btn-outline-warning"><i class="fa-solid fa-user-pen"></i> Edit</a>
                    <a href="hapusUser.php?id=<?= $row['iqbal_id_user'] ?>" class="btn btn-outline-danger ml-1" <?php if($row['iqbal_id_role'] == 1) echo 'disabled'; ?> onclick="return confirm('Apakah anda yakin akan menghapus data ini?')" <?php if($row['iqbal_id_role'] == 1) echo 'title="Penghapusan data user dengan role Admin tidak diizinkan"'; ?>><i class="fa-solid fa-user-minus"></i> Hapus</a>
                </td>
            </tr>
        <?php endforeach; ?>
    </table>
<?php include '../layouts/footer.php'; ?>