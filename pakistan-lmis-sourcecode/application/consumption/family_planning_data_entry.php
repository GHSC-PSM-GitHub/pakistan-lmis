<?php
//Including files
include("../includes/classes/AllClasses.php");
//Including header
include(PUBLIC_PATH . "html/header.php");
//Including top_im
include PUBLIC_PATH . "html/top_im.php";

//Items
$products_arr = array();
$products_arr[1] = 'Condom';
$products_arr[2] = 'POP';
$products_arr[9] = 'COC';
//$products_arr[3] = 'ECP';
$products_arr[5] = 'Copper-T-380A';
$products_arr[4] = 'Multiload';
//$products_arr[6] = '2-Month Inj';
$products_arr[7] = '3-Month Inj';
$products_arr[8] = '3-Month Inj.- Sayana Press';
$products_arr[13] = 'Implanon';
$products_arr[34] = 'Jadelle';
$products_arr[32] = 'Tubal Ligation';
$products_arr[31] = 'Vasectomy';

//Parameters
if (!(isset($_GET['stk']) && isset($_GET['m']) && isset($_GET['d']) && isset($_GET['p']))){
    echo 'Invalid Parameters';
    exit();
}
else{
    $stk = $_GET['stk'];
    $month = $_GET['m'];
    $district = $_GET['d'];
    $province = $_GET['p'];
}

//Get Dist Name
$qry = "
        SELECT
            LocName
        FROM
        	tbl_locations
        WHERE
        	PkLocID = $district
        LIMIT 1
        	";
$result = mysql_query($qry);
$dist_name = '';
while ($row = mysql_fetch_assoc($result)) {
    $dist_name = $row['LocName'];
}

//Previous Data: Consumption
$qry = "
        SELECT
        	fp_adp_consumption.item_id, 
        	fp_adp_consumption.wh_obl_a, 
        	fp_adp_consumption.wh_issue_up, 
        	fp_adp_consumption.wh_cbl_a, 
        	fp_adp_consumption.new_clients, 
        	fp_adp_consumption.followup_clients
        FROM
        	fp_adp_consumption
        WHERE
        	fp_adp_consumption.stk_id = $stk AND
        	fp_adp_consumption.dist_id = $district AND
        	fp_adp_consumption.report_month = '$month'";
//result
//echo $qry;exit;
$result = mysql_query($qry);
$prev_data_consumption = array();
while ($row = mysql_fetch_assoc($result)) {
    $prev_data_consumption[$row['item_id']] = $row;
}

//Previous Data: Referral
$qry = "
        SELECT
        	fp_adp_referral.lhw,
        	fp_adp_referral.fwa,
        	fp_adp_referral.sm 
        FROM
        	fp_adp_referral 
        WHERE
        	fp_adp_referral.stk_id = $stk 
        	AND fp_adp_referral.dist_id = $district 
        	AND fp_adp_referral.report_month = '$month' 
        	LIMIT 1";
//result
//echo $qry;exit;
$result = mysql_query($qry);
$prev_data_referral = array();
while ($row = mysql_fetch_assoc($result)) {
    $prev_data_referral = $row;
}
?>
</head>
<!-- END HEAD -->

<body class="">
<!-- BEGIN HEADER -->
<div class="page-containerz">
    <div class="">
        <div class="page-content" style="margin: 15px 15px 15px 15px; background-color: #FCF7F8" >
            <div class="row">
                <div class="col-md-12">
                    <h3 class="heading">Family Planning Data Of PWD & DOH under ADP Scheme Strategic Planning Unit</h3>
                    <div class="widget">
                        <div class="widget-head">
                            <h3 class="white"><?php echo date('M-y', strtotime($month)) . "&nbsp;" . $dist_name?></h3>
                        </div>
                        <div class="widget-body">

                        </div>
                        <!--                        </div>-->
                        <form name="frm" id="frm" action="family_planning_action.php" method="post"
                              enctype="multipart/form-data">

                            <h4>&nbsp; Client Data</h4>
                            <table class="table table-bordered">
                                <thead>
                                <tr>
                                    <th align="center" rowspan="2">Client Type</th>
                                    <th style="text-align:center" rowspan="">Condoms (Pcs)</th>
                                    <th colspan="2" rowspan="" style="text-align:center">Oral Pills (Cycles)</th>
                                    <th colspan="2" rowspan="" style="text-align:center">IUD (IUD)</th>
                                    <th colspan="2" rowspan="" style="text-align:center">Injectables (Vials)</th>
                                    <th colspan="2" rowspan="" style="text-align:center">Implant (Pcs)</th>
                                    <th colspan="2" rowspan="" style="text-align:center">Surgery Cases</th>
                                </tr>

                                <tr>
                                    <?php
                                    foreach ($products_arr as $item) {
                                        echo '<th style="text-align:center">' . $item . '</th>';
                                    }
                                    ?>
                                </tr>
                                </thead>
                                <tbody>
                                <tr>
                                    <td>New</td>
                                    <?php
                                    foreach ($products_arr as $id => $item) {
                                        echo '<td><input class="form-control" type="number" min="0" name="client_data[new][' . $id . ']" style="height:25px" value="'. ((isset($prev_data_consumption[$id]['new_clients']))?$prev_data_consumption[$id]['new_clients']:'') .'"></td>';
                                    }
                                    ?>
                                </tr>
                                <tr>
                                    <td>Follow Up</td>
                                    <?php
                                    foreach ($products_arr as $id => $item) {
                                        echo '<td><input class="form-control" type="number" min="0" name="client_data[follow_up][' . $id . ']" style="height:25px" value="'. ((isset($prev_data_consumption[$id]['followup_clients']))?$prev_data_consumption[$id]['followup_clients']:'') .'"></td>';
                                    }
                                    ?>
                                </tr>
                                </tbody>
                            </table>

                            <br>
                            <h4>&nbsp; Commodities Utilization</h4>
                            <table class="table table-bordered" width="100%">
                                <tr>
                                    <th>Sr No.</th>
                                    <th>Method</th>
                                    <th>Stock Available</th>
                                    <th>Consumption</th>
                                    <th>Balance</th>
                                </tr>

                                <?php
                                $a = 1;
                                foreach ($products_arr as $id => $item) {
                                    if (in_array($id, [31,32])){
                                        continue;
                                    }
                                    echo '<tr>';
                                    echo '<td> ' . $a++ . ' </td>';
                                    echo '<td> ' . $item . ' </td>';
                                    echo '<td><input class="form-control" type="number" min="0" value="'. ((isset($prev_data_consumption[$id]['followup_clients']))?$prev_data_consumption[$id]['wh_obl_a']:'') .'" name="commodities_utilization[opening_balance][' . $id . ']" style="height:25px"></td>';//Stock Available
                                    echo '<td><input class="form-control" type="number" min="0" value="'. ((isset($prev_data_consumption[$id]['followup_clients']))?$prev_data_consumption[$id]['wh_issue_up']:'') .'" name="commodities_utilization[issuance][' . $id . ']" style="height:25px"></td>';//Consumption
                                    echo '<td><input class="form-control" type="number" min="0" value="'. ((isset($prev_data_consumption[$id]['followup_clients']))?$prev_data_consumption[$id]['wh_cbl_a']:'') .'" name="commodities_utilization[closing_balance][' . $id . ']" style="height:25px"></td>';//Balance
                                    echo '</tr>';
                                }
                                ?>
                            </table>

                            <br>
                            <h4>&nbsp; Referrals</h4>
                            <table class="table table-bordered" width="100%">
                                <tr>
                                    <th>Sr No.</th>
                                    <th>Referred By</th>
                                    <th>No of referrals</th>
                                </tr>
                                <tr>
                                    <td>1</td>
                                    <td>Lady Health Worker</td>
                                    <td><input class="form-control" type="number" min="0" name="referrals[lhw]" style="height:25px" value="<?= ((isset($prev_data_referral['lhw']))?$prev_data_referral['lhw']:'') ?>"></td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Family Welfare Assistant</td>
                                    <td><input class="form-control" type="number" min="0" name="referrals[fwa]" style="height:25px" value="<?= ((isset($prev_data_referral['fwa']))?$prev_data_referral['fwa']:'') ?>"></td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>Social Mobilizer</td>
                                    <td><input class="form-control" type="number" min="0" name="referrals[sm]" style="height:25px" value="<?= ((isset($prev_data_referral['sm']))?$prev_data_referral['sm']:'') ?>"></td>
                                </tr>
                            </table>

                            <input type="hidden" name="stakeholder" value="<?=$stk?>">
                            <input type="hidden" name="prov_sel" value="<?=$province?>">
                            <input type="hidden" name="district" value="<?=$district?>">
                            <input type="hidden" name="month" value="<?=$month?>">
                            <input type="submit" class="btn btn-success" value="Submit">
                        </form>
                    </div>
                    <!-- // Content END -->
                </div>
            </div>
        </div>
    </div>
</div>
</div>
</body>
<!-- END BODY -->

</html>