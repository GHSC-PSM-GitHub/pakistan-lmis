<?php

$issuance_flag = 'FALSE';
$district_issuance = 0;

if (!isset($fsrlevel)) {

    $qry1 = "SELECT
	tbl_warehouse.prov_id,
	tbl_warehouse.dist_id,
	tbl_warehouse.stkid,
	stakeholder.lvl
FROM
	tbl_warehouse
INNER JOIN stakeholder ON tbl_warehouse.stkofficeid = stakeholder.stkid
WHERE
	tbl_warehouse.wh_id = $wh_id
LIMIT 1";
    $rs1 = mysql_query($qry1);
    $rs1 = mysql_fetch_array($rs1);
    $fsrlevel = $rs1['lvl'];
    $fsrdist1 = $rs1['dist_id'];
    $fsrpro1 = $rs1['prov_id'];
    $fsrstk1 = $rs1['stkid'];
}


        $qryIR2 = "SELECT
	SUM(tbl_wh_data.wh_received) total
FROM 
        tbl_wh_data 
INNER JOIN tbl_warehouse ON tbl_wh_data.wh_id = tbl_warehouse.wh_id
INNER JOIN stakeholder ON tbl_warehouse.stkofficeid = stakeholder.stkid
WHERE
	tbl_warehouse.prov_id = $fsrpro1
AND tbl_warehouse.stkid = $fsrstk1
AND stakeholder.lvl = 3 
AND tbl_wh_data.item_id = 'IT-".sprintf("%03d", $item_int)."'
AND tbl_wh_data.RptDate = '$RptDate'";
//        echo $qryIR2;exit;
        $rsIR2 = mysql_query($qryIR2);
        $rsIR22 = mysql_fetch_array($rsIR2);
        if ($rsIR22['total'] > 0) {
            $district_issuance =  $rsIR22['total'];
            $issuance_flag = 'TRUE';
        }
   
