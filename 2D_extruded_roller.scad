
include <16mm.scad>
// obsolete once switch to new sprocket type
spktBase_R = 1.27/2;	// SPECS: ... but prob for OVAL shaped!!! 1.829/2;
spktTop_R = 0.25;


// see Extruding a Polygon doco/help

outerWallGap = 1;

include <sprocket.scad>

L0 = 0;                    // first outer edge
L1 = L0 + OuterCyl_H;      // + outer wall thickness
L2 = L1 + RunnerCyl_H;     // + runner thickness
L3 = L2 + CoreCyl_H;       // + central shaft
L4 = L3 + RunnerCyl_H;     // + runner thickness
L5 = L4 + ;      // + outer wall thickness

module rollerOutline (){
	// each line below draws a line vertical to the shaft
	// lines ALONG/PARALLEL to shaft are drawn by {line:last to next_line:first} data pairs!
	//... well will always be this way ONCE tidied code!!!!!
	polygon( points=[[shaft_R, L0], [OuterCyl_R, L0],
				[OuterCyl_R, L1-outerWallGap], [RunnerCyl_R, L1],	//outer guide wall
				[RunnerCyl_R, L2], [CoreCyl_R, L2],	                // runner
				[CoreCyl_R, L3],								    // core
				[RunnerCyl_R, L3],							        // runner
				[RunnerCyl_R, OuterCyl_H + 2 * RunnerCyl_H + CoreCyl_H],						// runner EDGE
				[OuterCyl_R, OuterCyl_H + 2 * RunnerCyl_H + CoreCyl_H + outerWallGap], 			//outer guide wall
				[OuterCyl_R, 2 * OuterCyl_H + 2 * RunnerCyl_H + CoreCyl_H], 					//outer guide wall
				[shaft_R, 2 * OuterCyl_H + 2 * RunnerCyl_H + CoreCyl_H], 						//outer guide wall
								]);
}

//rotated 90 degrees to show how the rotation will look, the rotate_extrude() needs it flat).
//rotate([90,0,0]) rollerOutline ();

rotate_extrude($fn=200) rollerOutline ();

