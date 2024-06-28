<?php
//echo '<pre>';print_r($_REQUEST);exit;
//include AllClasses
include("../includes/classes/AllClasses.php");
//include header
include(PUBLIC_PATH . "html/header.php");
//report id
$rptId = 'dpr';
//user province id
$userProvId = $_SESSION['user_province1'];
//if submitted
if (isset($_POST['submit'])) {
    //get from date
    $fromDate = isset($_POST['from_date']) ? mysql_real_escape_string($_POST['from_date']) : '';
    //get to date
    $toDate = isset($_POST['to_date']) ? mysql_real_escape_string($_POST['to_date']) : '';
    //get selected province
    $selProv = mysql_real_escape_string($_POST['prov_sel']);
    //get district id
    $districtId = mysql_real_escape_string($_POST['district']);
    //get stakeholder
    $stakeholder = mysql_real_escape_string($_POST['stakeholder']);
//select query
    // Get district name
    $qry = "SELECT
                tbl_locations.LocName
            FROM
                tbl_locations
            WHERE
                tbl_locations.PkLocID = $districtId";
    //query result
    $row = mysql_fetch_array(mysql_query($qry));
    //district name
    $distrctName = $row['LocName'];

    // Get item data
    $qry = "SELECT
                *
            FROM
                itminfo_tab";
    //query result
    $qryRes = mysql_query($qry);
    $item_arr = array();
    while ($row = mysql_fetch_assoc($qryRes)) {
        $item_arr[$row['itmrec_id']] = $row;
    }
    // echo '<pre>';
    // print_r($item_arr);
    //file name
    $fileName = 'DPR_' . $distrctName . '_for_' . $fromDate . '-' . $toDate;
}
//districtId
$districtId = isset($districtId) ? $districtId : '';
if (empty($stakeholder)){
    $stakeholder = 1;
}
//fromDate
$fromDate = isset($fromDate) ? $fromDate : '';
//toDate
$toDate = isset($toDate) ? $toDate : '';
//selProv
$selProv = isset($selProv) ? $selProv : '0';
?>
</head>
<!-- END HEAD -->
<body class="page-header-fixed page-quick-sidebar-over-content">
    <div class="page-container">
<?php
//include top
include PUBLIC_PATH . "html/top.php";
//include top_im
include PUBLIC_PATH . "html/top_im.php";
?>
        <div class="page-content-wrapper">
            <div class="page-content">
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="page-title row-br-b-wp">PWD-4 Report</h3>
                        <div class="widget" data-toggle="collapse-widget">
                            <div class="widget-head">
                                <h3 class="heading">Filter by</h3>
                            </div>
                            <div class="widget-body">
                                <?php
                                //sub_dist_form
                                //                                include('sub_dist_form.php');
                                ?>
                                <form name="frm" id="frm" action="" method="post" role="form">
                                    <div class="row">
                                        <div class="col-md-12">

                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label class="control-label">Start Date</label>
                                                    <div class="form-group">
                                                        <input type="text" name="from_date" id="from_date" readonly="readonly" class="form-control input-sm" value="<?php echo $fromDate; ?>" required>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label class="control-label">End Date</label>
                                                    <div class="form-group">
                                                        <input type="text" name="to_date" id="to_date" readonly="readonly" class="form-control input-sm" value="<?php echo $toDate; ?>" required>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label class="control-label">Stakeholder</label>
                                                    <div class="form-group">
                                                        <select name="stakeholder" id="stakeholder" required class="form-control input-sm" onchange="showDistricts();">
                                                            <option value="">Select</option>
                                                            <?php

                                                            $querys = "SELECT
                                                                        stakeholder.stkid,
                                                                        stakeholder.stkname
                                                                        FROM
                                                                        stakeholder
                                                                        WHERE
                                                                        stakeholder.ParentID IS NULL
                                                                        AND stakeholder.stk_type_id IN (0, 1) AND
                                                                        stakeholder.is_reporting = 1
                                                                        AND stakeholder.lvl = 1
                                                                        ORDER BY
                                                                        stakeholder.stkorder ASC";
                                                            //query result
                                                            $rsprov = mysql_query($querys) or die();
                                                            $stk_name = '';
                                                            while ($rowp = mysql_fetch_array($rsprov)) {
                                                                if ($stakeholder == $rowp['stkid']) {
                                                                    $sel = "selected='selected'";
                                                                    $stk_name = $rowp['stkname'];
                                                                } else {
                                                                    $sel = "";
                                                                }
                                                                //Populate prov_sel combo

                                                                // Hide all other stakeholders other than own for AIDS Sindh. Jira Ticket ID: LMIS-3356
                                                                if (!($_SESSION['user_stakeholder1'] == 3421 && $_SESSION['user_province1'] == 2) || $rowp['stkid'] == 3421) {
                                                                    if (!($_SESSION['user_stakeholder1'] == 9 && $_SESSION['user_province1'] == 2) || $rowp['stkid'] == 9) {

                                                                        ?>
                                                                        <option value="<?php echo $rowp['stkid']; ?>" <?php echo $sel; ?>><?php echo $rowp['stkname']; ?></option>
                                                                        <?php
                                                                    }
                                                                }
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
                                                        <select name="prov_sel" id="prov_sel" required class="form-control input-sm">
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
                                                                if ($selProv == $rowprov['prov_id']) {
                                                                    $sel = "selected='selected'";
                                                                    $prov_name = $rowprov['prov_title'];
                                                                } else {
                                                                    $sel = "";
                                                                }
                                                                //Populate prov_sel combo
                                                                // Hide all other province other than AIDS Sindh. Jira Ticket ID: LMIS-3356
                                                                // Hide all other province other than PPHI (For PPHI Reports)
                                                                if (!(($_SESSION['user_stakeholder1'] == 3421 || $_SESSION['user_stakeholder1'] == 9) && $_SESSION['user_province1'] == 2) || $rowprov['prov_id'] == 2) {

                                                                    ?>
                                                                    <option value="<?php echo $rowprov['prov_id']; ?>" <?php echo $sel; ?>><?php echo $rowprov['prov_title']; ?></option>
                                                                    <?php
                                                                }
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
                                                        <select name="district" id="district" class="form-control input-sm">
                                                            <option value="">All</option>

                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-2">
                                                <div class="form-group" id="districtDiv">
                                                    <label class="control-label">Indicator</label>
                                                    <div class="form-group">
                                                        <select name="indicator" id="indicator"
                                                                class="form-control input-sm">
                                                            <option value="com">Change of Method</option>
                                                            <option value="rem">Removals</option>
                                                            <option value="dro">Dropouts</option>
                                                            <option value="ret">Retrieved</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-12">
                                                    <div class="form-group">
                                                        <div class="form-group">
                                                            <button type="submit" name="submit" class="btn btn-primary input-sm">Go</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <?php
                //check if submitted
                if (isset($_POST['submit'])) {
                if (empty($fromDate) || empty($toDate)) {
                    //reporting period
                    $reportingPeriod = " Until " . date('M-Y', strtotime('today'));
                } else if ($fromDate != $toDate) {
                    //reportint period
                    $reportingPeriod = "For the period of " . date('M-Y', strtotime($fromDate)) . ' to ' . date('M-Y', strtotime($toDate));
                } else {
                    //reportint period
                    $reportingPeriod = "For the month of " . date('M-Y', strtotime($fromDate));
                }
                //define variable
                $from_date = $_POST['from_date'];
                $to_date = $_POST['to_date'];
                $stakeholder = $_POST['stakeholder'];
                $province = $_POST['prov_sel'];
                $district = $_POST['district'];
                $indicator = $_POST['indicator'];
                $district_filter = '';
                if ($district != 'all') {
                    $district_filter = "fp_adp_consumption.dist_id = $district AND";
                }
                // get districts
                $qry = "
                    SELECT
	                    PkLocID,
	                    LocName 
                    FROM
                    	tbl_locations
                    WHERE
                        ParentID = 1 
                        AND LocLvl = 3
                    ORDER BY
	                    LocName
                        ";
                //query result
                //    echo $qry;exit;
                $qryRes = mysql_query($qry);
                //                    check if result exists
                if (mysql_num_rows($qryRes) > 0) {
                    $all_districts = array();
                while ($row = mysql_fetch_assoc($qryRes)) {
                    $all_districts[] = $row;
                }
                ?>
                <?php
                //include sub_dist_reports
                include('sub_dist_reports.php');
                ?>
                <div class="col-md-12" style="overflow:auto;">
                    <?php


                    //end referrals

                    //                         echo '<pre>';
                    //                         print_r($processed_data);
                    //                         echo '</pre>';exit();
                    //print_r($_SESSION);
                    ?>
                    <table id="myTable" width="100%" border="1">
                        <tr>
                            <td align="center" colspan="22">
                                <h4 class="center">
                                    <?php
                                    echo "PWD-4 - $reportingPeriod<br>";
                                    ?>
                                    <?php echo 'Inrespect of  District ' . $distrctName . ' , Population Welfare Department ' . $prov_name; ?>
                                </h4>
                            </td>

                        </tr>
<!---->
<!--                        <tr>-->
<!--                            <th colspan=""><h4>Change of Method</h4></th>-->
<!--                        </tr>-->
                        <?php

                        //Change of Method
                        if ($indicator == 'com') {

                            $products_arr = array();
                            $products_arr[1] = 'Condom';
                            $products_arr[2] = 'POP';
                            $products_arr[9] = 'COC';
                            $products_arr[3] = 'ECP';
                            $products_arr[5] = 'Copper-T-380A';
                            $products_arr[7] = '3-Month Inj';
                            $products_arr[34] = '3 Month Inj - Sayana Press';
                            $products_arr[8] = 'Implanon';
                            $products_arr[81] = 'Implanon NXT';
                            $products_arr[13] = 'Jadelle';

                            echo '<tr>';
                            echo '<td rowspan="2"> Sr. No </td>';
                            echo '<td rowspan="2"> District </td>';
                            foreach ($products_arr as $product_id => $product_name) {
                                echo '<td colspan="2" class="center"> ' . $product_name . ' </td>';
                            }
                            echo '</tr>';

                            echo '<tr>';
                            foreach ($products_arr as $product_id => $product_name) {
                                echo '<td class="center"> + </td>';
                                echo '<td class="center"> - </td>';
                            }
                            echo '</tr>';

                            $a = 1;
                            foreach ($all_districts as $row) {
                                echo '<tr>';
                                echo '<td>' . $a++ . '</td>';
                                echo '<td>' . $row['LocName'] . '</td>';
                                foreach ($products_arr as $product_id => $product_name) {
                                    echo '<td class="center"> 0 </td>';
                                    echo '<td class="center"> 0 </td>';
                                }
                                echo '</tr>';
                            }
                        }

                        if ($indicator == 'rem'){

                            $products_arr = array();
//                            $products_arr[1] = 'Condom';
//                            $products_arr[2] = 'POP';
//                            $products_arr[9] = 'COC';
//                            $products_arr[3] = 'ECP';
                            $products_arr[5] = 'Copper-T-380A';
//                            $products_arr[7] = '3-Month Inj';
//                            $products_arr[34] = '3 Month Inj - Sayana Press';
                            $products_arr[8] = 'Implanon';
                            $products_arr[81] = 'Implanon NXT';
                            $products_arr[13] = 'Jadelle';

                            echo '<tr>';
                            echo '<td> Sr. No </td>';
                            echo '<td> District </td>';
                            foreach ($products_arr as $product_id => $product_name) {
                                echo '<td class="center"> ' . $product_name . ' </td>';
                            }
                            echo '</tr>';

                            $a = 1;
                            foreach ($all_districts as $row) {
                                echo '<tr>';
                                echo '<td>' . $a++ . '</td>';
                                echo '<td>' . $row['LocName'] . '</td>';
                                foreach ($products_arr as $product_id => $product_name) {
                                    echo '<td class="center"> 0 </td>';
                                }
                                echo '</tr>';
                            }
                        }

                        if ($indicator == 'dro'){

                            $products_arr = array();
                            $products_arr[1] = 'Condom';
                            $products_arr[2] = 'POP';
                            $products_arr[9] = 'COC';
                            $products_arr[3] = 'ECP';
                            $products_arr[5] = 'Copper-T-380A';
                            $products_arr[7] = '3-Month Inj';
                            $products_arr[34] = '3 Month Inj - Sayana Press';
                            $products_arr[8] = 'Implanon';
                            $products_arr[81] = 'Implanon NXT';
                            $products_arr[13] = 'Jadelle';

                            echo '<tr>';
                            echo '<td> Sr. No </td>';
                            echo '<td> District </td>';
                            foreach ($products_arr as $product_id => $product_name) {
                                echo '<td class="center"> ' . $product_name . ' </td>';
                            }
                            echo '</tr>';

                            $a = 1;
                            foreach ($all_districts as $row) {
                                echo '<tr>';
                                echo '<td>' . $a++ . '</td>';
                                echo '<td>' . $row['LocName'] . '</td>';
                                foreach ($products_arr as $product_id => $product_name) {
                                    echo '<td class="center"> 0 </td>';
                                }
                                echo '</tr>';
                            }
                        }

                        if ($indicator == 'ret'){

                            $products_arr = array();
                            $products_arr[1] = 'Condom';
                            $products_arr[2] = 'POP';
                            $products_arr[9] = 'COC';
                            $products_arr[3] = 'ECP';
                            $products_arr[5] = 'Copper-T-380A';
                            $products_arr[7] = '3-Month Inj';
                            $products_arr[34] = '3 Month Inj - Sayana Press';
                            $products_arr[8] = 'Implanon';
                            $products_arr[81] = 'Implanon NXT';
                            $products_arr[13] = 'Jadelle';

                            echo '<tr>';
                            echo '<td> Sr. No </td>';
                            echo '<td> District </td>';
                            foreach ($products_arr as $product_id => $product_name) {
                                echo '<td class="center"> ' . $product_name . ' </td>';
                            }
                            echo '</tr>';

                            $a = 1;
                            foreach ($all_districts as $row) {
                                echo '<tr>';
                                echo '<td>' . $a++ . '</td>';
                                echo '<td>' . $row['LocName'] . '</td>';
                                foreach ($products_arr as $product_id => $product_name) {
                                    echo '<td class="center"> 0 </td>';
                                }
                                echo '</tr>';
                            }
                        }
                        ?>

                    </table>
                </div>
            </div>
            <?php
            } else {
                echo "No record found";
            }
            }
            // Unset varibles
            unset($data, $total);
            ?>
        </div>
    </div>
</div>
                        <?php
                        //include footer
                        include PUBLIC_PATH . "/html/footer.php";
                        //include combos
                        include ('combos.php');
                        ?>
</body>
</html>