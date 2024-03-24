-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 24 Mar 2024 pada 16.01
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.0.30

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
CREATE DEFINER=`root`@`localhost` PROCEDURE `kurangi_stok_barang` (IN `id` INT(11), IN `jumlah` INT(11))   UPDATE iqbal_tb_barang SET iqbal_tb_barang.iqbal_stok_barang = iqbal_tb_barang.iqbal_stok_barang - jumlah WHERE iqbal_tb_barang.iqbal_id_barang = id$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `tambah_stok_barang` (IN `id` INT(11), IN `jumlah` INT(11))   UPDATE iqbal_tb_barang SET iqbal_tb_barang.iqbal_stok_barang = iqbal_tb_barang.iqbal_stok_barang + jumlah WHERE iqbal_tb_barang.iqbal_id_barang = id$$

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `iqbal_tb_barang`
--

INSERT INTO `iqbal_tb_barang` (`iqbal_id_barang`, `iqbal_nama_barang`, `iqbal_harga_barang`, `iqbal_stok_barang`, `iqbal_updated_at`) VALUES
(1, 'Mouse Noir', 300000, 8, '2024-03-24 05:09:36'),
(2, 'Keyboard Zifriend', 400000, 2, '2024-03-24 05:57:49'),
(3, 'headphone rexus daxa', 550000, 5, '2024-03-18 06:45:09'),
(5, 'flashdisk sandisk 32gb', 50000, 24, '2024-03-24 05:57:49'),
(7, 'laptop axioo', 16000000, 4, '2024-03-05 06:09:30'),
(10, 'monitor aoc', 2000000, 15, '2024-03-05 00:42:51'),
(11, 'router tp-link', 250000, 13, '2024-03-24 14:29:44'),
(12, 'wlan receiver', 110000, 16, '2024-03-24 14:30:21'),
(13, 'headset', 200000, 4, '2024-03-24 05:07:23'),
(15, 'tws soundcore r50i', 180000, 50, '2024-03-24 14:34:22');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `iqbal_tb_detail`
--

INSERT INTO `iqbal_tb_detail` (`iqbal_id_detail`, `iqbal_id_transaksi`, `iqbal_id_barang`, `iqbal_qty`, `iqbal_subtotal`, `iqbal_created_at`) VALUES
(2, 1, 1, 2, 600000, '2024-02-26 03:22:40'),
(3, 2, 2, 1, 400000, '2024-02-26 03:22:20'),
(4, 3, 1, 1, 300000, '2024-02-27 04:45:02'),
(5, 10, 1, 1, 300000, '2024-03-18 13:52:31'),
(6, 10, 11, 2, 500000, '2024-03-18 13:52:31'),
(7, 11, 1, 1, 300000, '2024-03-24 03:18:56'),
(8, 11, 12, 1, 110000, '2024-03-24 03:18:56'),
(9, 12, 13, 1, 200000, '2024-03-24 03:28:14'),
(10, 12, 12, 1, 110000, '2024-03-24 03:28:14'),
(11, 13, 5, 1, 50000, '2024-03-24 03:54:59'),
(12, 13, 12, 1, 110000, '2024-03-24 03:54:59'),
(13, 14, 1, 2, 600000, '2024-03-24 04:12:41'),
(14, 14, 5, 1, 50000, '2024-03-24 04:12:41'),
(15, 15, 5, 1, 50000, '2024-03-24 04:46:52'),
(16, 15, 13, 1, 200000, '2024-03-24 04:46:52'),
(17, 16, 2, 1, 400000, '2024-03-24 04:51:18'),
(18, 16, 1, 1, 300000, '2024-03-24 04:51:18'),
(19, 16, 5, 1, 50000, '2024-03-24 04:51:18'),
(20, 17, 13, 1, 200000, '2024-03-24 05:07:23'),
(21, 17, 1, 1, 300000, '2024-03-24 05:07:23'),
(22, 18, 2, 1, 400000, '2024-03-24 05:57:49'),
(23, 18, 5, 1, 50000, '2024-03-24 05:57:49');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(62, 1, 'Login', '2024-03-18 00:39:18'),
(63, 1, 'Logout', '2024-03-18 01:36:19'),
(64, 2, 'Login', '2024-03-18 01:36:27'),
(65, 2, 'Logout', '2024-03-18 01:46:02'),
(66, 1, 'Login', '2024-03-18 01:46:09'),
(67, 1, 'Logout', '2024-03-18 01:46:21'),
(68, 1, 'Login', '2024-03-18 02:04:36'),
(69, 1, 'Logout', '2024-03-18 02:13:33'),
(70, 1, 'Login', '2024-03-18 02:13:36'),
(71, 1, 'Logout', '2024-03-18 02:21:18'),
(72, 1, 'Login', '2024-03-18 02:22:24'),
(73, 5, '', '2024-03-18 02:42:08'),
(74, 1, 'Logout', '2024-03-18 02:46:43'),
(75, 5, 'Login', '2024-03-18 02:46:48'),
(76, 5, 'Login', '2024-03-18 02:47:45'),
(77, 1, 'Logout', '2024-03-18 02:47:54'),
(78, 2, 'Logout', '2024-03-18 02:47:58'),
(79, 4, 'Login', '2024-03-18 02:48:01'),
(80, 5, 'Logout', '2024-03-18 02:48:05'),
(81, 1, 'Login', '2024-03-18 02:48:08'),
(82, 1, 'Login', '2024-03-18 02:48:46'),
(83, 1, 'Login', '2024-03-18 02:48:52'),
(84, 5, 'Logout', '2024-03-18 02:49:41'),
(85, 4, 'Login', '2024-03-18 02:50:03'),
(86, 1, 'Logout', '2024-03-18 02:50:15'),
(87, 1, 'Login', '2024-03-18 02:50:58'),
(88, 4, 'Login', '2024-03-18 02:51:21'),
(89, 6, '', '2024-03-18 02:55:54'),
(90, 1, 'Logout', '2024-03-18 03:00:10'),
(91, 4, 'Login', '2024-03-18 03:00:15'),
(92, 4, 'Logout', '2024-03-18 03:00:20'),
(93, 6, 'Login', '2024-03-18 03:00:27'),
(94, 6, 'Logout', '2024-03-18 05:00:37'),
(95, 1, 'Login', '2024-03-18 05:00:40'),
(96, 1, 'Logout', '2024-03-18 06:28:55'),
(97, 1, 'Login', '2024-03-18 06:29:00'),
(98, 1, 'Login', '2024-03-24 03:17:57'),
(99, 1, 'Login', '2024-03-24 05:12:50'),
(100, 1, 'Login', '2024-03-24 05:17:00'),
(101, 1, 'Logout', '2024-03-24 05:39:45'),
(102, 1, 'Login', '2024-03-24 05:57:36'),
(103, 1, 'Login', '2024-03-24 13:52:13'),
(104, 1, 'Login', '2024-03-24 14:59:45');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
(20, 5, 'flashdisk sandisk 32 gb', 'Ubah barang', '2024-03-18 02:10:11'),
(21, 5, 'flashdisk sandisk 32gb', 'Ubah barang', '2024-03-18 02:10:19'),
(22, 13, 'headset', 'Ubah barang', '2024-03-18 06:45:09'),
(23, 3, 'headphone rexus daxa', 'Ubah barang', '2024-03-18 06:45:09'),
(24, 12, 'wlan receiver', 'Ubah barang', '2024-03-18 06:45:30'),
(25, 13, 'headset', 'Ubah barang', '2024-03-18 13:51:10'),
(26, 1, 'mouse noir', 'Ubah barang', '2024-03-18 13:52:31'),
(27, 11, 'router tp-link', 'Ubah barang', '2024-03-18 13:52:31'),
(28, 1, 'mouse noir', 'Ubah barang', '2024-03-24 03:18:56'),
(29, 12, 'wlan receiver', 'Ubah barang', '2024-03-24 03:18:56'),
(30, 13, 'headset', 'Ubah barang', '2024-03-24 03:28:14'),
(31, 12, 'wlan receiver', 'Ubah barang', '2024-03-24 03:28:14'),
(32, 5, 'flashdisk sandisk 32gb', 'Ubah barang', '2024-03-24 03:54:59'),
(33, 12, 'wlan receiver', 'Ubah barang', '2024-03-24 03:54:59'),
(34, 1, 'mouse noir', 'Ubah barang', '2024-03-24 04:12:41'),
(35, 5, 'flashdisk sandisk 32gb', 'Ubah barang', '2024-03-24 04:12:41'),
(36, 5, 'flashdisk sandisk 32gb', 'Ubah barang', '2024-03-24 04:46:35'),
(37, 5, 'flashdisk sandisk 32gb', 'Ubah barang', '2024-03-24 04:46:52'),
(38, 13, 'headset', 'Ubah barang', '2024-03-24 04:46:52'),
(39, 2, 'keyboard zifriend', 'Ubah barang', '2024-03-24 04:51:18'),
(40, 1, 'mouse noir', 'Ubah barang', '2024-03-24 04:51:18'),
(41, 5, 'flashdisk sandisk 32gb', 'Ubah barang', '2024-03-24 04:51:18'),
(42, 13, 'headset', 'Ubah barang', '2024-03-24 05:07:23'),
(43, 1, 'mouse noir', 'Ubah barang', '2024-03-24 05:07:23'),
(44, 1, 'Mouse Noir', 'Ubah barang', '2024-03-24 05:09:36'),
(45, 2, 'Keyboard Zifriend', 'Ubah barang', '2024-03-24 05:09:47'),
(46, 14, 'soundcore r50i', 'Tambah barang', '2024-03-24 05:19:28'),
(47, 14, 'soundcore r50i', 'Hapus barang', '2024-03-24 05:19:34'),
(48, 2, 'Keyboard Zifriend', 'Ubah barang', '2024-03-24 05:57:49'),
(49, 5, 'flashdisk sandisk 32gb', 'Ubah barang', '2024-03-24 05:57:49'),
(50, 11, 'router tp-link', 'Ubah barang', '2024-03-24 14:29:44'),
(51, 12, 'wlan receiver', 'Ubah barang', '2024-03-24 14:30:21'),
(52, 15, 'tws soundcore r50i', 'Tambah barang', '2024-03-24 14:34:22');

-- --------------------------------------------------------

--
-- Struktur dari tabel `iqbal_tb_log_transaksi`
--

CREATE TABLE `iqbal_tb_log_transaksi` (
  `iqbal_id_log` int(11) NOT NULL,
  `iqbal_id_transaksi` int(11) NOT NULL,
  `iqbal_id_user` int(11) NOT NULL,
  `iqbal_status` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `iqbal_tb_role`
--

CREATE TABLE `iqbal_tb_role` (
  `iqbal_id_role` int(11) NOT NULL,
  `iqbal_role` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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
  `iqbal_kembali` int(11) NOT NULL,
  `iqbal_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `iqbal_tb_transaksi`
--

INSERT INTO `iqbal_tb_transaksi` (`iqbal_id_transaksi`, `iqbal_id_user`, `iqbal_tanggal`, `iqbal_total`, `iqbal_tunai`, `iqbal_kembali`, `iqbal_status`) VALUES
(1, 2, '2024-03-18 13:14:59', 600000, 600000, 0, 1),
(2, 2, '2024-03-18 13:14:59', 400000, 400000, 0, 1),
(3, 1, '2024-03-18 13:14:59', 300000, 300000, 0, 1),
(10, 0, '2024-03-18 13:52:31', 800000, 0, 0, 0),
(11, 1, '2024-03-24 03:19:24', 410000, 420000, 10000, 1),
(12, 1, '2024-03-24 03:49:57', 310000, 350000, 40000, 1),
(13, 1, '2024-03-24 03:55:09', 160000, 200000, 40000, 1),
(14, 1, '2024-03-24 04:13:01', 650000, 700000, 50000, 1),
(15, 1, '2024-03-24 04:46:57', 250000, 300000, 50000, 1),
(16, 1, '2024-03-24 04:51:47', 750000, 760000, 10000, 1),
(17, 1, '2024-03-24 05:07:30', 500000, 500000, 0, 1),
(18, 1, '2024-03-24 05:57:55', 450000, 500000, 50000, 1);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `iqbal_tb_user`
--

INSERT INTO `iqbal_tb_user` (`iqbal_id_user`, `iqbal_id_role`, `iqbal_nama`, `iqbal_username`, `iqbal_password`, `iqbal_jk`, `iqbal_status`) VALUES
(1, 1, 'david', 'admin', '$2y$10$OHk3H7mX3yHqfrItOLiOwOaVHMuJqYhKnQbkN9j6S.olgetLc.pi.', 'laki-laki', 'Login'),
(2, 2, 'pedro', 'petugas', '$2y$10$s3O/eAxlbhLQiFANlLVya.ENdf1rzJeRTKFB.YmFB8c3vBP/Sc6xS', 'laki-laki', 'Logout'),
(4, 2, 'jynn', 'kasir', '$2y$10$2HewZQcuojEaMIz1C6GQWOc7dWg.GGrgdCsXZ3qqLSLK3NzvKJhra', 'laki-laki', 'Logout'),
(6, 1, 'wanto', 'atmin', '$2y$10$rpUN1mKKdtWR3.CH9Ocn6O3h86qNbBwJ.o/YBGgVJ0uPx8gfpg0rO', 'laki-laki', 'Logout');

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
  MODIFY `iqbal_id_barang` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_detail`
--
ALTER TABLE `iqbal_tb_detail`
  MODIFY `iqbal_id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_log`
--
ALTER TABLE `iqbal_tb_log`
  MODIFY `iqbal_id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_log_barang`
--
ALTER TABLE `iqbal_tb_log_barang`
  MODIFY `iqbal_id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

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
  MODIFY `iqbal_id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_user`
--
ALTER TABLE `iqbal_tb_user`
  MODIFY `iqbal_id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
-- Ketidakleluasaan untuk tabel `iqbal_tb_user`
--
ALTER TABLE `iqbal_tb_user`
  ADD CONSTRAINT `iqbal_tb_user_ibfk_1` FOREIGN KEY (`iqbal_id_role`) REFERENCES `iqbal_tb_role` (`iqbal_id_role`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
