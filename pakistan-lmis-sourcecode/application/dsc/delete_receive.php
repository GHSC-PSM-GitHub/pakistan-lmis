#####################
Batch Text Replacer Demo ID:7298476
#####################
<?php
/**
 * delete_receive

 */
include("../includes/classes/AllClasses.php");

if (isset($_REQUEST['id']) && !empty($_REQUEST['id'])) {
    $id = $_REQUEST['id'];

    
    $objStockDetail->deleteReceive($id);

    if (!empty($_REQUEST['p']) && $_REQUEST['p'] == 'stock') {
		$_SESSION['success'] = 2;
        redirect("stock_receive.php");
        exit;
    }
	$_SESSION['success'] = 2;
    redirect("new_receive.php");
    exit;
}

//Delete records after stock is issued
if(isset($_POST['detailId']) && !empty($_POST['detailId'])){
	$detailId = $_POST['detailId'];
	$batchId = $_POST['batchId'];
	// Delete Issue Entry
	$objStockDetail->deleteReceive($detailId);
}
#####################
Batch Text Replacer Demo ID:3633216210
#####################
