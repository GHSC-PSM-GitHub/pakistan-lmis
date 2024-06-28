<?php
ini_set('max_execution_time', 300);
include("../includes/classes/AllClasses.php");
include(PUBLIC_PATH . "html/header.php");
$rptId = 'spr3';
$total_out_dist = 0;
$stakeholder = 1;
$t=0;
$t_u=0;
$t2=0;
$t_u2=0;
$selProv = 0;
$total_dist_array = array();
$total_out_type = 0;
$total_type_array = array();
$usr_col_array=array();
$usr_row_array=array();
$usr_col_array_type=array(); 
$c_type_array=array();
$c_dist_array=array();
$cyp_col_dist=array();
if (isset($_POST['submit'])) {
  //selected province
    $selProv = mysql_real_escape_string($_POST['prov_sel']);
    //from date
    $startDate = isset($_POST['from_date']) ? mysql_real_escape_string($_POST['from_date']) : '';
    //to date
    $endDate = isset($_POST['to_date']) ? mysql_real_escape_string($_POST['to_date']) : '';
    //start date
    $startDate = $startDate . '-01';
    //end date
    $endDate = date("Y-m-t", strtotime($endDate));
    
    $qry = "SELECT DISTINCT
	prov.LocName AS prov_name,
	dist.PkLocID AS dist_id,
	dist.LocName AS dist_name
FROM
	tbl_locations AS prov
INNER JOIN tbl_locations AS dist ON dist.ParentID = prov.PkLocID
INNER JOIN tbl_warehouse ON tbl_warehouse.dist_id = dist.PkLocID
INNER JOIN wh_user ON wh_user.wh_id = tbl_warehouse.wh_id
INNER JOIN stakeholder ON tbl_warehouse.stkofficeid = stakeholder.stkid
WHERE
	prov.PkLocID = $selProv
AND stakeholder.lvl = 3
AND tbl_warehouse.stkid = $stakeholder
ORDER BY
	dist_name ASC";
    $distName = array();
    $res = mysql_query($qry);
    while($row = mysql_fetch_assoc($res))
    {
        $provinceName = $row['prov_name'];
        $distName[$row['dist_id']] = $row['dist_name'];
    }
    $fileName = 'SPR3_' . $provinceName . '_from_' . date('M-Y', strtotime($startDate)) . '_to_' . date('M-Y', strtotime($endDate));
    $qry = "SELECT
            itminfo_tab.itm_id,
            itminfo_tab.itm_name,
            itminfo_tab.itm_category,
            itminfo_tab.method_type,
            itminfo_tab.method_rank,
            itminfo_tab.user_factor
            FROM
            itminfo_tab
            INNER JOIN stakeholder_item ON itminfo_tab.itm_id = stakeholder_item.stk_item
            WHERE
            itminfo_tab.itm_category in (1,2) AND
            itminfo_tab.method_type IS NOT NULL AND
            stakeholder_item.stkid = $stakeholder
            ORDER BY
            itminfo_tab.method_rank ASC

 ";
    $product = $items = $p_name_id =  array();
    $res = mysql_query($qry);
    while($row = mysql_fetch_assoc($res))
    {
        $product[$row['method_type']][] = $row['itm_name'];
        $items[$row['itm_id']] = $row['itm_name'];
        $p_name_id[$row['itm_name']] = $row['itm_id'];
        $usr_row_array[$row['itm_id']]=$row['user_factor'];
    }
    
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
                        <h3 class="page-title row-br-b-wp">Provincial Summary (CCI Format 1)</h3>
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
                    
                    $qryreportedWH = "SELECT
                                COUNT( DISTINCT tbl_warehouse.wh_id ) AS reportedWH 
                            FROM
                                tbl_warehouse
                                INNER JOIN wh_user ON tbl_warehouse.wh_id = wh_user.wh_id
                                INNER JOIN stakeholder ON tbl_warehouse.stkofficeid = stakeholder.stkid
                                INNER JOIN tbl_hf_data ON tbl_warehouse.wh_id = tbl_hf_data.warehouse_id
                                INNER JOIN tbl_hf_type ON tbl_warehouse.hf_type_id = tbl_hf_type.pk_id
                                INNER JOIN itminfo_tab ON tbl_hf_data.item_id = itminfo_tab.itm_id 
                            WHERE
                                tbl_warehouse.wh_id NOT IN ((
                                    SELECT
                                        warehouse_status_history.warehouse_id 
                                    FROM
                                        warehouse_status_history
                                        INNER JOIN tbl_warehouse ON warehouse_status_history.warehouse_id = tbl_warehouse.wh_id 
                                    WHERE
                                        warehouse_status_history.reporting_month BETWEEN '$startDate-01' 
                                        AND '$endDate-31' 
                                        AND warehouse_status_history.`status` = 0 
                                        AND tbl_warehouse.stkid = $stakeholder 
                                    )) 
                                AND tbl_warehouse.stkid = $stakeholder 
                                AND tbl_warehouse.prov_id = $selProv 
                                AND stakeholder.lvl = 7 
                                AND tbl_hf_data.reporting_date BETWEEN '$startDate' 
                                AND '$endDate' 
                                AND tbl_hf_type.pk_id IN ( 1,2,4,5,7,8) 
                                AND itminfo_tab.itm_category IN ( 1, 2 ) 
                            GROUP BY
                                tbl_hf_type.pk_id";
//                     echo $qryreportedWH;die();
                    $ResqryreportedWH = mysql_query($qryreportedWH);
                    
                    
                    

                    $qry = " SELECT
                                    tbl_hf_type_data.district_id,
                                    tbl_hf_type_data.facility_type_id,
                                    tbl_hf_type_data.item_id,
                                    tbl_hf_type_data.reporting_date,
                                    Sum(
                                            tbl_hf_type_data.issue_balance
                                    ) AS issuance,
                                    itminfo_tab.itm_name,
                            itminfo_tab.user_factor as u_factor,
                                    itminfo_tab.method_type,
                                    tbl_hf_type.hf_type,
                                    tbl_locations.LocName AS dist_name
                            FROM
                                    tbl_hf_type_data
                            INNER JOIN tbl_locations ON tbl_hf_type_data.district_id = tbl_locations.PkLocID
                            INNER JOIN itminfo_tab ON tbl_hf_type_data.item_id = itminfo_tab.itm_id
                            INNER JOIN tbl_hf_type ON tbl_hf_type_data.facility_type_id = tbl_hf_type.pk_id

                            WHERE
                                    tbl_locations.ParentID =$selProv
                            AND  tbl_hf_type_data.reporting_date BETWEEN '$startDate' 
                            AND '$endDate' 
                            AND itminfo_tab.itm_category = 1
                            AND method_type IS NOT NULL
                            AND tbl_hf_type.stakeholder_id = $stakeholder
                            AND  tbl_hf_type_data.facility_type_id IN (1,2,4,5,7,8)
                            GROUP BY
                                    tbl_hf_type_data.facility_type_id,
                                    tbl_hf_type_data.item_id
                            ORDER BY
                                    tbl_hf_type_data.facility_type_id
                        ";
                   // print_r($qry);
//                    echo $qry;exit;
                    $qryRes = mysql_query($qry);
                    $query_test = "SELECT
                            Count(distinct tbl_warehouse.wh_id) AS total_outlets,
                            tbl_warehouse.dist_id,
                            tbl_warehouse.hf_type_id
                            from tbl_warehouse

                            INNER JOIN wh_user ON tbl_warehouse.wh_id = wh_user.wh_id
                            INNER JOIN stakeholder ON tbl_warehouse.stkofficeid = stakeholder.stkid

                            WHERE
                            tbl_warehouse.prov_id = $selProv AND
                            tbl_warehouse.stkid = $stakeholder AND
                            tbl_warehouse.reporting_start_month <= '$startDate" . "-01'" . " AND
                            stakeholder.lvl = 7
                            AND tbl_warehouse.hf_type_id IN (1,2,4,5,7,8)
                            GROUP BY
                            tbl_warehouse.hf_type_id
                            ";
                                                $qryResTest = mysql_query($query_test);
                                                $query  = "SELECT
                            provincial_cyp_factors.cyp_factor as c_factor,
                            provincial_cyp_factors.item_id
                            FROM
                            provincial_cyp_factors
                            WHERE
                            provincial_cyp_factors.stakeholder_id = $stakeholder AND
                            provincial_cyp_factors.province_id = $selProv 

";
                    $result_cyp  = mysql_query($query );
                     // print_r($query);exit;
                    if (mysql_num_rows($qryRes) > 0 && mysql_num_rows($qryResTest) > 0 && mysql_num_rows($result_cyp) > 0) {
                        ?>
                        <?php
                        //include sub_dist_reports
                        include('sub_dist_reports.php');
                        ?>
                        <div class="col-md-12" style="overflow:auto;">
                            <?php
                            //set items				
                            $hfType = $type_wise_arr = $dist_wise_arr = $dist_name = array();
                            //get results
                            while ($row = mysql_fetch_array($qryRes)) {
                                if (!in_array($row['itm_name'], $items)) {
                                    //$items[$row['item_id']] = $row['itm_name'];
                                    //$product[$row['method_type']][] = $row['itm_name'];
                                }
                                $hfType[$row['facility_type_id']] = $row['hf_type'];
                                //$p_name_id[$row['itm_name']] = $row['item_id'];

                                @$type_wise_arr[$row['facility_type_id']][$row['item_id']] += $row['issuance'];
                                @$dist_wise_arr[$row['district_id']][$row['item_id']] += $row['issuance'];
                                //$val=$row['u_factor']*$row['item_id'];
                                //@$usr_row_array[$row['item_id']]=$row['u_factor'];
                               
                                //@$usr_col_array[$row['item_id']]=  $row['u_factor'];
                               
                            }
                            
                            
                            
                            $qry = " SELECT
                                            tbl_hf_data.item_id,
                                            tbl_warehouse.hf_type_id,
                                            Sum(tbl_hf_data_reffered_by.static + tbl_hf_data_reffered_by.camp) AS performance,
                                            itminfo_tab.user_factor AS userFactor,
                                            itminfo_tab.extra AS CYPFactor,
                                            itminfo_tab.itm_category,
                                            itminfo_tab.itm_name,
                                            tbl_warehouse.dist_id
                                    FROM
                                            tbl_warehouse
                                    INNER JOIN tbl_hf_data ON tbl_warehouse.wh_id = tbl_hf_data.warehouse_id
                                    INNER JOIN tbl_hf_data_reffered_by ON tbl_hf_data.pk_id = tbl_hf_data_reffered_by.hf_data_id
                                    INNER JOIN itminfo_tab ON tbl_hf_data.item_id = itminfo_tab.itm_id
                                    WHERE
                                            tbl_warehouse.prov_id = $selProv
                                            AND tbl_warehouse.stkid = $stakeholder
                                            AND tbl_hf_data.reporting_date BETWEEN '$startDate' 
                                AND '$endDate' 
                                    GROUP BY
                                            tbl_warehouse.dist_id,
                                            tbl_warehouse.hf_type_id,
                                            tbl_hf_data.item_id

                                ";
        //                    echo $qry;exit;
                            $qryRes = mysql_query($qry);
                            while ($row = mysql_fetch_array($qryRes)) {
                                @$type_wise_arr[$row['hf_type_id']][$row['item_id']] += $row['performance'];
                                @$dist_wise_arr[$row['dist_id']][$row['item_id']] += $row['performance'];
                            }

                            
                            
                            
                            
                             //print_r( $usr_row_array_type);
                            while ($row_test = mysql_fetch_array($qryResTest)) {


                                @$outlets_type_wise[$row_test['hf_type_id']] += $row_test['total_outlets'];
                                @$outlets_district_wise[$row_test['dist_id']] += $row_test['total_outlets'];
                            }
                             while ($row_cyp = mysql_fetch_array($result_cyp)) {


                                @$c_type_array[$row_cyp['item_id']] += $row_cyp['c_factor'];
                               // @$c_dist_array[$row_cyp['item_id']] += $row_cyp['c_factor'];
                            }
               
                            //echo '<pre>';print_r($product);print_r($hfType);print_r($p_name_id);exit;
                           //  echo '<pre>';print_r(@$c_type_array); 
                            ?>
                            <table width="100%">
                                <tr>
                                    <td style="padding-top: 10px;" align="center">
                                         <h4 class="center bold">
                                            CCI Format 1 (Outlet wise Total, Reporting / Users / CYP) <?php echo 'From ' . date('M-Y', strtotime($startDate)) . ' to ' . date('M-Y', strtotime($endDate)); ?><br>
                                            Inrespect of Population Welfare Department <?php echo $provinceName ?>
                                        </h4>
                                        <table width="100%" id="myTable" cellspacing="0" align="center">
                                            <thead>
                                                <tr>
                                                    <th rowspan="2">S.No.</th>
                                                    <th rowspan="2" width="13%">Name of Service Outlet</th>
                                                    <th rowspan="2" width="7%">No. of Outlets</th>
                                                    <th rowspan="2" width="7%">No. of Reported Outlets</th>
                                                    <th rowspan="2">CYP</th>
                                                    <th rowspan="2">Users</th>
                                                </tr>
                                                <tr></tr>
                                            </thead>
                                            <tbody> 
                                                <?php
                                                $counter = 1;
                                                $totalReportedOutlets = 0;
                                                //hf Type
                                                foreach ($hfType as $id => $hfName) {
                                                    $ResqryreportedWHCount = mysql_fetch_assoc($ResqryreportedWH);
                                                    $totalReportedOutlets += $ResqryreportedWHCount['reportedWH'];
                                                    ?>
                                                    <tr>
                                                        <td class="center"><?php echo $counter++; ?></td>
                                                        <td><?php echo $hfName; ?></td>
                                                        <td class="center"><?php
                                                            echo $outlets_type_wise[$id];
                                                            $total_out_type += $outlets_type_wise[$id];
                                                            ?></td>
                                                        <td class="center"><?= $ResqryreportedWHCount['reportedWH'];?></td>
                                                        <?php
                                                        $var = '';
                                                        $count = 1;
                                                        //get product
                                                        foreach ($product as $proType => $proNames) {
                                                            //set method Type Total 	
                                                            $methodTypeTotal = 0;
                                                            foreach ($proNames as $methodName) {
                                                                $prod_id = $p_name_id[$methodName];
                                                                if (!empty($type_wise_arr[$id][$prod_id]))
                                                                    $this_cons = $type_wise_arr[$id][$prod_id];
                                                                else
                                                                    $this_cons = 0;
                                                                $methodTypeTotal = $methodTypeTotal + $this_cons;
                                                                
                                                                @$total_type_array[$prod_id] += $this_cons;
                                                                @$usr_col_array[$prod_id]=$this_cons*$usr_row_array[$prod_id];
                                                                @$c_dist_array[$prod_id]= $this_cons*$c_type_array[$prod_id];
                                                                $t+= $c_dist_array[$prod_id];
                                                                 $t_u+= $usr_col_array[$prod_id];
                                                            }
                                                            $var = $proType;
                                                            $count++;
                                                        }
                                                        echo "<th class=\"right\">";
                                                        print_r(number_format(array_sum(@$c_dist_array)));
                                                        echo '</th>';
                                                         echo "<th class=\"right\">";
                                                        print_r(number_format(array_sum($usr_col_array)));
                                                        echo '</th>';
                                                        ?>
                                                    </tr>
                                                    <?php
                                                }
                                               // print_r($t);
                                                ?>
                                            </tbody>
                                             <tfoot>
                                                <tr>
                                                    <th class="right" colspan="2">Total</th>
                                                    <th class="center"><?php echo number_format($total_out_type); ?></th>
                                                        <?php
                                                        //show CYP
                                                        echo "<th class='right'>" . number_format($totalReportedOutlets) . "</th>";
                                                        echo "<th class='right'>" . number_format($t) . "</th>";
                                                        //show users
                                                        echo "<th class='right'>" . number_format($t_u) . "</th>";
                                                        ?>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <?php
                        }
                        else
                        {
                            echo 'No record found';
                            
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
        include ('combos.php');
        ?>
        <script>
            $(function () {
                $('#stakeholder').change(function (e) {
                    $('#itm_id, #prov_sel').html('<option value="">Select</option>');

                    showProvinces('');
                });
            })
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