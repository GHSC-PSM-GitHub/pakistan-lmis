<?php
//echo '<pre>';print_r($_REQUEST);exit;
//include AllClasses
include("../includes/classes/AllClasses.php");
//include header
include(PUBLIC_PATH . "html/header.php");
//report id
$rptId = 'dpr';
$allOpt = 'yes';
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
                        <h3 class="page-title row-br-b-wp">Monthly Family Planning Report</h3>
                        <div class="widget" data-toggle="collapse-widget">
                            <div class="widget-head">
                                <h3 class="heading">Filter by</h3>
                            </div>
                            <div class="widget-body">
                                <?php
                                //sub_dist_form
                                include('sub_dist_form.php');
                                ?>
                            </div>
                        </div>

                    </div>
                </div>
                <?php
                //check if submitted
                if (isset($_POST['submit'])) {
                if (empty($fromDate) || empty($toDate)) {
                    $where = "  ";
                    $where2 = "  ";

                    //reporting period
                    $reportingPeriod = " Until " . date('M-Y', strtotime('today'));
                } else if ($fromDate != $toDate) {
                    $where = " AND RptDate BETWEEN '$fromDate-01' AND '$toDate-01' ";
                    $where2 = " AND tbl_hf_data.reporting_date BETWEEN '$fromDate-01' AND '$toDate-01' ";

                    //reportint period
                    $reportingPeriod = "For the period of " . date('M-Y', strtotime($fromDate)) . ' to ' . date('M-Y', strtotime($toDate));
                } else {
                    $where = " AND RptDate BETWEEN '$fromDate-01' AND '$toDate-01' ";
                    $where2 = " AND tbl_hf_data.reporting_date BETWEEN '$fromDate-01' AND '$toDate-01' ";
                    //reportint period
                    $reportingPeriod = "For the month of " . date('M-Y', strtotime($fromDate));
                }
                    //define variable
                    $from_date = $_POST['from_date'];
                    $to_date = $_POST['to_date'];
                    $stakeholder = $_POST['stakeholder'];
                    $province = $_POST['prov_sel'];
                    $district = $_POST['district'];
                    $district_filter = '';
                    if ($district != 'all'){
                        $district_filter = "fp_adp_consumption.dist_id = $district AND";
                    }
                    // get client data
                    $qry = "
                    SELECT
                    	fp_adp_consumption.item_id, 
                    	fp_adp_consumption.new_clients AS new, 
                    	fp_adp_consumption.followup_clients AS old, 
                    	fp_adp_consumption.wh_obl_a As opening_balance, 
                    	fp_adp_consumption.wh_issue_up As issue_balance, 
                    	fp_adp_consumption.wh_cbl_a As closing_balance,
                    	fp_adp_consumption.report_month
                    FROM
                    	fp_adp_consumption
                    WHERE
                    	$district_filter
                    	fp_adp_consumption.stk_id = $stakeholder AND
                    	fp_adp_consumption.report_month >= DATE_FORMAT('$from_date-01', '%Y-%m-%d') AND
                    	fp_adp_consumption.report_month <= DATE_FORMAT('$to_date-01', '%Y-%m-%d')
                    GROUP BY
                        fp_adp_consumption.item_id
                        ";
                    //query result
//    echo $qry;exit;
                    $qryRes = mysql_query($qry);
                    //check if result exists
//                    if (mysql_num_rows($qryRes) > 0) {
                        ?>
                        <?php
                        //include sub_dist_reports
                        include('sub_dist_reports.php');
                        ?>
                        <div class="col-md-12" style="overflow:auto;">
                        <?php
                        $processed_data = array();
                        while ($row = mysql_fetch_assoc($qryRes)) {
//                            print_r($row);
                            //client data
                            @$processed_data['client_data'][$row['item_id']]['new_total'] += $row['new'];
                            @$processed_data['client_data'][$row['item_id']]['old_total'] += $row['old'];
                            //end client data

                            //commodities utilization
                            if ($row['report_month'] == $from_date.'-01'){
                                $processed_data['commodities_utilization'][$row['item_id']]['ob'] = $row['opening_balance'];
                            }
                            if ($row['report_month'] == $to_date.'-01'){
                                $processed_data['commodities_utilization'][$row['item_id']]['cb'] = $row['closing_balance'];
                            }
                            @$processed_data['commodities_utilization'][$row['item_id']]['issue_balance'] += $row['issue_balance'];
                            //end commodities utilization
                        }

                        //referrals
                        if ($district != 'all'){
                            $district_filter = "fp_adp_referral.dist_id = $district AND";
                        }
                        $qry = "
                                SELECT
                                	fp_adp_referral.report_month,
	                                SUM(fp_adp_referral.lhw) as lhw,
	                                SUM(fp_adp_referral.fwa) as fwa,
	                                SUM(fp_adp_referral.sm) as sm
                                FROM
                                	fp_adp_referral
                                WHERE
                                	$district_filter
                                	fp_adp_referral.stk_id = $stakeholder AND
                                	fp_adp_referral.report_month >= DATE_FORMAT('$from_date-01', '%Y-%m-%d') AND
                                	fp_adp_referral.report_month <= DATE_FORMAT('$to_date-01', '%Y-%m-%d')
                        ";
                        //query result
//                            echo $qry;
                        $qryRes = mysql_query($qry);
                        if (mysql_num_rows($qryRes) > 0) {
                            while ($row = mysql_fetch_assoc($qryRes)) {
                                $processed_data['referrals']['lhw'] = $row['lhw'];
                                $processed_data['referrals']['fwa'] = $row['fwa'];
                                $processed_data['referrals']['sm'] = $row['sm'];
                            }
                        }

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
                            echo "Monthwise Family Planning Report - $reportingPeriod<br>";
                            ?>
                            <?php echo 'Inrespect of  District ' . $distrctName . ' , Population Welfare Department ' . $prov_name; ?>
                                        </h4>
                                    </td>

                                </tr>


                                <tr>
                                    <th colspan="12"><h4>Client Data</h4></th>
                                </tr>

                                <tr>
<!--                                    <td   style="text-align:center"rowspan="2" >S.No.</td>-->

                                    <td  align="center" rowspan="2" >Client Type</td>
                                    <td    style="text-align:center"rowspan="" >Condoms (Pcs)</td>
                                    <td colspan="3" rowspan=""   style="text-align:center">Oral Pills (Cycles)</td>
                                    <td colspan="2" rowspan=""   style="text-align:center">IUD (IUD)</td>
                                    <td colspan="3" rowspan=""   style="text-align:center">Injectables (Vials)</td>
                                    <td colspan="2" rowspan=""   style="text-align:center">Implant (Pcs)</td>
                                    <td colspan="2" rowspan=""   style="text-align:center">Surgery Cases</td>
                                </tr>




                                <tr>
                                    <td   style="text-align:center">Condom</td>
                                    <td   style="text-align:center">POP</td>
                                    <td   style="text-align:center">COC</td>
                                    <td   style="text-align:center">ECP</td>
                                    <td   style="text-align:center">Copper-T-380A</td>
                                    <td   style="text-align:center">Multiload</td>
                                    <td   style="text-align:center">2-Month Inj</td>
                                    <td   style="text-align:center">3-Month Inj</td>
                                    <td   style="text-align:center">3-Month Inj.- Sayana Press</td>
                                    <td   style="text-align:center">Implanon</td>
                                    <td   style="text-align:center">Jadelle</td>
                                    <td   style="text-align:center">Tubal Ligation</td>
                                    <td   style="text-align:center">Vasectomy</td>
                                </tr>
                                <tr>
                                    <td   style="text-align:center">1</td>

                                    <td   style="text-align:center">2</td>
                                    <td   style="text-align:center">3</td>
                                    <td   style="text-align:center">4</td>
                                    <td   style="text-align:center">5</td>
                                    <td   style="text-align:center">6</td>
                                    <td   style="text-align:center">7</td>
                                    <td   style="text-align:center">8</td>
                                    <td   style="text-align:center">9</td>
                                    <td   style="text-align:center">10</td>
                                    <td   style="text-align:center">11</td>
                                    <td   style="text-align:center">12</td>
                                    <td   style="text-align:center">13</td>
                                    <td   style="text-align:center">14</td>

                                </tr>    


        <?php
        $products_arr = array();
        $products_arr[1] = 'IT-001';
        $products_arr[2] = 'IT-002';
        $products_arr[9] = 'IT-009';
        $products_arr[3] = 'IT-003';
        $products_arr[5] = 'IT-005';
        $products_arr[4] = 'IT-004';
        $products_arr[6] = 'IT-006';
        $products_arr[7] = 'IT-007';
        $products_arr[8] = 'IT-008';
        $products_arr[13] = 'IT-013';
        $products_arr[34] = 'IT-034';
        $products_arr[32] = 'IT-032';
        $products_arr[31] = 'IT-031';

        $count = 0;
        $prod_totals = $master_total = array();
        ?>
                                <tr>
                                    <td>New</td>
                                    <?php
                                    foreach ($products_arr as $item_id => $item){
                                        echo '<td>'. ((isset($processed_data['client_data'][$item_id]['new_total']))?$processed_data['client_data'][$item_id]['new_total']:'N/A') .'</td>';
                                    }
                                    ?>
                                </tr>
                                <tr>
                                    <td>Follow Up</td>
                                    <?php
                                    foreach ($products_arr as $item_id => $item){
                                        echo '<td>'. ((isset($processed_data['client_data'][$item_id]['old_total']))?$processed_data['client_data'][$item_id]['old_total']:'N/A') .'</td>';
                                    }
                                    ?>
                                </tr>

                            </table>

                            <table id="myTable" width="100%">
                                <tr>
                                    <th colspan="5">Commodities Utilization</th>
                                </tr>
                                <tr>
                                    <td>Sr No.</td>
                                    <td>Method</td>
                                    <td>Stock Available</td>
                                    <td>Consumption</td>
                                    <td>Balance</td>
                                </tr>
                                <tr>
                                    <td>1</td>
                                    <td>Condom</td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][1]['ob']))?$processed_data['commodities_utilization'][1]['ob']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][1]['issue_balance']))?$processed_data['commodities_utilization'][1]['issue_balance']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][1]['cb']))?$processed_data['commodities_utilization'][1]['cb']:'0') ?></td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>POP</td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][2]['ob']))?$processed_data['commodities_utilization'][2]['ob']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][2]['issue_balance']))?$processed_data['commodities_utilization'][2]['issue_balance']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][2]['cb']))?$processed_data['commodities_utilization'][2]['cb']:'0') ?></td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>COC</td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][9]['ob']))?$processed_data['commodities_utilization'][9]['ob']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][9]['issue_balance']))?$processed_data['commodities_utilization'][9]['issue_balance']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][9]['cb']))?$processed_data['commodities_utilization'][9]['cb']:'0') ?></td>
                                </tr>
                                <tr>
                                    <td>4</td>
                                    <td>ECP</td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][3]['ob']))?$processed_data['commodities_utilization'][3]['ob']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][3]['issue_balance']))?$processed_data['commodities_utilization'][3]['issue_balance']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][3]['cb']))?$processed_data['commodities_utilization'][3]['cb']:'0') ?></td>
                                </tr>
                                <tr>
                                    <td>5</td>
                                    <td>Copper T</td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][5]['ob']))?$processed_data['commodities_utilization'][5]['ob']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][5]['issue_balance']))?$processed_data['commodities_utilization'][5]['issue_balance']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][5]['cb']))?$processed_data['commodities_utilization'][5]['cb']:'0') ?></td>
                                </tr>
                                <tr>
                                    <td>6</td>
                                    <td>2-Month Inj</td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][6]['ob']))?$processed_data['commodities_utilization'][6]['ob']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][6]['issue_balance']))?$processed_data['commodities_utilization'][6]['issue_balance']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][6]['cb']))?$processed_data['commodities_utilization'][6]['cb']:'0') ?></td>
                                </tr>
                                <tr>
                                    <td>7</td>
                                    <td>3-Month Inj</td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][7]['ob']))?$processed_data['commodities_utilization'][7]['ob']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][7]['issue_balance']))?$processed_data['commodities_utilization'][7]['issue_balance']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][7]['cb']))?$processed_data['commodities_utilization'][7]['cb']:'0') ?></td>
                                </tr>
                                <tr>
                                    <td>8</td>
                                    <td>3-Month Inj.- Sayana Press</td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][34]['ob']))?$processed_data['commodities_utilization'][34]['ob']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][34]['issue_balance']))?$processed_data['commodities_utilization'][34]['issue_balance']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][34]['cb']))?$processed_data['commodities_utilization'][34]['cb']:'0') ?></td>
                                </tr>
                                <tr>
                                    <td>9</td>
                                    <td>Implanon</td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][8]['ob']))?$processed_data['commodities_utilization'][8]['ob']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][8]['issue_balance']))?$processed_data['commodities_utilization'][8]['issue_balance']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][8]['cb']))?$processed_data['commodities_utilization'][8]['cb']:'0') ?></td>
                                </tr>
                                <tr>
                                    <td>10</td>
                                    <td>Jadelle</td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][13]['ob']))?$processed_data['commodities_utilization'][13]['ob']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][13]['issue_balance']))?$processed_data['commodities_utilization'][13]['issue_balance']:'0') ?></td>
                                    <td><?= ((isset($processed_data['commodities_utilization'][13]['cb']))?$processed_data['commodities_utilization'][13]['cb']:'0') ?></td>
                                </tr>
                            </table>

                            <table id="myTable" width="100%">
                                <tr>
                                    <th colspan="5">Referrals</th>
                                </tr>
                                <tr>
                                    <td>Sr No.</td>
                                    <td>Referred By</td>
                                    <td>No of referrals</td>
                                </tr>
                                <tr>
                                    <td>1</td>
                                    <td>Lady Health Worker</td>
                                    <td><?= ((isset($processed_data['referrals']['lhw']))?$processed_data['referrals']['lhw']:0) ?></td>
                                </tr>
                                <tr>
                                    <td>2</td>
                                    <td>Family Welfare Assistant</td>
                                    <td><?= ((isset($processed_data['referrals']['fwa']))?$processed_data['referrals']['fwa']:0) ?></td>
                                </tr>
                                <tr>
                                    <td>3</td>
                                    <td>Social Mobilizer</td>
                                    <td><?= ((isset($processed_data['referrals']['sm']))?$processed_data['referrals']['sm']:0) ?></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                                <?php
//                            } else {
//                                echo "No record found";
//                            }
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

                        function change_prov(){

                        }
                        ?>
</body>
</html>