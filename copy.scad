mirror_copy(d=[6, 10, 15]) cube([5,5,5], center=true);
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
