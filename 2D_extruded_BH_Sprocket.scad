// changes here are NOT ALWAYS automatically compiled/reloaded. Need to press F5 in main app!

//include <16mm_vars.scad>

//spkt_W = 1.854;
//spkt_L = 2.794;		// note this is DIAMETER of cyl/cone!!
spktRadius = 2.794 /2;
//	  spktCorner_R = 0;		// there is no corner, but is cylinder above!

$fn=200;

// complete with outer guide walls
module sprocketBase(){
	difference()
	{
		circle (r = spktRadius, center = true);
		// "spkt_L+2" below is v dodgy .. without it have uneven edge, but is size correct with it?
		translate ([0, spkt_W + spkt_W/4, 0]) square ([spkt_L+2, spkt_H], center = true);
		translate ([0, -(spkt_W + spkt_W/4), 0]) square ([spkt_L+2, spkt_H], center = true);
	}
}

//Draw with/out the outer guide edges, according to parameter passed in.
module TwoDExtrudeSprocket(){
	//rotate(a=[0,180,0]){			// rotate to get sprocket facing outwards!
	linear_extrude(height = spkt_H, center = true, convexity = 10, scale=1.2)
	sprocketBase();
}

        //rotated 90 degrees to show how the rotation will look, the rotate_extrude() needs it flat).
//        rotate([90,0,0])
//sprocketBase();
//TwoDExtrudeSprocket();
