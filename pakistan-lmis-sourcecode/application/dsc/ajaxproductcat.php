#####################
Batch Text Replacer Demo ID:457318
#####################
<?php

/**
 * ajaxproductcost

 */

//Including required files
include("../includes/classes/AllClasses.php");

//for product category
if(isset($_POST['product']) && !empty($_POST['product'])){
	$product = $_POST['product'];
	$cat = $objManageItem->GetProductCat($product);
	
	if($cat != false){
		echo $cat;
	}
}

if(isset($_POST['qty']) && !empty($_POST['qty']) && !empty($_POST['itemId']))
{
	$qty = $_POST['qty'];
	$product = $_POST['itemId'];
	$doses = $objManageItem->GetProductDoses($product);
}
?>
#####################
Batch Text Replacer Demo ID:531705386
#####################
