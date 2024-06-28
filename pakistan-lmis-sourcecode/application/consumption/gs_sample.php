<?php
//Including files
include("../includes/classes/AllClasses.php");
include_once(PUBLIC_PATH."php-excel/xlsxwriter.class.php");
ini_set('display_errors', 0);
ini_set('log_errors', 1);
error_reporting(E_ALL & ~E_NOTICE);

$filename = "LMIS_UPLOAD_SAMPLE.xlsx";
header('Content-disposition: attachment; filename="'.XLSXWriter::sanitize_filename($filename).'"');
header("Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
header('Content-Transfer-Encoding: binary');
header('Cache-Control: must-revalidate');
header('Pragma: public');

/** commented by shaban on 19 oct to add new format --start--- */
// $header = array(
//     'Store Name'=>'string',
//     'Store Code'=>'string',
//     'Product ID'=>'string',
//     'Opening Balance'=>'integer',
//     'Received'=>'integer',
//     'Adjustment + '=>'double',
//     'Adjustment - '=>'double',
//     'Sale/Issue'=>'integer',
//     'Closing Balance '=>'double',
//     'Item Name '=>'string'
// );
/** commented by shaban on 19 oct to add new format --end--- */
$header = array(
    'Wh_id'=>'string',
    'District ID'=>'string',
    'District NAME'=>'string',
    'Item ID'=>'string',
    'Item Name'=>'string',
    'Opening Balance'=>'integer',
    'Received'=>'integer',
    'Issued'=>'integer',
    'Closing'=>'double',
    'Adj +'=>'double',
    'Adj -'=>'double',
    'Report Month'=>'string',
    'Report Y'=>'string'
);


//Query for Green Star sample
/** commented by shaban on 19 oct to add new format --start--- */
// $qry = "SELECT DISTINCT
// 			tbl_warehouse.wh_name,
// 			tbl_warehouse.wh_id,
// 			itminfo_tab.itmrec_id,
// 			'' AS opening_balance,
// 			'' AS receive,
// 			'' AS `adjustment+`,
// 			'' AS `adjustment-`,
// 			'' AS sale,
// 			'' AS closing_balance,
// 			itminfo_tab.itm_name
// 		FROM
// 			tbl_warehouse
// 		INNER JOIN wh_user ON tbl_warehouse.wh_id = wh_user.wh_id
// 		INNER JOIN stakeholder ON tbl_warehouse.stkofficeid = stakeholder.stkid,
// 		 itminfo_tab
// 		INNER JOIN stakeholder_item ON itminfo_tab.itm_id = stakeholder_item.stk_item
// 		WHERE
// 			tbl_warehouse.stkid = ".$_SESSION['user_stakeholder']."
// 		AND stakeholder.lvl = 4
// 		AND stakeholder_item.stkid = ".$_SESSION['user_stakeholder']."
// 		ORDER BY
// 			tbl_warehouse.wh_id ASC,
// 			itminfo_tab.frmindex ASC";
/** commented by shaban on 19 oct to add new format --end--- */

$qry = "SELECT DISTINCT
	tbl_warehouse.wh_id, 
	tbl_warehouse.dist_id, 
	tbl_locations.LocName, 
	itminfo_tab.itmrec_id, 
	itminfo_tab.itm_name, 
	'0' AS opening_balance, 
	'0' AS receive, 
	'0' AS issued, 
	'0' AS closing, 
	'0' AS `adj+`, 
	'0' AS `adj-`, 
	'' AS report_mnth, 
	'' AS report_year
FROM
	tbl_warehouse
	INNER JOIN
	tbl_locations
	ON 
		tbl_warehouse.dist_id = tbl_locations.PkLocID
	INNER JOIN
	wh_user
	ON 
		tbl_warehouse.wh_id = wh_user.wh_id
	INNER JOIN
	stakeholder
	ON 
		tbl_warehouse.stkofficeid = stakeholder.stkid
	INNER JOIN
	stakeholder_item
	ON 
		tbl_warehouse.stkid = stakeholder_item.stkid
	INNER JOIN
	itminfo_tab
	ON
		itminfo_tab.itm_id = stakeholder_item.stk_item  
		WHERE
			tbl_warehouse.stkid = ".$_SESSION['user_stakeholder']."
		AND stakeholder.lvl = 4
		AND stakeholder_item.stkid = ".$_SESSION['user_stakeholder']."
		ORDER BY
			tbl_warehouse.wh_id ASC,
			itminfo_tab.frmindex ASC";
//Query result
$rows = mysql_query($qry);
$data = array();
while( $row = mysql_fetch_row($rows) )
{
	$data[] = $row;
}
//Creating XLSXWriter
$writer = new XLSXWriter();
//Author 
$writer->setAuthor('LMIS');
//Write data on sheet
$writer->writeSheet($data,'Sheet1',$header);
$writer->writeToStdOut();
exit(0);