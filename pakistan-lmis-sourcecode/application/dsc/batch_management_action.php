#####################
Batch Text Replacer Demo ID:829456374
#####################
<?php
/**
 * batch_management_action

 */

//Including required files
include("../includes/classes/AllClasses.php");
ob_start();
$strDo = "Add";
$nstkId =0;

if(isset($_REQUEST['product']) && !empty($_REQUEST['product'])) {
        //product
	$product = $_REQUEST['product'];
}
if(isset($_REQUEST['status']) && !empty($_REQUEST['status'])) {
        //status
	$status = $_REQUEST['status'];
}
if(isset($_REQUEST['batch_no']) && !empty($_REQUEST['batch_no'])) {
        //Batch No.
	$batch_no = $_REQUEST['batch_no'];
}
if(isset($_REQUEST['ref_no']) && !empty($_REQUEST['ref_no'])) {
        //Reference No
	$ref_no = $_REQUEST['ref_no'];
}

$objStockBatch->item_id = $product;
$objStockBatch->batch_no = $batch_no;
$objStockBatch->TranRef = $ref_no;
$objStockBatch->search();

header("location:batch_management.php");
ob_flush();
exit;
#####################
Batch Text Replacer Demo ID:33250725
#####################
