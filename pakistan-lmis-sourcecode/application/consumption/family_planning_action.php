<?php
//echo '<pre>';print_r($_POST);exit;
//include AllClasses
include("../includes/classes/AllClasses.php");

if (!empty($_POST['client_data']) && !empty($_POST['commodities_utilization']) && !empty($_POST['referrals'])) {
    $stakeholder = $_POST['stakeholder'];
    $province = $_POST['prov_sel'];
    $district = $_POST['district'];
    $user_id = $_SESSION['user_id'];
    $month = date('Y-m-01', strtotime($_POST['month']));
//    print_r($month);exit();

    $client_data = $_POST['client_data'];
    $commodities_utilization = $_POST['commodities_utilization'];
    $referrals = $_POST['referrals'];
//    print_r($referrals['lhw']);exit();

    $del_qry = "DELETE FROM fp_adp_consumption 
                WHERE stk_id = $stakeholder
				AND prov_id = $province
				AND dist_id = $district
				AND report_month = '$month' ";
    //execute query
    mysql_query($del_qry);
    foreach ($client_data['new'] as $item_id => $value) {
        $qry = "INSERT INTO fp_adp_consumption
			SET
				stk_id = $stakeholder,
				prov_id = $province,
				dist_id = $district,
				report_month = '$month',
				item_id = $item_id,
				wh_obl_a = " . ((!empty($commodities_utilization['opening_balance'][$item_id]))?$commodities_utilization['opening_balance'][$item_id]:0) . ",
				wh_issue_up = " . ((!empty($commodities_utilization['issuance'][$item_id]))?$commodities_utilization['issuance'][$item_id]:0) . ",
				wh_cbl_a = " . ((!empty($commodities_utilization['closing_balance'][$item_id]))?$commodities_utilization['closing_balance'][$item_id]:0) . ",
				new_clients = " . ((!empty($client_data['new'][$item_id]))?$client_data['new'][$item_id]:0) . ",
				followup_clients = " . ((!empty($client_data['follow_up'][$item_id]))?$client_data['follow_up'][$item_id]:0) . ",
				created_by = '" . $user_id . "'
				";
        //execute query
        mysql_query($qry);
    }


    //Referral Data
    $del_qry = "DELETE FROM fp_adp_referral 
                WHERE stk_id = $stakeholder
				AND prov_id = $province
				AND dist_id = $district
				AND report_month = '$month' ";
    //execute query
    mysql_query($del_qry);
    $ref_qry = "INSERT INTO fp_adp_referral
			SET
				stk_id = $stakeholder,
				prov_id = $province,
				dist_id = $district,
				report_month = '$month',
				lhw = " . ((!empty($referrals['lhw']))?$referrals['lhw']:0) . ",
				fwa = " . ((!empty($referrals['fwa']))?$referrals['fwa']:0)   . ",
				sm =  " . ((!empty($referrals['sm']))?$referrals['sm']:0). ",
				created_by = '" . $user_id . "'
				";
    //execute query
    mysql_query($ref_qry);
}
?>

<script>
    window.close();
    window.opener.location.reload();
</script>
