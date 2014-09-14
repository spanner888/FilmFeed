include <16mm.scad>        // all the variables for part sizes!
include <sprocket.scad>    // draws the ring of sprockets at correct position along shaft

L0 = 0;                    // first outer edge
L1 = L0 + OuterCyl_H;      // + outer wall thickness
L2 = L1 + RunnerCyl_H;     // + runner thickness
L3 = L2 + CoreCyl_H;       // + central shaft
L4 = L3 + RunnerCyl_H;     // + runner thickness
L5 = L4 + OuterCyl_H;      // + outer wall thickness

module rollerOutline (){
    // see Extruding a Polygon doco/help
	// each line below draws a line vertical to the shaft
	// lines ALONG/PARALLEL to shaft are drawn by {line:last to next_line:first} data pairs!
	polygon( points=[[shaft_R, L0], [OuterCyl_R, L0],
				[OuterCyl_R, L1-outerWallSlopeGap], [RunnerCyl_R, L1],	    //outer guide wall
				[RunnerCyl_R, L2], [CoreCyl_R, L2],	                        // runner
				[CoreCyl_R, L3], [RunnerCyl_R, L3], 			            // core
				[RunnerCyl_R, L4], [OuterCyl_R, L4 + outerWallSlopeGap],    // runner
                [OuterCyl_R, L5], [shaft_R, L5],    				        //outer guide wall
								]);
}

//rotated 90 degrees to show how the rotation will look, the rotate_extrude() needs it flat).
//rotate([90,0,0]) rollerOutline ();
rotate_extrude($fn=200) rollerOutline ();
