-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 05 Mar 2024 pada 09.02
-- Versi server: 10.4.22-MariaDB
-- Versi PHP: 7.4.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `iqbal_db_kasir`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `kurangi_stok_barang` (IN `id` INT(11), IN `jumlah` INT(11))  UPDATE iqbal_tb_barang SET iqbal_tb_barang.iqbal_stok_barang = iqbal_tb_barang.iqbal_stok_barang - jumlah WHERE iqbal_tb_barang.iqbal_id_barang = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_stok_barang` (IN `id` INT(11), IN `jumlah` INT(11))  UPDATE iqbal_tb_barang SET iqbal_tb_barang.iqbal_stok_barang = iqbal_tb_barang.iqbal_stok_barang + jumlah WHERE iqbal_tb_barang.iqbal_id_barang = id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `iqbal_tb_barang`
--

CREATE TABLE `iqbal_tb_barang` (
  `iqbal_id_barang` int(11) NOT NULL,
  `iqbal_nama_barang` varchar(50) NOT NULL,
  `iqbal_harga_barang` int(11) NOT NULL,
  `iqbal_stok_barang` int(11) NOT NULL,
  `iqbal_updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `iqbal_tb_barang`
--

INSERT INTO `iqbal_tb_barang` (`iqbal_id_barang`, `iqbal_nama_barang`, `iqbal_harga_barang`, `iqbal_stok_barang`, `iqbal_updated_at`) VALUES
(1, 'mouse noir', 300000, 14, '2024-03-04 02:12:43'),
(2, 'keyboard zifriend', 400000, 4, '2024-02-26 03:26:37'),
(3, 'headphone rexus daxa', 550000, 6, '2024-02-27 00:24:17'),
(5, 'flashdisk sandisk', 50000, 2, '2024-03-05 07:54:45'),
(7, 'laptop axioo', 16000000, 4, '2024-03-05 06:09:30'),
(10, 'monitor aoc', 2000000, 15, '2024-03-05 00:42:51'),
(11, 'router tp-link', 250000, 3, '2024-03-04 06:16:09'),
(12, 'wlan receiver', 110000, 5, '2024-03-05 04:49:57');

--
-- Trigger `iqbal_tb_barang`
--
DELIMITER $$
CREATE TRIGGER `barang_hapus` AFTER DELETE ON `iqbal_tb_barang` FOR EACH ROW INSERT INTO iqbal_tb_log_barang (iqbal_id_barang, iqbal_nama_barang, iqbal_status, created_at) 
VALUES (OLD.iqbal_id_barang, OLD.iqbal_nama_barang, 'Hapus barang', NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `barang_masuk` AFTER INSERT ON `iqbal_tb_barang` FOR EACH ROW INSERT INTO iqbal_tb_log_barang (iqbal_id_barang, iqbal_nama_barang, iqbal_status, created_at)
    VALUES (NEW.iqbal_id_barang, NEW.iqbal_nama_barang, 'Tambah barang', NOW())
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `barang_ubah` BEFORE UPDATE ON `iqbal_tb_barang` FOR EACH ROW INSERT INTO iqbal_tb_log_barang (iqbal_id_barang, iqbal_nama_barang, iqbal_status, created_at)
    VALUES (NEW.iqbal_id_barang, NEW.iqbal_nama_barang, 'Ubah barang', NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `iqbal_tb_detail`
--

CREATE TABLE `iqbal_tb_detail` (
  `iqbal_id_detail` int(11) NOT NULL,
  `iqbal_id_transaksi` int(11) NOT NULL,
  `iqbal_id_barang` int(11) NOT NULL,
  `iqbal_qty` int(11) NOT NULL,
  `iqbal_subtotal` int(11) NOT NULL,
  `iqbal_created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `iqbal_tb_detail`
--

INSERT INTO `iqbal_tb_detail` (`iqbal_id_detail`, `iqbal_id_transaksi`, `iqbal_id_barang`, `iqbal_qty`, `iqbal_subtotal`, `iqbal_created_at`) VALUES
(2, 1, 1, 2, 600000, '2024-02-26 03:22:40'),
(3, 2, 2, 1, 400000, '2024-02-26 03:22:20'),
(4, 3, 1, 1, 300000, '2024-02-27 04:45:02');

--
-- Trigger `iqbal_tb_detail`
--
DELIMITER $$
CREATE TRIGGER `barang_keluar` AFTER INSERT ON `iqbal_tb_detail` FOR EACH ROW UPDATE iqbal_tb_barang 
SET iqbal_stok_barang = iqbal_stok_barang - new.iqbal_qty 
WHERE iqbal_id_barang = new.iqbal_id_barang
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `iqbal_tb_log`
--

CREATE TABLE `iqbal_tb_log` (
  `iqbal_id_log` int(11) NOT NULL,
  `iqbal_id_user` int(11) NOT NULL,
  `iqbal_status` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `iqbal_tb_log`
--

INSERT INTO `iqbal_tb_log` (`iqbal_id_log`, `iqbal_id_user`, `iqbal_status`, `created_at`) VALUES
(26, 1, 'Login', '2024-02-27 03:41:19'),
(27, 1, 'Login', '2024-02-27 03:45:35'),
(28, 1, 'Logout', '2024-02-27 03:45:38'),
(29, 1, 'Login', '2024-02-27 04:40:25'),
(30, 1, 'Login', '2024-02-27 06:07:35'),
(31, 1, 'Login', '2024-03-04 02:15:23'),
(32, 1, 'Login', '2024-03-04 06:52:04'),
(33, 1, 'Logout', '2024-03-04 06:52:12'),
(34, 2, 'Login', '2024-03-04 06:52:28'),
(35, 2, 'Logout', '2024-03-04 06:52:32'),
(36, 1, 'Login', '2024-03-05 00:19:44'),
(42, 3, '', '2024-03-05 01:31:24'),
(43, 3, '', '2024-03-05 01:31:29'),
(44, 4, '', '2024-03-05 01:37:09'),
(45, 4, '', '2024-03-05 01:42:59'),
(46, 1, 'Logout', '2024-03-05 02:22:52'),
(47, 4, 'Login', '2024-03-05 02:23:04'),
(48, 4, 'Logout', '2024-03-05 02:29:45'),
(49, 1, 'Login', '2024-03-05 02:29:49'),
(50, 1, 'Logout', '2024-03-05 02:30:54'),
(51, 4, 'Login', '2024-03-05 02:30:58'),
(52, 4, 'Logout', '2024-03-05 03:05:20'),
(53, 1, 'Login', '2024-03-05 03:05:24'),
(54, 1, 'Logout', '2024-03-05 03:48:14'),
(55, 4, 'Login', '2024-03-05 03:48:18'),
(56, 1, 'Login', '2024-03-05 03:52:58'),
(57, 4, 'Login', '2024-03-05 04:08:21'),
(58, 1, 'Logout', '2024-03-05 06:13:33'),
(59, 1, 'Login', '2024-03-05 06:13:42'),
(60, 1, 'Logout', '2024-03-05 06:56:37'),
(61, 1, 'Login', '2024-03-05 07:03:45'),
(62, 1, 'Login', '2024-03-05 07:51:38');

-- --------------------------------------------------------

--
-- Struktur dari tabel `iqbal_tb_log_barang`
--

CREATE TABLE `iqbal_tb_log_barang` (
  `iqbal_id_log` int(11) NOT NULL,
  `iqbal_id_barang` int(11) NOT NULL,
  `iqbal_nama_barang` varchar(50) NOT NULL,
  `iqbal_status` varchar(50) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `iqbal_tb_log_barang`
--

INSERT INTO `iqbal_tb_log_barang` (`iqbal_id_log`, `iqbal_id_barang`, `iqbal_nama_barang`, `iqbal_status`, `created_at`) VALUES
(1, 7, 'laptop axioo', 'Ubah barang', '2024-02-27 06:28:34'),
(2, 8, 'charger', 'Tambah barang', '2024-02-27 06:33:25'),
(3, 8, 'charger', 'Hapus barang', '2024-02-27 06:33:37'),
(4, 5, 'flashdisk sandisk', 'Ubah barang', '2024-02-27 06:51:05'),
(5, 9, 'fsefesf', 'Tambah barang', '2024-02-27 06:59:25'),
(6, 9, 'fsefesf', 'Hapus barang', '2024-02-27 06:59:29'),
(7, 1, 'mouse noir', 'Ubah barang', '2024-02-27 07:33:26'),
(8, 1, 'mouse noir', 'Ubah barang', '2024-02-27 07:33:39'),
(9, 1, 'mouse noir', 'Ubah barang', '2024-02-27 07:45:51'),
(10, 1, 'mouse noir', 'Ubah barang', '2024-02-27 07:46:04'),
(11, 1, 'mouse noir', 'Ubah barang', '2024-03-04 02:12:43'),
(12, 10, 'monitor aoc', 'Tambah barang', '2024-03-04 05:08:53'),
(13, 11, 'router tp-link', 'Tambah barang', '2024-03-04 06:16:09'),
(14, 12, 'wlan receiver', 'Tambah barang', '2024-03-04 06:16:32'),
(15, 13, 'headset', 'Tambah barang', '2024-03-04 06:16:52'),
(16, 10, 'monitor aoc', 'Ubah barang', '2024-03-04 06:36:34'),
(17, 10, 'monitor aoc', 'Ubah barang', '2024-03-05 00:42:51'),
(18, 12, 'wlan receiver', 'Ubah barang', '2024-03-05 04:49:57'),
(19, 7, 'laptop axioo', 'Ubah barang', '2024-03-05 06:09:30'),
(20, 5, 'flashdisk sandisk', 'Ubah barang', '2024-03-05 07:54:45'),
(21, 13, 'headset', 'Hapus barang', '2024-03-05 07:55:44');

-- --------------------------------------------------------

--
-- Struktur dari tabel `iqbal_tb_log_transaksi`
--

CREATE TABLE `iqbal_tb_log_transaksi` (
  `iqbal_id_log` int(11) NOT NULL,
  `iqbal_id_transaksi` int(11) NOT NULL,
  `iqbal_id_user` int(11) NOT NULL,
  `iqbal_status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `iqbal_tb_role`
--

CREATE TABLE `iqbal_tb_role` (
  `iqbal_id_role` int(11) NOT NULL,
  `iqbal_role` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `iqbal_tb_role`
--

INSERT INTO `iqbal_tb_role` (`iqbal_id_role`, `iqbal_role`) VALUES
(1, 'admin'),
(2, 'petugas');

-- --------------------------------------------------------

--
-- Struktur dari tabel `iqbal_tb_transaksi`
--

CREATE TABLE `iqbal_tb_transaksi` (
  `iqbal_id_transaksi` int(11) NOT NULL,
  `iqbal_id_user` int(11) NOT NULL,
  `iqbal_tanggal` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `iqbal_total` int(11) NOT NULL,
  `iqbal_tunai` int(11) NOT NULL,
  `iqbal_kembali` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `iqbal_tb_transaksi`
--

INSERT INTO `iqbal_tb_transaksi` (`iqbal_id_transaksi`, `iqbal_id_user`, `iqbal_tanggal`, `iqbal_total`, `iqbal_tunai`, `iqbal_kembali`) VALUES
(1, 2, '2024-02-26 03:21:05', 600000, 600000, 0),
(2, 2, '2024-02-26 03:22:05', 400000, 400000, 0),
(3, 1, '2024-02-27 04:44:46', 300000, 300000, 0);

-- --------------------------------------------------------

--
-- Struktur dari tabel `iqbal_tb_user`
--

CREATE TABLE `iqbal_tb_user` (
  `iqbal_id_user` int(11) NOT NULL,
  `iqbal_id_role` int(11) NOT NULL,
  `iqbal_nama` varchar(50) NOT NULL,
  `iqbal_username` varchar(50) NOT NULL,
  `iqbal_password` varchar(255) NOT NULL,
  `iqbal_jk` enum('laki-laki','perempuan') NOT NULL,
  `iqbal_status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `iqbal_tb_user`
--

INSERT INTO `iqbal_tb_user` (`iqbal_id_user`, `iqbal_id_role`, `iqbal_nama`, `iqbal_username`, `iqbal_password`, `iqbal_jk`, `iqbal_status`) VALUES
(1, 1, 'david', 'admin', 'admin', 'laki-laki', 'Login'),
(2, 2, 'pedro', 'petugas', '123456', 'laki-laki', 'Logout'),
(4, 2, 'jynn', 'kasir', '123456', 'laki-laki', 'Login');

--
-- Trigger `iqbal_tb_user`
--
DELIMITER $$
CREATE TRIGGER `log` AFTER UPDATE ON `iqbal_tb_user` FOR EACH ROW INSERT INTO iqbal_tb_log (iqbal_id_user, iqbal_status, created_at)
VALUES (NEW.iqbal_id_user, NEW.iqbal_status, NOW())
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `iqbal_tb_barang`
--
ALTER TABLE `iqbal_tb_barang`
  ADD PRIMARY KEY (`iqbal_id_barang`);

--
-- Indeks untuk tabel `iqbal_tb_detail`
--
ALTER TABLE `iqbal_tb_detail`
  ADD PRIMARY KEY (`iqbal_id_detail`),
  ADD KEY `id_barang` (`iqbal_id_barang`),
  ADD KEY `id_transaksi` (`iqbal_id_transaksi`);

--
-- Indeks untuk tabel `iqbal_tb_log`
--
ALTER TABLE `iqbal_tb_log`
  ADD PRIMARY KEY (`iqbal_id_log`),
  ADD KEY `iqbal_id_user` (`iqbal_id_user`);

--
-- Indeks untuk tabel `iqbal_tb_log_barang`
--
ALTER TABLE `iqbal_tb_log_barang`
  ADD PRIMARY KEY (`iqbal_id_log`);

--
-- Indeks untuk tabel `iqbal_tb_log_transaksi`
--
ALTER TABLE `iqbal_tb_log_transaksi`
  ADD PRIMARY KEY (`iqbal_id_log`);

--
-- Indeks untuk tabel `iqbal_tb_role`
--
ALTER TABLE `iqbal_tb_role`
  ADD PRIMARY KEY (`iqbal_id_role`);

--
-- Indeks untuk tabel `iqbal_tb_transaksi`
--
ALTER TABLE `iqbal_tb_transaksi`
  ADD PRIMARY KEY (`iqbal_id_transaksi`),
  ADD KEY `id_user` (`iqbal_id_user`);

--
-- Indeks untuk tabel `iqbal_tb_user`
--
ALTER TABLE `iqbal_tb_user`
  ADD PRIMARY KEY (`iqbal_id_user`),
  ADD KEY `id_role` (`iqbal_id_role`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_barang`
--
ALTER TABLE `iqbal_tb_barang`
  MODIFY `iqbal_id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_detail`
--
ALTER TABLE `iqbal_tb_detail`
  MODIFY `iqbal_id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_log`
--
ALTER TABLE `iqbal_tb_log`
  MODIFY `iqbal_id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_log_barang`
--
ALTER TABLE `iqbal_tb_log_barang`
  MODIFY `iqbal_id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_log_transaksi`
--
ALTER TABLE `iqbal_tb_log_transaksi`
  MODIFY `iqbal_id_log` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_role`
--
ALTER TABLE `iqbal_tb_role`
  MODIFY `iqbal_id_role` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_transaksi`
--
ALTER TABLE `iqbal_tb_transaksi`
  MODIFY `iqbal_id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_user`
--
ALTER TABLE `iqbal_tb_user`
  MODIFY `iqbal_id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `iqbal_tb_detail`
--
ALTER TABLE `iqbal_tb_detail`
  ADD CONSTRAINT `iqbal_tb_detail_ibfk_1` FOREIGN KEY (`iqbal_id_transaksi`) REFERENCES `iqbal_tb_transaksi` (`iqbal_id_transaksi`),
  ADD CONSTRAINT `iqbal_tb_detail_ibfk_2` FOREIGN KEY (`iqbal_id_barang`) REFERENCES `iqbal_tb_barang` (`iqbal_id_barang`);

--
-- Ketidakleluasaan untuk tabel `iqbal_tb_transaksi`
--
ALTER TABLE `iqbal_tb_transaksi`
  ADD CONSTRAINT `iqbal_tb_transaksi_ibfk_1` FOREIGN KEY (`iqbal_id_user`) REFERENCES `iqbal_tb_user` (`iqbal_id_user`);

--
-- Ketidakleluasaan untuk tabel `iqbal_tb_user`
--
ALTER TABLE `iqbal_tb_user`
  ADD CONSTRAINT `iqbal_tb_user_ibfk_1` FOREIGN KEY (`iqbal_id_role`) REFERENCES `iqbal_tb_role` (`iqbal_id_role`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
