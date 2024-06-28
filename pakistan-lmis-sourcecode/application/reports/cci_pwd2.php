<?php
set_time_limit(0);
/**
 * spr3
 * @package reports
 * 
 * @author     Ajmal Hussain
 * @email <ahussain@ghsc-psm.org>
 * 
 * @version    2.2
 * 
 */
//include AllClasses
include("../includes/classes/AllClasses.php");
//include header
include(PUBLIC_PATH . "html/header.php");
//report id
$rptId = 'spr3';
//distrcit id
$districtId = '';
//stakeholder 
$stakeholder = 1;
//selected year
$selYear = '';
////selected province
$selProv = '';
//check if submitted
if (isset($_POST['submit'])) {
    //selected province
    $selProv = mysql_real_escape_string($_POST['prov_sel']);
    //from date
    $fromDate = isset($_POST['from_date']) ? mysql_real_escape_string($_POST['from_date']) : '';
    //to date
    $toDate = isset($_POST['to_date']) ? mysql_real_escape_string($_POST['to_date']) : '';
    //start date
    $startDate = $fromDate . '-01';
    //end date
    $endDate = date("Y-m-t", strtotime($toDate));
    //select query
    // Get Province name
    $qry = "SELECT
                tbl_locations.LocName
            FROM
                tbl_locations
            WHERE
                tbl_locations.PkLocID = $selProv";
    //fetch result
    $row = mysql_fetch_array(mysql_query($qry));
    //province name
    $provinceName = $row['LocName'];
    //file name
    $fileName = 'SPR3_' . $provinceName . '_from_' . date('M-Y', strtotime($startDate)) . '_to_' . date('M-Y', strtotime($endDate));
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
                        <h3 class="page-title row-br-b-wp">Provincial Summary (CCI Format 2)</h3>
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
                //if submitted
                if (isset($_POST['submit'])) {
                    $query = "SELECT
                        Count( DISTINCT tbl_warehouse.wh_id ) AS total_outlets,
                        tbl_warehouse.dist_id,
                        tbl_warehouse.hf_type_id 
                    FROM
                        tbl_warehouse
                        INNER JOIN wh_user ON tbl_warehouse.wh_id = wh_user.wh_id
                        INNER JOIN stakeholder ON tbl_warehouse.stkofficeid = stakeholder.stkid 
                    WHERE
                        tbl_warehouse.prov_id IN ( $selProv ) 
                        AND tbl_warehouse.stkid IN ( 1 ) 
                        AND tbl_warehouse.reporting_start_month <= '$startDate'
                        AND stakeholder.lvl = 7 
                        AND tbl_warehouse.hf_type_id IN ( 1, 2, 4 )
                    GROUP BY
                        tbl_warehouse.hf_type_id";
                    $resultQuery = mysql_query($query);
                    $qry = "SELECT
	COUNT( DISTINCT A.wh_id ) AS so_facilities ,
	A.hf_type,
    A.pk_id,
	A.itm_name AS product_name,
	A.itm_id AS product_id
FROM
	(
	SELECT
		tbl_warehouse.wh_id,
        tbl_warehouse.hf_type_id,
		tbl_hf_data.closing_balance ,
		tbl_hf_type.hf_type,
		tbl_hf_type.pk_id,
		itminfo_tab.itm_id,
		itminfo_tab.itm_name
	FROM
		tbl_warehouse
		INNER JOIN stakeholder ON stakeholder.stkid = tbl_warehouse.stkofficeid
		INNER JOIN tbl_hf_data ON tbl_warehouse.wh_id = tbl_hf_data.warehouse_id
		INNER JOIN tbl_locations ON tbl_warehouse.dist_id = tbl_locations.PkLocID
		INNER JOIN tbl_hf_type ON tbl_warehouse.hf_type_id = tbl_hf_type.pk_id
		INNER JOIN itminfo_tab ON tbl_hf_data.item_id = itminfo_tab.itm_id 
	WHERE
		stakeholder.lvl = 7 
		AND tbl_warehouse.prov_id IN ( $selProv ) 
		AND tbl_warehouse.stkid IN ( 1 ) 
		AND tbl_hf_data.reporting_date BETWEEN '$startDate' AND '$endDate'
		AND itminfo_tab.itm_category = 1 
		AND itminfo_tab.itm_id IN ( 1, 9, 2, 3, 7, 34, 5, 13, 8 ) 
		AND tbl_hf_type.pk_id IN ( 1,2,4 ) 
		AND closing_balance <= 0 
	) AS A 
        GROUP BY
	A.pk_id,
	A.itm_id 
        ORDER BY
		 FIELD(A.itm_id, 1, 9, 2, 3, 7, 34, 5, 13, 8),"
                            . "A.pk_id";
// echo $qry;exit;
                    $qryRes = mysql_query($qry);
                    //if result exists
                    if (mysql_num_rows($qryRes) > 0) {
                        ?>
                        <?php
                        //include sub_dist_reports
                        include('sub_dist_reports.php');
                        ?>
                        <div class="col-md-12" style="overflow:auto;">
                            <?php
                            //items
                            $items = $hfType = array();
                            //fetch result
                            while ($row = mysql_fetch_array($qryRes)) {
                                //hf type
                                $hfType[$row['pk_id']] = $row['hf_type'];
                                $items[$row['product_id']] = $row['product_name'];
                                $data[$row['pk_id']][$row['product_id']] = $row['so_facilities'];
                            }
                            ?>
                            <table width="100%">
                                <tr>
                                    <td style="padding-top: 10px;" align="center">
                                        <h4 class="center bold">
                                            CCI Format 2 (Outlet & Product wise Stock out Report) <?php echo 'From ' . date('M-Y', strtotime($startDate)) . ' to ' . date('M-Y', strtotime($endDate)); ?><br>
                                            Inrespect of Population Welfare Department <?php echo $provinceName ?>
                                        </h4>
                                        <table width="100%" id="myTable" cellspacing="0" align="center">
                                            <thead>
                                                <tr>
                                                    <th rowspan="2">S.No.</th>
                                                    <th rowspan="2" width="13%">Name of Service Outlet</th>
                                                    <th rowspan="2">No. of Outlets</th>
                                                    <?php
                                                    foreach ($items as $name) {
                                                        echo "<th>$name</th>";
                                                    }
                                                    ?>
                                                </tr>
                                                <tr></tr>
                                            </thead>
                                            <tbody>
                                                <?php
                                                //counter
                                                $counter = 1;
                                                $totalReportedOutlets = 0;
                                                $prod_totals = array();
                                                $totalOutlets = 0;
                                                foreach ($hfType as $id => $hfName) {
                                                    $row_outlets = mysql_fetch_object($resultQuery);
                                                    ?>
                                                    <tr>
                                                        <td class="center"><?= $counter++; ?></td>
                                                        <td><?= $hfName; ?></td>
                                                        <td style="text-align: right;"><?= number_format($row_outlets->total_outlets, 2);?></td>
                                                        <?php
                                                        foreach ($items as $pid => $methodName) {
                                                            $val = ( (!empty($data[$id][$pid])) ? $data[$id][$pid] : 0 );
                                                            $d1 = new DateTime($endDate);
                                                            $d2 = new DateTime($startDate);
                                                            $interval = $d1->diff($d2);
                                                            $diffInSeconds = $interval->s; //45
                                                            $diffInMinutes = $interval->i; //23
                                                            $diffInHours   = $interval->h; //8
                                                            $diffInDays    = $interval->d; //21
                                                            $diffInMonths  = $interval->m; //4
                                                            $diffInYears   = $interval->y; //1
                                                            if (empty($prod_totals[$pid]))
                                                                $prod_totals[$pid] = 0;
                                                            $prod_totals[$pid] += number_format($val/($diffInMonths+1), 2);
                                                            echo "<td class=\"right\">" . number_format($val/($diffInMonths+1), 2) . "</td>";
                                                        }
                                                        $totalOutlets += $row_outlets->total_outlets;
                                                        ?>
                                                    </tr>
                                                    <?php
                                                }
                                                ?>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th colspan="2" style="text-align: right;">Total</th>
                                                    <td style="text-align: right;"><?= number_format($totalOutlets, 2);?></td>
                                                <?php if(!empty($prod_totals)):?>
                                                <?php foreach ($prod_totals as $key => $total):?>
                                                    <td style="text-align: right;"><?= number_format($total, 2);?></td>
                                                <?php endforeach;?>
                                                <?php endif;?>
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
unset($data, $issue, $totalUsers, $totalCYP, $items, $distName, $totalOutlets, $product);
?>
        </div>
    </div>
</div>
<?php
//include footer
include PUBLIC_PATH . "/html/footer.php";
//include combos
include('combos.php');
?>
</body>
</html>