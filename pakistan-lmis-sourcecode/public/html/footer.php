<!-- BEGIN FOOTER -->
<div class="clearfix"></div>
<div class="footer">
    <div class="footer-inner" style="width:95%;">
        <p style="float:left; margin-bottom:0px !important;">For any comments and suggestions please write to <a href="mailto:support@lmis.gov.pk" style="color:#FFF;">support@lmis.gov.pk</a></p>
        <p style="float:right; margin-bottom:0px !important;"><a style="color:white;" href="http://lmis.gov.pk">http://lmis.gov.pk</a></p>
    </div>
    <div class="footer-tools">
        <span class="go-top">
            <a href="#"><i class="fa fa-angle-up"></i></a>
        </span>
    </div>
</div>
<!-- END FOOTER -->
<script type="text/javascript">
    var basePath = "<?php echo PUBLIC_URL; ?>";
    var appPath = "<?php echo APP_URL; ?>";
</script>

<!-- BEGIN JAVASCRIPTS(Load javascripts at bottom, this will reduce page load time) -->
<!-- BEGIN CORE PLUGINS -->
<!--[if lt IE 9]>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/respond.min.js"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/excanvas.min.js"></script>
<![endif]-->
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/jquery-1.11.0.min.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/jquery-migrate-1.2.1.min.js" type="text/javascript"></script>
<!-- IMPORTANT! Load jquery-ui-1.10.3.custom.min.js before bootstrap.min.js to fix bootstrap tooltip conflict with jquery ui tooltip -->
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/jquery-ui/jquery-ui-1.10.3.custom.min.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/jquery.cokie.min.js" type="text/javascript"></script>
<?php /* ?><script src="<?php echo PUBLIC_URL;?>assets/global/plugins/uniform/jquery.uniform.min.js" type="text/javascript"></script><?php */ ?>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
<!-- END CORE PLUGINS -->
<!-- BEGIN PAGE LEVEL PLUGINS -->

<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/jquery.pulsate.min.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/bootstrap-daterangepicker/moment.min.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/bootstrap-daterangepicker/daterangepicker.js" type="text/javascript"></script>
<!-- IMPORTANT! fullcalendar depends on jquery-ui-1.10.3.custom.min.js for drag & drop support -->
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/fullcalendar/fullcalendar/fullcalendar.min.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/jquery-easypiechart/jquery.easypiechart.min.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/jquery.sparkline.min.js" type="text/javascript"></script>
<!-- END PAGE LEVEL PLUGINS -->
<!-- BEGIN PAGE LEVEL SCRIPTS -->
<script src="<?php echo PUBLIC_URL; ?>js/jquery.notyfy.js"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/global/scripts/metronic.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/admin/layout/scripts/layout.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/admin/layout/scripts/quick-sidebar.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/admin/pages/scripts/index.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>assets/admin/pages/scripts/tasks.js" type="text/javascript"></script>

<script src="<?php echo PUBLIC_URL; ?>assets/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
<!-- END PAGE LEVEL SCRIPTS -->
<script>
    jQuery(document).ready(function () {
        Metronic.init(); // init metronic core componets
        Layout.init(); // init layout
        QuickSidebar.init() // init quick sidebar
        // Index.init();
        //Index.initDashboardDaterange();
        //Index.initJQVMAP(); // init index page's custom scripts
        //Index.initCalendar(); // init index page's custom scripts
        //Index.initCharts(); // init index page's custom scripts
        //Index.initChat();
        //Index.initMiniCharts();
        //Index.initIntro();
        Tasks.initDashboardWidget();
    });
</script>

<!-- END JAVASCRIPTS -->

<!-- JAVA Script files that were  in old code but are not present in current code -->
<!-- small hack that enables the use of touch events on sites using the jQuery UI user interface library -->
<script src="<?php echo PUBLIC_URL; ?>common/theme/scripts/plugins/system/jquery-ui-touch-punch/jquery.ui.touch-punch.min.js"></script>
<!-- Modernizr -->
<script src="<?php echo PUBLIC_URL; ?>common/theme/scripts/plugins/system/modernizr.js"></script>
<script src="<?php echo PUBLIC_URL; ?>common/theme/scripts/demo/common.js?1369414385"></script>
<!-- PrettyPhoto -->
<script src="<?php echo PUBLIC_URL; ?>common/theme/scripts/plugins/gallery/prettyphoto/js/jquery.prettyPhoto.js"></script>

<!-- DataTables Tables Plugin -->
<!--<script src="<?php //echo PUBLIC_URL; ?>assets/dataTables.min.js"></script>-->
<script src="<?php echo PUBLIC_URL; ?>common/theme/scripts/plugins/tables/DataTables/media/js/jquery.dataTables.js"></script>
<script src="<?php echo PUBLIC_URL; ?>common/theme/scripts/plugins/tables/DataTables/media/js/DT_bootstrap.js"></script>
<script src="<?php echo PUBLIC_URL; ?>common/theme/scripts/demo/date-uk.js" type="text/javascript"></script>
<script src="<?php echo PUBLIC_URL; ?>common/theme/scripts/demo/tables.js" type="text/javascript"></script>


<script src="<?php echo PUBLIC_URL; ?>js/jquery.price_format.js"></script>
<script src="<?php echo PUBLIC_URL; ?>common/theme/scripts/plugins/tables/DataTables/extras/TableTools/media/js/TableTools.js"></script>
<!-- Column Table Tools min -->
<script src="<?php echo PUBLIC_URL; ?>common/theme/scripts/plugins/tables/DataTables/extras/TableTools/media/js/TableTools.min.js"></script>
<!-- Column Table Tools zero Clipboard -->
<script src="<?php echo PUBLIC_URL; ?>common/theme/scripts/plugins/tables/DataTables/extras/TableTools/media/js/ZeroClipboard.js"></script>
<script type="text/javascript" src="<?php echo PUBLIC_URL; ?>js/admin/jquery.validate.js"></script>
<script type="text/javascript" src="<?php echo PUBLIC_URL; ?>js/admin/custom.js"></script>
<script type="text/javascript" src="<?php echo PUBLIC_URL; ?>js/custom_dev.js"></script>

<script type="text/javascript" src="<?php echo PUBLIC_URL ?>js/bootstrap-datetimepicker.js"></script>
<script src="<?php echo PUBLIC_URL; ?>js/jquery.notyfy.js"></script>

<script type='text/javascript' src='<?php echo PUBLIC_URL; ?>js/jquery.cookie.js'></script>
<script type='text/javascript' src='<?php echo PUBLIC_URL; ?>js/jquery.dcjqaccordion.2.7.js'></script>
<script type="text/javascript">
    $(document).ready(function ($) {
        $('#accordion').dcAccordion({
            eventType: 'click',
            autoClose: true,
            saveState: true,
            disableLink: true,
            speed: 'fase',
            showCount: false,
            autoExpand: true,
            cookie: 'dcjq-accordion',
            classExpand: 'dcjq-current-parent'
        });
    });

    $(function () {
        // show active users
        $("#active-user-button").mouseover(function () {
            $("#active-users").html("<center><img src='http://c.lmis.gov.pk/public/images/ajax-loader.gif'></center>");
            var url = "default/activeUsers.php";
            $.ajax({
                type: "POST",
                url: appPath + url,
                data: {},
                dataType: 'html',
                success: function (data) {
                    $("#active-users").html(data);
                }
            });
        });

        $("#global_role").change(function () {
            if (confirm("Do you want to change your role?")) {
                var newrole = $("#global_role").val();
                var url = appPath + "default/index.php?newrole="+newrole;
                window.location = url;
            }
        });
    });
</script>
<script>
    (function (i, s, o, g, r, a, m) {
        i['GoogleAnalyticsObject'] = r;
        i[r] = i[r] || function () {
            (i[r].q = i[r].q || []).push(arguments)
        }, i[r].l = 1 * new Date();
        a = s.createElement(o),
                m = s.getElementsByTagName(o)[0];
        a.async = 1;
        a.src = g;
        m.parentNode.insertBefore(a, m)
    })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');
    ga('create', 'UA-55062070-1', 'auto');
    ga('send', 'pageview');
</script>

<!--Following is the generic script for Excel download buttons-->
<script>
     var xport = {
  _fallbacktoCSV: true,  
  toXLS: function(tableId, filename) {   
    this._filename = (typeof filename == 'undefined') ? tableId : filename;
    
    //var ieVersion = this._getMsieVersion();
    //Fallback to CSV for IE & Edge
    if ((this._getMsieVersion() || this._isFirefox()) && this._fallbacktoCSV) {
      return this.toCSV(tableId);
    } else if (this._getMsieVersion() || this._isFirefox()) {
      alert("Not supported browser");
    }

    //Other Browser can download xls
    var htmltable = document.getElementById(tableId);
    var html = htmltable.outerHTML;

    this._downloadAnchor("data:application/vnd.ms-excel" + encodeURIComponent(html), 'xls'); 
  },
  toCSV: function(tableId, filename) {
    this._filename = (typeof filename === 'undefined') ? tableId : filename;
    // Generate our CSV string from out HTML Table
    var csv = this._tableToCSV(document.getElementById(tableId));
    // Create a CSV Blob
    var blob = new Blob([csv], { type: "text/csv" });

    // Determine which approach to take for the download
    if (navigator.msSaveOrOpenBlob) {
      // Works for Internet Explorer and Microsoft Edge
      navigator.msSaveOrOpenBlob(blob, this._filename + ".csv");
    } else {      
      this._downloadAnchor(URL.createObjectURL(blob), 'csv');      
    }
  },
  _getMsieVersion: function() {
    var ua = window.navigator.userAgent;

    var msie = ua.indexOf("MSIE ");
    if (msie > 0) {
      // IE 10 or older => return version number
      return parseInt(ua.substring(msie + 5, ua.indexOf(".", msie)), 10);
    }

    var trident = ua.indexOf("Trident/");
    if (trident > 0) {
      // IE 11 => return version number
      var rv = ua.indexOf("rv:");
      return parseInt(ua.substring(rv + 3, ua.indexOf(".", rv)), 10);
    }

    var edge = ua.indexOf("Edge/");
    if (edge > 0) {
      // Edge (IE 12+) => return version number
      return parseInt(ua.substring(edge + 5, ua.indexOf(".", edge)), 10);
    }

    // other browser
    return false;
  },
  _isFirefox: function(){
    if (navigator.userAgent.indexOf("Firefox") > 0) {
      return 1;
    }
    
    return 0;
  },
  _downloadAnchor: function(content, ext) {
      var anchor = document.createElement("a");
      anchor.style = "display:none !important";
      anchor.id = "downloadanchor";
      document.body.appendChild(anchor);

      // If the [download] attribute is supported, try to use it
      
      if ("download" in anchor) {
        anchor.download = this._filename + "." + ext;
      }
      anchor.href = content;
      anchor.click();
      anchor.remove();
  },
  _tableToCSV: function(table) {
    // We'll be co-opting `slice` to create arrays
    var slice = Array.prototype.slice;

    return slice
      .call(table.rows)
      .map(function(row) {
        return slice
          .call(row.cells)
          .map(function(cell) {
            return '"t"'.replace("t", cell.textContent);
          })
          .join(",");
      })
      .join("\r\n");
  }
};

    </script>
    
    <script type="text/javascript">
    $(document).ready( function() {

$(document).on("click",".my_custom_btn_xprt_xls", function () {
   
    var tab_text="<table border='2px'><tr bgcolor='#D9EDF7'>";
    var textRange; var j=0;
    var this_id = $(this).attr('table_id'); // id of table
    tab = document.getElementById(this_id); 
console.log('id:'+this_id);
    for(j = 0 ; j < tab.rows.length ; j++) 
    {     
        tab_text=tab_text+tab.rows[j].innerHTML+"</tr>";
        //tab_text=tab_text+"</tr>";
    }

    tab_text=tab_text+"</table>";
    tab_text= tab_text.replace(/<A[^>]*>|<\/A>/g, "");//remove if u want links in your table
    tab_text= tab_text.replace(/<img[^>]*>/gi,""); // remove if u want images in your table
    tab_text= tab_text.replace(/<input[^>]*>|<\/input>/gi, ""); // reomves input params

    var ua = window.navigator.userAgent;
    var msie = ua.indexOf("MSIE "); 

    if (msie > 0 || !!navigator.userAgent.match(/Trident.*rv\:11\./))      // If Internet Explorer
    {
        txtArea1.document.open("txt/html","replace");
        txtArea1.document.write(tab_text);
        txtArea1.document.close();
        txtArea1.focus(); 
        sa=txtArea1.document.execCommand("SaveAs",true,"Say Thanks to Sumit.xls");
    }  
    else                 //other browser not tested on IE 11
        sa = window.open('data:application/vnd.ms-excel,' + encodeURIComponent(tab_text));  

    return (sa);
   
});

     $('.my_custom_print').on('click',function(){
        var this_id = $(this).attr('table_id'); // id of table
        var divToPrint=document.getElementById(this_id);
        newWin= window.open("print",'_blank');
        newWin.document.write(divToPrint.outerHTML);
        newWin.print();
        newWin.close();

        })
    });
	
</script>