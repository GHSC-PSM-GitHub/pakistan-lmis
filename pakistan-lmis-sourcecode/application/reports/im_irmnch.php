<?php
/**
 * cls11
 * @package reports
 * 
 * @author     Ajmal Hussain
 * @email <ahussain@ghsc-psm.org>
 * 
 * @version    2.2
 * 
 */
ini_set('max_execution_time', 300);
//include AllClasses
include("../includes/classes/AllClasses.php");
//include header
include(PUBLIC_PATH . "html/header.php");
//report id
$rptId = 'stkiss';
//if submitted
if (isset($_POST['submit'])) {
    $selProv = mysql_real_escape_string($_POST['prov_sel']);
    $stakeholder = mysql_real_escape_string($_POST['stakeholder']);
    $selItem = mysql_real_escape_string($_POST['itm_id']);
    $fromDate = $_POST['from_date'];
    $toDate = $_POST['to_date'];
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
                        <h3 class="page-title row-br-b-wp">Stock Issue By PMU and Received By DMU Report - IRMNCH</h3>
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
                if (isset($_POST['submit'])) {
                    $query = "SELECT 
                                tbl_stock_master.trandate,
                                tbl_stock_master.pkstockid,
                                tbl_stock_master.tranno,
                                tbl_locations.locname AS province,
                                tbl_stock_master.tranref,
                                tbl_stock_detail.pkdetailid,
                                tbl_warehouse.wh_id,
                                tbl_warehouse.wh_name AS wh_name,
                                fundingSource.wh_name AS funding_source,
                                stock_batch.batch_no,
                                stock_batch.batch_expiry,
                                stock_batch.manufacturer,
                                tbl_stock_detail.batchid,
                                tbl_stock_detail.qty,
                                tbl_itemunits.unittype,
                                itminfo_tab.itm_name,
                                itminfo_tab.generic_name,
                                Ifnull(stakeholder_item.quantity_per_pack, itminfo_tab.qty_carton)
                                qty_carton,
                                itminfo_tab.field_color,
                                stakeholder.stkname,
                                stk_ofc.stkname AS stk_office_name,
                                (SELECT Sum(placements.quantity) AS remValue
                                FROM   placements
                                    WHERE  placements.stock_detail_id = tbl_stock_detail.pkdetailid AND is_placed = 0) AS sumIssueQty,
                               tbl_stock_detail.isreceived,
                               stk.stkname AS stakeholder_name,
                               stakeholder_item.unit_price,
                               ( stakeholder_item.unit_price * Abs(tbl_stock_detail.qty) ) AS price_of_qty,
                               tbl_locations.locname AS province,
                               tbl_stock_master.createdby,
                               tbl_stock_master.createdon,
                               stk_ofc.lvl,
                               tbl_warehouse.is_allowed_im,
                               tbl_warehouse.im_start_month,
                               tbl_stock_master.requisition_type,
                               tbl_stock_master.method,
                               tbl_stock_master.attachment_name,
                               tbl_stock_detail.isreceived
                            FROM   tbl_stock_master
                               INNER JOIN tbl_stock_detail
                                       ON tbl_stock_master.pkstockid = tbl_stock_detail.fkstockid
                               INNER JOIN tbl_warehouse
                                       ON tbl_stock_master.whidto = tbl_warehouse.wh_id
                               INNER JOIN stock_batch
                                       ON tbl_stock_detail.batchid = stock_batch.batch_id
                               LEFT JOIN tbl_warehouse AS fundingSource
                                      ON stock_batch.funding_source = fundingSource.wh_id
                               INNER JOIN itminfo_tab
                                       ON stock_batch.item_id = itminfo_tab.itm_id
                               LEFT JOIN tbl_itemunits
                                      ON itminfo_tab.itm_type = tbl_itemunits.unittype
                               LEFT JOIN stakeholder_item
                                      ON stock_batch.manufacturer = stakeholder_item.stk_id
                               LEFT JOIN stakeholder
                                      ON stakeholder_item.stkid = stakeholder.stkid
                               LEFT JOIN stakeholder AS stk_ofc
                                      ON tbl_warehouse.stkofficeid = stk_ofc.stkid
                               LEFT JOIN stakeholder AS stk
                                      ON tbl_warehouse.stkid = stk.stkid
                               LEFT JOIN tbl_locations
                                      ON tbl_warehouse.prov_id = tbl_locations.pklocid
                               INNER JOIN tbl_locations AS province
                                       ON tbl_warehouse.prov_id = province.pklocid
                            WHERE  tbl_stock_master.trandate BETWEEN '$fromDate-01' AND '".date('Y-m-t', strtotime($toDate))."'
                                AND tbl_stock_master.trantypeid = 2
                                AND stock_batch.wh_id = ".$_SESSION['user_warehouse']."
                                AND tbl_stock_detail.temp = 0
                            ORDER BY tbl_warehouse.wh_name ";
                            // echo $query;die();
                            $result = mysql_query($query);
                    //get query result
                    // Sort the array
                    if (mysql_num_rows($result) > 0) {
                        //include sub_dist_reports
                        include('sub_dist_reports.php');
                        ?>
                        <div class="col-md-12" style="overflow:auto;">
                            <?php
                            //fetch result
                            while ($row = mysql_fetch_array($result)) {
                                //wh_name
                                $data[$row['wh_id']]['wh_name'] = $row['wh_name'];
                                $data[$row['wh_id']]['issue'] += 1;
                                if ($row['isreceived'] == 1) {
                                    $data[$row['wh_id']]['received'] += 1;
                                    $data[$row['wh_id']]['not_received'] += 0;
                                }else{
                                    $data[$row['wh_id']]['received'] += 0;
                                    $data[$row['wh_id']]['not_received'] += 1;
                                }
                            }
                            ?>
                            <table width="100%" class="table table-striped" id="myTable" >
                                <tr >
                                    <td align="center"><h4 class="center"> Stock Issue By PMU and Received By DMU Report </h4></td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="padding-top: 10px;"><table width="100%" id="myTable" cellspacing="0" align="center">
                                            <thead>
                                                <tr>
                                                    <th width="5%">S.No.</th>
                                                    <th width="15%">District</th>
                                                    <th>Total No of Issued Vouchers To District By PMU</th>
                                                    <th>Vouchers Received By District</th>
                                                    <th width="15%" >Vouchers Not Received By District</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            <?php
                                                $counter = 1;
                                                $issue = $received = $not_received = 0;
                                                foreach ($data as $id => $dataItem) {
                                                    $issue += $dataItem['issue'];
                                                    $received += $dataItem['received'];
                                                    $not_received += $dataItem['not_received'];
                                            ?>
                                                    <tr>
                                                        <td class="center"><?= $counter++; ?></td>
                                                        <td><?= $dataItem['wh_name']; ?></td>
                                                        <td class="right"><?= $dataItem['issue']; ?></td>
                                                        <td class="right"><?= $dataItem['received']; ?></td>
                                                        <td class="right"><?= $dataItem['not_received']; ?></td>
                                                    </tr>
                                            <?php
                                                }
                                            ?>
                                            </tbody>
                                            <tfoot>
                                                <tr>
                                                    <th colspan="2" class="right">Grand Total</th>
                                                    <th class="right"><?= $issue;?></th>
                                                    <th class="right"><?= $received;?></th>
                                                    <th class="right"><?= $not_received;?></th>
                                                </tr>
                                            </tfoot>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <?php
                } else {
                    echo "No record found";
                }
            }
            ?>
        </div>
    </div>
</div>
<?php
include PUBLIC_PATH . "/html/footer.php";
//include combos
include ('combos.php');
?>
<script>
    $(function () {
        $('#stakeholder').change(function (e) {
            $('#itm_id, #prov_sel').html('<option value="">Select</option>');
            showProducts('');
            showProvinces('');
        });
    })
    function showProducts(pid) {
        var stk = $('#stakeholder').val();
        if (typeof stk !== 'undefined')
        {
            $.ajax({
                url: 'ajax_calls.php',
                type: 'POST',
                data: {stakeholder: stk, productId: pid},
                success: function (data) {
                    $('#itm_id').html(data);
                }
            })
        }
    }
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