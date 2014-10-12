// TO BE ADDED
// ajax to send json fo whole table to rails on Save
// clean up code with functions


var edit_row_form = "<tr class='edit_row'><td></td><td colspan = '7'><div class='edit_row_form'><h3>Enter Linestudy Data</h3>\
<input type='text' id='sta_val' class='input-small' placeholder='Start time'>\
<input type='text' id='end_val' class='input-small' placeholder='End time'>\
<input type='text' id='dur_val' class='input-small' placeholder='Duration' DISABLED>\
<input type='text' id='des_val' class='input-xlarge' placeholder='Description'>\
<select class'form-control' id='mac_val'>\
<option value='Running'>Running</option>\
<option value='Idle'>Idle</option>\
<option value='Down'>Down</option></select>\
<input type='text' id='spe_val' class='input-small' placeholder='Speed'>\
<button id='btn-save-row' class='icon'><i class='glyphicon glyphicon-ok'></i></button></div></td></tr>";

// <input type='text' id='mac_val' class='input-xlarge' placeholder='Machine status'>

var table_row = "<tr>\
<td class='row_id' style='display:none;'></td>\
<td><i class='glyphicon-plus'></i></td>\
<td class='ls_row col_sta'></td>\
<td class='ls_row col_end'></td>\
<td class='ls_row col_dur'></td>\
<td class='ls_row col_des'></td>\
<td class='ls_row col_mac'></td>\
<td class='ls_row col_spe'></td><td>\
<i class='glyphicon-minus'></i></td>\
</tr>";

var available_descriptions = [];
//var available_status = ['Running', 'Idle', 'Down'];

var re_time = /^([01]?\d|2[0-3]):?([0-5]\d):?([0-5]\d)$/;
var re_digit = /^\d+\.?\d*$/;

function remove_edit_row() { $('.edit_row').remove(); }
function unselect_all_rows() { $('#line-study-table').find(".row_selected").removeClass("row_selected"); }
function select_row(row) { row.addClass("row_selected"); }
function update_row_id() {
	i=1;
	$('#line-study-table').find('td.row_id').each(function(){ $(this).val(i); i++ })
}

function show_edit_row(row) {
	row.after(edit_row_form);
	// if the start value is empty pull down the end value from the previous row
	var row_start_val = row.find('.col_end').text();
	var prev_end_val = row.prev().find('.col_end').text();	
	var current_start = $('#line-study-table').find(".row_selected").find('.col_sta').text();
	var current_end = $('#line-study-table').find(".row_selected").find('.col_end').text();
	var current_dur = $('#line-study-table').find(".row_selected").find('.col_dur').text();
	var current_descript = $('#line-study-table').find(".row_selected").find('.col_des').text();
	var current_status = $('#line-study-table').find(".row_selected").find('.col_mac').text();
	var current_speed = $('#line-study-table').find(".row_selected").find('.col_spe').text();
	if ((prev_end_val!=null || prev_end_val!="") && (row_start_val==null || row_start_val=="")) {
		$('#line-study-table').find('#sta_val').val(prev_end_val);
	}	else 	{
		$('#line-study-table').find('#sta_val').val(current_start);
	}
	$('#line-study-table').find('#end_val').val(current_end);
	$('#line-study-table').find('#dur_val').val(current_dur);
	$('#line-study-table').find('#des_val').val(current_descript);
	$('#line-study-table').find('#mac_val').val(current_status);
	$('#line-study-table').find('#spe_val').val(current_speed);
}

function update_duration() {
	var start = $('#line-study-table').find('#sta_val').val();
	var end = 	$('#line-study-table').find('#end_val').val();
	var st_re_match = start.match(re_time);
	var ed_re_match = end.match(re_time);
	if (st_re_match && ed_re_match) {
		var st_hour = 	parseInt(st_re_match[1]);
		var st_min = 	parseInt(st_re_match[2]);
		var st_sec = 	parseInt(st_re_match[3]);
		var ed_hour = 	parseInt(ed_re_match[1]);
		var ed_min = 	parseInt(ed_re_match[2]);
		var ed_sec = 	parseInt(ed_re_match[3]);
		var dur = (ed_hour*3600 + ed_min*60 + ed_sec) - (st_hour*3600 + st_min*60 + st_sec);
		dur = Math.round((dur*100/60))/100;
		$('#line-study-table').find('#dur_val').val(dur);
	}
}

function capitaliseFirstLetter(string) { return string.charAt(0).toUpperCase() + string.slice(1); }

function highlght_edit_row_boxes() {
	var l_table = $('#line-study-table');
	if(l_table.find('.edit_row').length) {

		var start = 	l_table.find('#sta_val');
		var end = 		l_table.find('#end_val');
		var duration = 	l_table.find('#dur_val');
		var description = l_table.find('#des_val');
		var mach_stat = l_table.find('#mac_val');
		var speed = 	l_table.find('#spe_val');

		if (!start.val().match(re_time)) {
			start.css( "border", "2px solid red" )
		} else if ( !check_start_is_end_of_previous_row() ) {
			start.css( "border", "2px solid red" )
		} else {
			start.css( "border", "1px solid #ccc" )
		}

		if (!end.val().match(re_time)) {
			end.css( "border", "2px solid red" )
		} else {
			end.css( "border", "1px solid #ccc" )
		}

		if (!duration.val().match(re_digit)) {
			duration.css( "border", "2px solid red" )
		} else {
			duration.css( "border", "1px solid #ccc" )
		}

		if (description.val()==null || description.val()=="") {
			description.css( "border", "2px solid red" )
		} else {
			description.css( "border", "1px solid #ccc" )
		}

		if (mach_stat.val()==null || mach_stat.val()=="") {
			mach_stat.css( "border", "2px solid red" )
		} else {
			mach_stat.css( "border", "1px solid #ccc" )
		}

		if (mach_stat.val() !="Running" && mach_stat.val() !="Idle" && mach_stat.val() != "Down") {
			mach_stat.css( "border", "2px solid red" )
		} else {
			mach_stat.css( "border", "1px solid #ccc" )
		}

		if (!speed.val().match(re_digit)) {
			speed.css( "border", "2px solid red" )
		} else {
			speed.css( "border", "1px solid #ccc" )
		}

		if ((mach_stat.val() =="Idle" || mach_stat.val() == "Down") && parseInt(speed.val()) != 0) {
			speed.css( "border", "2px solid red" )
		} else {
			speed.css( "border", "1px solid #ccc" )
		}

	}
}

function check_start_is_end_of_previous_row() {
	var l_table = $('#line-study-table');
	var start = l_table.find('#sta_val').val();
	var previous_end = l_table.find('tr.row_selected').prev().find('.col_end').text();

	if(previous_end.length && start.length) {
		return previous_end == start
	}
	return true
}

function check_all_starts_are_end_of_previous() {
	var l_table = $('#line-study-table');
	var start_times = l_table.find('td.col_sta');
	var end_times = l_table.find('td.col_end');
	var result = true;

	for (var i = 0; i < start_times.length -1; i++) {
		var st = $(start_times[i+1]);
		var ed = $(end_times[i]);
		if (st.text() != ed.text()) {
			st.css( "border", "2px solid red" );
			ed.css( "border", "2px solid red" );
			result = false;
		} else {
			st.css( "border", "1px solid #dddddd" );
			ed.css( "border", "1px solid #dddddd" );
		}
	}
	return result
}

$(document).ready(function(){
	var l_table = $('#line-study-table')

	// ADDING A NEW ROW
	l_table.on('click', '.glyphicon-plus', function() {
		$(this).parent().parent().after(table_row);
		unselect_all_rows();
		remove_edit_row();
		select_row($(this).parent().parent().next());
		show_edit_row($(this).parent().parent().next());
		event.stopPropagation();
		update_row_id()
	});

	// DELETING A ROW
	l_table.on('click', '.glyphicon-minus', function() {
		$(this).parent().parent().remove();
		unselect_all_rows();
		remove_edit_row();
		update_row_id()
	});

	// BRINGING UP THE EDIT ROW DIALOG
	l_table.on('click', '.ls_row', function() {
		unselect_all_rows()
		remove_edit_row();
		select_row($(this).parent())
		show_edit_row($(this).parent())

		// if the start value is empty pull down the end value from the previous row
		var row_start_val = $(this).parent().find('.col_end').text();
		var prev_end_val = $(this).parent().prev().find('.col_end').text();		
		if ((prev_end_val!=null || prev_end_val!="") && (row_start_val==null || row_start_val=="")) {
			l_table.find('#sta_val').val(prev_end_val);
		}
		event.stopPropagation();
	});

	// DELETE OR BACKSPACE UNSELECTS ANY SELECTED ROWS
	$(document).keydown(function( event ) {
		// escape
		if ( event.which == 27 ) {
   			event.preventDefault();
   			remove_edit_row();
   			unselect_all_rows()
  		}
  		// tab or enter
		else if ( event.which == 9 || event.which == 13 ) {
   			event.preventDefault();
   			highlght_edit_row_boxes();
   			check_all_starts_are_end_of_previous();
  		}
	});

	// HIGHLIGHT ANY INPUT BOXES IF ERROR
	l_table.on('click', function() {
		highlght_edit_row_boxes();
		check_all_starts_are_end_of_previous();
	});

	// SAVING THE EDITED ROW
	l_table.on('click', '#btn-save-row',function() {
		var start = 	l_table.find('#sta_val').val();
		var end = 		l_table.find('#end_val').val();
		var duration = 	l_table.find('#dur_val').val();
		var description = capitaliseFirstLetter( l_table.find('#des_val').val() );
		var mach_stat = capitaliseFirstLetter( l_table.find('#mac_val').val() );
		var speed = 	l_table.find('#spe_val').val();
		if (!start.match(re_time)) {
			alert("Row not saved: Start time must be a time in the form HH:MM:SS");
			return false;
		} else if ( !check_start_is_end_of_previous_row() ) {
			alert("Row not saved: Start time must equal end time of previous row");
			return false;
		}

		if (!end.match(re_time)) {
			alert("Row not saved: End time must be a time in the form HH:MM:SS");
			return false;
		}
		if (!duration.match(re_digit)) {
			alert("Row not saved: End time must be after start time (duration can't be negative!)");
			return false;
		}
		if (description==null || description=="") {
			alert("Row not saved: Description must be filled out");
			return false;
		}
		if (mach_stat==null || mach_stat=="") {
			alert("Row not saved: Machine status must be filled out");
			return false;
		}
		if (mach_stat!="Running" && mach_stat!="Idle" && mach_stat != "Down") {
			alert("Row not saved: Machine status must be Running, Idle or Down");
			return false;
		}
		if (!speed.match(re_digit)) {
			alert("Row not saved: Speed must be a positive number");
			return false;
		}
		if ((mach_stat =="Idle" || mach_stat == "Down") && parseInt(speed) != 0) {
			alert("Row not saved: Speed must be 0 when machine down or idle");
			return false;
		}
		var sel_row = l_table.find(".row_selected")
		sel_row.find('.col_sta').text(start);
		sel_row.find('.col_end').text(end);
		sel_row.find('.col_dur').text(duration);
		sel_row.find('.col_des').text(description);
		sel_row.find('.col_mac').text(mach_stat);
		sel_row.find('.col_spe').text(speed);

		//add the description (NOT STATUS) to the avalable list for use with autocomplete
		if ($.inArray(description, available_descriptions) == -1) {	available_descriptions.push(description) }
		//if ($.inArray(mach_stat, available_status) == -1) {	available_status.push(mach_stat) }

		unselect_all_rows();
		remove_edit_row();
	});


	// FILLING IN THE DURATION COLUMN
	l_table.on('change', '#sta_val',function() { update_duration() });
	l_table.on('change', '#end_val',function() { update_duration() });

	// AUTOCOMPLETE ON THE DESCRIPTION
	l_table.on("focus","#des_val",function(e) {
   		if ( !$(this).data("autocomplete") ) { // If the autocomplete wasn't called yet:
			$(this).autocomplete({             //   call it
				source: available_descriptions     //     passing some parameters
			});
		}
	});
	// // AUTOCOMPLETE ON THE STATUS
	// l_table.on("focus","#mac_val",function(e) {
	// 	if ( !$(this).data("autocomplete") ) { // If the autocomplete wasn't called yet:
	// 		$(this).autocomplete({             //   call it
	// 			source: available_status     //     passing some parameters
	// 		});
	// 	}
	// });

	// SUBMIT BUTTON
	$('#save_linestudy_link').live("click", function() {
		unselect_all_rows();
		remove_edit_row();
		var check_start_ends = check_all_starts_are_end_of_previous();
		if (!check_start_ends) { 
			alert('Study not saved: start and end times do not align');
			return false
		}

		var self = this;

		var table_data = [];
		var headers = ['js_id', 'blank', 'start_time', 'stop_time', 'duration', 'description', 'status', 'speed', 'blank' ];

		// Loop through grabbing everything
		var $rows = $("#line-study-table tr").each(function(index) {
			$cells = $(this).find("td");
			table_data[index] = {};

			$cells.each(function(cellIndex) {
				// Update the row object with the header/cell combo
				table_data[index][headers[cellIndex]] = $(this).text();
			});    
			// delete the blank header
			delete table_data[index]['blank'];
			delete table_data[index]['duration'];
		});

		var json_table_data = {
			"line_study_table": table_data
			};
		// alert(JSON.stringify(json_table_data));
		
		$.ajax({
			type : "PUT",
			url: 'save',
			data: json_table_data,
			async: true,
			dataType: 'script',
			success: function(data){
				var url = $(self).attr('ajax_path');
				var last_index = url.lastIndexOf("/");
				url = url.slice(0,last_index);
				window.location = url;
			}
		});
		return false;
	});

})
