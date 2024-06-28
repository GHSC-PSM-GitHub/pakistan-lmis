<?php
include("../includes/classes/AllClasses.php");
include(PUBLIC_PATH . "html/header.php");
//echo '<pre>';
//print_r($_SESSION);
//echo '</pre>';
//exit;        
$from_date = date('Y-m-01');
$to_date = date('Y-m-d');

$stakeholder = $_SESSION['user_stakeholder1'];
$selProv = $_SESSION['user_province1'];

if (!empty($_REQUEST['from_date']))
    $from_date = $_REQUEST['from_date'];
if (!empty($_REQUEST['to_date']))
    $to_date = $_REQUEST['to_date'];

if (isset($_POST['prov_sel'])){
    $selProv = $_POST['prov_sel'];/*print_r($selProv);exit();*/
}

$dist = '';
if (isset($_POST['district'])){
    $dist = $_POST['district'];
}


if (isset($_POST['stakeholder'])){
    $stakeholder = $_POST['stakeholder'];
}

$indicator = '';
if (isset($_POST['indicator'])){
    $indicator = $_POST['indicator'];
}

$rpt_type = '';
if (isset($_POST['rpt_type'])){
    $rpt_type = $_POST['rpt_type'];
}

$indicator_list = array(
    'obl' => 'Opening Balance',
    'rcv' => 'Receiving',
    'iss' => 'Issuance',
    'cbl' => 'Closing Balance',
    'pad' => 'Positive Adjustment(+)',
    'nad' => 'Negative Adjustment(-)',
    'ncl' => 'New Client',
    'ocl' => 'Old Client',
    'rem' => 'Removals',
    'rcs' => 'Surgery Cases(Referred)',
    'ics' => 'Cases of Implants',
    'scs' => 'Surgery Cases(Performed)',
    'mcs' => 'Mother & Child Care (No. of Cases)'
);
//echo '<pre>';
//print_r($cyp_array);
//echo '</pre>';
//exit;    

?>
<style>
    canvas {
        -moz-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
    }
    table.table thead .sorting_disabled, table.table thead .sorting {
        background: #2272b7 !important;
        color: #FFF !important;
    }
    
</style>
    <link rel="stylesheet" type="text/css" href="../../public/assets/global/plugins/select2/select2.css"/>
</head>

<body class="page-header-fixed page-quick-sidebar-over-content">
    <div class="page-container">
        <?php
        include PUBLIC_PATH . "html/top.php";
        include PUBLIC_PATH . "html/top_im.php";
        ?>
        <div class="page-content-wrapper">
            <div class="page-content"> 
                <!-- BEGIN PAGE HEADER-->
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="font-blue-chambray">Report

                            <?php
                            if (!is_request_from_mobile()) {
                                ?>
                                <a class="btn btn-info pull-right"  download href="../../public/docs/fp_client_register.xlsx"><i class="fa fa-download"></i> Download FP Client Register</a>
                                <?php
                            }
                            ?>
                        </h3>
                        <div class="widget" data-toggle="collapse-widget">
                            <div class="widget-head">
                                <h3 class="heading">  Report  </h3>
                            </div>
                            <div class="widget-body">
                                <form method="POST" name="" id="" action="" >
                                    <div class="row">
                                        <div class="col-md-12">

                                            <div class="col-md-2">
                                                <div class="control-group">
                                                    <label class="control-label" for="date_of_visit">From <span
                                                                class="font-red">*</span> </label>
                                                    <div class="controls">
                                                        <input type="date" required value="<?= $from_date ?>" max="<?= date('Y-m-d') ?>" id="from_date" name="from_date" class="form-control">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="control-group">
                                                    <label class="control-label" for="date_of_visit">To <span
                                                                class="font-red">*</span> </label>
                                                    <div class="controls">
                                                        <input type="date" required value="<?= $to_date ?>" max="<?= date('Y-m-d') ?>" id="to_date" name="to_date" class="form-control">
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="control-group ">
                                                    <label class="control-label">Stakeholder</label>
                                                    <div class="controls" id="districtsCol">
                                                        <select name="stakeholder" id="stakeholder" class="select2me" style="width: 100%" onchange="change_province()">

                                                            <?php
                                                            $stkFilter = ' stakeholder.stk_type_id IN (0, 1)';
                                                            $qry = "SELECT DISTINCT
					                                                	stakeholder.stkid,
					                                                	stakeholder.stkname
					                                                FROM
					                                                	tbl_warehouse
					                                                INNER JOIN stakeholder ON tbl_warehouse.stkid = stakeholder.stkid
					                                                INNER JOIN wh_user ON tbl_warehouse.wh_id = wh_user.wh_id
					                                                WHERE
					                                                	$stkFilter
					                                                AND tbl_warehouse.is_active = 1
					                                                ORDER BY
					                                                	stakeholder.stk_type_id ASC,
					                                                	stakeholder.stkorder ASC";
                                                            $rsfd = mysql_query($qry) or die(mysql_error());
                                                            $stk_name = '';
                                                            while ($row = mysql_fetch_array($rsfd)) {
                                                                $sel = '';

                                                                if ($stakeholder == $row['stkid']) {
                                                                    $sel = 'selected="selected"';
                                                                    $stk_name = $row['stkname'];
                                                                }
                                                                echo "<option value=\"" . $row['stkid'] . "\" $sel>" . $row['stkname'] . "</option>";
                                                            }
                                                            ?>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label class="control-label">Province</label>
                                                    <div class="form-group">
                                                        <select name="prov_sel" id="prov_sel" required
                                                                class="form-control" onchange="change_province()">
                                                            <option value="">Select</option>
                                                            <?php

                                                            $queryprov = "SELECT
                                                                            tbl_locations.PkLocID AS prov_id,
                                                                            tbl_locations.LocName AS prov_title
                                                                        FROM
                                                                            tbl_locations
                                                                        WHERE
                                                                            LocLvl = 2
                                                                        AND parentid IS NOT NULL";
                                                            //query result
                                                            $rsprov = mysql_query($queryprov) or die();
                                                            $prov_name = '';
                                                            while ($rowprov = mysql_fetch_array($rsprov)) {
                                                                if (!empty($selProv) && ($selProv == $rowprov['prov_id'])) {
                                                                    $sel = "selected='selected'";
//                                                        $prov_name = $rowprov['prov_title'];
                                                                } else {
                                                                    $sel = "";
                                                                }

//                                                                if ($_SESSION['user_province1'] != $rowprov['prov_id']){
//                                                                    continue;
//                                                                }
                                                                ?>
                                                                <option value="<?php echo $rowprov['prov_id']; ?>" <?php echo $sel; ?>><?php echo $rowprov['prov_title']; ?></option>
                                                                <?php
                                                            }

                                                            ?>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="form-group" id="districtDiv">
                                                    <label class="control-label">District</label>
                                                    <div class="form-group">
                                                        <select required name="district" id="district"
                                                                class="form-control">
                                                            <option value="">All</option>

                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label class="control-label">Indicator</label>
                                                    <div class="form-group">
                                                        <select required name="indicator" id="indicator" class="form-control">
                                                            <?php
                                                            foreach ($indicator_list as $code => $name){
                                                                $ind_sel = '';
                                                                if ($code == $indicator){
                                                                    $ind_sel = 'selected';
                                                                }
                                                                echo '<option '. $ind_sel .' value="'. $code .'"> '. $name .' </option>';
                                                            }
                                                            ?>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label class="control-label">Report Type</label>
                                                    <div class="form-group">
                                                        <label>District <input <?= (($rpt_type == 'dist')?'checked':'') ?>checked type="radio" value="dist" name="rpt_type"></label>
                                                        <label>Facility <input <?= (($rpt_type == 'fac')?'checked':'') ?> type="radio" value="fac" name="rpt_type"></label>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-2">

                                                <label class="control-label"></label>
                                                    <div class="controls">
                                                        <input name="submit" type="submit" value="Search" class="form-control btn btn-success">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <?php
                        if (isset($_POST['submit'])) {

                            $im_indicator_list = array('obl', 'rcv','iss','cbl', 'pad', 'nad', 'ncl', 'ocl', 'rem');

                            if (in_array($indicator, $im_indicator_list)) {
                                $column_name = '';
                                switch ($indicator){
                                    case 'obl':
                                        $column_name = 'opening_balance';
                                        break;
                                    case 'rcv':
                                        $column_name = 'received_balance';
                                        break;
                                    case 'iss':
                                        $column_name = 'issue_balance';
                                        break;
                                    case 'cbl':
                                        $column_name = 'closing_balance';
                                        break;
                                    case 'pad':
                                        $column_name = 'adjustment_positive';
                                        break;
                                    case 'nad':
                                        $column_name = 'adjustment_negative';
                                        break;
                                    case 'ncl':
                                        $column_name = 'new';
                                        break;
                                    case 'ocl':
                                        $column_name = 'old';
                                        break;
                                    case 'rem':
                                        $column_name = 'removals';
                                        break;
                                    default:
                                        //to avoid error
                                        $column_name = 'opening_balance';
                                }

                                $dist_filter = '';
                                if (!empty($dist)){
                                    $dist_filter = "tbl_warehouse.dist_id = $dist AND";
                                }

                                $rpt_type_filter = '';
                                if ($rpt_type == 'fac'){
                                    $rpt_type_filter = ",tbl_warehouse.wh_id";
                                }
                                if ($rpt_type == 'dist'){
                                    $rpt_type_filter = ",tbl_warehouse.dist_id";
                                }

                                $qry = "
                                SELECT
                                	tbl_hf_data.item_id, 
                                	itminfo_tab.itm_name, 
                                	SUM(tbl_hf_data.$column_name) AS quantity, 
                                	tbl_warehouse.wh_name,
                                	prov.LocName province, 
                                	dist.LocName district,
                                	reporting_date,
                                	wh_id
                                FROM
                            	tbl_hf_data
                            	INNER JOIN
                            	tbl_warehouse
                            	ON 
                            		tbl_hf_data.warehouse_id = tbl_warehouse.wh_id
                            	INNER JOIN
                            	itminfo_tab
                            	ON 
                            		tbl_hf_data.item_id = itminfo_tab.itm_id
                            	INNER JOIN
                            	tbl_locations AS dist
                            	ON 
                            		tbl_warehouse.dist_id = dist.PkLocID
                            	INNER JOIN
                            	tbl_locations AS prov
                            	ON 
                            		tbl_warehouse.prov_id = prov.PkLocID
                                WHERE
                                	$dist_filter
                                	tbl_warehouse.prov_id = $selProv AND
                                	tbl_warehouse.stkid = 1 AND
                                	item_id NOT IN (31,32) AND
                                	tbl_hf_data.reporting_date >= '$from_date' 
                                AND tbl_hf_data.reporting_date <= '$to_date'
                                GROUP BY
                                	item_id,
	                                reporting_date
                                    $rpt_type_filter
                                ORDER BY
	                            district,item_id
                                ";
//                                echo $qry;exit();
                                //query result
                                $rs = mysql_query($qry) or die('Invalid Parameters');

                                //Arrays Processing
                                $all_months = array();
                                $all_items = array();
                                $all_wh = array();
                                $qty_data = array();
                                $wh_data = array();
                                while ($row = mysql_fetch_assoc($rs)) {
                                    $all_months[$row['reporting_date']] = $row['reporting_date'];
                                    $all_items[$row['item_id']] = $row['itm_name'];
                                    $all_wh[$row['wh_id']] = $row['wh_name'];
                                    $qty_data[$row['wh_id']][$row['reporting_date']][$row['item_id']] = $row['quantity'];
                                    $wh_data[$row['wh_id']] = $row;
                                }
//                                print_r($all_months);
//                                print_r($all_wh);
//                                print_r($qty_data);exit();
                                //End Array Processing

                                echo '<div style="overflow: auto">';
                                echo '<table class="table table-bordered">';

                                echo '<thead>';
                                echo '<tr>';
                                echo '<th> Sr No. </th>';
                                echo '<th> Province </th>';
                                echo '<th> District </th>';
                                if ($rpt_type == 'fac'){
                                    echo '<th> Facility Name </th>';
                                }
                                echo '<th> Item Name </th>';
                                foreach ($all_months as $month){
                                    echo "<th> Quantity ($month) </th>";
                                }
                                echo '<th> Total </th>';
                                echo '</tr>';
                                echo '</thead>';

                                echo '<tbody>';
                                $a = 1;
                                $col_count = array();
                                foreach ($all_wh as $wh_id => $wh) {
                                    foreach ($all_items as $item_id => $item) {
                                        $row_total = 0;
                                        echo '<tr>';
                                        echo '<td> ' . $a++ . ' </td>';
                                        echo '<td> ' . $wh_data[$wh_id]['province'] . ' </td>';
                                        echo '<td> ' . $wh_data[$wh_id]['district'] . ' </td>';
                                        if ($rpt_type == 'fac') {
                                            echo '<td> ' . $wh . ' </td>';
                                        }
                                        echo '<td> ' . $item . ' </td>';
                                        foreach ($all_months as $month) {
                                            echo '<td> ' . ((isset($qty_data[$wh_id][$month][$item_id]))?$qty_data[$wh_id][$month][$item_id]:0) . ' </td>';
                                            @$row_total += $qty_data[$wh_id][$month][$item_id];
                                            @$col_count[$month] += $qty_data[$wh_id][$month][$item_id];
                                        }
                                        echo "<td> $row_total </td>";
                                        echo '</tr>';
                                    }
                                }

                                echo '</tbody>';

                                echo '<tfoot>';

                                echo '<tr>';
                                $colspan = 4;
                                if ($rpt_type == 'fac'){
                                    $colspan = 5;
                                }
                                echo '<td colspan="'. $colspan .'"> Total </td>';
                                foreach ($all_months as $month){
                                    echo '<td> '. $col_count[$month] .' </td>';
                                }
                                echo '<td> - </td>';
                                echo '</tr>';

                                echo '</tfoot>';

                                echo '</table>';
                                echo '</div>';
                            }
                            elseif ($indicator == 'mcs'){

                                $rpt_type_filter = '';
                                if ($rpt_type == 'fac'){
                                    $rpt_type_filter = ",tbl_hf_mother_care.warehouse_id";
                                }
                                if ($rpt_type == 'dist'){
                                    $rpt_type_filter = ",dist.PkLocID";
                                }

                                $qry = "
                                SELECT
                                	wh_id,
                                	tbl_warehouse.wh_name,
                                	prov.LocName province,
                                	dist.LocName district,
                                	reporting_date,
                                	SUM(tbl_hf_mother_care.pre_natal_new) as pre_natal_new,
                                	SUM(tbl_hf_mother_care.pre_natal_old) as pre_natal_old,
                                	SUM(tbl_hf_mother_care.post_natal_new) as post_natal_new,
                                	SUM(tbl_hf_mother_care.post_natal_old) as post_natal_old,
                                	SUM(tbl_hf_mother_care.ailment_children) as ailment_children,
                                	SUM(tbl_hf_mother_care.ailment_adults) as ailment_adults,
                                	SUM(tbl_hf_mother_care.general_ailment) as general_ailment
                                FROM
                                	tbl_hf_mother_care
                                	INNER JOIN tbl_warehouse ON tbl_hf_mother_care.warehouse_id = tbl_warehouse.wh_id
                                	INNER JOIN tbl_locations AS dist ON tbl_warehouse.dist_id = dist.PkLocID
                                	INNER JOIN tbl_locations AS prov ON tbl_warehouse.prov_id = prov.PkLocID 
                                WHERE
                                	tbl_warehouse.prov_id = $selProv 
                                	AND tbl_warehouse.dist_id = $dist 
                                	AND tbl_warehouse.stkid = $stakeholder 
                                	AND tbl_hf_mother_care.reporting_date >= '$from_date' 
                                	AND tbl_hf_mother_care.reporting_date <= '$to_date' 
                                GROUP BY
                                	reporting_date
                                    $rpt_type_filter
                                ORDER BY
                                	district
                                ";
//                                echo $qry;exit();
                                //query result
                                $rs = mysql_query($qry) or die('Invalid Parameters');

                                $mcs_data = array();
                                while ($row = mysql_fetch_assoc($rs)) {
                                    $all_months[$row['reporting_date']] = $row['reporting_date'];
                                    $all_wh[$row['wh_id']] = $row['wh_name'];
                                    $mcs_data[$row['wh_id']][$row['reporting_date']] = $row;
                                    $wh_data[$row['wh_id']] = $row;
                                }

//                                print_r($mcs_data);

                                echo '<div style="overflow: auto">';
                                echo '<table class="table table-bordered">';

                                echo '<thead>';
                                echo '<tr>';
                                echo '<th> Sr No. </th>';
                                echo '<th> Province </th>';
                                echo '<th> District </th>';
                                if ($rpt_type == 'fac'){
                                    echo '<th> Facility Name </th>';
                                }
                                foreach ($all_months as $month){
                                    echo "<th> $month </th>";
                                }
//                                echo '<td> Total </td>';
                                echo '</tr>';
                                echo '</thead>';

                                echo '<tbody>';
                                $a = 1;
                                foreach ($all_wh as $wh_id => $wh_name){
                                    echo '<tr>';
                                    echo '<td> '. $a++ .' </td>';
                                    echo '<td> '. $wh_data[$wh_id]['province'] .' </td>';
                                    echo '<td> '. $wh_data[$wh_id]['district'] .' </td>';
                                    if ($rpt_type == 'fac') {
                                        echo '<td> ' . $wh_name . ' </td>';
                                    }
                                    foreach ($all_months as $month){
                                        echo '<td>';
                                        echo '<table class="table table-bordered ">';

                                        echo '<thead>';

                                        echo '<tr>';
                                        echo '<td></td>';
                                        echo '<td> New </td>';
                                        echo '<td> Old </td>';
                                        echo '</tr>';

                                        echo '<tr>';
                                        echo '<td>Ante-natal</td>';
                                        echo '<td> '. $mcs_data[$wh_id][$month]['pre_natal_new'] .' </td>';
                                        echo '<td> '. $mcs_data[$wh_id][$month]['pre_natal_old'] .' </td>';
                                        echo '</tr>';

                                        echo '<tr>';
                                        echo '<td>Post-natal</td>';
                                        echo '<td> '. $mcs_data[$wh_id][$month]['post_natal_new'] .' </td>';
                                        echo '<td> '. $mcs_data[$wh_id][$month]['post_natal_old'] .' </td>';
                                        echo '</tr>';

                                        echo '<tr>';
                                        echo '<td>Children</td>';
                                        echo '<td> '. $mcs_data[$wh_id][$month]['ailment_children'] .' </td>';
                                        echo '<td> '. $mcs_data[$wh_id][$month]['ailment_adults'] .' </td>';
                                        echo '</tr>';

                                        echo '<tr>';
                                        echo '<td>General Ailment</td>';
                                        echo '<td colspan="2"> '. $mcs_data[$wh_id][$month]['general_ailment'] .' </td>';
                                        echo '</tr>';

                                        echo '</thead>';

                                        echo '</table>';
                                        echo '</td>';
                                    }
                                    echo '</tr>';
                                }
                                echo '</tbody>';

                                echo '</table>';
                                echo '</div>';
                            }
                        }
                        ?>
                    </div>
                </div>
            </div>
        </div>
    </div>
        <!-- // Content END -->
<?php
include PUBLIC_PATH . "/html/footer.php";

$districtId = isset($districtId) ? $districtId : '';
?>
    <script type="text/javascript" src="../../public/assets/global/plugins/select2/select2.min.js"></script>

    <script>
        change_province();

        function change_province(){
            var provinceId = $('#prov_sel').val();
            if (provinceId != '')
            {
                var stkk = $('#stakeholder').val();
                if(stkk=='undefined' || stkk == ''){
                var stkk = 1;
                }

                $.ajax({
                    url: '../reports/ajax_calls.php',
                    data: {
                        provinceId: provinceId,
                        dId: '<?php echo $districtId; ?>',
                        stkId: stkk
                    },
                    type: 'POST',
                    success: function(data)
                    {
                        $('#districtDiv').html(data);
                        $("#district").prepend("<option value='' selected='selected'>All</option>");
                        $('#district option[value="<?=$dist?>"]').prop('selected', true)
                    }
                })
            }
        }
    </script>
</body>
</html>