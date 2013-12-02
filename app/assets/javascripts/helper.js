var w = 700;
var h = 200;
var padding = 30;
var svg;
var data=[{
    "barrels": [
	 {
        "container": "container", 
        "contents": "contents", 
        "gallons": "gallons",
		"readings": "readings"
      },
      {
        "container": "AB-FO12-01", 
        "contents": "Apple Brandy", 
        "gallons": 55.74,
		"readings": [55.74, 53, 52, 48, 48]
      }, 
      {
		"container": "AB-FO12-02", 
		"contents": "Apple Brandy", 
		"gallons": 58.65,
		"readings": [58.74, 58, 56, 50, 48]
      }, 
      {
		"container": "AB-FO12-03", 
		"contents": "Apple Brandy", 
		"gallons": 58.12,
		"readings": [58, 58, 56, 50, 50]
      }
	, 
      {
		"container": "WH-FO12-02", 
		"contents": "Whiskey", 
		"gallons": 30.12,
		"readings": [30, 31, 20, 20, 20]
      }
	, 
      {
		"container": "WH-FO12-03", 
		"contents": "Whiskey", 
		"gallons": 44,
		"readings": [58, 58, 56, 50, 50]
      }
	, 
      {
		"container": "WH-FO12-04", 
		"contents": "Whiskey", 
		"gallons": 58.12,
		"readings": [58, 58, 56, 50, 50]
      }
	, 
      {
		"container": "WH-FO12-05", 
		"contents": "Whiskey", 
		"gallons": 50,
		"readings": [58, 58, 56, 50, 50]
      }
		]
}]
var vis;
function init(){
	vis = d3.select("body");
	/**svg = d3.select("body").append("svg")
	.attr("width", w)
	.attr("height", h);*/
	console.log("in init");
	

	
	d3.select("#selector")
		.on("change", updateSelector)
		.selectAll("option.auto")
		.data(plist).enter()
		.append("option")
		.attr("value", function(d) { return d; })
		.text(function(d) { return pname[d]; });
	makeTable(CHART);

}
var titles =["container", "contents", "gallons"];
var CHART = 0;
var BARCHART = 1;
function makeTable(type){
	d3.select("table").remove();
	d3.select("#barchart").remove();
	var dataset = [],
	tmpDataset = [],
	i, j;
	
	
	if (type == CHART){
	
	for (i = 0; i < data[0].barrels.length; i++) {
	    for (j = 0, tmpDataset = []; j < 3; j++) {
			if (i == 0){
				tmpDataset.push(titles[j])
			}
			else if (j == 0 ){
				tmpDataset.push(data[0].barrels[i].container);
			}
			else if (j == 1){
				tmpDataset.push(data[0].barrels[i].contents);
			}
	        else tmpDataset.push(data[0].barrels[i].gallons);
	    }
	    dataset.push(tmpDataset);
	}

	d3.select("body")
	    .append("table")
	    .style("border-collapse", "collapse")
	    .style("border", "2px black solid")

	    .selectAll("tr")
	    .data(dataset)
	    .enter().append("tr")

	    .selectAll("td")
	    .data(function(d){return d;})
	    .enter().append("td")
	    .style("border", "5px black solid")
	    .style("padding", "10px")

	    .text(function(d){return d;})
	    .style("font-size", "24px");
	}
	else if (type == BARCHART){
		var dataset2 = data[0].barrels.slice(1, data[0].barrels.length);
		
		
		var svg = d3.select("body")
			.append("svg")
			.attr("id", "barchart")
			.attr("width", w)
			.attr("height", h);
		var barPadding = 4;  
		console.log("w is: " + w , "dataset length is" + dataset2.length);
		svg.selectAll("rect")
			   .data(dataset2)
			   .enter()
			   .append("rect")
			   .attr("x", function(d, i) {
			    return i * (w / dataset2.length);  //Bar width of 20 plus 1 for padding
			})
			   .attr("y",function(d) {
			    return h - d.gallons - padding - 20;  //Height minus data value
			})
				
			   .attr("width", (w/dataset2.length) - barPadding)
			   .attr("height",function(d, i) {
			    return d.gallons;  //Bar width of 20 plus 1 for padding
			}) 
			var barWidth = w/dataset2.length - barPadding;
			svg.selectAll("text")
				.data(dataset2)
				.enter()
				.append("text")
				.attr("text-anchor", "middle")
				.text(function(d) {
					return d.container;
				})
				.attr("x", function(d, i) {
					return i * barWidth + barWidth/2;  //Bar width of 20 plus 1 for padding
				})
				.attr("y",function(d) {
					return h - padding;  //Height minus data value
				})
			svg.selectAll("text")
				.data(data[0].barrels.slice(1, 4))
				.enter()
				.append("text")
				.attr("text-anchor", "middle")
				.attr("font-family", "sans-serif")
			    .attr("font-size", "9px")
		  		.attr("fill", "yellow")
				.text(function(d) {
					return d.gallons;
						})
				.attr("x", function(d, i) {
					return i * barWidth + barWidth/2;  //Bar width of 20 plus 1 for padding
							})
				.attr("y", function(d, i) {
					return h - d - padding - 20;  
					})
				
		
			
	}
	
}



function updateSelector(){
	d = this.value;
	if (d=='tableView'){
		makeTable(CHART);
	}
	else makeTable(BARCHART);

}