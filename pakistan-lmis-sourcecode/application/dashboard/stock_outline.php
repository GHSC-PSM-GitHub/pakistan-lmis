<?php
include("../includes/classes/AllClasses.php");
include(PUBLIC_PATH . "html/header.php");
//include "../includes/styling/dynamic_theme_color.php";

//Initializing Variables
$total_districts = $total_facilities = $total_items = 0;

$qry = "SELECT
	COUNT(tbl_locations.PkLocID) as total_districts
FROM
	tbl_locations
WHERE
	tbl_locations.ParentID = ".$_SESSION['user_province1']."
GROUP BY
tbl_locations.ParentID ";
//echo $qry;exit();
$tot_dist_qry_res = mysql_query($qry);
while ($row = mysql_fetch_assoc($tot_dist_qry_res)) {
    $total_districts = $row['total_districts'];
}

$qry = "SELECT
	COUNT( tbl_warehouse.wh_id) as total_facilities
FROM
	tbl_warehouse 
WHERE
	tbl_warehouse.prov_id = ".$_SESSION['user_province1']." 
	AND tbl_warehouse.stkid = ".$_SESSION['user_stakeholder1']."
GROUP BY
	tbl_warehouse.prov_id,
	tbl_warehouse.stkid";
//echo $qry;exit();
$tot_fac_qry_res = mysql_query($qry);
while ($row = mysql_fetch_assoc($tot_fac_qry_res)) {
    $total_facilities = $row['total_facilities'];
}

$qry = "SELECT
	COUNT(stakeholder_item.stk_id) as total_items
FROM
	stakeholder_item
WHERE
	stakeholder_item.stkid = ".$_SESSION['user_stakeholder1']."
GROUP BY
stakeholder_item.stkid ";
//echo $qry;exit();
$tot_itm_qry_res = mysql_query($qry);
while ($row = mysql_fetch_assoc($tot_itm_qry_res)) {
    $total_items = $row['total_items'];
}


//echo '<pre>';
//print_r($total_districts);
//print_r($total_facilities);
//print_r($total_items);
//echo '</pre>';
//exit;
?>

<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/highcharts-more.js"></script>
<script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>

<body class="page-header-fixed page-quick-sidebar-over-content">
<div class="page-container">
    <?php
    include PUBLIC_PATH . "html/top.php";
    include PUBLIC_PATH . "html/top_im.php";
    ?>
    <div class="page-content-wrapper">
        <div class="page-content">
            <!-- BEGIN PAGE HEADER-->
            <div class="row">
                <div class="col-md-12">
                    <h3 class="font-blue-chambray"> Provincial Stock Outline Dashboard </h3>
                    <br>
                    <div class="col-md-12">

                        <div class="col-md-3">
                            <div class="dashboard-stat red-pink" style="height:130px;background-image: linear-gradient(to bottom right, #cc2b5e, #753a88);box-shadow: 0 0 3px 0 #999;">
                                <div class="desc" style="font-size:24px;float:left;padding-left:12%;"><b> Total Districts </b></div>
                                <div class="">
                                    <div class="center" id="general_av_dist" style="font-size:22px;padding-top: 22%;color:white;"> <?= $total_districts ?> </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="dashboard-stat red-pink" style="height:130px;background-image: linear-gradient(to bottom right, #bdc3c7 , #2c3e50);box-shadow: 0 0 3px 0 #999;">
                                <div class="desc" style="font-size:24px;float:left;padding-left:12%;"><b> Total Facilities </b></div>
                                <div class="">
                                    <div class="center" id="general_av_dist" style="font-size:22px;padding-top: 22%;color:white;"> <?= $total_facilities ?> </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="dashboard-stat red-pink" style="height:130px;background-image: linear-gradient(to bottom right, #4ca1af , #c4e0e5);box-shadow: 0 0 3px 0 #999;">
                                <div class="desc" style="font-size:24px;float:left;padding-left:12%;"><b> Total Items </b></div>
                                <div class="">
                                    <div class="center" id="general_av_dist" style="font-size:22px;padding-top: 22%;color:white;"> <?= $total_items ?> </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="dashboard-stat red-pink" style="height:130px;background-image: linear-gradient(to bottom right, #ffafbd, #ffc3a0);box-shadow: 0 0 3px 0 #999;">
                                <div class="desc" style="font-size:24px;float:left;padding-left:12%;"><b> Coming Soon </b></div>
                                <div class="">
                                    <div class="center" id="general_av_dist" style="font-size:22px;padding-top: 22%;color:white;"> 000 </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <h3 class="font-blue-chambray"> Item Wise SOH </h3>
                    <br>
                    <div class="col-md-12">
                        <figure>
                            <div id="item_wise_soh"></div>
                        </figure>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12">
                    <h3 class="font-blue-chambray"> District Wise Reporting Rate </h3>
                    <br>
                    <div class="col-md-12">
                        <figure>
                            <div id="dist_wise_rr"></div>
                        </figure>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- // Content END -->

</div>
<?php
include PUBLIC_PATH . "/html/footer.php";
?>

<script>

    function renderIcons() { }

    $.ajax({
        url: 'stock_outline_helper.php',
        type: 'POST',
        dataType: 'json',
        data: {
            type: 1
        },
        success: function(data) {
            // console.log(data);
            const items = new Array();
            for(let i in data['all_items']){
                items.push(data['all_items'][i]);
            }
            const soh = new Array();
            for(let i in data['itm_wise_soh_data']){
                soh.push(data['itm_wise_soh_data'][i]);
            }
            // console.log(items);
            Highcharts.chart('item_wise_soh', {
                chart: {
                    type: 'column'
                },
                tooltip: {
                    style: {
                        fontSize: '1.5em'
                    },
                    pointFormat: '{series.name}<br><span style="font-size:1.5em; color: {point.color}; font-weight: bold">{point.y}</span>',
                },
                xAxis: {
                    labels: {
                        style:{
                            fontSize: '1.5em'
                        }
                    },
                    categories: items,
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'SOH'
                    }
                },
                colors: [
                    '#4572A7',
                    '#AA4643',
                    '#89A54E',
                    '#80699B',
                    '#3D96AE',
                    '#DB843D',
                    '#92A8CD',
                    '#A47D7C',
                    '#B5CA92'
                ],
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        colorByPoint: true
                    }
                },
                series: [
                    {
                        name: 'SOH',
                        data: soh,
                    }
                ]
            });
        }
    });

    $.ajax({
        url: 'stock_outline_helper.php',
        type: 'POST',
        dataType: 'json',
        data: {
            type: 2
        },
        success: function(data) {
            // console.log(data);
            const items = new Array();
            for(let i in data['all_dist']){
                items.push(data['all_dist'][i]);
            }
            const soh = new Array();
            for(let i in data['dist_wise_rr_data']){
                soh.push(data['dist_wise_rr_data'][i]);
            }
            // console.log(items);
            Highcharts.chart('dist_wise_rr', {
                chart: {
                    type: 'line'
                },
                tooltip: {
                    style: {
                        fontSize: '1.5em'
                    },
                    pointFormat: '{series.name}<br><span style="font-size:1.5em; color: {point.color}; font-weight: bold">{point.y}</span>',
                },
                xAxis: {
                    labels: {
                        style:{
                            fontSize: '1.5em'
                        }
                    },
                    categories: items,
                },
                yAxis: {
                    min: 0,
                    title: {
                        text: 'SOH'
                    }
                },
                colors: [
                    '#4572A7',
                    '#AA4643',
                    '#89A54E',
                    '#80699B',
                    '#3D96AE',
                    '#DB843D',
                    '#92A8CD',
                    '#A47D7C',
                    '#B5CA92'
                ],
                plotOptions: {
                    column: {
                        pointPadding: 0.2,
                        borderWidth: 0,
                        colorByPoint: true
                    }
                },
                series: [
                    {
                        name: 'SOH',
                        data: soh,
                    }
                ]
            });
        }
    });

</script>

</body>
</html>