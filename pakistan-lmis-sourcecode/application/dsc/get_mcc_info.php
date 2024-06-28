<?php
include("../includes/classes/AllClasses.php");

        $pk_id = $_REQUEST['pk_id'];
        $query_xmlw = "SELECT
                                itminfo_tab.itm_id,
                                CONCAT(COALESCE(itminfo_tab.dosage_form,''),' ',COALESCE(itminfo_tab.generic_updated,''),' ',COALESCE(itminfo_tab.strength,'')) AS generic_updated,
                                itminfo_tab.mcc_category_id 
                        FROM
                                itminfo_tab 
                        WHERE
                                itminfo_tab.itm_id = '".$pk_id."'";
//        echo $query_xmlw;exit;
        $result_xmlw = mysql_query($query_xmlw);

        $query_xmlws = "SELECT
                                ROUND(stakeholder_item.unit_price,2) AS unit_price 
                        FROM
                                stakeholder_item
                                INNER JOIN itminfo_tab ON stakeholder_item.stk_item = itminfo_tab.itm_id 
                        WHERE
                                stakeholder_item.stk_item = '".$pk_id."'
                                AND unit_price IS NOT NULL";
        //echo $query_xmlw;exit;
        $result_xmlws = mysql_query($query_xmlws);


        $json_array = array();
        while ($row_xmlw = mysql_fetch_array($result_xmlw)) {
            $json_array['generic_updated'] = $row_xmlw['generic_updated'];
            $json_array['mcc_category_name'] = $row_xmlw['mcc_category_id'];
        }
        
        while ($row_xmlws = mysql_fetch_array($result_xmlws)) {
            $json_array['uprice'] = $row_xmlws['unit_price'];
        }
        
        echo json_encode($json_array);

