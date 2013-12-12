$(function () {
    $('.clickable').click(function () {
		var that = $(this);
		console.log(that.attr('id'));
		$.ajax(
		    {
			
		      url:"/barrels/history",
			  data: {barrel: this.id}
		    });
        return true;
    })
});