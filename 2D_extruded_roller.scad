// changes here are NOT ALWAYS automatically compiled/reloaded. Need to press F5 in main app!

//TODO review rollerOutlineAll/Partial
// make rollerOutlineAll call rollerOutlinePartial???
// need think about shaft position....

L0 = 0;                    // first outer edge
L1 = L0 + OuterCyl_H;      // + outer wall thickness
L2 = L1 + RunnerCyl_H;     // + runner thickness
L3 = L2 + CoreCyl_H;       // + central shaft
L4 = L3 + RunnerCyl_H;     // + runner thickness
L5 = L4 + OuterCyl_H;      // + outer wall thickness

LP0 = 0;                    // first outer edge
LP1 = LP0 + RunnerCyl_H;     // + runner thickness
LP2 = LP1 + CoreCyl_H;       // + central shaft
LP3 = LP2 + RunnerCyl_H;     // + runner thickness


// complete with outer guide walls
module rollerOutlineAll(){
    // see Extruding a Polygon doco/help
	// each line below draws a line vertical to the shaft
	// lines ALONG/PARALLEL to shaft are drawn by {line:last to next_line:first} data pairs!
	polygon( points=[[shaft_R, L0], [OuterCyl_R, L0],
				[OuterCyl_R, L1-outerWallSlopeGap], [RunnerCyl_R, L1],	    //outer guide wall
				[RunnerCyl_R, L2], [CoreCyl_R, L2],	                        // runner
				[CoreCyl_R, L3], [RunnerCyl_R, L3], 			            // core
				[RunnerCyl_R, L4], [OuterCyl_R, L4 + outerWallSlopeGap],    // runner
                [OuterCyl_R, L5], [shaft_R, L5]     				        //outer guide wall
								]);
}

// complete with outer guide walls
module rollerOutlinePartial (){
    // see Extruding a Polygon doco/help
	// each line below draws a line vertical to the shaft
	// lines ALONG/PARALLEL to shaft are drawn by {line:last to next_line:first} data pairs!
	polygon( points=[[shaft_R, LP0], [RunnerCyl_R, LP0],	        //outer edge
				[RunnerCyl_R, LP1], [CoreCyl_R, LP1],	            // runner
				[CoreCyl_R, LP2], [RunnerCyl_R, LP2], 			    // runner
				[RunnerCyl_R, LP3], [shaft_R, LP3]    				//outer edge
								]);
}

//Draw with/out the outer guide edges, according to parameter passed in.
module TwoDExtrudeRoller(addOuterGuideEdges = true){
    if (addOuterGuideEdges){
        //rotated 90 degrees to show how the rotation will look, the rotate_extrude() needs it flat).
        //rotate([90,0,0])
        rotate_extrude($fn=200) rollerOutlineAll();
    }
    else {
        rotate_extrude($fn=200) rollerOutlinePartial();
    }
}

