$(document).ready(function() {
	$("tr[data-link]").click(function() {
		console.log("clicked")
		window.location = $(this).data("link")
	})
});
