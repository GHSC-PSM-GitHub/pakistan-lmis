#####################
Batch Text Replacer Demo ID:0889681
#####################
<?php

/**
 * ajaxproductbatch

 */
include("../includes/classes/AllClasses.php");

if (isset($_POST['product']) && !empty($_POST['product'])) {
    $product = $_POST['product'];
    $array = $objItemUnits->GetUnitByItemId($product);

    if ($array != FALSE) {
        $type = $array['type'];
        $id = $array['id'];
        echo $type;
        echo '<input type="hidden" name="unit" id="unit" value="' . $id . '" />';
    }
}
?>
#####################
Batch Text Replacer Demo ID:65720540
#####################
