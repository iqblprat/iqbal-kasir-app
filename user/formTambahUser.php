<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/icon/css/all.css" rel="stylesheet">
    <title>Tambah Data User</title>
</head>
<body>
<div class="container" method="POST">
        <h2 class="mt-3"><i class="fa-solid fa-user-plus"></i> <b>Tambah Data User</b></h2>
        <hr>
        <a href="user.php" class="btn btn-outline-secondary my-2"><i class="fa-solid fa-arrow-left"></i> Kembali</a>
        <form action="tambahUser.php" method="POST" width="75%">
            <div class="row">
                <div class="col-6">
                    <div class="form-group my-2">
                        <label for="nama">Nama</label>
                        <input type="text" name="nama" placeholder="Masukkan Nama" class="form-control" required>
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
                <input type="text" name="username" placeholder="Masukkan Username" class="form-control" required>
            </div>
            <div class="form-group my-2">
                <label for="password">Password</label>
                <input type="text" name="password" placeholder="Masukkan Password" class="form-control" required>
            </div>            
            <button type="submit" class="btn btn-outline-success" value="tambah"><i class="fa-solid fa-user-plus"></i> Tambah</button>
        </form>
    </div>
</body>
</html>