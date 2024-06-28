<?php
//Including files
include("../includes/classes/AllClasses.php");
include(PUBLIC_PATH . "html/header.php");

//Items
$products_arr = array();
$products_arr[1] = 'Condom';
$products_arr[2] = 'POP';
$products_arr[9] = 'COC';
//$products_arr[3] = 'ECP';
$products_arr[5] = 'Copper-T-380A';
$products_arr[4] = 'Multiload';
//$products_arr[6] = '2-Month Inj';
$products_arr[7] = '3-Month Inj';
$products_arr[8] = '3-Month Inj.- Sayana Press';
$products_arr[13] = 'Implanon';
$products_arr[34] = 'Jadelle';
$products_arr[32] = 'Tubal Ligation';
$products_arr[31] = 'Vasectomy';

$selProv = '';
if (isset($_POST['prov_sel'])){
    $selProv = $_POST['prov_sel'];/*print_r($selProv);exit();*/
}

$dist = '';
if (isset($_POST['district'])){
    $dist = $_POST['district'];
}
?>
</head>
<!-- END HEAD -->

<body class="page-header-fixed page-quick-sidebar-over-content" >
    <!-- BEGIN HEADER -->
    <div class="page-container">
        <?php
        //Including files
        include PUBLIC_PATH . "html/top.php";
        include PUBLIC_PATH . "html/top_im.php";
        ?>
        <div class="page-content-wrapper">
            <div class="page-content">
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="heading">Family Planning Data Of PWD & DOH under ADP Scheme Strategic Planning Unit</h3>
                        <div class="widget">
                            <div class="widget-head">
                            </div>
                            <div class="widget-body">

                                <div class="row">
                                    <form action="family_planning.php" method="post" enctype="multipart/form-data">

                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="control-label">Province</label>
                                                <div class="form-group">
                                                    <select name="prov_sel" id="prov_sel" required class="form-control" onchange="change_province()">
                                                        <option value="">Select</option>
                                                        <?php

                                                        $queryprov = "SELECT
                                        tbl_locations.PkLocID AS prov_id,
                                        tbl_locations.LocName AS prov_title
                                    FROM
                                        tbl_locations
                                    WHERE
                                        LocLvl = 2
                                    AND parentid IS NOT NULL";
                                                        //query result
                                                        $rsprov = mysql_query($queryprov) or die();
                                                        $prov_name = '';
                                                        while ($rowprov = mysql_fetch_array($rsprov)) {
                                                            if (!empty($selProv) && ($selProv == $rowprov['prov_id'])) {
                                                                $sel = "selected='selected'";
//                                                        $prov_name = $rowprov['prov_title'];
                                                            } else {
                                                                $sel = "";
                                                            }

                                                            if ($_SESSION['user_province1'] != $rowprov['prov_id']){
                                                                continue;
                                                            }
                                                            ?>
                                                            <option value="<?php echo $rowprov['prov_id']; ?>" <?php echo $sel; ?>><?php echo $rowprov['prov_title']; ?></option>
                                                            <?php
                                                        }

                                                        ?>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-md-2">
                                            <div class="form-group" id="districtDiv">
                                                <label class="control-label">District</label>
                                                <div class="form-group">
                                                    <select required name="district" id="district" class="form-control">
                                                        <option value="">All</option>

                                                    </select>
                                                </div>
                                            </div>
                                        </div>

<!--                                        <div class="col-md-2">-->
<!--                                            <div class="form-group" id="districtDiv">-->
<!--                                                <label class="control-label">Month</label>-->
<!--                                                <div class="form-group">-->
<!--                                                    <input required type="month" class="form-control" name="month">-->
<!--                                                </div>-->
<!--                                            </div>-->
<!--                                        </div>-->

                                        <div class="col-md-2">
                                            <div class="form-group">
                                                <label class="control-label">&nbsp;</label>
                                                <div class="form-group">
                                                    <input type="submit" class="form-control btn btn-primary" name="submit" value="Submit">
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                            </div>

                        <div class="col-md-12" id="message">
                            <div class="note note-info">To proceed , please click Submit button after selecting filters.</div>
                        </div>
                        <?php
                        echo '<div id="mon">';
                        if (isset($_POST['submit'])){
                            $existing_data_qry = "
                                            SELECT
                                            	fp_adp_consumption.report_month, 
                                            	fp_adp_consumption.dist_id, 
                                            	fp_adp_consumption.stk_id
                                            FROM
                                            	fp_adp_consumption
                                            WHERE
                                            	fp_adp_consumption.dist_id = $dist
                                            GROUP BY
                                            	fp_adp_consumption.stk_id, 
                                            	fp_adp_consumption.report_month";
                            $rs = mysql_query($existing_data_qry);
                            $existing_data = array();
                            while ($row = mysql_fetch_array($rs)) {
                                $existing_data[$row['stk_id']][$row['report_month']] = 1;
                            }

                            echo '<table class="table table-bordered">';
                            echo '<thead>';

                            echo '<tr>';
                            echo '<th>Months</th>';
                            echo '<th>PWD</th>';
                            echo '<th>DOH (Static HF)</th>';
                            echo '</tr>';

                            for ($i = 0; $i < date_difference(); $i++) {
                                echo '<tr>';
                                $pwd_url = "family_planning_data_entry.php?stk=1&m=". date('Y-m-01', strtotime("-$i month")). "&d=" . $dist . "&p=". $selProv;
                                $doh_url = "family_planning_data_entry.php?stk=7&m=". date('Y-m-01', strtotime("-$i month")). "&d=" . $dist . "&p=". $selProv;

                                $pwd_class = ((isset($existing_data[1][date('Y-m-01', strtotime("-$i month"))]))?'btn btn-danger':'btn btn-success');
                                $doh_class = ((isset($existing_data[7][date('Y-m-01', strtotime("-$i month"))]))?'btn btn-danger':'btn btn-success');

                                $pwd_btntext = ((isset($existing_data[1][date('Y-m-01', strtotime("-$i month"))]))?'Edit':'Add');
                                $doh_btntext = ((isset($existing_data[7][date('Y-m-01', strtotime("-$i month"))]))?'Edit':'Add');

                                echo '<td>' . date('M-Y', strtotime("-$i month")) . '</td>';
                                echo '<td><a class="'. $pwd_class .'" onclick="openPopUp(\''. $pwd_url .'\')">'. $pwd_btntext .'(' . date('M-Y', strtotime("-$i month")) . ')</a></td>';
                                echo '<td><a class="'. $doh_class .'" onclick="openPopUp(\''. $doh_url .'\')">'. $doh_btntext .'(' . date('M-Y', strtotime("-$i month")) . ')</a></td>';


                                echo '</tr>';
                            }

                            echo '</thead>';
                            echo '</table>';
                        }
                        echo '</div>';
                        ?>

                            <!-- // Content END -->
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <?php
    //Including file
    include PUBLIC_PATH . "/html/footer.php";

    $districtId = isset($districtId) ? $districtId : '';

    function date_difference(){
        $current_date = date('Y-m-d');
        $start_date = date('Y-m-d', strtotime('2023-12'));

        $ts1 = strtotime($current_date);
        $ts2 = strtotime($start_date);

        $year1 = date('Y', $ts1);
        $year2 = date('Y', $ts2);

        $month1 = date('m', $ts1);
        $month2 = date('m', $ts2);

        return (($year1 - $year2) * 12) + ($month1 - $month2);
    }
    ?>
    <!-- END JAVASCRIPTS -->
</body>
<!-- END BODY -->

<script>
    change_province();

    function change_province(){
        var provinceId = $('#prov_sel').val();
        if (provinceId != '')
        {
            // var stkk = $('#stakeholder').val();
            // if(stkk=='undefined' || stkk == ''){
            var stkk = 1;
            // }

            $.ajax({
                url: '../reports/ajax_calls.php',
                data: {
                    provinceId: provinceId,
                    dId: '<?php echo $districtId; ?>',
                    stkId: stkk
                },
                type: 'POST',
                success: function(data)
                {
                    $('#districtDiv').html(data);
                    $('#district option[value="<?=$dist?>"]').prop('selected', true)
                }
            })
        }
    }


    function openPopUp(pageURL)
    {
        var w = screen.width - 100;
        var h = screen.height - 100;
        var left = (screen.width / 2) - (w / 2);
        var top = 0;

        return window.open(pageURL, 'Data Entry', 'toolbar=no, location=no, directories=no, status=no, menubar=no, scrollbars=yes, resizable=no, copyhistory=no, width=' + w + ', height=' + h + ', top=' + top + ', left=' + left);
    }

    $(document).on('change', '#district', function() {
        $('#mon').hide();
        $('#message').show();
    });

</script>
</html>