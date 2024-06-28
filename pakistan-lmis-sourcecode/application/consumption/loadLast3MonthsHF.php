<?php
//echo '<pre>';
//print_r($_REQUEST);
//exit;
include("../includes/classes/AllClasses.php");

$debug = false;
$flag1 = FALSE;
$allMonths = '';
$lock_flag = false;
//check dataEntryURL
if (isset($_REQUEST['dataEntryURL'])) {
    //get dataEntryURL
    $dataEntryURL = $_REQUEST['dataEntryURL'];
}

if (isset($_SESSION['user_id'])) {
    $userid = $_SESSION['user_id'];
    $objwharehouse_user->m_npkId = $userid;
    $province = $_SESSION['user_province'];
    $mainStk = $_SESSION['user_stakeholder'];
    $district_id = $_SESSION['user_district'];
}
if (isset($_REQUEST['wharehouse_id'])) {
    $wh_Id = $_REQUEST['wharehouse_id'];
    $qry = "SELECT
				tbl_warehouse.stkid,
				tbl_warehouse.prov_id,
				tbl_warehouse.is_lock_data_entry,
                                tbl_warehouse.editable_data_entry_months,
                                tbl_warehouse.ecr_start_month,
				CONCAT(DATE_FORMAT(MAX(tbl_hf_data.last_update),'%d/%m/%Y'),' ',TIME_FORMAT(MAX(tbl_hf_data.last_update),'%r')) AS last_update
			FROM
				tbl_warehouse
			LEFT JOIN tbl_hf_data ON tbl_warehouse.wh_id = tbl_hf_data.warehouse_id
			WHERE
				tbl_warehouse.wh_id = $wh_Id
			ORDER BY
				tbl_hf_data.pk_id DESC
			LIMIT 1";
    //echo $qry;exit;
    $qryRes = mysql_fetch_assoc(mysql_query($qry));
//    echo '<pre>';
//    print_r($qryRes);
//    echo '</pre>';
//    exit;
    $mainStk = $qryRes['stkid'];
    $lastUpdate = (!empty($qryRes['last_update'])) ? $qryRes['last_update'] : 'Not yet reported';
    //following condition removed on 3 aug 2017 , for lock/unlock data entry
    //if ($qryRes['prov_id'] == 2 && $mainStk == 1) {
        //check is_lock_data_entry
        if( $_SESSION['user_role'] != '2' &&  $_SESSION['user_role'] !='26' )
        { 
//             if ($qryRes['is_lock_data_entry'] == 1 && $_SERVER['SERVER_NAME'] != 'localhost') {
             if ($qryRes['is_lock_data_entry'] == 1) {
                 if ( !empty($qryRes['ecr_start_month']) && $qryRes['ecr_start_month'] != '0000-00-00'){
                     $do3Months = urlencode("Z" . ($wh_Id + 77000) . '|' . date('Y-m-') . '01|1');
                     $url = $dataEntryURL . "?Do=" . $do3Months;
                     $allMonths[]= ($debug?'a':'')."<a href=\"javascript:void(0);\" onclick=\"openPopUp('$url')\" class=\"btn btn-xs green\">" . date('M-Y') . " <i class=\"fa fa-edit\"></i></a>";
                 }
                $allMonths[]= '<span class="help-block">Last Update : ' . $lastUpdate . '</span> 
                    <span class="help-block" style="color:#E04545">Data entry date for this facility has passed. Please contact administrator to enter data.</span>';
                $lock_flag = true;
                //exit;
            }
        }
       
    //}
} else {
    die('No warehouses selected.');
}


$objReports->wh_id = $wh_Id;
$objReports->stk = $mainStk;
$objReports->province_id = $province;
$objReports->district_id = $district_id;
//Get Last Report Date HF
$LastReportDate = $objReports->GetLastReportDateHF();
//echo 'Last:'.$LastReportDate;

if ($LastReportDate != "") {
    $LRD_dt = new DateTime($LastReportDate);
    //Get Pending Report Month HF
    $NewReportDate = $objReports->GetPendingReportMonthHF();

    //Check for PWD KP
    if ($NewReportDate == "" && $qryRes['prov_id'] == 3 && $mainStk == 1) {
        $cur_day = date("d");
        if($cur_day >= 25){
            if($LRD_dt->format("m") != date("m") && $LRD_dt->format("y") != date("y")){
                $NewReportDate = date("Y-m-d");
            }            
        }
    }
//echo 'NNNN:'.$NewReportDate;
//    $NewReportDate='2023-05-01';
    if ($NewReportDate != "") {
        if($debug){ echo '<br/>NewRepDate Not Empty'; }
        $NRD_dt = new DateTime($NewReportDate);
        echo '<span class="help-block">Last update: ' . $lastUpdate . '</span>';
        $do = urlencode("Z" . ($wh_Id + 77000) . '|' . $NRD_dt->format('Y-m-') . '01|1');
        ?>
        <td>
            <?php
            // Show last three months for which date is entered
            
            
            if($_SESSION['user_province']!=2 || ($_SESSION['user_province']==2 && !empty($qryRes['editable_data_entry_months']) && $qryRes['editable_data_entry_months'] > 1) )
            {
                    //Get Last 3 Months HF
                    $last3Months = $objReports->GetLast3MonthsHF();
                    for ($i = 0; $i < sizeof($last3Months); $i++) {
                        $L3M_dt = new DateTime($last3Months[$i]);
                        $do3Months = urlencode("Z" . ($wh_Id + 77000) . '|' . $L3M_dt->format('Y-m-') . '01|0');
                        //url
                        $url = $dataEntryURL . "?Do=" . $do3Months;
                        //all months
                        //echo "Data Entry is Lock";
                        $allMonths[] = ($debug?'b':'')."<a href=\"javascript:void(0);\" onclick=\"openPopUp('$url')\" class=\"btn btn-xs red\">" . $L3M_dt->format('M-Y') . " <i class=\"fa fa-edit\"></i></a>";
                    }
            }
//            if(!empty($qryRes['ecr_start_month'])){
//                echo " <a href=\"../ecr/search_clients.php\"   class=\"btn btn-xs blue\"> Open ECR </a> ";
//                $flag1 = TRUE;
//                
//            }
//            else{
                $url = $dataEntryURL . "?Do=" . $do;
                
                if($lock_flag){
                    $allMonths = array();
                }
                echo ($debug?'c':'')." <a href=\"javascript:void(0);\" onclick=\"openPopUp('$url')\" class=\"btn btn-xs green\"> Add " . $NRD_dt->format('M-y') . " Report <i class=\"fa fa-plus\"></i></a> ";
                echo (!empty($allMonths)) ? implode(' ', $allMonths) : '';
                $flag1 = TRUE;
//            }
            ?>

        </td>
        <?php
    } else {
        
        if($debug){ echo '<br/>NewRepDate is EMPTYYY'; }
//          if(!empty($qryRes['ecr_start_month'])){
//                echo " <a href=\"../ecr/search_clients.php\"   class=\"btn btn-xs blue\"> Open ECR </a> ";
//                $flag1 = TRUE;
//                
//            }
//            else{
                echo '<span class="help-block">Last Updated: ' . $lastUpdate . '</span>';
                ?>
                <td>
                    <?php
                    // Show last three months for which date is entered
                    $allMonths = '';
                    //Get Last 3 Months HF
                    $last3Months = $objReports->GetLast3MonthsHF();
//                    echo '<pre>'.date('Y-m-01');
//                    print_r($last3Months);
//                    echo '</pre>';
//                    exit;
                    $ecr_month='';
                    if(!empty($qryRes['ecr_start_month']) && $last3Months[0] == date('Y-m-01',strtotime('-1 month'))){
                        // if last reported month is previous month
                        $do3Months = urlencode("Z" . ($wh_Id + 77000) . '|' . date('Y-m-') . '01|1');
                        $url = $dataEntryURL . "?Do=" . $do3Months;
                        $ecr_month = ($debug?'d':'')."<a href=\"javascript:void(0);\" onclick=\"openPopUp('$url')\" class=\"btn btn-xs green\">" . date('M-Y') . " <i class=\"fa fa-edit\"></i></a>";

                    }
                    $skip_curr_in_loop = false;
                    if(!empty($qryRes['ecr_start_month']) && $last3Months[0] == date('Y-m-01')){
                        // if last reported month is the current one
                        $do3Months = urlencode("Z" . ($wh_Id + 77000) . '|' . date('Y-m-') . '01|0');
                        $url = $dataEntryURL . "?Do=" . $do3Months;
                        $ecr_month = ($debug?'e':'')."<a href=\"javascript:void(0);\" onclick=\"openPopUp('$url')\" class=\"btn btn-xs red\">" . date('M-Y') . " <i class=\"fa fa-edit\"></i></a>";
                        $skip_curr_in_loop = true;
                    }
                    for ($i = 0; $i < sizeof($last3Months); $i++) {
                        $L3M_dt = new DateTime($last3Months[$i]);
                        $do3Months = urlencode("Z" . ($wh_Id + 77000) . '|' . $L3M_dt->format('Y-m-') . '01|0');
                        //url
                        $url = $dataEntryURL . "?Do=" . $do3Months;
                        //all month

                        if($skip_curr_in_loop && date('Y-m')==$L3M_dt->format('Y-m')){
                            ///// dont include the curr month
                        }else{
                            $allMonths[] = ($debug?'f':'')."<a href=\"javascript:void(0);\" onclick=\"openPopUp('$url')\" class=\"btn btn-xs red\">" . $L3M_dt->format('M-Y') . " <i class=\"fa fa-edit\"></i></a>";
                        }

                    }
                    
                    if($lock_flag){
                        $allMonths = array();
                    }
                    $allMonths[]=$ecr_month;
                    
                    echo (!empty($allMonths)) ? implode(' ', $allMonths) : '';
                    ?>

                </td>
        <?php
//            }
    }
}

if ($flag1 != TRUE) {
    //Get This Month Report Date
    $NRD_dt = new DateTime($objReports->GetThisMonthReportDate());
    if (substr($LastReportDate, 0, 7) != $NRD_dt->format('Y-m')) {
        if (substr($LastReportDate, 0, 7) < $NRD_dt->format('Y-m')) {
            echo '<span class="help-block">Last Updated On: ' . $lastUpdate . '</span>';
            $do = urlencode("Z" . ($wh_Id + 77000) . '|' . $NRD_dt->format('Y-m-') . '01|1');
            $url = $dataEntryURL . "?Do=" . $do;
            echo ($debug?'g':'')."<a href=\"javascript:void(0);\" onclick=\"openPopUp('$url')\" class=\"btn btn-xs green\"> Add " . $NRD_dt->format('M-y') . " Report <i class=\"fa fa-plus\"></i></a>";
        }
    }
}
?>