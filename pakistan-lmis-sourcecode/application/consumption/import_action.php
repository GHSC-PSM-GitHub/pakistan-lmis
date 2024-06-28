<?php
ini_set('max_execution_time', 300); 
//include AllClasses
include("../includes/classes/AllClasses.php");
//if for submitted
if ( $_POST['submit'] )
{
	$error = '';
    //get user_stakeholder
	$stakeholder = $_SESSION['user_stakeholder'];
    //get month
	$month = mysql_real_escape_string($_POST['month']);
    // get year
	$year = mysql_real_escape_string($_POST['year']);
	
	// File upload
	$info = pathinfo($_FILES['data_file']['name']);
	//info
    $extension = $info['extension'];
	//file name
    $fileName = 'LMIS_UPLOADED_FILE' . '.' . $extension;
	//upload dir
   	$uploadDir = '../../uploads';
	
	// Check if the file already exists, and if so, delete it
	if (file_exists($uploadDir . '/' . $fileName)) {
		unlink($uploadDir . '/' . $fileName);
	}
	// Create upload directory
	move_uploaded_file($_FILES['data_file']['tmp_name'], $uploadDir . $fileName);
	
	/**
	* XLS parsing uses php-excel-reader from http://code.google.com/p/php-excel-reader/
	*/
	header('Content-Type: text/plain');
	//file path
	$Filepath = $uploadDir.$fileName;
	
	// Excel reader from http://code.google.com/p/php-excel-reader/
	require(PUBLIC_PATH.'php-excel/excel_reader2.php');
	require(PUBLIC_PATH.'php-excel/SpreadsheetReader.php');
	//time zone
	date_default_timezone_set('UTC');
	
	try
	{
        //Spreadsheet Reader
		$Spreadsheet = new SpreadsheetReader($Filepath);
		$Sheets = $Spreadsheet -> Sheets();
		//fetching data from Sheets
		foreach ($Sheets as $Index => $Name)
		{
			$Time = microtime(true);
                        //change sheet
			$Spreadsheet -> ChangeSheet($Index);
	
			foreach ($Spreadsheet as $Key => $Row)
			{
				if ( $Key == 0 ) // Check if headers are correct
				{
					/** commented by shaban on 19 oct to add new format --start--- */
					// if (
					// 	$Row[0] != 'Store Name' || 
					// 	$Row[1] != 'Store Code' || 
					// 	$Row[2] != 'Product ID' || 
					// 	$Row[3] != 'Opening Balance' ||
					// 	$Row[4] != 'Received' || 
					// 	$Row[5] != 'Adjustment +' ||
					// 	$Row[6] != 'Adjustment -' ||
					// 	$Row[7] != 'Sale/Issue' ||
					// 	$Row[8] != 'Closing Balance')
					// {
					// 	$error .= "Data is not correctly formatted. <br />";
					// 	break;
					// }
					/** commented by shaban on 19 oct to add new format --end--- */

					if (
						$Row[0] != 'Wh_id' || 
						$Row[3] != 'Item ID' || 
						$Row[5] != 'Opening Balance' ||
						$Row[6] != 'Received' || 
						$Row[7] != 'Issued' || 
						$Row[8] != 'Closing' ||
						$Row[9] != 'Adj +' ||
						$Row[10] != 'Adj -')
					{
						$error .= "Data is not correctly formatted. <br />";
						break;
					}
				}
				else // If correct data then read it
				{
					$check_qry="SELECT wh_id FROM tbl_warehouse WHERE wh_id =".$Row[0]." AND stkid = ".$_SESSION['user_stakeholder']." and dist_id = '".$Row[1]."' ";
//                                        echo $check_qry;exit;
                                        $wh_num_rows = mysql_num_rows(mysql_query($check_qry));
					if ($wh_num_rows == 0)
					{
						$error .= 'In-correct IDs in Wh_id column <strong>' . $Row[0] . '</strong> on line <strong>' . ($Key + 1)  . '</strong><br />';
					}

					$rptDate = $year . '-' . str_pad($month, 2, '0', STR_PAD_LEFT) . '-01';
					$qry = "SELECT
								tbl_wh_data.wh_cbl_a AS OB
							FROM
								tbl_wh_data
							WHERE
								tbl_wh_data.RptDate = DATE_ADD('$rptDate', INTERVAL -1 MONTH)
							AND tbl_wh_data.item_id = '".$Row[3]."'
							AND tbl_wh_data.wh_id = ".$Row[0]."
							ORDER BY
								tbl_wh_data.w_id DESC
							LIMIT 1";
					//result
//                                        echo $qry;exit;
                    $qryRes = mysql_fetch_array(mysql_query($qry));
					
					
					if(!empty($qryRes['OB'])) // If previous balance found
					{
						if($Row[5] != $qryRes['OB'])
						{
							$error .= 'In-correct opening balance of '.$Row[4].' for '.$Row[2].' ('.$Row[0].') at line ' . ($Key + 1) . '. It must be the closing balance of previous month, which was: <b>' .$qryRes['OB'] . '</b><br />';
						}
					}
					
					$cb = $Row[5] + $Row[6] + $Row[9] - $Row[10] - $Row[7];
					if ( $cb == $Row[8] )
					{
						$dataArr[$Row[0]][$Row[3]]['ob'] = $Row[5];
						$dataArr[$Row[0]][$Row[3]]['rcv'] = $Row[6];
						$dataArr[$Row[0]][$Row[3]]['adjust+'] = $Row[9];
						$dataArr[$Row[0]][$Row[3]]['adjust-'] = $Row[10];
						$dataArr[$Row[0]][$Row[3]]['issue'] = $Row[7];
						$dataArr[$Row[0]][$Row[3]]['cb'] = $Row[8];
					}
					else
					{
                                            //error msg
						$error .= 'In-correct closing balance calculation of '.$Row[4].' for '.$Row[2].' ('.$Row[0].') at line ' . ($Key + 1) . '<br />';
					}

					
				}
			}
		}
		
		if ( empty($error) )
		{
			foreach( $dataArr as $whId => $whData )
			{
				foreach( $whData as $itemId => $data )
				{
					// Check if data already exists
					$qry = "SELECT tbl_wh_data.w_id FROM tbl_wh_data WHERE tbl_wh_data.report_month = $month AND tbl_wh_data.report_year = $year AND tbl_wh_data.item_id = '$itemId' AND tbl_wh_data.wh_id = $whId";
					
					if (mysql_num_rows(mysql_query($qry)) > 0) // If data exists then delete the old data
					{
                        //delete query
						$qry = "DELETE
							FROM
								tbl_wh_data
							WHERE
								tbl_wh_data.report_month = $month
							AND tbl_wh_data.report_year = $year
							AND tbl_wh_data.item_id = '$itemId'
							AND tbl_wh_data.wh_id = $whId ";
						mysql_query($qry);
					}
				
					$ip_address = '';
					 if (!empty($_SERVER['REMOTE_ADDR'])) {
					 	$ip_address = $_SERVER['REMOTE_ADDR'];
					 } else {
					 	$ip_address = ''; // or any default value you prefer
					 }
					$qry = "INSERT INTO tbl_wh_data
							SET
							tbl_wh_data.report_month = $month,
							tbl_wh_data.report_year = $year,
							tbl_wh_data.item_id = '$itemId',
							tbl_wh_data.wh_id = '$whId',
							tbl_wh_data.wh_obl_a = '".$data['ob']."',
							tbl_wh_data.wh_received = '".$data['rcv']."',
							tbl_wh_data.wh_issue_up = '".$data['issue']."',
							tbl_wh_data.wh_cbl_a = '".$data['cb']."',
							tbl_wh_data.wh_adja = '".$data['adjust+']."',
							tbl_wh_data.wh_adjb = '".$data['adjust-']."',
							tbl_wh_data.RptDate = '".$year.'-'.$month."-01',
							tbl_wh_data.add_date = '".date('Y-m-d H:i:s')."',
							tbl_wh_data.last_update = '".date('Y-m-d H:i:s')."',
							tbl_wh_data.ip_address = '".$ip_address."',
							tbl_wh_data.created_by = '".$_SESSION['user_id']."'";
					mysql_query($qry);

					
				}
			}
			
			// Delete the fiile 
			@unlink($Filepath);
                        //msg
			$_SESSION['msg'] = 'Data imported successfully.';
			header("Location: import.php");
			exit;
		}
		else
		{
			// Delete the fiile 
			@unlink($Filepath);
			$_SESSION['error'] = $error;
			$url = 'import.php?month='.$month.'&year='.$year;
			header("Location: $url");
			exit;
		}
		
	}
	catch (Exception $E)
	{
		// Delete the fiile 
		@unlink($Filepath);
        //error msg
		$_SESSION['error'] = 'There is an error with your request. Please try re-importing the data.';
		$url = 'import.php?month='.$month.'&year='.$year;
		header("Location: $url");
		exit;
	}
}
