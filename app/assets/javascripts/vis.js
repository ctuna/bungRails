


function init(spiritId){

	var margin = {top: 0, right: 100, bottom: 30, left: 25},
	    width = 460 - margin.left - margin.right,//was 960
	    height = 197 - margin.top - margin.bottom;//was 500
	
	var parseDate = d3.time.format("%Y-%m-%dT%X%Z").parse,
	    bisectDate = d3.bisector(function(d) { return d.date; }).left,
	    formatValue = d3.format(",.2f"),
	    formatGal = function(d) { return formatValue(d) + " gal" }
	    formatLtr = function(d) { return formatValue(d) + " ltr" };

	var x = d3.time.scale()
	    .range([0, width]);

	var y = d3.scale.linear()
	    .range([height, 0]);

	var xAxis = d3.svg.axis()
	    .scale(x)
	    .orient("bottom");

	var yAxis = d3.svg.axis()
	    .scale(y)
	    .orient("left");

	var line = d3.svg.line()
	    .x(function(d) { return x(d.date); })
	    .y(function(d) { return y(d.close); });

	var svg = d3.select("#vis").append("svg")
	    .attr("width", width + margin.left + margin.right)
	    .attr("height", height + margin.top + margin.bottom)
	  .append("g")
	    .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
	
	console.log("we're going to "+ ("/barrels/visdata?spirit="+spiritId))
	d3.json(("/barrels/visdata?spirit="+spiritId), function(error, data) {
		
	  data.forEach(function(d) {
	    d.date = new Date(Date.parse(d.updated_at));
	    d.close = +d.liters;
	  });

	  data.sort(function(a, b) {
	    return a.date - b.date;
	  });

	  x.domain([data[0].date, data[data.length - 1].date]);
	  y.domain(d3.extent(data, function(d) { return d.close; }));

	  svg.append("g")
	      .attr("class", "x axis")
	      .attr("transform", "translate(0," + height + ")")
	      .call(xAxis);

	  svg.append("g")
	      .attr("class", "y axis")
	      .call(yAxis);

	  var title = svg.append("text")
	      .attr("x", width/2);
		
	  var barrelTxt = "Barrel " + data[0].spirit_id;
	
	  title.append("tspan")
	    .text(barrelTxt)
	    .attr("class", "title");

	  title.append("tspan")
	     .attr("dx", (-barrelTxt.length*7))
	     .attr("dy", 20)
	     .text("Volume")
	     .attr("class", "subtitle");

	  var area = d3.svg.area()
	    .x(function(d) { return x(d.date); })
	    .y0(height)
	    .y1(function(d) { return y(d.close); });

	  svg.append("path")
	    .datum(data)
	    .attr("class", "area")
	    .attr("d", area)
	    .on("mouseover", function() { d3.select(".area").style("fill", "black"); })
	    .on("mouseout", function() { d3.select(".area").style("display", "none"); });

	  svg.append("path")
	      .datum(data)
	      .attr("class", "line")
	      .attr("d", line);

	  data.forEach( function(d) {
	                    svg.append("line")
	                    .attr("class", "readingline")
	                    .attr("x1", x(d.date))
	                    .attr("x2", x(d.date))
	                    .attr("y1", (y(d.close)+1.5))
	                    .attr("y2", height);
	                    });

	  var focus = svg.append("g")
	      .attr("class", "focus")
	      .style("display", "none");

	  focus.append("line")
	      .attr("class", "focusline");

	  focus.append("text")
	      .attr("x", 9)
	      .attr("dy", ".35em");

	  focus.append("circle")
	      .attr("r", 5);

	  svg.append("rect")
	      .attr("class", "overlay")
	      .attr("width", width)
	      .attr("height", height)
	      .on("mouseover", function() { focus.style("display", null); })
	      .on("mouseout", function() { focus.style("display", "none"); })
	      .on("mousemove", mousemove);

	  function mousemove() {
	    var x0 = x.invert(d3.mouse(this)[0]),
	        i = bisectDate(data, x0, 1),
	        d0 = data[i - 1],
	        d1 = data[i],
	        d = x0 - d0.date > d1.date - x0 ? d1 : d0;
	    focus.select("line").attr("x1", x(d.date));
	    focus.select("line").attr("x2", x(d.date));
	    focus.select("line").attr("y1", (y(d.close) + 4.2));
	    focus.select("line").attr("y2", height);
	    focus.select("text").attr("transform", "translate(" + x(d.date) +
	    "," +  ( height - (height - y(d.close)) / 2 ) + ")");
	    var txt = focus.select("text").text("");
	    txt.append("tspan").text(formatLtr(d.close));
	    txt.append("tspan").attr("x", 9).attr("dy", 15).text(d.date);
	    focus.select("circle").attr("transform", "translate(" + x(d.date)
	    + "," + y(d.close) + ")");
	  }
	});

}
