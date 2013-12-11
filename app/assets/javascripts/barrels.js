$(function () {
    $('.clickable').click(function () {
		$.ajax(
		    {
		      url:"/barrels/history",
			  data: {barrel: this.id}
		    });
        return false;
    })
});