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
                    $('#batch_detail_ajax').html(data);
                }
            });
        }
        else
        {
            $('#mcc_generic_name_div').fadeOut();
            $('#mcc_category_div').fadeOut();
            
            $('#batch_detail_ajax').html('');
            $('#vaccine-detail').hide();
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

function makeIt(id)
{
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
        }
    });
}

