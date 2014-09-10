// mounting shaft hole ... Does it have to go ALL the way through??
// mounting shaft hole ... add a flat spot to mate with shaft?

//... should the INSIDE edges of the outer guide edges have slight slope ?
// - ie thinner at top edges to help film slot in easier.
// ... or at LEAST a rounded top edge?

//should sprockets be more oval shaped?

///////////////////////////////////////////////////////////////////////////////////////////
// Set up thr variables for the size of the roller sub-parts
// hopefully sizes are mm!!
///////////////////////////////////////////////////////////////////////////////////////////
shaft_R = 6.5/2;

CoreCyl_H = 10;
CoreCyl_R = 4;

RunnerCyl_H = 3;
RunnerCyl_R = 5;

OuterCyl_H = 2;
OuterCyl_R = 8;

numSprockets = 8;
sprocketOffset = 0.3;	// because a flat cone base on a cylinder surface would leave a gap,
					// need to 'embed' sprocket cone into surface to ensure fully mates - no gaps!
spktBase_R = 0.8;
spktTop_R = 0.5;
spkt_H = 3;

fragResolution = 500;

// add/remove these parts from teh final object
includeSprockets = true;
includeOuterGuideEdges = true;
///////////////////////////////////////////////////////////////////////////////////////////
// now draw the parts
///////////////////////////////////////////////////////////////////////////////////////////

//Central core cylinder set - shaft hole
difference() {
	//First join all the cylinders into the roller shape
	union(){
		cylinder(h = CoreCyl_H, r = CoreCyl_R, $fn=fragResolution);

		// step up .. film runs on these two cylinders
	      translate ([0,0,CoreCyl_H]) cylinder(h = RunnerCyl_H, r = RunnerCyl_R, $fn=fragResolution);
	      translate ([0,0,-RunnerCyl_H]) cylinder(h = RunnerCyl_H, r = RunnerCyl_R, $fn=fragResolution);
      
	      //Outer edges - contain film 
		if (includeOuterGuideEdges == true){
		      translate ([0,0,CoreCyl_H + RunnerCyl_H]) cylinder(h = OuterCyl_H, r = OuterCyl_R, $fn=fragResolution);
		      translate ([0,0,-(RunnerCyl_H + OuterCyl_H)]) cylinder(h = OuterCyl_H, r = OuterCyl_R, $fn=fragResolution);
		}
	}
	// now difference (subtract) the mounting shaft hole
    translate ([0,0,-(RunnerCyl_H + OuterCyl_H)])
	cylinder (h = (CoreCyl_H + 2*RunnerCyl_H + 2*OuterCyl_H), r = shaft_R, $fn=fragResolution);
}


//film drive sprockets
if (includeSprockets == true){
	// by default dir of cyl is "up Z axis" ... 3rd param
	for ( i = [0 : 1 : numSprockets-1 ] )
	{
	   rotate( [90,0,i * 360 / numSprockets])
	   translate([0,-0.5*RunnerCyl_H, RunnerCyl_R-sprocketOffset ])
	   cylinder(r1 = spktBase_R, r2 = spktTop_R, h = spkt_H, $fn = fragResolution);
	}
}
