-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 26 Mar 2024 pada 07.42
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
(1, 'Mouse Noir', 300000, 4, '2024-03-26 06:41:18'),
(2, 'Keyboard Zifriend', 400000, 1, '2024-03-26 06:41:18'),
(3, 'headphone rexus daxa', 550000, 4, '2024-03-26 06:41:18'),
(5, 'flashdisk sandisk 32gb', 50000, 20, '2024-03-26 06:41:18'),
(7, 'laptop axioo', 16000000, 3, '2024-03-26 06:41:18'),
(10, 'monitor aoc', 2000000, 14, '2024-03-26 06:41:18'),
(11, 'router tp-link', 250000, 11, '2024-03-26 06:41:18'),
(12, 'wlan receiver', 110000, 11, '2024-03-26 06:41:18'),
(13, 'headset', 200000, 6, '2024-03-26 06:41:18'),
(15, 'tws soundcore r50i', 185000, 42, '2024-03-26 06:41:18');

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
(23, 18, 5, 1, 50000, '2024-03-24 05:57:49'),
(24, 19, 1, 1, 300000, '2024-03-25 02:20:22'),
(25, 19, 11, 1, 250000, '2024-03-25 02:20:22'),
(26, 20, 5, 1, 50000, '2024-03-25 04:03:20'),
(27, 20, 12, 1, 110000, '2024-03-25 04:03:20'),
(28, 21, 15, 1, 180000, '2024-03-25 04:04:39'),
(29, 22, 13, 1, 200000, '2024-03-25 05:16:52'),
(30, 22, 5, 1, 50000, '2024-03-25 05:16:52'),
(31, 22, 12, 1, 110000, '2024-03-25 05:16:52'),
(32, 23, 15, 1, 185000, '2024-03-26 03:08:27'),
(33, 23, 5, 1, 50000, '2024-03-26 03:08:27'),
(34, 24, 15, 1, 185000, '2024-03-26 03:25:36'),
(35, 25, 15, 1, 185000, '2024-03-26 04:46:13'),
(36, 25, 13, 1, 200000, '2024-03-26 04:46:13'),
(37, 25, 12, 1, 110000, '2024-03-26 04:46:13'),
(38, 26, 12, 1, 110000, '2024-03-26 04:46:50'),
(39, 26, 15, 1, 185000, '2024-03-26 04:46:50'),
(40, 26, 13, 2, 400000, '2024-03-26 04:46:50'),
(41, 26, 1, 1, 300000, '2024-03-26 04:46:50'),
(42, 27, 13, 1, 200000, '2024-03-26 06:27:51'),
(43, 27, 15, 1, 185000, '2024-03-26 06:27:51'),
(44, 28, 15, 1, 185000, '2024-03-26 06:29:31'),
(45, 28, 1, 1, 300000, '2024-03-26 06:29:31'),
(46, 29, 1, 1, 300000, '2024-03-26 06:41:18'),
(47, 29, 2, 1, 400000, '2024-03-26 06:41:18'),
(48, 29, 3, 1, 550000, '2024-03-26 06:41:18'),
(49, 29, 5, 1, 50000, '2024-03-26 06:41:18'),
(50, 29, 7, 1, 16000000, '2024-03-26 06:41:18'),
(51, 29, 10, 1, 2000000, '2024-03-26 06:41:18'),
(52, 29, 11, 1, 250000, '2024-03-26 06:41:18'),
(53, 29, 12, 1, 110000, '2024-03-26 06:41:18'),
(54, 29, 13, 1, 200000, '2024-03-26 06:41:18'),
(55, 29, 15, 1, 185000, '2024-03-26 06:41:18');

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
(104, 1, 'Login', '2024-03-24 14:59:45'),
(105, 1, 'Logout', '2024-03-25 00:54:17'),
(106, 4, 'Login', '2024-03-25 00:54:24'),
(107, 4, 'Logout', '2024-03-25 01:02:01'),
(108, 6, 'Login', '2024-03-25 01:02:08'),
(109, 1, 'Login', '2024-03-25 03:20:18'),
(110, 1, 'Logout', '2024-03-25 04:02:48'),
(111, 1, 'Login', '2024-03-25 04:02:52'),
(112, 1, 'Logout', '2024-03-26 02:30:47'),
(113, 1, 'Login', '2024-03-26 02:36:57'),
(114, 4, 'Login', '2024-03-26 03:12:33'),
(115, 4, 'Logout', '2024-03-26 03:13:50'),
(116, 6, 'Login', '2024-03-26 03:13:57'),
(117, 4, 'Login', '2024-03-26 03:18:43'),
(118, 4, 'Logout', '2024-03-26 03:18:53'),
(119, 1, 'Login', '2024-03-26 03:23:47'),
(120, 4, 'Login', '2024-03-26 03:24:52'),
(121, 1, 'Logout', '2024-03-26 03:26:11'),
(122, 1, 'Login', '2024-03-26 03:30:27'),
(123, 1, 'Logout', '2024-03-26 03:40:29'),
(124, 1, 'Login', '2024-03-26 03:40:37'),
(125, 1, 'Logout', '2024-03-26 03:44:08'),
(126, 1, 'Login', '2024-03-26 03:44:11'),
(127, 1, 'Logout', '2024-03-26 03:44:57'),
(128, 4, 'Login', '2024-03-26 03:45:03'),
(129, 4, 'Logout', '2024-03-26 03:55:14'),
(130, 1, 'Login', '2024-03-26 03:55:18');

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
(52, 15, 'tws soundcore r50i', 'Tambah barang', '2024-03-24 14:34:22'),
(53, 1, 'Mouse Noir', 'Ubah barang', '2024-03-25 02:20:22'),
(54, 11, 'router tp-link', 'Ubah barang', '2024-03-25 02:20:22'),
(55, 5, 'flashdisk sandisk 32gb', 'Ubah barang', '2024-03-25 04:03:20'),
(56, 12, 'wlan receiver', 'Ubah barang', '2024-03-25 04:03:20'),
(57, 15, 'tws soundcore r50i', 'Ubah barang', '2024-03-25 04:04:39'),
(58, 13, 'headset', 'Ubah barang', '2024-03-25 05:16:52'),
(59, 5, 'flashdisk sandisk 32gb', 'Ubah barang', '2024-03-25 05:16:52'),
(60, 12, 'wlan receiver', 'Ubah barang', '2024-03-25 05:16:52'),
(61, 15, 'tws soundcore r50i', 'Ubah barang', '2024-03-26 02:23:15'),
(62, 15, 'tws soundcore r50i', 'Ubah barang', '2024-03-26 03:08:27'),
(63, 5, 'flashdisk sandisk 32gb', 'Ubah barang', '2024-03-26 03:08:27'),
(64, 15, 'tws soundcore r50i', 'Ubah barang', '2024-03-26 03:25:36'),
(65, 15, 'tws soundcore r50i', 'Ubah barang', '2024-03-26 04:46:13'),
(66, 13, 'headset', 'Ubah barang', '2024-03-26 04:46:13'),
(67, 12, 'wlan receiver', 'Ubah barang', '2024-03-26 04:46:13'),
(68, 12, 'wlan receiver', 'Ubah barang', '2024-03-26 04:46:50'),
(69, 15, 'tws soundcore r50i', 'Ubah barang', '2024-03-26 04:46:50'),
(70, 13, 'headset', 'Ubah barang', '2024-03-26 04:46:50'),
(71, 1, 'Mouse Noir', 'Ubah barang', '2024-03-26 04:46:50'),
(72, 13, 'headset', 'Ubah barang', '2024-03-26 06:20:10'),
(73, 13, 'headset', 'Ubah barang', '2024-03-26 06:27:51'),
(74, 15, 'tws soundcore r50i', 'Ubah barang', '2024-03-26 06:27:51'),
(75, 15, 'tws soundcore r50i', 'Ubah barang', '2024-03-26 06:29:31'),
(76, 1, 'Mouse Noir', 'Ubah barang', '2024-03-26 06:29:31'),
(77, 1, 'Mouse Noir', 'Ubah barang', '2024-03-26 06:41:18'),
(78, 2, 'Keyboard Zifriend', 'Ubah barang', '2024-03-26 06:41:18'),
(79, 3, 'headphone rexus daxa', 'Ubah barang', '2024-03-26 06:41:18'),
(80, 5, 'flashdisk sandisk 32gb', 'Ubah barang', '2024-03-26 06:41:18'),
(81, 7, 'laptop axioo', 'Ubah barang', '2024-03-26 06:41:18'),
(82, 10, 'monitor aoc', 'Ubah barang', '2024-03-26 06:41:18'),
(83, 11, 'router tp-link', 'Ubah barang', '2024-03-26 06:41:18'),
(84, 12, 'wlan receiver', 'Ubah barang', '2024-03-26 06:41:18'),
(85, 13, 'headset', 'Ubah barang', '2024-03-26 06:41:18'),
(86, 15, 'tws soundcore r50i', 'Ubah barang', '2024-03-26 06:41:18');

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
  `iqbal_kembali` int(11) NOT NULL,
  `iqbal_status` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `iqbal_tb_transaksi`
--

INSERT INTO `iqbal_tb_transaksi` (`iqbal_id_transaksi`, `iqbal_id_user`, `iqbal_tanggal`, `iqbal_total`, `iqbal_tunai`, `iqbal_kembali`, `iqbal_status`) VALUES
(1, 2, '2024-03-18 13:14:59', 600000, 600000, 0, 1),
(2, 2, '2024-03-18 13:14:59', 400000, 400000, 0, 1),
(3, 1, '2024-03-18 13:14:59', 300000, 300000, 0, 1),
(10, 1, '2024-03-25 02:15:51', 800000, 800000, 0, 1),
(11, 1, '2024-03-24 03:19:24', 410000, 420000, 10000, 1),
(12, 1, '2024-03-24 03:49:57', 310000, 350000, 40000, 1),
(13, 1, '2024-03-24 03:55:09', 160000, 200000, 40000, 1),
(14, 1, '2024-03-24 04:13:01', 650000, 700000, 50000, 1),
(15, 1, '2024-03-24 04:46:57', 250000, 300000, 50000, 1),
(16, 1, '2024-03-24 04:51:47', 750000, 760000, 10000, 1),
(17, 1, '2024-03-24 05:07:30', 500000, 500000, 0, 1),
(18, 1, '2024-03-24 05:57:55', 450000, 500000, 50000, 1),
(19, 6, '2024-03-25 02:22:50', 550000, 600000, 50000, 1),
(20, 1, '2024-03-25 04:04:01', 160000, 170000, 10000, 1),
(21, 1, '2024-03-25 04:05:36', 180000, 200000, 20000, 1),
(22, 1, '2024-03-25 05:17:02', 360000, 400000, 40000, 1),
(23, 1, '2024-03-26 03:09:14', 235000, 250000, 15000, 1),
(24, 1, '2024-03-26 03:25:41', 185000, 190000, 5000, 1),
(25, 1, '2024-03-26 04:47:18', 495000, 500000, 5000, 1),
(26, 1, '2024-03-26 04:46:59', 995000, 1000000, 5000, 1),
(27, 1, '2024-03-26 06:28:08', 385000, 390000, 5000, 1),
(28, 1, '2024-03-26 06:29:55', 485000, 500000, 15000, 1),
(29, 1, '2024-03-26 06:41:32', 20045000, 20050000, 5000, 1);

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
(1, 1, 'david', 'admin', '$2y$10$OHk3H7mX3yHqfrItOLiOwOaVHMuJqYhKnQbkN9j6S.olgetLc.pi.', 'laki-laki', 'Login'),
(2, 2, 'pedro', 'petugas', '$2y$10$s3O/eAxlbhLQiFANlLVya.ENdf1rzJeRTKFB.YmFB8c3vBP/Sc6xS', 'laki-laki', 'Logout'),
(4, 2, 'jynn', 'kasir', '$2y$10$2HewZQcuojEaMIz1C6GQWOc7dWg.GGrgdCsXZ3qqLSLK3NzvKJhra', 'laki-laki', 'Logout'),
(6, 1, 'wanto', 'atmin', '$2y$10$rpUN1mKKdtWR3.CH9Ocn6O3h86qNbBwJ.o/YBGgVJ0uPx8gfpg0rO', 'laki-laki', 'Login');

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
  MODIFY `iqbal_id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=56;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_log`
--
ALTER TABLE `iqbal_tb_log`
  MODIFY `iqbal_id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT untuk tabel `iqbal_tb_log_barang`
--
ALTER TABLE `iqbal_tb_log_barang`
  MODIFY `iqbal_id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

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
  MODIFY `iqbal_id_transaksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

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
