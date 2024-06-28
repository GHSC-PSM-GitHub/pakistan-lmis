$(function() {
    $('#product').change(function() {
        if ($('#product').val() != '')
        {
            $('#mcc_generic_name_div').fadeIn();    
            $('#mcc_category_div').fadeIn(); 
            
            $.ajax({
                type: "POST",
                url: "get_mcc_info.php",
                cache: false,
                data: {'pk_id': $('#product').val()}, // since, you need to delete post of particular id
                dataType: 'json',
                success: function(data) {
    //                      alert(data.category_id);
                    $("#mcc_generic_name").val(data.generic_updated);
                    $("#mcc_category").val(data.mcc_category_name);
                 }
             });    
            
            $('#printSummary').css('display', 'none');
            $.ajax({
                type: "POST",
                url: "ajaxbatch.php",
                data: {id: $('#product').val()},
                dataType: 'html',
                success: function(data) {
                    $('#vaccine-detail').show();
                    $('#batch_detail_ajax').html(data).show();
                }
            });
        }
        else
        {
            $('#mcc_generic_name_div').fadeOut();
            $('#mcc_category_div').fadeOut();
            
            $('#batch_detail_ajax').html('').hide();
            $('#printSummary').css('display', 'block');
        }
    });

    $.inlineEdit({
        expiry: 'ajaxExpiry.php?type=expiry&Id='
    }, {
        animate: false,
        filterElementValue: function($o) {
            return $o.html().trim();
        },
        afterSave: function() {
        }

    });

    /*$("button[id$='-makeit']").click(function(){
     var value = $(this).attr("id");
     var action = value.replace("-makeit","");
     alert(value + ' - ' + action);
     $.ajax({
     type: "POST",
     url: "ajaxbatch.php",
     data: {batch_id: $('#'+action+'_id').val(), status: $('#'+action+'_status').val()},
     dataType: 'json',
     success: function(data){
     $('#'+action+'-status').html(data.status);
     $('#'+action+'-button').html(data.button);
     $('#'+action+'_status').val(data.status);
     }		
     });
     });*/
});

function makeIt(id) {
    var value = id;
    var action = value.replace("-makeit", "");
    $.ajax({
        type: "POST",
        url: "ajaxbatch.php",
        data: {batch_id: $('#' + action + '_id').val(), status: $('#' + action + '_status').val()},
        dataType: 'json',
        success: function(data) {
            $('#' + action + '-status').html(data.status);
            $('#' + action + '-button').html(data.button);
            $('#' + action + '_status').val(data.status);
            if ($('#' + action + '_status').val() == 'Stacked') {
                $('#' + action + '-makeit').removeClass("btn-danger");
                $('#' + action + '-makeit').addClass("btn-success");
            } else {
                $('#' + action + '-makeit').removeClass("btn-success");
                $('#' + action + '-makeit').addClass("btn-danger");
            }
        }
    });
}

function loadPlacementInfo(id) {
    $('#modal-body-contents').html("<div style='text-align: center; '><img src='../../assets/global/img/loading-spinner-grey.gif' alt='' class='loading'><span>&nbsp;&nbsp;Loading... </span></div>");
    $.ajax({
        type: "POST",
        url: "ajax_stock_batch_placement_info.php",
        data: {id: id},
        dataType: 'html',
        success: function(data) {
            $('#modal-body-contents').html(data);
        }
    });
}

function deletePlacement(id, batchId) {
    if (confirm('Are You sure, You want to delete?')) {
        $.ajax({
            type: "POST",
            url: "delete_placement.php",
            data: {id: id, batchId: batchId},
            dataType: 'html',
            success: function(data) {
                $('#' + id).closest("tr").remove();
            }
        });

    }
}