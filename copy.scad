// mirror_copy(d=[6, 10, 15]) cube([5,5,5], center=true);
module mirror_copy(axis, d) {
	if (is_undef(axis)) mirror_copy(axis=d, d=d) children();
	else if (is_num(axis)) mirror_copy(axis=[axis?1:0,0], d=d) children();
	else if (axis.z) mirrorZ_copy(d) mirror_copy(axis=[axis.x, axis.y, 0], d=d) children();
	else if (axis.y) mirrorY_copy(d) mirror_copy(axis=[axis.x, 0, 0], d=d) children();
	else if (axis.x) mirrorX_copy(d) children();
	else children();
}
module mirrorX_copy(d) {
	if (is_num(d)) mirrorX_copy() translate([d/2,0,0]) children();
	else if (is_num(d.x)) mirrorX_copy() translate([d.x/2,0,0]) children();
	else {
		mirror([1,0,0]) children();
		children();
	}
}
module mirrorY_copy(d) {
	if (is_num(d)) mirrorY_copy() translate([0,d/2,0]) children();
	else if (is_num(d.y)) mirrorY_copy() translate([0,d.y/2,0]) children();
	else {
		mirror([0,1,0]) children();
		children();
	}
}
module mirrorZ_copy(d) {
	if (is_num(d)) mirrorZ_copy() translate([0,0,d/2]) children();
	else if (is_num(d.z)) mirrorZ_copy() translate([0,0,d.z/2]) children();
	else {
		mirror([0,0,1]) children();
		children();
	}
}
module translate_copy(v, n=2) {
	if (is_num(v)) translate_copy([v,0,0]) children();
	else if (v.z) translate_copy([v.x,v.y,0]) translate([1,0,0]) children();
	else if (v.x) translate_copy([0,0,0]) translate([1,0,0]) children();
	// else if (is_num(v.y)) translate_copy([0,v.y,0]) children();
	// else if (is_num(v.z)) translate_copy([0,0,v.z]) children();
	else {
		children();
	}
}
module translateX_copy(d,n=2, center=true) {
	translate([-d*(n-1)/2,0,0]*(center?1:0))
	for (i = [0:n-1])
		translate([d,0,0] * i) children();
}
module translateY_copy(d,n=2, center=true) {
	translate([0,-d*(n-1)/2,0]*(center?1:0))
	for (i = [0:n-1])
		translate([0,d,0] * i) children();
}
module translateZ_copy(d,n=2, center=true) {
	translate([0,0,-d*(n-1)/2]*(center?1:0))
	for (i = [0:n-1])
		translate([0,0,d] * i) children();
}
translateX_copy(3,3)
	cube([2,2,2], center=true);