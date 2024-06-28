<?php
/**
 * cls11
 * @package reports
 * 
 * @author     Ajmal Hussain
 * @email <ahussain@ghsc-psm.org>
 * 
 * @version    2.2
 * 
 */
ini_set('max_execution_time', 300);
//include AllClasses
include("../includes/classes/AllClasses.php");
//include header
include(PUBLIC_PATH . "html/header.php");
//report id
$rptId = 'dpw_punjab';
//if submitted
if (isset($_POST['submit'])) {
    //get selected month
    //$selMonth = mysql_real_escape_string($_POST['month_sel']);
    //get selected year
    //$selYear = mysql_real_escape_string($_POST['year_sel']);
    //get selected province
    $selProv = mysql_real_escape_string($_POST['prov_sel']);
    $stakeholder = mysql_real_escape_string($_POST['stakeholder']);
    //get selected item
    $selItem = mysql_real_escape_string($_POST['itm_id']);
    $fromDate = date('Y-m-01', strtotime($_POST['year_sel'].'-'.$_POST['month_sel'].' -2 months'));
    // var_dump($fromDate);die();
    $toDate = $_POST['year_sel'].'-'.$_POST['month_sel'].'-'.'01';
    //get reporting date
    //$reportingDate = mysql_real_escape_string($_POST['year_sel']) . '-' . $selMonth . '-01';
    $reportingDate = $toDate;

    if ($fromDate == $toDate) {
        //reporting period                          
        $reportingPeriod = "For the period of " . date('M-Y', strtotime($fromDate)) . ' to ' . date('M-Y', strtotime($toDate));
    } else {
        //reporting period  
        $reportingPeriod = "For the month of " . date('M-Y', strtotime($toDate));
    }
    // Get Province name
    $qry = "SELECT
                tbl_locations.LocName
            FROM
                tbl_locations
            WHERE
                tbl_locations.PkLocID = $selProv";
    //query result
    $row = mysql_fetch_array(mysql_query($qry));
    //province name
    $provinceName = $row['LocName'];
    //select query
    // Get 
    // Product name
    //product id
    $qry = "SELECT
                itminfo_tab.itmrec_id,
                itminfo_tab.itm_name
            FROM
                itminfo_tab
            WHERE
                itminfo_tab.itm_id = '$selItem' ";
    //query result
    $row = mysql_fetch_array(mysql_query($qry));
    //item name
    $itemName = $row['itm_name'];
    //item rec id
    $itemRecId = $row['itmrec_id'];
    //file name
    $fileName = 'CLR11_' . $itemName . '_' . $provinceName . '_for_' . str_replace(" ", "", str_replace("'", "", str_replace("-", "", $reportingDate)));
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
                        <h3 class="page-title row-br-b-wp">Provincial PWD District Wise Stock Report- Punjab</h3>
                        <div class="widget" data-toggle="collapse-widget">
                            <div class="widget-head">
                                <h3 class="heading">Filter by</h3>
                            </div>
                            <div class="widget-body">
                                <?php
                                //include sub_dist_form
                                include('sub_dist_form.php');
                                ?>
                            </div>
                        </div>
                    </div>
                </div>
                <?php
                if (isset($_POST['submit'])) {
                    //select query
                    //gets
                    //B.PkLocID,
                    //Loccation Name,
                    //pk id,
                    //hf type,
                    //OB,
                    //Rcv,
                    //Issue,
                    //CB,
                    //hf type rank                
                    $qry = "SELECT
                        B.PkLocID,
                        B.LocName,
                        A.OB,
                        A.Rcv,
                        A.Issue,
                        A.CB,
                        A.hf_type_rank 
                    FROM
                        (
                        SELECT
                            tbl_hf_type.pk_id AS hf_type_id,
                            tbl_hf_data.item_id,
                            itminfo_tab.itm_id,
                            itminfo_tab.itm_category,
                            SUM( tbl_hf_data.opening_balance ) AS OB,
                            SUM( tbl_hf_data.received_balance ) AS Rcv,
                            SUM( tbl_hf_data.issue_balance ) AS Issue,
                            SUM( tbl_hf_data.adjustment_positive ) AS adjustment_positive,
                            SUM( tbl_hf_data.adjustment_negative ) AS adjustment_negative,
                            SUM( tbl_hf_data.closing_balance ) AS CB,
                            tbl_hf_type_rank.hf_type_rank,
                            tbl_locations.LocName,
                            tbl_locations.PkLocID 
                        FROM
                            tbl_warehouse
                            INNER JOIN tbl_hf_type ON tbl_hf_type.pk_id = tbl_warehouse.hf_type_id
                            INNER JOIN tbl_hf_type_rank ON tbl_hf_type.pk_id = tbl_hf_type_rank.hf_type_id
                            INNER JOIN tbl_hf_data ON tbl_warehouse.wh_id = tbl_hf_data.warehouse_id
                            INNER JOIN itminfo_tab ON tbl_hf_data.item_id = itminfo_tab.itm_id
                            LEFT JOIN tbl_hf_data_reffered_by ON tbl_hf_data.pk_id = tbl_hf_data_reffered_by.hf_data_id
                            INNER JOIN tbl_locations ON tbl_warehouse.dist_id = tbl_locations.PkLocID 
                        WHERE
                            tbl_locations.ParentID = $selProv  
                            AND tbl_hf_data.item_id = $selItem 
                            AND tbl_hf_type_rank.province_id = $selProv 
                            AND tbl_hf_type_rank.stakeholder_id = $stakeholder 
                            AND tbl_hf_data.reporting_date = '$reportingDate'
                            GROUP BY
                                    tbl_locations.PkLocID 
                        ORDER BY
                            tbl_hf_type_rank.hf_type_rank ASC,
                            itminfo_tab.frmindex ASC 
                        ) AS A
                        RIGHT JOIN (
                        SELECT DISTINCT
                            tbl_locations.PkLocID,
                            tbl_locations.LocName 
                        FROM
                            tbl_warehouse
                            INNER JOIN tbl_locations ON tbl_warehouse.dist_id = tbl_locations.PkLocID
                            INNER JOIN wh_user ON tbl_warehouse.wh_id = wh_user.wh_id 
                        WHERE
                            tbl_warehouse.prov_id = $selProv 
                            AND tbl_warehouse.stkid = $stakeholder 
                            AND tbl_warehouse.is_active = 1 
                        ) AS B ON A.PkLocID = B.PkLocID 
                    ORDER BY
                        B.LocName ASC,
                        A.hf_type_rank ASC";
                   // echo $qry;exit;
                    $qryRes = mysql_query($qry);
                    //get query result
                    // Sort the array
                    if (mysql_num_rows($qryRes) > 0) {
                        //include sub_dist_reports
                        include('sub_dist_reports.php');
                        ?>
                        <div class="col-md-12" style="overflow:auto;">
                            <?php
                            $distId = '';
                            //fetch result
                            while ($row = mysql_fetch_array($qryRes)) {
//                                $hfType[$row['hf_type_id']] = $row['hf_type'];
                                if ($distId != $row['PkLocID']) {
                                    //location name
                                    $districtName[$row['PkLocID']] = $row['LocName'];
                                    //pk location id
                                    $distId = $row['PkLocID'];
                                }
                                //Opening Balance
                                $data[$row['PkLocID']]['OB'] = $row['OB'];
                                //receive
                                $data[$row['PkLocID']]['Rcv'] = $row['Rcv'];
                                //issue
                                $data[$row['PkLocID']]['Issue'] = $row['Issue'];
                                //Closing Balance
                                $data[$row['PkLocID']]['CB'] = $row['CB'];
                            }
                            ?>
                            <table width="100%" class="table table-striped" id="myTable" >
                                <tr >
                                    <td align="center"><h4 class="center"> Provincial PWD District Wise Stock Report- Punjab  <?php echo $itemName; ?> <br>
                                            <?php echo $reportingPeriod . ', Province ' . $provinceName; ?> </h4></td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="padding-top: 10px;"><table width="100%" id="myTable" cellspacing="0" align="center">
                                            <thead>
                                                <tr>
                                                    <th rowspan="2" width="4%">S.No.</th>
                                                    <th rowspan="2" width="11%">District</th>
                                                    <th rowspan="2" width="11%">AMC</th>
                                                    <th colspan="5">District Store</th>
                                                    <th colspan="4">Field Store</th>
                                                    <th rowspan="2" width="11%">Total Available Balance</th>
                                                    <th rowspan="2" width="10%">Total MOS</th>
                                                </tr>
                                                <tr>
                                                    <?php
                                                    //District Store Total Columns
                                                    //Receive
//                                                    echo "<th width='" . (85 / (count($hfType) * 4)) . "%'>AMC</th>";
                                                    //Opening Balance
                                                    echo "<th width='" . (85 / (count($hfType) * 4)) . "%'>Closing Balance Of ".date('M-Y', strtotime($reportingDate.' -1 months'))."</th>";
                                                    //Receive
                                                    echo "<th width='" . (85 / (count($hfType) * 4)) . "%'>Received</th>";
                                                    //Issue
                                                    echo "<th width='" . (85 / (count($hfType) * 4)) . "%'>Issuance</th>";
                                                    //Closing Balance
                                                    echo "<th width='" . (85 / (count($hfType) * 4)) . "%'>Available Balance Store</th>";
                                                    // MOS
                                                    echo "<th width='" . (85 / (count($hfType) * 4)) . "%'>MOS</th>";

                                                    //Field Total Columns
                                                    //Amc
//                                                    echo "<th width='" . (85 / (count($hfType) * 4)) . "%'>AMC</th>";
                                                    //Opening Balance
                                                    echo "<th width='" . (85 / (count($hfType) * 4)) . "%'>Closing Balance Of ".date('M-Y', strtotime($reportingDate.' -1 months'))."</th>";
                                                    //Receive
                                                    echo "<th width='" . (85 / (count($hfType) * 4)) . "%'>Receiving</th>";
                                                    //Closing Balance
                                                    echo "<th width='" . (85 / (count($hfType) * 4)) . "%'>Available Balance SDOs</th>";
                                                    echo "<th width='" . (85 / (count($hfType) * 4)) . "%'>MOS</th>";
                                                    ?>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <?php
                                                $counter = 1;
                                                $opening_gtotal_dist = $receive_gtotal_dist = $issue_gtotal_dist = $closing_gtotal_dist = $amc_gtotal_dist = $mos_gtotal_dist = 0;
                                                $opening_gtotal_field = $receive_gtotal_field = $issue_gtotal_field = $closing_gtotal_field = $amc_gtotal_field = $mos_gtotal_field = $gtotal = $gtotal_mos = $total_mos = 0;
                                                //fetch results
                                                foreach ($districtName as $id => $name) {

                                                    // Get District warehouse
                                                    $qry = "SELECT
                                                                    tbl_warehouse.wh_id
                                                                FROM
                                                                    tbl_warehouse
                                                                INNER JOIN stakeholder ON tbl_warehouse.stkofficeid = stakeholder.stkid
                                                                WHERE
                                                                    tbl_warehouse.dist_id = $id
                                                                AND tbl_warehouse.stkid = $stakeholder
                                                                AND stakeholder.lvl = 3
                                                                ORDER BY
                                                                    tbl_warehouse.wh_id ASC
                                                                LIMIT 1";
                                                    //query result
                                                    $qryRes = mysql_fetch_array(mysql_query($qry));
                                                    //district warehouse
                                                    $distWH = $qryRes['wh_id'];
                                                    // Get District warehouse
                                                    $qryField = "SELECT
                                                                    tbl_warehouse.wh_id
                                                                FROM
                                                                    tbl_warehouse
                                                                INNER JOIN stakeholder ON tbl_warehouse.stkofficeid = stakeholder.stkid
                                                                WHERE
                                                                    tbl_warehouse.dist_id = $id
                                                                AND tbl_warehouse.stkid = $stakeholder
                                                                AND stakeholder.lvl = 4
                                                                ORDER BY
                                                                    tbl_warehouse.wh_id ASC
                                                                LIMIT 1";
                                                    //query result
                                                    $qryResField = mysql_fetch_array(mysql_query($qryField));
                                                    //district warehouse
                                                    $fieldWH = $qryResField['wh_id'];
                                                    //select query
                                                    //gets
                                                    //tbl_warehouse.dist_id,
                                                    //item id,
                                                    //Opening Balance,
                                                    //Receive,
                                                    //Issue,
                                                    //Closing Balance DistStore
                                                    $qry_dist = "SELECT
                                                                        tbl_warehouse.dist_id,
                                                                        itminfo_tab.itm_id,
                                                                        SUM(tbl_wh_data.wh_obl_a) AS OB,
                                                                        SUM(tbl_wh_data.wh_received) AS Rcv,
                                                                        SUM(tbl_wh_data.wh_issue_up) AS Issue
                                                                    FROM
                                                                        tbl_wh_data
                                                                    INNER JOIN itminfo_tab ON tbl_wh_data.item_id = itminfo_tab.itmrec_id
                                                                    INNER JOIN tbl_warehouse ON tbl_warehouse.wh_id = tbl_wh_data.wh_id
                                                                    WHERE
                                                                        tbl_wh_data.RptDate = '$reportingDate'
                                                                    AND tbl_wh_data.wh_id = $distWH
                                                                    AND tbl_wh_data.item_id = '$itemRecId'
                                                                    AND tbl_warehouse.stkid = $stakeholder";
                                                    //query result
                                                    $qryRes_dist = mysql_query($qry_dist);
                                                    $tIssue = 0;
                                                    $loop = 0;
                                                    $dateissue = $reportingDate;
                                                    start:
//                                                    $qry_dist_amc = "SELECT
//                                                                        SUM(tbl_wh_data.wh_issue_up) AS Issue
//                                                                    FROM
//                                                                        tbl_wh_data
//                                                                    INNER JOIN itminfo_tab ON tbl_wh_data.item_id = itminfo_tab.itmrec_id
//                                                                    INNER JOIN tbl_warehouse ON tbl_warehouse.wh_id = tbl_wh_data.wh_id
//                                                                    WHERE
//                                                                        tbl_wh_data.RptDate = '$dateissue'
//                                                                    AND tbl_wh_data.wh_id = $distWH
//                                                                    AND tbl_wh_data.item_id = '$itemRecId'
//                                                                    AND tbl_warehouse.stkid = $stakeholder";
                                                               $qry_dist_amc = " SELECT
                                                                        summary_district.avg_consumption AS Issue 
                                                                FROM
                                                                        summary_district 
                                                                WHERE
                                                                        summary_district.reporting_date = '$dateissue' 
                                                                        AND summary_district.stakeholder_id = $stakeholder 
                                                                        AND summary_district.district_id = $id 
                                                                        AND summary_district.item_id = '$itemRecId'";
                                                                    // echo $qry_dist_amc;die();
                                                    $qryRes_dist_amc = mysql_query($qry_dist_amc);
                                                    $district_amc = mysql_fetch_assoc($qryRes_dist_amc);
//                                                    if ($district_amc['Issue'] != NULL && $district_amc['Issue'] > 0) {
                                                        $tIssue = $district_amc['Issue'];
//                                                        $loop++;
//                                                    }
                                                    $dateissue2 = date('Y-m-01', strtotime($dateissue.' -1 months'));
//                                                    if($loop != 3){
//                                                        goto start;
//                                                    }
                                                    $qry_field_amc = "SELECT
                                                                        SUM(tbl_wh_data.wh_issue_up) AS Issue
                                                                    FROM
                                                                        tbl_wh_data
                                                                    INNER JOIN itminfo_tab ON tbl_wh_data.item_id = itminfo_tab.itmrec_id
                                                                    INNER JOIN tbl_warehouse ON tbl_warehouse.wh_id = tbl_wh_data.wh_id
                                                                    WHERE
                                                                        tbl_wh_data.RptDate BETWEEN '$dateissue2' AND '$dateissue'
                                                                    AND tbl_wh_data.wh_id = $fieldWH
                                                                    AND tbl_wh_data.item_id = '$itemRecId'
                                                                    AND tbl_warehouse.stkid = $stakeholder";
                                                                    // echo $qry_field_amc;die();
                                                    $field_amc = mysql_fetch_assoc(mysql_query($qry_field_amc));
                                                    $opening_dist = $receive_dist = $issue_dist = $CBDistStore = $mos_district = $amc_district = 0;
                                                    if (mysql_num_rows($qryRes_dist) > 0) {
                                                        $row_dist = mysql_fetch_array($qryRes_dist);
                                                        $opening_dist = $row_dist['OB'];
                                                        $amc_district = ($tIssue);
                                                        $issue_dist = $row_dist['Issue'];
                                                        $receive_dist = $row_dist['Rcv'];
                                                        $CBDistStore = ($opening_dist + $receive_dist) - $issue_dist;
                                                        $mos_district = $CBDistStore / $amc_district;

                                                        $amc_gtotal_dist += $amc_district;
                                                        $receive_gtotal_dist += $receive_dist;
                                                        $opening_gtotal_dist += $opening_dist;
                                                        $mos_gtotal_dist += $mos_district;
                                                        $issue_gtotal_dist += $issue_dist;
                                                        $closing_gtotal_dist += $CBDistStore;
                                                        $gtotal += $CBDistStore;
                                                    }
                                                    ?>
                                                    <tr>
                                                        <td class="center"><?php echo $counter++; ?></td>
                                                        <td><?php echo $name; ?></td>
                                                        <?php
                                                        $district_total_html = $field_total_html = "";
                                                        $issue = (isset($data[$id]['Issue']) ? $data[$id]['Issue'] : 0);
                                                        $amc = ($tIssue);
                                                        $receive = $row_dist['Issue'];
                                                        $opening = (isset($data[$id]['OB']) ? $data[$id]['OB'] : 0);
                                                        $closing = ($opening + $receive - $issue);
                                                        $mos = $closing / $amc;
                                                        
                                                        $opening_gtotal_field += $opening;
                                                        $receive_gtotal_field += $receive;
                                                        $closing_gtotal_field += $closing;
                                                        $amc_gtotal_field += $amc;
                                                        $mos_gtotal_field += $mos;

                                                        $gtotal += $closing;
                                                        $total_mos = ($mos_district + $mos);
                                                        $gtotal_mos += $total_mos;

                                                        $district_total_html .= "<td class=\"right\">" . number_format((isset($amc_district) ? $amc_district : '0')) . "</td>";
                                                        $district_total_html .= "<td class=\"right\">" . number_format(isset($opening_dist) ? $opening_dist : '0') . "</td>";
                                                        $district_total_html .= "<td class=\"right\">" . number_format((isset($receive_dist) ? $receive_dist : '0')) . "</td>";
                                                        $district_total_html .= "<td class=\"right\">" . number_format((isset($issue_dist) ? $issue_dist : '0')) . "</td>";
                                                        $district_total_html .= "<td class=\"right\">" . number_format($CBDistStore) . "</td>";
                                                        $district_total_html .= "<td class=\"right\">" . number_format($mos_district, 2) . "</td>";

//                                                        $field_total_html .= "<td class=\"right\">" . number_format($amc) . "</td>";
                                                        $field_total_html .= "<td class=\"right\">" . number_format($opening) . "</td>";
                                                        $field_total_html .= "<td class=\"right\">" . number_format($receive) . "</td>";
                                                        $field_total_html .= "<td class=\"right\">" . number_format($closing) . "</td>";
                                                        $field_total_html .= "<td class=\"right\">" . number_format($mos, 2) . "</td>";
                                                        $field_total_html .= "<td class=\"right\">" . number_format($CBDistStore+$closing) . "</td>";
                                                        $field_total_html .= "<td class=\"right\">" . number_format($total_mos, 2) . "</td>";

                                                        echo $district_total_html;
                                                        echo $field_total_html;
                                                        ?>
                                                    </tr>
                                                    <?php
                                                }
                                                ?>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th colspan="2" class="right">Grand Total</th>
                                                    <th class="right"><?= number_format($amc_gtotal_dist);?></th>
                                                    <th class="right"><?= number_format($opening_gtotal_dist);?></th>
                                                    <th class="right"><?= number_format($receive_gtotal_dist);?></th>
                                                    <th class="right"><?= number_format($issue_gtotal_dist);?></th>
                                                    <th class="right"><?= number_format($closing_gtotal_dist);?></th>
                                                    <th class="right"><?= number_format($mos_gtotal_dist, 3);?></th>
                                                    <!--<th class="right"><?= number_format($amc_gtotal_field);?></th>-->
                                                    <th class="right"><?= number_format($opening_gtotal_field);?></th>
                                                    <th class="right"><?= number_format($receive_gtotal_field);?></th>
                                                    <th class="right"><?= number_format($closing_gtotal_field);?></th>
                                                    <th class="right"><?= number_format($mos_gtotal_field, 3);?></th>
                                                    <th class="right"><?= number_format($gtotal);?></th>
                                                    <th class="right"><?= number_format($gtotal_mos, 3);?></th>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <?php
                } else {
                    echo "No record found";
                }
            }
            // Unset varibles
            unset($data, $issue, $hfType, $districtName);
            ?>
        </div>
    </div>
</div>
<?php
include PUBLIC_PATH . "/html/footer.php";
//include combos
include ('combos.php');
?>
<script>
    $(function () {
        $('#stakeholder').change(function (e) {
            $('#itm_id, #prov_sel').html('<option value="">Select</option>');
            showProducts('');
            showProvinces('');
        });
    })
    function showProducts(pid) {
        var stk = $('#stakeholder').val();
        if (typeof stk !== 'undefined')
        {
            $.ajax({
                url: 'ajax_calls.php',
                type: 'POST',
                data: {stakeholder: stk, productId: pid},
                success: function (data) {
                    $('#itm_id').html(data);
                }
            })
        }
    }
    function showProvinces(pid) {
        var stk = $('#stakeholder').val();
        if (typeof stk !== 'undefined')
        {
            $.ajax({
                url: 'ajax_stk.php',
                type: 'POST',
                data: {stakeholder: stk, provinceId: pid, showProvinces: 1},
                success: function (data) {
                    $('#prov_sel').html(data);
                }
            })
        }
    }
</script>
</body>
</html>