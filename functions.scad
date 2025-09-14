function expand(x, n = 4) =
	(is_num(x)) ? [for (i = [0:n-1]) x] : [for (i = [0:n-1]) x[i%len(x)]];
function expand_center(size, center = true) =
	(center == true) ? [for (i = size) -i/2] :
	(center == false) ? [for (i = size) 0] :
	(len(center) < len(size)) ? expand_center(expand(center, len(size)), size) :
	[for (i = [0:len(size)-1]) size[i] * (bool(center[i], [1,0])/2-.5) ];
function bool(b, vals = [0,1]) = (!is_bool(b)) ? b : (b) ? vals[1] : vals[0];
