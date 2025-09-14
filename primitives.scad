include <transform.scad>
module torus(R, r, D, d) {
	if (R != undef && r != undef) {
		rotate_extrude()
			translate([R, 0, 0]) {
				circle(r);
			}
	} 
	else if (D != undef) torus(R=D/2, r=r, d=d);
	else if (d != undef) torus(R=R, r=d/2);
	else torus(R=10, r=2);
}
module pill(length=10, diameter=5, center=true) {
	center([diameter,diameter,length], center)
	translate([diameter,diameter,length]/2) {
		cylinder(d=diameter, h=length-diameter, center=true);
		translate([0,0,length/2-diameter/2])
			sphere(d=diameter);
		translate([0,0,-length/2+diameter/2])
			sphere(d=diameter);

	}
}
pill();