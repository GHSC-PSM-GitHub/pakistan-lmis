<?php
include("../includes/classes/AllClasses.php");
include(PUBLIC_PATH . "html/header.php");
include "../includes/styling/dynamic_theme_color.php";
?>
<script src="<?php echo PUBLIC_URL; ?>assets/chart.min.js"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/utils.js"></script>
<style>
    canvas {
        -moz-user-select: none;
        -webkit-user-select: none;
        -ms-user-select: none;
    }
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
                <!-- BEGIN PAGE HEADER-->
                <div class="row">
                    <div class="col-md-12">
                        <h3 class="font-blue-chambray">ELECTRONIC CLIENT RECORDS
                            <a class="btn btn-info pull-right"  download href="../../public/docs/fp_client_register.xlsx"><i class="fa fa-download"></i> Download FP Client Register</a>
                        </h3>
                        <div class="widget" data-toggle="collapse-widget">
                            <div class="widget-head">
                                <h3 class="heading">Welcome</h3>
                            </div>
                            <div class="widget-body">
                                <form method="POST" name="add_client" id="add_client" action="add_client_action.php"  >
                                    <div class="row">
                                        <div class="col-md-12">


                                            <div class="col-md-6" style="margin-left:0px;margin-right: 0px;" id="graph_row_1">
                                                <div class="portlet box purple" data-toggle="collapse-widget">
                                                    <div class="portlet-title">
                                                        <div class="caption"><i class="fa fa-cogs"></i>Title
                                                        </div>
                                                        <div class="tools"><a href="javascript:;" class="collapse" data-original-title="" title=""></a>
                                                        </div>
                                                    </div>
                                                    <div class="portlet-body">
                                                        <div id="canvas-holder" style="width:90%">
                                                            <canvas id="ch1"></canvas>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6" style="margin-left:0px;margin-right: 0px;" id="graph_row_1">
                                                <div class="portlet box purple" data-toggle="collapse-widget">
                                                    <div class="portlet-title">
                                                        <div class="caption"><i class="fa fa-cogs"></i>Title
                                                        </div>
                                                        <div class="tools"><a href="javascript:;" class="collapse" data-original-title="" title=""></a>
                                                        </div>
                                                    </div>
                                                    <div class="portlet-body">
                                                <div id="canvas-holder" style="width:90%">
                                                    <canvas id="ch2"></canvas>
                                                </div>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-md-6" style="margin-left:0px;margin-right: 0px;" id="graph_row_1">
                                                <div class="portlet box purple" data-toggle="collapse-widget">
                                                    <div class="portlet-title">
                                                        <div class="caption"><i class="fa fa-cogs"></i>Title
                                                        </div>
                                                        <div class="tools"><a href="javascript:;" class="collapse" data-original-title="" title=""></a>
                                                        </div>
                                                    </div>
                                                    <div class="portlet-body">
                                                <div id="canvas-holder" style="width:90%">
                                                    <canvas id="ch3"></canvas>
                                                </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6" style="margin-left:0px;margin-right: 0px;" id="graph_row_1">
                                                <div class="portlet box purple" data-toggle="collapse-widget">
                                                    <div class="portlet-title">
                                                        <div class="caption"><i class="fa fa-cogs"></i>Title
                                                        </div>
                                                        <div class="tools"><a href="javascript:;" class="collapse" data-original-title="" title=""></a>
                                                        </div>
                                                    </div>
                                                    <div class="portlet-body">
                                                <div id="canvas-holder" style="width:90%">
                                                    <canvas id="ch4"></canvas>
                                                </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6" style="margin-left:0px;margin-right: 0px;" id="graph_row_1">
                                                <div class="portlet box purple" data-toggle="collapse-widget">
                                                    <div class="portlet-title">
                                                        <div class="caption"><i class="fa fa-cogs"></i>Title
                                                        </div>
                                                        <div class="tools"><a href="javascript:;" class="collapse" data-original-title="" title=""></a>
                                                        </div>
                                                    </div>
                                                    <div class="portlet-body">
                                                <div id="canvas-holder" style="width:90%">
                                                    <canvas id="ch5"></canvas>
                                                </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6" style="margin-left:0px;margin-right: 0px;" id="graph_row_1">
                                                <div class="portlet box purple" data-toggle="collapse-widget">
                                                    <div class="portlet-title">
                                                        <div class="caption"><i class="fa fa-cogs"></i>Title
                                                        </div>
                                                        <div class="tools"><a href="javascript:;" class="collapse" data-original-title="" title=""></a>
                                                        </div>
                                                    </div>
                                                    <div class="portlet-body">
                                                <div id="canvas-holder" style="width:90%">
                                                    <canvas id="ch6"></canvas>
                                                </div>
                                                    </div>
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
        </div>
        <!-- // Content END --> 

    </div>
    <?php
    include PUBLIC_PATH . "/html/footer.php";
    ?>

    <script>
        $(document).ready(function() {
    
    
        });
    </script>

    <script>
        
        var chartColors = window.chartColors;
        var color = Chart.helpers.color;
        
        
        //start of new chart
        var ctx = document.getElementById('ch1').getContext('2d');
        var data = {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [{
                    label: 'Trendline ',
                    //                    backgroundColor: 'rgb(255, 99, 132)',
                    borderColor: 'rgb(255, 99, 132)',
                    data: [0, 10, 5, 2, 20, 30, 45]
                }]
        };
        var options = {};
        var chart = new Chart(ctx, {
            type: 'line',
            data: data,
            options: options
        });
        
        
        //start of new chart
        var ctx = document.getElementById('ch2').getContext('2d');
        var data = {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [{
                    label: 'Monthly Comparison',
                    backgroundColor: [
                        color(chartColors.red).alpha(0.5).rgbString(),
                        color(chartColors.orange).alpha(0.7).rgbString(),
                        color(chartColors.yellow).alpha(0.8).rgbString(),
                        color(chartColors.green).alpha(0.7).rgbString(),
                        color(chartColors.blue).alpha(0.8).rgbString(),
                        color(chartColors.red).alpha(0.9).rgbString(),
                    ],
                    borderColor: 'rgb(250, 105, 185)',
                    data: [0, 10, 5, 2, 20, 30, 45]
                }]
        };
        var options = {};
        var chart = new Chart(ctx, {
            type: 'bar',
            data: data,
            options: options
        });
        
        
        //start of new chart
        var ctx = document.getElementById('ch3').getContext('2d');
        var data = {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [{
                    label: 'Monthly Comparison',
                    backgroundColor: [
                        color(chartColors.red).alpha(0.5).rgbString(),
                        color(chartColors.orange).alpha(0.7).rgbString(),
                        color(chartColors.yellow).alpha(0.8).rgbString(),
                        color(chartColors.green).alpha(0.7).rgbString(),
                        color(chartColors.blue).alpha(0.8).rgbString(),
                        color(chartColors.red).alpha(0.9).rgbString(),
                    ],
                    //                    borderColor: 'rgb(250, 105, 185)',
                    data: [0, 10, 5, 2, 20, 30, 45]
                }]
        };
        var options = {};
        var chart = new Chart(ctx, {
            type: 'radar',
            data: data,
            options: options
        });
        
        
        //start of new chart
        var ctx = document.getElementById('ch4').getContext('2d');
        var data = {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [{
                    label: 'Monthly Comparison',
                    backgroundColor: [
                        color(chartColors.red).alpha(0.5).rgbString(),
                        color(chartColors.orange).alpha(0.7).rgbString(),
                        color(chartColors.yellow).alpha(0.8).rgbString(),
                        color(chartColors.green).alpha(0.7).rgbString(),
                        color(chartColors.blue).alpha(0.8).rgbString(),
                        color(chartColors.red).alpha(0.9).rgbString(),
                    ],
                    //                    borderColor: 'rgb(250, 105, 185)',
                    data: [0, 10, 5, 2, 20, 30, 45]
                }]
        };
        var options = {};
        var chart = new Chart(ctx, {
            type: 'pie',
            data: data,
            options: options
        });
        
        
        //start of new chart
        var ctx = document.getElementById('ch5').getContext('2d');
        var data = {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [{
                    label: 'Monthly Comparison',
                    backgroundColor: [
                        color(chartColors.red).alpha(0.5).rgbString(),
                        color(chartColors.orange).alpha(0.7).rgbString(),
                        color(chartColors.yellow).alpha(0.8).rgbString(),
                        color(chartColors.green).alpha(0.7).rgbString(),
                        color(chartColors.blue).alpha(0.8).rgbString(),
                        color(chartColors.red).alpha(0.9).rgbString(),
                    ],
                    //                    borderColor: 'rgb(250, 105, 185)',
                    data: [0, 10, 5, 2, 20, 30, 45]
                }]
        };
        var options = {};
        var chart = new Chart(ctx, {
            type: 'doughnut',
            data: data,
            options: options
        });
        
        
        
        //start of new chart
        var ctx = document.getElementById('ch6').getContext('2d');
        var data = {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [{
                    label: 'Monthly Comparison',
                    backgroundColor: [
                        color(chartColors.red).alpha(0.5).rgbString(),
                        color(chartColors.orange).alpha(0.7).rgbString(),
                        color(chartColors.yellow).alpha(0.8).rgbString(),
                        color(chartColors.green).alpha(0.7).rgbString(),
                        color(chartColors.blue).alpha(0.8).rgbString(),
                        color(chartColors.red).alpha(0.9).rgbString(),
                    ],
                    //                    borderColor: 'rgb(250, 105, 185)',
                    data: [0, 10, 5, 2, 20, 30, 45]
                }]
        };
        var options = {};
        var chart = new Chart(ctx, {
            type: 'polarArea',
            data: data,
            options: options
        });
        
        
       
		
    </script>
</body>
</html>