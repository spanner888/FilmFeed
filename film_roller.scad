//*** ASSUMPTION: SPROCKETS ARE IN CENTER OF RUNNER!!!!!!!!

// mounting shaft hole ... Does it have to go ALL the way through??
// mounting shaft hole ... add a flat spot to mate with shaft?

//... should the INSIDE edges of the outer guide edges have slight slope ?
// - ie thinner at top edges to help film slot in easier.
// ... or at LEAST a rounded top edge?

//sprockets should be more oval shaped?

// how to bevel or round edges of a cylinder????

// how to MEASURE/VALIDATE sizes before creating/printing?

/*******************************************************************************
*** RunnerCyl_R IS CRITICAL - SETS SPROCKET SPACING = FRAME PERF SPACING!!!!
?? CALC FROM DIAMETER = numSprockets*Sprocket-pitch, SO RADIUS = numSprockets*Sprocket-pitch/2&pi

*******************************************************************************/

///////////////////////////////////////////////////////////////////////////////////////////
// Set up thr variables for the size of the roller sub-parts
// hopefully sizes are mm!!
///////////////////////////////////////////////////////////////////////////////////////////
/* 16mm Standards:	these do NOT include suuper or ultra 16mm sizes!!!
  sprocket width		1.829
  sprocket height		1.27
  sprocket radius		0.25

  Frame:
	  frame width		10.26
	  frame height		7.49

  perf sizes (see doc for other formats:)			
	  width			1.829
	  height			1.27
	  corner radius		0.25	

  ??WHICH IS IT?????
  Sprocket-pitch 1	7.605
  Sprocket-pitch 2	7.62
*/

numSprockets = 8;
SprocketPitch = 7.605;
sprocketEmbed = 0.3;	// because a flat cone base on a cylinder surface would leave a gap,
					// need to 'embed' sprocket cone into surface to ensure fully mates - no gaps!
spktBase_R = 1.27/2;	// SPECS: ... but prob for OVAL shaped!!! 1.829/2;
spktTop_R = 0.25;
spkt_H = 1.27 + sprocketEmbed;


filmWidth = 16;		 // from 16mm standards
frameWidth = 10.26; // from 16mm standards
filmSlop = 0.2;		// a little bit of slop - so film does not grab/stick/rub on sides
				// reduce or REMOVE if add sloping outer walls

RunnerCyl_H = (filmWidth - frameWidth - 0.6)/2;		// -0.6 => film frame surface NOT touching roller!
//RunnerCyl_R = 6;
RunnerCyl_R = (numSprockets*SprocketPitch)/(2*3.414);

CoreCyl_H = filmWidth + filmSlop - 2*RunnerCyl_H ;
CoreCyl_R = 4;

OuterCyl_H = 2;
OuterCyl_R = RunnerCyl_R + 3;


shaft_R = 6.5/2;

fragResolution = 500;

// add/remove these parts from teh final object
includeSprockets = true;
includeOuterGuideEdges = true;
///////////////////////////////////////////////////////////////////////////////////////////
// now draw the parts
///////////////////////////////////////////////////////////////////////////////////////////

$fn = fragResolution;

//Central core cylinder set - shaft hole
difference() {
	//First join all the cylinders into the roller shape
	union(){
		cylinder(h = CoreCyl_H, r = CoreCyl_R);

		// step up .. film runs on these two cylinders
	      translate ([0,0,CoreCyl_H]) cylinder(h = RunnerCyl_H, r = RunnerCyl_R);
	      translate ([0,0,-RunnerCyl_H]) cylinder(h = RunnerCyl_H, r = RunnerCyl_R);
      
	      //Outer edges - contain film 
		if (includeOuterGuideEdges == true){
		      translate ([0,0,CoreCyl_H + RunnerCyl_H]) cylinder(h = OuterCyl_H, r = OuterCyl_R);
		      translate ([0,0,-(RunnerCyl_H + OuterCyl_H)]) cylinder(h = OuterCyl_H, r = OuterCyl_R);
		}
	}
	// now difference (subtract) the mounting shaft hole
    translate ([0,0,-(RunnerCyl_H + OuterCyl_H)])
	cylinder (h = (CoreCyl_H + 2*RunnerCyl_H + 2*OuterCyl_H), r = shaft_R);
}


//film drive sprockets
if (includeSprockets == true){
	// by default dir of cyl is "up Z axis" ... 3rd param
	for ( i = [0 : 1 : numSprockets-1 ] )
	{
	   rotate( [90, 0, i * 360 / numSprockets])
	   translate([0, -0.5*RunnerCyl_H, RunnerCyl_R-sprocketEmbed ])
	   cylinder(r1 = spktBase_R, r2 = spktTop_R, h = spkt_H, $fn = fragResolution);
	}
}
