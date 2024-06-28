<?php
/**
 * stock_sufficiency_report
 * @package reports
 *
 * @author Ajmal Hussain
 * @email <ahussain@ghsc-psm.org>
 *
 * @version    2.2
 *
 */
//Including AllClasses
session_start();
$_SESSION['user_id'] = 1;
include("../includes/classes/AllClasses.php");
include(APP_PATH . "includes/report/FunctionLib.php");
include(PUBLIC_PATH . "html/header.php");
$report_id = "STOCKSUFFICIENCY";
$districtId = '';
$filter_prov = '';
if (isset($_POST['month_sel'])) {
    $selMonth = mysql_real_escape_string($_POST['month_sel']);
    $selYear = mysql_real_escape_string($_POST['year_sel']);
    $array = array_values($_POST['district']);
    $List = implode(',', $array);
    $stakeholder = mysql_real_escape_string($_POST['stakeholder']);
    $selProv = mysql_real_escape_string($_POST['prov_sel']);
    $selDist = $List;
    // $dist_arr = explode(',',$selDist);
$dist_arr=array();
    $queryDist = "SELECT DISTINCT
    tbl_locations.PkLocID,
    tbl_locations.LocName
    FROM
    tbl_locations
    INNER JOIN tbl_warehouse ON tbl_locations.PkLocID = tbl_warehouse.dist_id
    INNER JOIN wh_user ON tbl_warehouse.wh_id = wh_user.wh_id
    WHERE
    tbl_locations.LocLvl = 3
    AND tbl_locations.ParentID = 3
    AND tbl_warehouse.stkid = 7
    ORDER BY
    tbl_locations.LocName ASC";
    $rsDist = mysql_query($queryDist) or die();
    while ($rowDist = mysql_fetch_array($rsDist)) {
        $dist_arr[$rowDist['PkLocID']]=$rowDist['LocName'];
    }

    $reportingDate = mysql_real_escape_string($_POST['year_sel']) . '-' . $selMonth . '-01';

    $qry = "SELECT
                tbl_locations.LocName
            FROM
                tbl_locations
            WHERE
                tbl_locations.PkLocID = $selProv";
    $row = mysql_fetch_array(mysql_query($qry));
    $provinceName = $row['LocName'];

    $fileName = 'stock_sufficiency_report_' . $provinceName . '_for_' . date('M-Y', strtotime($reportingDate));
}
?>
</head>
<!-- END HEAD -->

<body class="page-header-fixed page-quick-sidebar-over-content">
    <div class="page-container">
        <?php
        include PUBLIC_PATH . "html/top.php";
        include PUBLIC_PATH . "html/top_im.php";
        ?>
        <div class="page-content-wrapper">
            <div class="page-content">
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="page-title row-br-b-wp">MNCH VEML Stock Status</h3>
                        <div style="display: block;" id="alert-message" class="alert alert-info text-message"><?php echo stripslashes(getReportDescription($report_id)); ?></div>
                        <div class="widget" data-toggle="collapse-widget">
                            <div class="widget-head">
                                <h3 class="heading">Filter by</h3>
                            </div>
                            <div class="widget-body">
                                <form name="frm" id="frm" action="" method="post" role="form">
                                    <div class="row">
                                        <div class="col-md-12">
                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label class="control-label">Month</label>
                                                    <div class="form-group">
                                                        <select name="month_sel" id="month_sel" class="form-control input-sm" required>
                                                    <?php
                                                        for ($i = 1; $i <= 12; $i++) {
                                                            //check selMonth
                                                            $sel = ($selMonth == $i)?'selected':'';
                                                    ?>
                                                            <?php // Populate month_sel combo?>
                                                            <option value="<?= date('m', mktime(0, 0, 0, $i, 1));?>" <?= $sel;?>>
                                                                <?= date('M', mktime(0, 0, 0, $i, 1));?>
                                                            </option>
                                                    <?php
                                                        }
                                                    ?>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label class="control-label">Year</label>
                                                    <div class="form-group">
                                                        <select name="year_sel" id="year_sel" class="form-control input-sm" required>
                                                    <?php
                                                        for ($j = date('Y'); $j >= 2010; $j--) {
                                                            //check selYear
                                                            $sel = ($selYear == $j)?'selected':'';
                                                    ?>
                                                            <?php // Populate year_sel combo?>
                                                            <option value="<?= $j;?>" <?= $sel;?>>
                                                                <?= $j;?>
                                                            </option>
                                                    <?php
                                                        }
                                                    ?>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <?php
                                            if (@$wh_name == '') {
                                                $button = 'true';
                                                $user_lvl = (!empty($_SESSION['user_level']) ? $_SESSION['user_level'] : '');
                                                switch ($user_lvl) {
                                                    case 1:
                                                    case 2:
                                                    case 3:
                                                    case 4:
                                                        //include levelcombos_all_levels
                                                        include("allcombos_mnch_veml.php");
                                                        $js = 'levelcombos_all_levels.js';
                                                        break;
                                                    /* case 4:
                                                      include("levelcombos.php");
                                                      $js = 'levelcombos.js';
                                                      break; */
                                                }
                                            } else {
                                            ?>
                                                <div class="col-md-12">
                                                    <div class="col-md-3">
                                                        <div class="control-group">
                                                            <div class="controls">
                                                                <input class="form-control input-medium" id="recipient" name="" type="text" disabled="" value="<?php echo $wh_name; ?>"/>
                                                                <input class="form-control input-medium" id="warehouse" name="warehouse" type="hidden" value="<?php echo $whouse_id; ?>"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            <?php }
                                            ?>
                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label class="control-label">&nbsp;</label>
                                                    <div class="form-group">
                                                        <button type="submit" name="submit" class="btn btn-primary input-sm">Go</button>
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
                if (!empty($_POST['month_sel'])) {
                    $to_date = date('Y-m-d', strtotime($reportingDate));
                    $from_date = date("Y-m-d", strtotime($to_date . " -12 month"));
                    //getting issuance of district stores
                    $qry_dist_issuance = "SELECT
                                                Sum(tbl_stock_detail.Qty) AS wh_issue_up, 
                                                stock_batch.item_id, 
                                                tbl_warehouse.dist_id
                                            FROM tbl_stock_detail
                                                INNER JOIN tbl_stock_master ON 
                                                    tbl_stock_detail.fkStockID = tbl_stock_master.PkStockID
                                                INNER JOIN stock_batch ON 
                                                    tbl_stock_detail.BatchID = stock_batch.batch_id
                                                INNER JOIN tbl_warehouse ON 
                                                    stock_batch.wh_id = tbl_warehouse.wh_id
                                                INNER JOIN stakeholder ON 
                                                    tbl_warehouse.stkofficeid = stakeholder.stkid
                                            WHERE tbl_stock_master.TranTypeID = 2
                                                AND tbl_stock_master.TranDate BETWEEN '$from_date' AND '$to_date'
                                                AND tbl_warehouse.dist_id IN ($selDist)
                                                AND tbl_warehouse.stkid = '$stakeholder'
                                                AND stakeholder.lvl = 3
                                                AND tbl_warehouse.wh_name NOT LIKE '%DHQ%'
                                            GROUP BY stock_batch.item_id, tbl_warehouse.dist_id";
                    $qryResDistIssuance = mysql_query($qry_dist_issuance);
                    $dist_issuance = array();
                    if (mysql_num_rows($qryResDistIssuance) > 0) {
                        while ($row = mysql_fetch_array($qryResDistIssuance)) {
                            $dist_issuance[$row['dist_id']][$row['item_id']] = abs($row['wh_issue_up']);
                        }
                    }
                    $qry_dist_cb = "SELECT
                                        Sum(tbl_stock_detail.Qty) AS wh_cbl_a, 
                                        stock_batch.item_id, 
                                        tbl_warehouse.dist_id
                                    FROM tbl_stock_detail
                                        INNER JOIN tbl_stock_master ON 
                                            tbl_stock_detail.fkStockID = tbl_stock_master.PkStockID
                                        INNER JOIN stock_batch ON  
                                            tbl_stock_detail.BatchID = stock_batch.batch_id
                                        INNER JOIN tbl_warehouse ON  
                                            stock_batch.wh_id = tbl_warehouse.wh_id
                                        INNER JOIN stakeholder ON 
                                            tbl_warehouse.stkofficeid = stakeholder.stkid
                                    WHERE tbl_stock_master.TranDate <= '$to_date'
                                        AND tbl_warehouse.dist_id IN ($selDist)
                                        AND tbl_warehouse.stkid = '$stakeholder'
                                        AND stakeholder.lvl = 3
                                        AND tbl_warehouse.wh_name NOT LIKE '%DHQ%'
                                    GROUP BY stock_batch.item_id, tbl_warehouse.dist_id";
                    $qryResDistCb = mysql_query($qry_dist_cb);
                    //fetch data from qry
                    $dist_cb = array();
                    if (mysql_num_rows($qryResDistCb) > 0) {
                        while ($row = mysql_fetch_array($qryResDistCb)) {
                            $dist_cb[$row['dist_id']][$row['item_id']] = $row['wh_cbl_a'];
                        }
                    }
                    $qry_hf_issuance = "SELECT
                                            SUM(tbl_hf_data.issue_balance) as issue_balance, 
                                            tbl_warehouse.dist_id, 
                                            tbl_hf_data.item_id
                                        FROM tbl_hf_data 
                                            INNER JOIN tbl_warehouse ON  
                                                tbl_hf_data.warehouse_id = tbl_warehouse.wh_id
                                        WHERE tbl_hf_data.reporting_date BETWEEN '$from_date' AND '$to_date'
                                            AND tbl_warehouse.dist_id IN ($selDist)
                                            AND tbl_warehouse.stkid = '$stakeholder'
                                        GROUP BY tbl_warehouse.dist_id, tbl_hf_data.item_id";
                    $qryResHfIssuance = mysql_query($qry_hf_issuance);
                    //fetch data from qry
                    $hf_issuance = array();
                    if (mysql_num_rows($qryResHfIssuance) > 0) {
                        while ($row = mysql_fetch_array($qryResHfIssuance)) {
                            @$hf_issuance[$row['dist_id']][$row['item_id']] += abs($row['issue_balance']);
                        }
                    }
                    $qry_hf_cb = "SELECT
                                        SUM(tbl_hf_data.closing_balance) AS closing_balance, 
                                        tbl_warehouse.dist_id, 
                                        tbl_hf_data.item_id
                                    FROM tbl_hf_data
                                        INNER JOIN tbl_warehouse ON  
                                            tbl_hf_data.warehouse_id = tbl_warehouse.wh_id
                                    WHERE tbl_hf_data.reporting_date = '$to_date' 
                                        AND tbl_warehouse.dist_id IN ($selDist)
                                        AND tbl_warehouse.stkid = '$stakeholder'
                                    GROUP BY tbl_warehouse.dist_id, tbl_hf_data.item_id";
                    $qryResHfCb = mysql_query($qry_hf_cb);
                    $hf_cb = array();
                    if (mysql_num_rows($qryResHfCb) > 0) {
                        while ($row = mysql_fetch_array($qryResHfCb)) {
                            @$hf_cb[$row['dist_id']][$row['item_id']] += $row['closing_balance'];
                        }
                    }
                    $qry_dhq_issuance = "SELECT
                                            Sum(tbl_stock_detail.Qty) AS wh_issue_up, 
                                            stock_batch.item_id, 
                                            tbl_warehouse.dist_id
                                        FROM tbl_stock_detail
                                            INNER JOIN tbl_stock_master ON 
                                                tbl_stock_detail.fkStockID = tbl_stock_master.PkStockID
                                            INNER JOIN stock_batch ON 
                                                tbl_stock_detail.BatchID = stock_batch.batch_id
                                            INNER JOIN tbl_warehouse ON 
                                                stock_batch.wh_id = tbl_warehouse.wh_id
                                            INNER JOIN stakeholder ON 
                                                tbl_warehouse.stkofficeid = stakeholder.stkid
                                        WHERE tbl_stock_master.TranTypeID = 2
                                            AND tbl_stock_master.TranDate BETWEEN '$from_date' AND '$to_date'
                                            AND tbl_warehouse.dist_id IN ($selDist)
                                            AND tbl_warehouse.stkid = '$stakeholder' 
                                            AND stakeholder.lvl = 3
                                            AND tbl_warehouse.wh_name LIKE '%DHQ%'
                                        GROUP BY stock_batch.item_id, tbl_warehouse.dist_id";
                    $qryResDhqIssuance = mysql_query($qry_dhq_issuance);
                    //fetch data from qry
                    $dhq_issuance = array();
                    if (mysql_num_rows($qryResDhqIssuance) > 0) {
                        while ($row = mysql_fetch_array($qryResDhqIssuance)) {
                            @$dhq_issuance[$row['dist_id']][$row['item_id']] += abs($row['wh_issue_up']);
                        }
                    }
                    $qry_dhq_cb = "SELECT
                                        Sum(tbl_stock_detail.Qty) AS wh_cbl_a, 
                                        stock_batch.item_id, 
                                        tbl_warehouse.dist_id
                                    FROM tbl_stock_detail
                                        INNER JOIN tbl_stock_master ON 
                                            tbl_stock_detail.fkStockID = tbl_stock_master.PkStockID
                                        INNER JOIN stock_batch ON 
                                            tbl_stock_detail.BatchID = stock_batch.batch_id
                                        INNER JOIN tbl_warehouse ON 
                                            stock_batch.wh_id = tbl_warehouse.wh_id
                                        INNER JOIN stakeholder ON 
                                            tbl_warehouse.stkofficeid = stakeholder.stkid
                                    WHERE tbl_stock_master.TranDate <= '$to_date'
                                        AND tbl_warehouse.dist_id IN ($selDist)
                                        AND tbl_warehouse.stkid = '$stakeholder'
                                        AND stakeholder.lvl = 3
                                        AND tbl_warehouse.wh_name LIKE '%DHQ%'
                                    GROUP BY stock_batch.item_id, tbl_warehouse.dist_id";
                    $qryResDhqCb = mysql_query($qry_dhq_cb);
                    //fetch data from qry
                    $dhq_cb = array();
                    if (mysql_num_rows($qryResDhqCb) > 0) {
                        while ($row = mysql_fetch_array($qryResDhqCb)) {
                            @$dhq_cb[$row['dist_id']][$row['item_id']] += $row['wh_cbl_a'];
                        }
                    }
                    $qryitm = "SELECT
                                    mcc_list_generic_names.generic_name AS itm_name,
                                    itminfo_tab.itm_id AS itm_id,
                                    mcc_list_generic_names.generic_name AS generic_updated,
                                    mcc_list_items.drug_name AS generic_updatedy,
                                    itminfo_tab.generic_updated AS generic_updatedX
                                FROM mcc_list_items
                                    INNER JOIN mcc_list_generic_names ON
                                        mcc_list_generic_names.pk_id = mcc_list_items.generic_name_id
                                    INNER JOIN mcc_list_mapping ON
                                        mcc_list_mapping.mcc_f_no = mcc_list_items.f_no
                                    INNER JOIN itminfo_tab ON
                                        itminfo_tab.itm_id = mcc_list_mapping.item_id
                                WHERE 
                                    mcc_list_mapping.mcc_f_no <> 'LP'
                                    AND mcc_list_mapping.mcc_f_no IS NOT NULL
                                ORDER BY mcc_list_generic_names.generic_name";
                    $itm_arr = $itm_gen  = $generic_arr =array();
                    $qryResItm = mysql_query($qryitm);
                    //fetch data from qry
                    if (mysql_num_rows($qryResItm) > 0) {
                        while ($row = mysql_fetch_array($qryResItm)) {
                            $row['generic_updated'] = str_replace(array("\n", "\r"), '', $row['generic_updated']);
                            $itm_arr[$row['itm_id']] = $row['itm_name'];
                            $itm_gen[$row['itm_id']] = $row['generic_updated'];
                            $generic_arr[$row['generic_updated']][$row['itm_id']] = $row['itm_name'];
                            $generic_arr2[$row['generic_updated']] = $row['generic_updated'];
                        }
                    }
                    //converting item wise data to generic aggregated data
                    $dist_cb2 = $dist_issuance2 = $hf_cb2 = $hf_issuance2 = $dhq_cb2 = $dhq_issuance2 = array();
                    foreach ($itm_arr as $itmid => $itm_name) {
                        $this_generic = $itm_gen[$itmid];
                        foreach ($dist_arr as $distid => $dist_name) {
                            if (!empty($dist_cb[$distid][$itmid])) {
                                @$dist_cb2[$distid][$this_generic] += $dist_cb[$distid][$itmid];
                            }
                            if (!empty($dist_issuance[$distid][$itmid])) {
                                @$dist_issuance2[$distid][$this_generic] += $dist_issuance[$distid][$itmid];
                            }
                            if (!empty($hf_cb[$distid][$itmid])) {
                                @$hf_cb2[$distid][$this_generic] += $hf_cb[$distid][$itmid];
                            }
                            if (!empty($hf_issuance[$distid][$itmid])) {
                                @$hf_issuance2[$distid][$this_generic] += $hf_issuance[$distid][$itmid];
                            }
                            if (!empty($dhq_cb[$distid][$itmid])) {
                                @$dhq_cb2[$distid][$this_generic] += $dhq_cb[$distid][$itmid];
                            }
                            if (!empty($dhq_issuance[$distid][$itmid])) {
                                @$dhq_issuance2[$distid][$this_generic] += $dhq_issuance[$distid][$itmid];
                            }
                        }
                    }
                    ?>
                    <table width="100%">
                        <tr>
                            <td align="center">
                                <h4 class="center"> Provincial MNCH VEML Stock Status <br>
                                    For the month of <?php echo date('M', mktime(0, 0, 0, $selMonth, 1)) . '-' . $selYear . ', Province ' . $provinceName; ?>
                                </h4>
                            </td>
                        </tr>
                    </table>
                    <table id="myTable" class="table table-bordered" cellspacing="0" align="center">
                        <thead>
                            <tr class="bg-success">
                                <th rowspan="2" width="10">S.No</th>
                                <th rowspan="2" width="100">Products</th>
                            <?php
                                foreach ($dist_arr as $distid => $dist_name) {
                            ?>
                                    <th colspan="4" style="text-align: center;"><?= $dist_name;?></th>
                            <?php
                                }
                            ?>
                            </tr>
                            <tr class = "bg-success">
                            <?php
                                foreach ($dist_arr as $distid => $dist_name) {
                            ?>
                                    <th style="text-align: center;" width="50">Dist Store MOS</th>
                                    <th style="text-align: center;" width="50">Field MOS</th>
                                    <th style="text-align: center;" width="50">DHQ MOS</th>
                                    <th style="text-align: center;" width="50">Total MOS</th>
                            <?php
                                }
                            ?>
                            </tr>
                        </thead>
                        <tbody>
                        <?php
                        // echo '<pre>';
                        // echo 'dist_cb2:';
                        // print_r($dist_cb2);
                        // echo 'hf_cb2:';
                        // print_r($hf_cb2);
                        // echo 'dhq_cb2:';
                        // print_r($dhq_cb2);die();
                        $counter = 0;
                        foreach ($generic_arr2 as $itm_name => $itm_data) {
                            $itmid = $itm_name;
                        ?>
                            <tr>
                                <th style="text-align: center;"><?= ++$counter;?></th>
                                <th><?= $itm_name;?></th>
                        <?php
                            foreach ($dist_arr as $distid => $dist_name) {
                                $dist_mos = $field_mos = $dhq_mos = $total_mos = 0;
                                if (!empty($dist_cb2[$distid][$itmid]) && !empty($dist_issuance2[$distid][$itmid]) && $dist_issuance2[$distid][$itmid] > 0) {
                                    $dist_mos = $dist_cb2[$distid][$itmid]/($dist_issuance2[$distid][$itmid]/12);
                                }
                                if (!empty($hf_cb2[$distid][$itmid]) && !empty($hf_issuance2[$distid][$itmid]) && $hf_issuance2[$distid][$itmid] > 0) {
                                    $field_mos = $hf_cb2[$distid][$itmid]/($hf_issuance2[$distid][$itmid]/12);
                                }
                                if (!empty($dhq_cb2[$distid][$itmid]) && !empty($dhq_issuance2[$distid][$itmid]) && $dhq_issuance2[$distid][$itmid] > 0) {
                                    $dhq_mos = $dhq_cb2[$distid][$itmid]/(abs($dhq_issuance2[$distid][$itmid])/12);
                                }
                                @$total_mos = $dist_mos + $field_mos + $dhq_mos;
                        ?>
                                <td align="right" title="<?= $dist_cb2[$distid][$itmid].'/('.$dist_issuance2[$distid][$itmid].'/12)';?>">
                                    <?= (($dist_mos == 0) ? '0' : number_format($dist_mos, 2));?>
                                </td>
                                <td align="right" title="<?= $hf_cb2[$distid][$itmid].'/('.$hf_issuance2[$distid][$itmid].'/12)';?>">
                                    <?= (($field_mos == 0) ? '0' : number_format($field_mos, 2));?>
                                </td>
                                <td align="right" title="<?= $dhq_cb2[$distid][$itmid].'/('.$dhq_issuance2[$distid][$itmid].'/12)';?>">
                                    <?= (($dhq_mos == 0) ? '0' : number_format($dhq_mos, 2));?>
                                </td>
                                <td align="right" title="<?= number_format($dist_mos, 2).' + '.number_format($field_mos, 2).' + '.number_format($dhq_mos, 2);?>">
                                    <?= (($total_mos == 0) ? '0' : number_format($total_mos, 2));?>
                                </td>
                        <?php } ?>
                            </tr>
                    <?php } ?>
                        </tbody>
                    </table> 
                <?php } ?>
            </div>
        </div>
    </div>
</div>
<?php
//include footer
include PUBLIC_PATH . "/html/footer.php";
?>
</body>
</html>