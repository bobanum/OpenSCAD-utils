$fa = .5;
$fs = .25;
module rcube(size=1, corner_radius=0, center=false) {
	if (is_num(size)) {
		rcube([size, size, size], corner_radius);
	} else if (len(size) == 2) {
		rsquare(size, corner_radius);
	} else if (len(size) == 3) {
		if (corner_radius > 0) {
			difference() {
				minkowski() {
					cube(size, center=center);
					sphere(corner_radius, $fn=50);
				}
				if (center) {
					translate([-size[0]/2, -size[1]/2, -size[2]/2])
						cube([size[0]-2*corner_radius, size[1]-2*corner_radius, size[2]-2*corner_radius]);
				} else {
					translate([corner_radius, corner_radius, corner_radius])
						cube([size[0]-2*corner_radius, size[1]-2*corner_radius, size[2]-2*corner_radius]);
				}
			}
		} else {
			cube(size, center=center);
		}
	}
	
}
module rsquare(size=1, corner_radius=0, center=false) {
	if (is_num(size) || len(size) != 2) {
		rsquare(expand(size,2), corner_radius=corner_radius, center=center);
	} else if (corner_radius == 0) {
		square(size, center=center);
	} else if (is_num(corner_radius) || len(corner_radius) != 4){
		rsquare(size, corner_radius = expand(corner_radius, 4), center=center);
	} else {
		corners = [[0,0],[0,size.y],[size.x,size.y],[size.x,0]];
		offset = [[1,1], [1,-1], [-1,-1], [-1,1]];
		decalages = [
			[0,1],
			[1,0],
			[0,-1],
			[-1,0],
			[0,1],
		];
		points = [
			for (i = [0:3])
				if (corner_radius[i] == 0) 
					corners[i] 
				else 
					for (j = [1,0]) corners[i] + decalages[i+j] * corner_radius[i]
		];
		center(size,center) {
			for (i = [0:3]) {
				translate(corners[i] + corner_radius[i] * offset[i]) if (corner_radius[i] > 0) circle(corner_radius[i]);
			}
			polygon(points);
		}
	}
}
rsquare([15,30], corner_radius=[3,0,1], center=true);
module center(size, center = true) {
	echo(expand_center(size, center));
	translate(expand_center(size, center)) children();
}
function expand(x, n = 4) =
	(is_num(x)) ? [for (i = [0:n-1]) x] : [for (i = [0:n-1]) x[i%len(x)]];
function expand_center(size, center = true) =
	(center == true) ? [for (i = size) -i/2] :
	(center == false) ? [for (i = size) 0] :
	(len(center) < len(size)) ? expand_center(expand(center, len(size)), size) :
	[for (i = [0:len(size)-1]) size[i] * (bool(center[i], [1,0])/2-.5) ];
function bool(b, vals = [0,1]) = (!is_bool(b)) ? b : (b) ? vals[1] : vals[0];

