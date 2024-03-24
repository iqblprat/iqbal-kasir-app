<?php

session_start();
require '../config/app.php';

require '../vendor/autoload.php';

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

$spreadsheet = new Spreadsheet();
$activeWorksheet = $spreadsheet->getActiveSheet();
$activeWorksheet->setCellValue('A2', 'No');
$activeWorksheet->setCellValue('B2', 'ID Transaksi');
$activeWorksheet->setCellValue('C2', 'ID User');
$activeWorksheet->setCellValue('D2', 'Waktu Transaksi');
$activeWorksheet->setCellValue('E2', 'Total Belanja');
$activeWorksheet->setCellValue('F2', 'Tunai');
$activeWorksheet->setCellValue('G2', 'Kembalian');
$activeWorksheet->setCellValue('H2', 'Status');

$data_transaksi = select("SELECT * FROM iqbal_tb_transaksi");

$no = 1;
$start = 3;

foreach ($data_transaksi as $transaksi){
    $activeWorksheet->setCellValue('A' . $start, $no++);
    $activeWorksheet->getColumnDimension('A')->setAutoSize(true);

    $activeWorksheet->setCellValue('B' . $start, $transaksi['iqbal_id_transaksi']);
    $activeWorksheet->getColumnDimension('B')->setAutoSize(true);

    $activeWorksheet->setCellValue('C' . $start, $transaksi['iqbal_id_user']);
    $activeWorksheet->getColumnDimension('C')->setAutoSize(true);

    $activeWorksheet->setCellValue('D' . $start, $transaksi['iqbal_tanggal']);
    $activeWorksheet->getColumnDimension('D')->setAutoSize(true);

    $activeWorksheet->setCellValue('E' . $start, $transaksi['iqbal_total']);
    $activeWorksheet->getColumnDimension('E')->setAutoSize(true);

    $activeWorksheet->setCellValue('F' . $start, $transaksi['iqbal_tunai']);
    $activeWorksheet->getColumnDimension('F')->setAutoSize(true);

    $activeWorksheet->setCellValue('G' . $start, $transaksi['iqbal_kembali']);
    $activeWorksheet->getColumnDimension('G')->setAutoSize(true);

    $activeWorksheet->setCellValue('H' . $start, $transaksi['iqbal_status']);
    $activeWorksheet->getColumnDimension('H')->setAutoSize(true);

    $start++;
}

$styleArray = [
    'borders' => [
        'allBorders' => [
            'borderStyle' => \PhpOffice\PhpSpreadsheet\Style\Border::BORDER_THIN,
        ],
    ],
];

$border = $start - 1;

$activeWorksheet->getStyle('A2:H' . $border)->applyFromArray($styleArray);

$writer = new Xlsx($spreadsheet);
$writer->save('Rekap Data Transaksi.xlsx');
header('Content-Type: application/vnc.openxmlformats-officedocument.spreadsheet.sheet');
header('Content-Disposition: attachment;filename="Rekap Data Transaksi.xlsx"');
readfile('Rekap Data Transaksi.xlsx');
unlink('Rekap Data Transaksi.xlsx');
exit;