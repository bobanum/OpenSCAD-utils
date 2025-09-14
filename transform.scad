module translateX(val) {
	if (is_num(val)) {
		translate([val,0,0]) children();
	} else if (len(val) == 1) {
		translate([val.x,0,0]) children();
	} else if (len(val) == 2) {
		translate([0, val.x, val.y]) children();
	} else {
		translate(val) children();
	}
}
module translateY(val) {
	if (is_num(val)) {
		translate([0,val,0]) children();
	} else if (len(val) == 1) {
		translate([0,val.x,0]) children();
	} else if (len(val) == 2) {
		translate([val.x, 0, val.y]) children();
	} else {
		translate(val) children();
	}
}
module translateZ(val) {
	if (is_num(val)) {
		translate([0,0,val]) children();
	} else if (len(val) == 1) {
		translate([0,0,val.x]) children();
	} else if (len(val) == 2) {
		translate([val.x, val.y, 0]) children();
	} else {
		translate(val) children();
	}
}

module center(size, center = true) {
	echo(expand_center(size, center));
	translate(expand_center(size, center)) children();
}
function expand_center(size, center = true) =
	(center == true) ? [for (i = size) -i/2] :
	(center == false) ? [for (i = size) 0] :
	(len(center) < len(size)) ? expand_center(expand(center, len(size)), size) :
	[for (i = [0:len(size)-1]) size[i] * (bool(center[i], [1,0])/2-.5) ];
