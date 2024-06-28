<?php
include("../includes/classes/AllClasses.php");
include(APP_PATH . "includes/report/FunctionLib.php");
include(PUBLIC_PATH . "html/header.php");
$report_id = "TOWER";
$actionpage = "tower.php";
$rptId = "tower";
$parameters = "TSP";
$date_from = date('01/m/Y');
$date_to = date('01/m/Y');

$sel_stk = $_SESSION['user_stakeholder'];
$sel_prov = '';
$sel_dist = '';
$sel_wh = '';
//$sel_prov = $_SESSION['user_province'];
//$sel_dist = $_SESSION['user_district'];
//echo '<pre>';
//print_r($_SESSION);
//echo '</pre>';
//exit;
$report_title = "Daily Reporting Facilities - Status of Stock";
if (isset($_POST['go'])) {
    $date_from = isset($_POST['date_from']) ? mysql_real_escape_string($_POST['date_from']) : '';
    $date_from1 = dateToDbFormat($date_from);
    $date_to = isset($_POST['date_to']) ? mysql_real_escape_string($_POST['date_to']) : '';
    $date_to1 = dateToDbFormat($date_to);
    $sel_prov = mysql_real_escape_string($_POST['province']);

    $sel_wh = mysql_real_escape_string($_POST['warehouse']);
    $sel_dist = mysql_real_escape_string($_POST['district']);
    $sel_stk = mysql_real_escape_string($_POST['stk_sel']);
    $selItem = mysql_real_escape_string($_POST['itm_id']);
}
?>
<link rel="stylesheet" type="text/css" href="../../public/assets/global/plugins/select2/select2.css"/>
<style>
    .table-scroll {
        position:relative;
        margin:auto;
        overflow:hidden;
        border:1px solid #000;
    }
    .table-wrap {
        overflow:auto;
    }
    .table-scroll table {
        width:100%;
        margin:auto;
        border-collapse:separate;
        border-spacing:0;
    }
    .table-scroll th, .table-scroll td {
        padding:5px 10px;
        border:1px solid #000;
        background:#fff;
        white-space:nowrap;
        vertical-align:top;
    }
    .table-scroll thead, .table-scroll tfoot {
        background:#f9f9f9;
    }
    .clone {
        position:absolute;
        top:0;
        left:0;
        pointer-events:none;
    }
    .clone th, .clone td {
        visibility:hidden
    }
    .clone td, .clone th {
        border-color:transparent
    }
    .clone tbody th {
        visibility:visible;
        color:red;
    }
    .clone .fixed-side {
        border:1px solid #000;
        background:#eee;
        visibility:visible;
    }
    .clone thead, .clone tfoot{background:transparent;}
</style>
</head>
<body class="page-header-fixed page-quick-sidebar-over-content">
    <div class="page-container">
        <?php
        include PUBLIC_PATH . "html/top.php";
        include PUBLIC_PATH . "html/top_im.php";
        ?>
        <div class="page-content-wrapper">
            <div class="page-content">
                <h3 class="page-title row-br-b-wp"> <?php echo $report_title; ?></h3>

                <div class="row">
                    <div class="col-md-12">
                        <form name="searchfrm" id="searchfrm" action="<?php $actionpage ?>" method="post">
                            <div class="widget" data-toggle="collapse-widget">
                                <div class="widget-head">
                                    <h3 class="heading">Filter by</h3>
                                </div>
                                <div class="widget-body">
                                    <div class="row">                                    
                                        <div class="col-md-3">
                                            <label class="control-label">Stakeholder</label>
                                            <div class="form-group">
                                                <select name="stk_sel" id="stk_sel" class="input-medium select2me">
                                                    <?php
                                                    $querystk = "SELECT DISTINCT
                                                                        stakeholder.stkid,
                                                                        stakeholder.stkname
                                                                FROM
                                                                        tbl_warehouse
                                                                INNER JOIN wh_user ON tbl_warehouse.wh_id = wh_user.wh_id
                                                                INNER JOIN stakeholder ON tbl_warehouse.stkid = stakeholder.stkid
                                                                WHERE
                                                                        stakeholder.stk_type_id IN (0, 1)
                                                                ORDER BY
                                                                        stakeholder.stkorder ASC";
                                                    //query result
                                                    $rsstk = mysql_query($querystk) or die();
                                                    //fetch result
                                                    while ($rowstk = mysql_fetch_array($rsstk)) {
                                                        ?>
                                                        <option value="<?php echo $rowstk['stkid']; ?>" <?php echo ($sel_stk == $rowstk['stkid']) ? 'selected=selected' : '' ?>><?php echo $rowstk['stkname']; ?></option>
                                                        <?php
                                                    }
                                                    ?>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="control-label">Province</label>
                                            <div class="form-group">
                                                <select name="province" id="province" class="input-medium select2me" data-placeholder="Select..." required="required">
                                                    <option value="">Select</option>
                                                    <?php
                                                    $qry = "SELECT
                                                                tbl_locations.PkLocID,
                                                                tbl_locations.LocName
                                                        FROM
                                                                tbl_locations
                                                        WHERE
                                                                tbl_locations.LocLvl = 2
                                                        AND tbl_locations.ParentID IS NOT NULL";
                                                    //query result
                                                    $qryRes = mysql_query($qry);
                                                    //fetch result
                                                    while ($row = mysql_fetch_array($qryRes)) {
                                                        ?>
                                                        <option value="<?php echo $row['PkLocID']; ?>" <?php echo ($sel_prov == $row['PkLocID']) ? 'selected=selected' : '' ?>><?php echo $row['LocName']; ?></option>
                                                        <?php
                                                    }
                                                    ?>
                                                </select>
                                            </div>

                                        </div>
                                        <div class="col-md-3" id="districts">
                                            <label class="control-label">District</label>
                                            <div class="form-group">
                                                <select name="district" id="district" class="input-medium  select2me" data-placeholder="Select..." >
                                                    <option value="">Select</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-3" id="stores">
                                            <label class="control-label">Facility</label>
                                            <div class="form-group">
                                                <select name="warehouse" id="warehouse" class="input-medium select2me">
                                                    <option value="">Select</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-3">
                                            <div class="form-group">
                                                <label class="control-label">Reporting Date</label>
                                                <div class="form-group">
                                                    <input type="text" name="date_from" id="date_from" readonly="readonly" class="form-control input-medium" value="<?php echo $date_from; ?>" required>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-3">
                                            <label class="control-label">&nbsp;</label>
                                            <input type="submit" name="go" id="go" value="GO" class="btn btn-primary input-sm" style="display:block" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <?php
                if (isset($_POST['go'])) {
                    ?>
                    <div id="table-scroll" class="table-scroll">
                        <div class="table-wrap">
                            <?php
                            $qry = "
                            SELECT
	tbl_hf_data_daily.*
FROM
	tbl_hf_data_daily
WHERE
	tbl_hf_data_daily.warehouse_id = $sel_wh
 AND
	tbl_hf_data_daily.reporting_date = '$date_from1'
 ";
                            //echo $qry;
                            $qryRes = mysql_query($qry);
                            if (mysql_num_rows($qryRes) > 0) {
//                                    echo 'into if';
//                                    echo mysql_num_rows($qryRes);
                                ?>

                                <table id="myTable" cellspacing="0" align="center" class="table table-bordered table-condensed main-table">
                                    <thead>
                                        <tr class="bg-success">
                                            <th>#</th>
                                            <th>Facility</th>
                                            <th>Date</th>
                                            <th>Opening Balance</th>
                                            <th>Received</th>
                                            <th>Issued</th>
                                            <th>Adj +ve</th>
                                            <th>Adj -ve</th>
                                            <th>Closing Balance</th> 
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <?php
                                        $c = 1;

                                        while ($row = mysql_fetch_assoc($qryRes)) {
//                                        echo '<pre>';
//                                        print_r($row);
//                                        echo '</pre>';
//                                        exit;
                                            echo '
                                            <tr>
                                                <td>' . $c++ . '</td>
                                                <td>' . $row['warehouse_id'] . '</td>
                                                <td>' . $row['reporting_date'] . '</td>
                                                <td>' . $row['opening_balance'] . '</td>
                                                <td>' . $row['received_balance'] . '</td>
                                                <td>' . $row['issue_balance'] . '</td>
                                                <td>' . $row['adjustment_positive'] . '</td>
                                                <td>' . $row['adjustment_negative'] . '</td>
                                                <td>' . $row['closing_balance'] . '</td>
                                            </tr>
                                            
                                            ';
                                        }
                                        ?>
                                    </tbody>
                                </table>
                                <?php
                            } else {
                                echo "No data reported for the date : ".$date_from1;
                            }
                            ?>
                        </div>
                    </div>
                    <?php
                }
                ?>
            </div>
        </div>
    </div>
    <?php include PUBLIC_PATH . "/html/footer.php"; ?>
    <?php
    ?>
    <script>
        $(function () {
            showDistricts('<?php echo $sel_prov; ?>', '<?php echo $sel_stk; ?>');
            showStores('<?php echo $sel_dist; ?>');

            $('#province, #stk_sel').change(function (e) {
                $('#district').html('<option value="">All</option>');
                $('#warehouse').html('<option value="">Select</option>');
                showDistricts($('#province').val(), $('#stk_sel').val());
            });
            $('#stk_sel').change(function (e) {
                $('#warehouse').html('<option value="">All</option>');
            });

            $(document).on('change', '#province, #stk_sel, #district', function () {
                showStores($('#district option:selected').val());
            })

            var startDateTextBox = $('#date_from');
            var endDateTextBox = $('#date_to');

            startDateTextBox.datepicker({
               
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true,
                onClose: function (dateText, inst) {
                    if (endDateTextBox.val() != '') {
                        var testStartDate = startDateTextBox.datepicker('getDate');
                        var testEndDate = endDateTextBox.datepicker('getDate');
                        if (testStartDate > testEndDate)
                            endDateTextBox.datepicker('setDate', testStartDate);
                    } else {
                        endDateTextBox.val(dateText);
                    }
                },
                onSelect: function (selectedDateTime) {
                    endDateTextBox.datepicker('option', 'minDate', startDateTextBox.datepicker('getDate'));
                }
            });
            endDateTextBox.datepicker({
                minDate: "+5M",
                maxDate: "+1Y",
                dateFormat: 'dd/mm/yy',
                changeMonth: true,
                changeYear: true,
                onClose: function (dateText, inst) {
                    if (startDateTextBox.val() != '') {
                        var testStartDate = startDateTextBox.datepicker('getDate');
                        var testEndDate = endDateTextBox.datepicker('getDate');
                        if (testStartDate > testEndDate)
                            startDateTextBox.datepicker('setDate', testEndDate);
                    } else {
                        startDateTextBox.val(dateText);
                    }
                },
                onSelect: function (selectedDateTime) {
                    startDateTextBox.datepicker('option', 'maxDate', endDateTextBox.datepicker('getDate'));
                }
            });

        });

        function showDistricts(prov, stk) {
            if (stk != '' && prov != '')
            {
                $.ajax({
                    type: 'POST',
                    url: 'my_report_ajax.php',
                    data: {provId: prov, stkId: stk, distId: '<?php echo $sel_dist; ?>', showAll: 1},
                    success: function (data) {
                        $("#districts").html(data);
                        $('#district').select2();
                        $('#district').removeClass('form-control').addClass('select2me');
                        $('#district').removeClass('input-sm').addClass('input-medium');
                    }
                });
            }
        }
        function showStores(dist) {
            var stk = $('#stk_sel').val();
            if (stk != '' && dist != '')
            {
                $.ajax({
                    type: 'POST',
                    url: 'tower_report_ajax.php',
                    data: {distId: dist, stkId: stk, whId: '<?php echo $sel_wh; ?>'},
                    success: function (data) {
                        $("#stores").html(data);
                        $('#warehouse').select2();
                        $('#warehouse').removeClass('form-control').addClass('select2me');
                        $('#warehouse').removeClass('input-sm').addClass('input-medium');
                    }
                });
            }
        }
    </script>
    <script type="text/javascript" src="../../public/assets/global/plugins/select2/select2.min.js"></script>
</body>
<!-- END BODY -->
</html>