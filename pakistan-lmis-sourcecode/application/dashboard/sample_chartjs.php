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
                        <h3 class="font-blue-chambray">Sample code of chart.js graphs
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

                                            <div class="row" style="margin-left:0px;margin-right: 0px;" id="graph_row_1">
                                                <div id="canvas-holder" style="width:90%">
                                                    <canvas id="ch1"></canvas>
                                                </div>


                                            </div>
                                            <div class="row" style="margin-left:0px;margin-right: 0px;" id="graph_row_1">
                                                <div id="canvas-holder" style="width:90%">
                                                    <canvas id="ch2"></canvas>
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
        // common settings 
        var ctx = document.getElementById('ch1').getContext('2d');
        var data = {
            labels: ['January', 'February', 'March', 'April', 'May', 'June', 'July'],
            datasets: [{
                    label: 'My First dataset',
//                    backgroundColor: 'rgb(255, 99, 132)',
//                    borderColor: 'rgb(255, 99, 132)',
                    data: [0, 10, 5, 2, 20, 30, 45]
                }]
        };
        var options = {};
        // common settings END
        
        // sample line start
        var chart = new Chart(ctx, {
            type: 'line',
            data: data,
            options: options
        });
        // sample line end
        
        // sample bar start
//        var myBarChart = new Chart(ctx, {
//            type: 'bar',
//            data: data,
//            options: options
//        });
        // sample bar end

//var myRadarChart = new Chart(ctx, {
//    type: 'radar',
//    data: data,
//    options: options
//});

//var myPieChart = new Chart(ctx, {
//    type: 'pie',
//    data: data,
//    options: options
//}); 

//var myDoughnutChart = new Chart(ctx, {
//    type: 'doughnut',
//    data: data,
//    options: options
//});


//var myPolar = new Chart(ctx, {
//    data: data,
//    type: 'polarArea',
//    options: options
//});
		
    </script>
</body>
</html>