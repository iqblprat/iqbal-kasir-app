<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/icon/css/all.css" rel="stylesheet">
    <title>Edit Data User</title>
</head>
<body>
<div class="container" method="POST">
        <h2 class="mt-3"><i class="fa-solid fa-user-pen"></i> <b>Edit Data User</b></h2>
        <hr>
        <a href="user.php" class="btn btn-outline-secondary my-2"><i class="fa-solid fa-arrow-left"></i> Kembali</a>
        <?php
        include '../config/db.php';

        if (isset($_GET['id'])) {
            $id = $_GET['id'];

            $sql = "SELECT * FROM iqbal_tb_user WHERE iqbal_id_user = '$id'";
            $result = mysqli_query($conn, $sql);
            $row = mysqli_fetch_assoc($result);

            if ($row) {
                $nama = $row['iqbal_nama'];
                $role = $row['iqbal_id_role'];
                $username = $row['iqbal_username'];
                $password = $row['iqbal_password'];
                ?>
                <form action="editUser.php" method="POST" width="75%">
                    <input type="hidden" name="id" value="<?php echo $id; ?>">
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group my-2">
                                <label for="nama">Nama</label>
                                <input type="text" name="nama" placeholder="Nama" value="<?php echo $nama; ?>" class="form-control" required>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group my-2">
                                <label for="role">Role</label>
                                <select name="role" id="role" class="form-select">
                                    <option value="1" disabled>Admin</option>
                                    <option value="2">Petugas</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="form-group my-2">
                        <label for="username">Username</label>
                        <input type="text" name="username" placeholder="Username" value="<?php echo $username; ?>" class="form-control" required>
                    </div>
                    <div class="form-group my-2">
                        <label for="password">Password</label>
                        <input type="text" name="password" placeholder="Password" value="<?php echo $password; ?>" class="form-control" required>
                    </div>            
                    <button type="submit" class="btn btn-outline-primary"><i class="fa-solid fa-floppy-disk"></i> Simpan</button>
                </form>
                <?php
            } else {
                echo "Data User tidak ditemukan.";
            }
        } else {
            echo "ID User tidak ditemukan.";
        }
        ?>
    </div>
</body>
</html>