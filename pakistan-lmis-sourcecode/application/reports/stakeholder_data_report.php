<?php
/**

 * 
 */
//Including AllClasses
include("../includes/classes/AllClasses.php");
//Including FunctionLib
include(APP_PATH . "includes/report/FunctionLib.php");
//Including header
include(PUBLIC_PATH . "html/header.php");
//Initialing variable report_id
//Checking date
if (date('d') > 10) {
    $date = date('Y-m', strtotime("-1 month", strtotime(date('Y-m-d'))));
} else {
    $date = date('Y-m', strtotime("-2 month", strtotime(date('Y-m-d'))));
}
$selMonth = date('m', strtotime($date));
$selYear = date('Y', strtotime($date));
//Initialing variables
$date_from = $date_to = $product = $provinceID = $district = $stakeholder = $warehouse = $xmlstore = $selProv = '';
//Checking search
?>
<!-- Content -->
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
                    <h3 class="page-title row-br-b-wp">Interfacing Data Report</h3>
                    <div class="widget" data-toggle="collapse-widget">
                        <div class="widget-head">
                            <h3 class="heading">Filter by</h3>
                        </div>
                        <div class="widget-body">
                            <div class="row">
                                <form method="POST" name="ledger" id="ledger" action="">
                                    <!-- Row -->
                                    <div class="row">
                                        <div class="col-md-12">
                                           <div class="col-md-2">
                                                <div class="form-group">
                                                    <label class="control-label">Date From</label>
                                                    <input type="text" readonly class="form-control input-sm" name="date_from" id="date_from" value="<?php echo $date_from; ?>"/>
                                                </div>
                                            </div>
                                            <div class="col-md-2">
                                                <div class="form-group">
                                                    <label class="control-label">Date To</label>
                                                    <input type="text" readonly class="form-control input-sm" name="date_to" id="date_to" value="<?php echo $date_to; ?>"/>
                                                </div>
                                            </div>

                                           
    <div class="col-md-2">
                                                <div class="form-group">
                                                    <label class="control-label">Stakeholder</label>
                                                    <div class="form-group">
                                                        <select name="stakeholder" id="stakeholder" required class="form-control input-sm">
                                                            <option value="">Select</option>
                                                            <?php
                                                            $querys = "SELECT
                                                        stakeholder.stkid,
                                                        stakeholder.stkname
                                                        FROM
                                                        stakeholder
                                                        WHERE
                                                        stakeholder.ParentID IS NULL
                                                        AND stakeholder.stkid IN (842, 362, 9) AND
                                                        stakeholder.is_reporting = 1 AND stakeholder.lvl = 1
                                                        $stk_where
                                                        ORDER BY
                                                        stakeholder.stkorder ASC";
                                                            //query result
                                                           $resMainStk = mysql_query($querys) or die('Error MainStakeholder');
                //fetch result
			
                while ($arryStk = mysql_fetch_assoc($resMainStk)) {
                    $sel = '';
//                    if ($_SESSION['lastTransStk'] == $arryStk['stkid']) {
//                        $sel = 'selected="selected"';
//                    }
                    if($_SESSION['user_stakeholder']==$arryStk['stkid'])
                    {
                     $sel = 'selected="selected"';   
                    }
                    //populate mainstkid combo
                    ?>
                    <option value="<?php echo $arryStk['stkname']; ?>" <?php echo $sel; ?>><?php echo $arryStk['stkname']; ?></option>
                <?php } ?>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
											<div class="col-md-2">
      <div class="form-group">
                    <label class="control-label">Province</label>
                                       <div class="form-group">
                                            <select name="prov_sel" id="prov_sel"  class="form-control input-sm">
                                               
                                                            <?php 
                                                                $queryprov = "SELECT
                                                                            tbl_locations.PkLocID AS prov_id,
                                                                            tbl_locations.LocName AS prov_title
                                                                        FROM
                                                                            tbl_locations
                                                                        WHERE
                                                                            LocLvl = 2 AND 
																			tbl_locations.PkLocID = 2
                                                                        AND parentid IS NOT NULL
                                                                        LIMIT 2
                                                                    ";
                                                                //query result
                                                                $rsprov = mysql_query($queryprov) or die();
                                                                $prov_name = '';
                                                                while ($rowprov = mysql_fetch_array($rsprov)) {
                                                                    if ($_SESSION['user_province1'] == $rowprov['prov_id']) {
                                                                        $sel = "selected='selected'";
                                                                        $prov_name = $rowprov['prov_title'];
                                                                    } else {
                                                                        $sel = "";
                                                                    }
                                                                    //Populate prov_sel combo
                                                                    ?>
                                                                    <option value="<?php echo $rowprov['prov_title']; ?>" <?php echo $sel; ?>><?php echo $rowprov['prov_title']; ?></option>
                                                                    <?php
                                                                } 
                                                            ?>                        
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <label for="firstname">&nbsp;</label>
                                                <div class="form-group">
                                                    <input type="submit" class="btn btn-success" name="submit" id="submit" value="Submit" />
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div id="product_ledger">

            </div>
        </div>
    </div>
</div>
<?php
//include footer
include PUBLIC_PATH . "/html/footer.php";
//reports_includes
include PUBLIC_PATH . "/html/reports_includes.php";
?>
<script>
    $(function () {
        var startDateTextBox = $('#date_from');
        var endDateTextBox = $('#date_to');

        startDateTextBox.datepicker({
            minDate: "-10Y",
            maxDate: 0,
            dateFormat: 'yy-mm',
            changeMonth: true,
            changeYear: true,
        });
        endDateTextBox.datepicker({
			 minDate: "-10Y",
            maxDate: 0,
            dateFormat: 'yy-mm',
            changeMonth: true,
            changeYear: true,
        });
    })
    $('#submit').click(function (e) {

        e.preventDefault();
        var formdata = $("#ledger").serialize();
        Metronic.startPageLoading('Please wait...');
        $.ajax({
            type: "POST",
            url: "stakeholder_xml.php",
            data: {data: formdata},
            dataType: 'html',
            success: function (data) {
                $('#product_ledger').html(data);
                Metronic.stopPageLoading();
                $.inlineEdit({
                    expiry: '/stock/product-ledger-date-edit/type/expiry/id/'
                }, {
                    animate: false,
                    filterElementValue: function ($o) {
                        return $o.html().trim();
                    },
                    afterSave: function () {
                    }
                });

                // initTable2();

            }
        });


    });
</script>
</body>
<!-- END BODY -->
</html>