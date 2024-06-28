<?php
/**
 * swp
 * @package reports
 * 
 * @author     Ajmal Hussain
 * @email <ahussain@ghsc-psm.org>
 * 
 * @version    2.2
 * 
 */
//echo '<pre>';print_r($_REQUEST);exit;
//include AllClasses
include("../includes/classes/AllClasses.php");
//include header
include(PUBLIC_PATH . "html/header.php");
//report id
$rptId = 'swp';
$table= array();
//user province id
$userProvId = $_SESSION['user_province1'];
//if submitted
if (isset($_POST['submit'])) {
    //get from date
    $fromDate = isset($_POST['from_date']) ? mysql_real_escape_string($_POST['from_date']) : '';
    //get to date
    $toDate = isset($_POST['to_date']) ? mysql_real_escape_string($_POST['to_date']) : '';
    //get selected province
    $selProv = mysql_real_escape_string($_POST['prov_sel']);

    // Get item data
    $qry = "SELECT
                *
            FROM
                itminfo_tab";
    //query result
    $qryRes = mysql_query($qry);
    $item_arr = array();
    while ($row = mysql_fetch_assoc($qryRes)) {
        $item_arr[$row['itmrec_id']] = $row;
    }

    // Get stakeholders data
    $qry = "SELECT
                distinct stakeholder.stkname,
                stakeholder.stkid
                FROM
                stakeholder
                INNER JOIN tbl_warehouse ON stakeholder.stkid = tbl_warehouse.stkid
                WHERE
                stakeholder.lvl = 1 AND
                stakeholder.is_reporting = 1 AND
                stakeholder.stk_type_id IN (0, 1) AND
                tbl_warehouse.prov_id = $selProv  ";
    //query result
    $qryRes = mysql_query($qry);
    $stake_list_arr = array();
    while ($row = mysql_fetch_assoc($qryRes)) {
        $stake_list_arr[$row['stkid']] = $row['stkname'];
    }
    $fileName = 'SWP_for_' . $fromDate . '-' . $toDate;
}


 
$stk_govt['govt_sector'] = 
['1'=>'PWD',
'2'=>'DOH (LHW)',
'7'=>'DOH (Static HF)',
'73'=>'DOH (MNCH)',
'9'=>'PPHI'];

$stk_govt['tch'] = 
['3100'=>'JPMC'];

$stk_govt['private_mou'] = ['209'=>'Aga Khan Health Services',
'4'=>'Rahnuma FPAP',
'154'=>'Hands',
'199'=>'Indus Hospital Network',
'194'=>'Peace Foundation',
'204'=>'Sehatmand Zindgi',
'3190'=>'Vital Pakistan Trust',
'3320'=>'Mezrab',
'3364'=>'SINA',
'3375'=>'KGWH',
'3404 '=>'PNS Shifa'
];

$stk_govt['private_non_mou'] = 
['1053'=>'Centers for Disease Control and Prevention',
'80'=>'DKT',
'2808'=>'Drap',
'5'=>'GS',
'362'=>'IHS',
'8'=>'MCHIP',
'842'=>'MERF',
'6'=>'MSS',
'156'=>'NCMNH',
'1192'=>'NDMA',
'1222'=>'NHSRC',
'929'=>'NIH',
'155'=>'Save the Children',
'153'=>'Sukh Aman'];
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
                        <h3 class="page-title row-br-b-wp">Consolidated Contraceptive Performance Report(Stakeholder Wise)</h3>
                        <div class="widget" data-toggle="collapse-widget">
                            <div class="widget-head">
                                <h3 class="heading">Filter by</h3>
                            </div>
                            <div class="widget-body">
                                <?php
//sub_dist_form
                                include('sub_dist_form.php');
                                ?>
                            </div>
                        </div>

                    </div>
                </div>
                <?php
                if (empty($fromDate) || empty($toDate)) {
                    $where = "  ";
                    //reporting period
                    $reportingPeriod = " Until " . date('M-Y', strtotime('today'));
                } else if ($fromDate != $toDate) {
                    $where = " AND reporting_date BETWEEN '$fromDate-01' AND '$toDate-01' ";
                    //reportint period
                    $reportingPeriod = "For the period of " . date('M-Y', strtotime($fromDate)) . ' to ' . date('M-Y', strtotime($toDate));
                } else {
                    $where = " AND reporting_date BETWEEN '$fromDate-01' AND '$toDate-01' ";
                    //reportint period
                    $reportingPeriod = "For the month of " . date('M-Y', strtotime($fromDate));
                }

                //check if submitted
                if (isset($_POST['submit'])) {

                    $qry = "SELECT
				summary_province.province_id,
                                summary_province.stakeholder_id,
                                summary_province.item_id,
                                itminfo_tab.itm_name,
                                itminfo_tab.method_type,
				SUM(summary_province.consumption) AS consumption,
                                itminfo_tab.user_factor,
                                provincial_cyp_factors.cyp_factor,
                                itminfo_tab.extra
			FROM
				summary_province
			INNER JOIN itminfo_tab ON summary_province.item_id = itminfo_tab.itmrec_id
			INNER JOIN tbl_locations ON summary_province.province_id = tbl_locations.PkLocID
			INNER JOIN stakeholder ON summary_province.stakeholder_id = stakeholder.stkid
                        LEFT JOIN provincial_cyp_factors ON summary_province.province_id = provincial_cyp_factors.province_id AND summary_province.stakeholder_id = provincial_cyp_factors.stakeholder_id AND itminfo_tab.itm_id = provincial_cyp_factors.item_id
			WHERE
				summary_province.province_id = '$selProv' 
                                    AND   stakeholder.lvl=1
                                    AND stakeholder.is_reporting=1
                                     AND stakeholder.stk_type_id IN(0,1) 
                                     
                                AND itminfo_tab.itm_category IN (1,2)
                                AND itminfo_tab.method_type IS NOT NULL
			$where
			AND tbl_locations.ParentID IS NOT NULL
			GROUP BY
				summary_province.province_id,summary_province.stakeholder_id,summary_province.item_id";



//                    echo $qry;exit;
                    //query result
                    $qryRes = mysql_query($qry);
                    //check if result exists
                    if (mysql_num_rows($qryRes) > 0) {
                        ?>
                        <?php
                        //include sub_dist_reports
                        include('sub_dist_reports.php');
                        ?>
                        <div class="col-md-12" style="overflow:auto;">
                            <?php
                            $disp_arr = $itm_arr = $itm_categ = $cyp_arr = $user_factor = $larc_arr = array();

                            while ($row = mysql_fetch_assoc($qryRes)) {
                                //print_r($row);
                                //echo '<br/>'.$row['stakeholder_id'];
                                $disp_arr[$row['stakeholder_id']][$row['item_id']] = $row['consumption'];
                                $itm_arr[$row['item_id']] = $row['itm_name'];
                                $itm_categ[$row['method_type']][$row['item_id']] = $row['itm_name'];
                                $cyp_arr[$row['item_id']] = (!empty($row['cyp_factor']) ? $row['cyp_factor'] : $row['extra']);
                                $user_factor[$row['item_id']] = $row['user_factor'];
                                if ($row['item_id'] == 'IT-005' || $row['item_id'] == 'IT-004' || $row['item_id'] == 'IT-008' || $row['item_id'] == 'IT-013') {
                                    $larc_arr[$row['item_id']] = (!empty($row['cyp_factor']) ? $row['cyp_factor'] : $row['extra']);
                                }
//                                
                            }
//                            echo '<pre>';print_r($itm_categ);
                            //exit;
//                            echo '<pre>'; print_r($itm_arr);
                            ?>
                            <table id="myTable" width="100%" border="1">
                                <tr>
                                    <td align="center" colspan="21">
                                        <h4 class="center">
                                            <?php
                                            echo "Consolidated Contraceptive Performance Report - $reportingPeriod<br>";
                                            ?>
                                            <?php echo 'Inrespect of ' . $prov_name . ' Province'; ?>
                                        </h4>
                                    </td>

                                </tr>


                                <tr>
<!--                                    <th   style="text-align:center"rowspan="2" >S.No.</th>-->
                                    <th  align="center" rowspan="2" >Stakeholder</th>
                                    <?php
                                    foreach ($itm_categ as $method_name => $items) {
                                        echo '<th style="text-align:center" colspan="' . count($items) . '" >' . $method_name . '</th>';
                                    }
                                    ?>
                                    <th   style="text-align:center" rowspan="2" >CYP of LARC</th>
                                    <th   style="text-align:center" rowspan="2" >CYP</th>
                                    <th    style="text-align:center" rowspan="2" >Users</th>
                                    <th    style="text-align:center" rowspan="2" >CYP contribution in %</th>
                                    <th    style="text-align:center" rowspan="2" >LARC %</th>
                                </tr>
                                <tr>
                                    <?php
                                    foreach ($itm_categ as $method_name => $items) {
                                        foreach ($items as $id => $item_name) {
                                            echo '<th style="text-align:center" colspan="" >' . $item_name . '</th>';
                                        }
                                    }
                                    ?>
                                </tr>
                                <tr style="background-color:#EEEEEE">
                                    <?php
//                                    echo '<td   style="text-align:center">#</td>';
                                    $cc = count($itm_arr) + 6;
                                    for ($i = 1; $i <= $cc; $i++) {
                                        echo '<td   style="text-align:center">' . $i . '</td>';
                                    }
                                    ?>
                                </tr>    

                                <?php
                                $count = 0;
                                $prod_totals = $cyp_totals = $user_totals = $larc_totals = array();
                                $prod_totals['CYP'] = 0;
                                $prod_totals['USER'] = 0;
                                $prod_totals['LARC'] = 0;
                                foreach ($stake_list_arr as $stkid => $stk_name) {
                                    $stk_data = @$disp_arr[$stkid];
                                    $count++;
                                    $cyp = 0;
                                    $user = 0;
                                    $larc = 0;
                                    
                                    $t ='';
                                    $t .= '<tr>
                                            <!--<td style="text-align:center">' . $count . '</td>-->';
                                    $t .= ' <td  style="text-align:left">' . $stk_name . '</td>';
                                    foreach ($itm_categ as $method_name => $items) {
                                        foreach ($items as $id => $item_name) {
                                            $t .= ' <td style="text-align:right">' . number_format(isset($stk_data[$id]) ? $stk_data[$id] : '0') . '</td>';

                                            if (empty($prod_totals[$id]))
                                                $prod_totals[$id] = 0;
                                            $prod_totals[$id] += isset($stk_data[$id]) ? $stk_data[$id] : '0';

                                            if (empty($cyp_totals[$id]))
                                                $cyp_totals[$id] = 0;
                                            $cyp_totals[$id] += ($cyp_arr[$id] * (isset($stk_data[$id]) ? $stk_data[$id] : '0'));

                                            if (empty($larc_totals[$id]))
                                                $larc_totals[$id] = 0;
                                            if ($row['item_id'] == 'IT-005' || $row['item_id'] == 'IT-004' || $row['item_id'] == 'IT-008' || $row['item_id'] == 'IT-013') {
                                                $larc_totals[$id] += ($larc_arr[$id] * (isset($stk_data[$id]) ? $stk_data[$id] : '0'));
                                            }
                                            if (empty($user_totals[$id]))
                                                $user_totals[$id] = 0;
                                            $user_totals[$id] += ($user_factor[$id] * (isset($stk_data[$id]) ? $stk_data[$id] : '0'));

                                            $cyp += ($cyp_arr[$id] * (isset($stk_data[$id]) ? $stk_data[$id] : '0'));
                                            $user += ($user_factor[$id] * (isset($stk_data[$id]) ? $stk_data[$id] : '0'));
                                            $larc += (@$larc_arr[$id] * (isset($stk_data[$id]) ? $stk_data[$id] : '0'));
                                        }
                                    }
                                    $prod_totals['CYP'] += $cyp;
                                    $prod_totals['USER'] += $user;
                                    $prod_totals['LARC'] += $larc;
                                    $t .= ' <td  style="text-align:right">' . number_format($larc) . '</td> '
                                    . '<td  style="text-align:right">' . number_format($cyp) . '</td>
                                                    <td  style="text-align:right">' . number_format($user) . '</td>';
                                    
//                                    $t .= '                 <td  style="text-align:right">' . 'number_format($user)' . '</td>
//                                                                  <td  style="text-align:right">' . 'percent' . '</td>
//                                                </tr> ';
                                    $a = array();
                                    $a['rowx'] = $t;
                                    $a['cyp'] = $cyp;
                                    $a['larc'] = $larc;
                                    
                                    $table[$stkid] = $a;
                                }
//                                echo '<pre>';print_r($table);exit;
                                $t ='';
                                $t .= ' <tr style="text-align:center;background-color:#EEEEEE" > 
                                                <td  style="text-align:center"  colspan="2"><b>Total</b></td>';
                                //foreach ($itm_arr as $id => $item_name) {
                                    foreach ($itm_categ as $method_name => $items) {
                                        foreach ($items as $id => $item_name) {
                                                $t .= ' <td style="text-align:right">' . number_format($prod_totals[$id]) . '</td>';
                                            }
                                    }
                                $t .= ' <td   id="larc_total" style="text-align:right">' . number_format($prod_totals['LARC']) . '</td>'
                                . '<td  id="cyp_total" style="text-align:right">' . number_format($prod_totals['CYP']) . '</td>
                                          <td  style="text-align:right">' . number_format($prod_totals['USER']) . '</td>
                                      </tr> ';
                                $total_cyp = $prod_totals['CYP'];
                                $total_larc = $prod_totals['LARC'];
                                $table['total'] = $t;

                                $t ='';
                                $t .= ' <tr style="text-align:center;" > 
                                                <td  style="text-align:center"  colspan="2"><b>CYP</b></td>';
                                foreach ($itm_categ as $method_name => $items) {
                                        foreach ($items as $id => $item_name) {
                                    $t .= ' <td  style="text-align:right">' . number_format($cyp_totals[$id]) . '</td>';
                                }
                                }
                                $t .= '</tr> ';
                                $table['cyp'] = $t;

                                $t = '';
                                $t .= ' <tr style="text-align:center;" > 
                                                <td  style="text-align:center"  colspan="2"><b>USERS</b></td>';
                                foreach ($itm_categ as $method_name => $items) {
                                        foreach ($items as $id => $item_name) {
                                    $t .= ' <td style="text-align:right">' . number_format($user_totals[$id]) . '</td>';
                                }
                                }
                                $t .= '</tr> ';
                                $table['users'] = $t;
                                
                                
//                                echo '<pre>TTTTTTTTTTTTTTTTTTT:';print_r($table);exit;
                                
                                echo '<tr><td colspan="21" style="text-align:center;background-color:#ffcece">Government Sector</td></tr>';
                                foreach($stk_govt['govt_sector'] as $stkid=>$stkname){
                                        $row=$table[$stkid];

                                        if(is_array($row)){
                                            echo $row['rowx'];
                                            $cyp = $row['cyp']*100/$total_cyp;
                                            $larc = $row['larc']*100/$total_larc;
                                            echo '<td  style="text-align:right">'.((!empty($cyp) && $cyp>0)?number_format($cyp,1):'0').' %</td>
                                                <td  style="text-align:right">'.((!empty($larc) && $larc>0)?number_format($larc,1):'0'). ' %</td>
                                                </tr>'; 
                                        }
                                        else
                                        {
//                                            echo $row;  
                                        }
                                }
                                
                                
                                
                                echo '<tr><td colspan="21" style="text-align:center;background-color:#ffcece">Tertiary Care Hospitals</td></tr>';
                                foreach($stk_govt['tch'] as $stkid=>$stkname){
                                        $row=$table[$stkid];

                                        if(is_array($row)){
                                            echo $row['rowx'];
                                            $cyp = $row['cyp']*100/$total_cyp;
                                            $larc = $row['larc']*100/$total_larc;
                                            echo '<td  style="text-align:right">'.((!empty($cyp) && $cyp>0)?number_format($cyp,1):'0').' %</td>
                                                <td  style="text-align:right">'.((!empty($larc) && $larc>0)?number_format($larc,1):'0'). ' %</td>
                                                </tr>'; 
                                        }
                                        else
                                        {
//                                            echo $row;  
                                        }
                                }
                                echo '<tr><td colspan="21" style="text-align:center;background-color:#ffcece">Private Sector ( MoU)</td></tr>';
                                foreach($stk_govt['private_mou'] as $stkid=>$stkname){
                                        $row=$table[$stkid];

                                        if(is_array($row)){
                                            echo $row['rowx'];
                                            $cyp = $row['cyp']*100/$total_cyp;
                                            $larc = $row['larc']*100/$total_larc;
                                            echo '<td  style="text-align:right">'.((!empty($cyp) && $cyp>0)?number_format($cyp,1):'0').' %</td>
                                                <td  style="text-align:right">'.((!empty($larc) && $larc>0)?number_format($larc,1):'0'). ' %</td>
                                                </tr>'; 
                                        }
                                        else
                                        {
//                                            echo $row;  
                                        }
                                }
                                echo '<tr><td colspan="21" style="text-align:center;background-color:#ffcece">Private Sector (Non MoU)/Defunct</td></tr>';
                                foreach($stk_govt['private_non_mou'] as $stkid=>$stkname){
                                        $row=$table[$stkid];

                                        if(is_array($row)){
                                            echo $row['rowx'];
                                            $cyp = $row['cyp']*100/$total_cyp;
                                            $larc = $row['larc']*100/$total_larc;
                                            echo '<td  style="text-align:right">'.((!empty($cyp) && $cyp>0)?number_format($cyp,1):'0').' %</td>
                                                <td  style="text-align:right">'.((!empty($larc) && $larc>0)?number_format($larc,1):'0'). ' %</td>
                                                </tr>'; 
                                        }
                                        else
                                        {
                                            echo $row;  
                                        }
                                }
                                echo $table['total'];
                                echo $table['cyp'];
                                echo $table['users'];
                                
                                ?>

                            </table>
                        </div>
                    </div>
            
                    <div class="row"  >
                        <div class="col-md-12">
                            <div class=" ">
                                <div class="note note-info h6"  ><em><?=$lastUpdateText?></em></div>
                            </div>
                        </div>
                    </div>
                    <?php
                } else {
                    echo "No record found";
                }
            }
            // Unset varibles
            unset($data, $total);
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
</body>
</html>