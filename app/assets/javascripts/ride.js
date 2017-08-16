document.addEventListener("turbolinks:load", function() {

	$('.ride_card').click(function(){
		// alert("clicked");
		// console.log($(this).attr('ride-id'))
		// $.ajax({
		// 	url: '/rides/'+$(this).attr('ride-id'),
		// 	type: 'get', 
		// })
	});
	$('#payment_status').on('change', function(){
		var checked = $(this).is(':checked') ? true : false;
		console.log(checked)
		$.ajax({
			url: '/rides/'+ $(this).attr('data-id')+'/toggle_payment_status',
			type: 'POST',
			data: {"payment_status" : checked},
			dataType: "json",
			success: function(response){
				//{status: true}
				if (response == 'Error') {
					alert("There was an error");
				}
				else {
					console.log(response);
					$('#status').text(response);	
				}
			}
		});
	});
})