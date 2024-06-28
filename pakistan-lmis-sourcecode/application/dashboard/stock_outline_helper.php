<?php
include("../includes/classes/AllClasses.php");

$action = $_REQUEST['type'];

if (!empty($action)) {
    //Graph 1: Item Wise SOH
    if ($action == 1) {
        $qry = "
        SELECT
        	tbl_warehouse.wh_id,
        	dd.item_id,
        	itminfo_tab.itm_name
         	,MAX(dd.reporting_date) as reporting_date
         	,(SELECT distinct hf.closing_balance FROM tbl_hf_data hf WHERE dd.warehouse_id= hf.warehouse_id and hf.reporting_date =MAX(dd.reporting_date) and hf.item_id = dd.item_id) as closing_balance
        FROM
        	tbl_hf_data AS dd
        INNER JOIN tbl_warehouse ON dd.warehouse_id = tbl_warehouse.wh_id
        INNER JOIN itminfo_tab ON dd.item_id = itminfo_tab.itm_id
        WHERE
        	tbl_warehouse.stkid = ".$_SESSION['user_stakeholder1']." 
        	and prov_id = ".$_SESSION['user_province1']."
        GROUP BY
        	wh_id";
        //echo $qry;exit();
        $itm_wise_soh = mysql_query($qry);
        $itm_wise_soh_data = array();
        $all_items = array();
        while ($row = mysql_fetch_assoc($itm_wise_soh)) {
            $all_items[$row['item_id']] = $row['itm_name'];
            @$itm_wise_soh_data[$row['item_id']] += $row['closing_balance'];
        }
        $data['itm_wise_soh_data'] = $itm_wise_soh_data;
        $data['all_items'] = $all_items;
        echo json_encode($data);
    }

    //Graph 2 : District Wise Reporting Rate
    if ($action == 2) {
        $qry = "
            SELECT
            	tbl_warehouse.dist_id, tbl_locations.LocName, COUNT(DISTINCTROW(warehouse_id)) as reported
            	,(SELECT
            	COUNT( wh_id ) 
            FROM
            	tbl_warehouse as total
            	INNER JOIN stakeholder ON stakeholder.stkid = total.stkofficeid
            WHERE
            	total.dist_id = tbl_warehouse.dist_id
            	AND total.stkid = ".$_SESSION['user_stakeholder1']." 
            	AND total.prov_id = ".$_SESSION['user_province1']." 
            	AND total.is_active = 1 
            	AND stakeholder.lvl = 7 
            GROUP BY
            	dist_id
            	LIMIT 1 ) total
            FROM 
            	tbl_hf_data
            INNER JOIN 
            	tbl_warehouse ON tbl_warehouse.wh_id = tbl_hf_data.warehouse_id
            INNER JOIN 
            	tbl_locations ON tbl_locations.PkLocID = tbl_warehouse.dist_id
            WHERE
            	tbl_warehouse.stkid = ".$_SESSION['user_stakeholder1']." 
            	AND tbl_warehouse.prov_id = ".$_SESSION['user_province1']." 
            	AND tbl_warehouse.is_active = 1 
            	AND reporting_date = '". date('Y-m',strtotime('-1 months')) ."-01'
            GROUP BY
            tbl_warehouse.dist_id";
//        echo $qry;exit();
        $dist_wise_rr = mysql_query($qry);
        $dist_wise_rr_data = array();
        $all_dist = array();
        while ($row = mysql_fetch_assoc($dist_wise_rr)) {
            $all_dist[$row['dist_id']] = $row['LocName'];
            @$dist_wise_rr_data[$row['dist_id']] = round(($row['reported']/ $row['total']) * 100, 2);
        }
        $data['dist_wise_rr_data'] = $dist_wise_rr_data;
        $data['all_dist'] = $all_dist;
        echo json_encode($data);
    }
}