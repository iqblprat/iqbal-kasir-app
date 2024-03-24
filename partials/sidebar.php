<?php
$current_page = basename($_SERVER['PHP_SELF']);

if (session_status() == PHP_SESSION_NONE) {
    session_start();
}

if (!isset($_SESSION['iqbal_id_role'])) {
    header("Location: index.php");
    exit();
}

$user_role = $_SESSION['iqbal_id_role'];
?>

<div class="col-md-2 border-end bg-white rounded shadow" id="sidebar-wrapper">
    <div class="sidebar-heading border-bottom text-center my-2"><i class="fa-solid fa-cash-register"></i> <b class="">Kasir</b></div>
    <div class="list-group list-group-flush">
        <a class="list-group-item list-group-item-action p-3 <?php echo ($current_page == 'beranda.php') ? 'active' : ''; ?>" href=""><i class="fa-solid fa-house"></i> Beranda</a>
        
        <?php if ($user_role == 1) : ?>
            <a class="list-group-item list-group-item-action p-3 <?php echo ($current_page == 'barang.php') ? 'active' : ''; ?>" href="../barang/barang.php"><i class="fa-solid fa-boxes-stacked"></i> Barang <small class="badge rounded-pill text-bg-secondary float-end">Admin</small></a>
            <a class="list-group-item list-group-item-action p-3 <?php echo ($current_page == 'user.php') ? 'active' : ''; ?>" href="../user/user.php"><i class="fa-solid fa-users"></i> User <small class="badge rounded-pill text-bg-secondary float-end">Admin</small></a>
            <!-- <a class="list-group-item list-group-item-action p-3 <?php echo ($current_page == 'logUser.php') ? 'active' : ''; ?>" href=""><i class="fa-solid fa-users-rectangle"></i> Log User <small class="badge rounded-pill text-bg-secondary float-end">Admin</small></a> -->
        <?php endif; ?>
        
        <a class="list-group-item list-group-item-action p-3 <?php echo ($current_page == 'transaksi.php') ? 'active' : ''; ?>" href="../transaksi/transaksi.php"><i class="fa-solid fa-cart-shopping"></i> Transaksi</a>
    </div>
    <div class="list-group list-group-flush bottom-0 w-100">
        <a class="list-group-item list-group-item-action p-3 <?php echo ($current_page == 'logout.php') ? 'active' : ''; ?>" href="../logout.php" onclick="return confirm('Apakah anda yakin akan logout?')"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
    </div>
</div>