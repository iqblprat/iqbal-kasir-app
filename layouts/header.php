<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="../assets/css/style.css">
    <link rel="stylesheet" href="../assets/icon/css/all.css">
    <title><?php echo $pageTitle; ?></title>
    <style>
        #sidebar-wrapper {
            width: 230px;
            height: 100vh; 
            overflow-y: auto;
            position: fixed;
            left: 0;
            top: 0;
        }
        #page-content-wrapper {
            margin-left: 200px;
        }
        .list-group-item.active {
            border-color: grey;
            opacity: 1;
            color: #ffffff;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <?php include '../partials/sidebar.php'; ?>
            <div class="col-md-10" id="page-content-wrapper" style="margin-left: 220px;">
                <div class="container">
