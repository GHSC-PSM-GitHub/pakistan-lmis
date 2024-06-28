#####################
Batch Text Replacer Demo ID:896236
#####################
<?php
/**
 * ajaxproductname

 */
include("../includes/classes/AllClasses.php");

if(isset($_POST['product']) && !empty($_POST['product'])){
	$product = $_POST['product'];
	$name = $objManageItem->GetProductName($product);
	
	if($name != false){
		echo $name;
	}
}


?>
#####################
Batch Text Replacer Demo ID:488772335
#####################
