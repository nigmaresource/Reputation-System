window.addEventListener('message', function(event) {
    var item = event.data;

    if (item.type === "show" && item.repsys == "on") {
        $('#one, #two, #three, #four, #five').hide();
        
        if ($(item.value).length) {
            $(item.value).show();
        }
    }
    if (item.type === "command" ) {
        $('#panel').show(1000);
    }
    if (item.message == "add") {
        let rowId = `row-${item.name}`;
        if ($(`#${rowId}`).length === 0) {
            $( "table" ).append('<tr id="' + rowId + '">' +
            '<td class="text"><b><span style="animation-name:glow;animation-duration:1s;animation-iteration-count:infinite;animation-direction:alternate;">' + item.name + '</span></b></td>' +
            '<td class="text"><b><span style="animation-name:glow;animation-duration:1s;animation-iteration-count:infinite;animation-direction:alternate;">' + item.stars + '</span></b></td>' +
            '</tr>');
        }
    }
    
});

function addto() {
    $("#panel").fadeOut("slow");
    let id = $(".id").val()
    $.post('https://gld_reputationsystem/addto', JSON.stringify({id}));
}

function removefrom() {
    $("#panel").fadeOut("slow");
    let id = $(".id").val()
    $.post('https://gld_reputationsystem/removefrom', JSON.stringify({id}));
}

function leaderboardbtn() {
    $("#panel").fadeOut("slow");
    $("#bgs").show();
    $.post('https://gld_reputationsystem/leaderboard', JSON.stringify({}));
    $( ".table-holder" ).empty()
		$( ".table-holder" ).append('<table style="width:90%; margin-left:5%;table-layout: auto;"></table>')
		$( "table" ).append('<tr>' +
		'<th class="divider">Name</th>' +
		'<th class="divider">Reputation</th>' +
	  	'</tr>') 
          $("#leaderboard").css("display", "block");   
}


document.onkeyup = function (data) {
    if (data.which == 27) {
        $("#panel").fadeOut("slow");
        $("#bgs").hide();
        $.post('https://gld_reputationsystem/close', JSON.stringify({}));
        return
    }
};
