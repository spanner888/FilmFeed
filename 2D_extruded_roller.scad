/* What is this thing?
    Guide roller for common film formats and also for SMD component tape feed.
    Optional outer guide walls and sprocket teeth.
    Adjustable features: guide wall slopes, number of sprockets, sprocket slopes & height....

License:
    Film-SMD-Roller-Capstan by Spanner888 at {U}sable{D}evices is licensed under a Creative Commons Attribution-ShareAlike 4.0 International License.
    Permissions beyond the scope of this license may be available via http://usabledevices.com/2011/11/contact-emails-and-legal-and-copyright-information/.

    Blog of hardware build and other Telecine info can be found at http://usabledevices.com/category/telecine/
    gitHub:	 http://github/spanner888
    thingiverse: http://www.thingiverse.com/user:spanner888

See README.txt for info on how to adjust etc

Version 0.6 2014-09-30
*/

// changes here are NOT ALWAYS automatically compiled/reloaded. Need to press F5 in main app!

//TODO review rollerOutlineAll/Partial
// make rollerOutlineAll call rollerOutlinePartial???
// need think about shaft position....

// for module rollerOutlineAll
L0 = 0;                                 // first outer edge
L1 = L0 + OuterCyl_H;                   // + outer wall thickness
L2 = L1 + RunnerCyl_H - frameGap;       // + runner thickness
L3 = L2 + CoreCyl_H + 2 * frameGap;     // + central shaft
L4 = L3 + RunnerCyl_H - frameGap;       // + runner thickness
L5 = L4 + OuterCyl_H;                   // + outer wall thickness

// for module rollerOutlinePartial
LP0 = 0;                                // first outer edge
LP1 = LP0 + RunnerCyl_H - frameGap;     // + runner thickness
LP2 = LP1 + CoreCyl_H + 2 * frameGap;   // + central shaft
LP3 = LP2 + RunnerCyl_H - frameGap;     // + runner thickness


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

