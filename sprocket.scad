// ASSUMPTION: embedding sprockets will reduce actual base size!!!!!
// hopefully this will give just enough slop for good fit :), else have to increase base size!


/*sprockets 
  *** ACTUALLY AT LEAST THREE DIF SPROCKET HOLE SHAPES: 16mm, Kodak, B&H
  .. need to determine for EACH FILM ... and even each clip on a film!!!!!
  ... see below in standards section

  Need to design sprocket type for each film ... or a generic type!!!!
*/

/*******************************************************************************
*** RunnerCyl_R IS CRITICAL - SETS SPROCKET SPACING = FRAME PERF SPACING!!!!
?? CALC FROM DIAMETER = numSprockets*Sprocket-pitch, SO RADIUS = numSprockets*Sprocket-pitch/2&pi

*******************************************************************************/

///////////////////////////////////////////////////////////////////////////////////////////
// Variables for size of roller sub-parts
// hopefully sizes are mm!!
///////////////////////////////////////////////////////////////////////////////////////////
/* 16mm & manufacturer Standards:	these do NOT include super or ultra 16mm sizes!!!

--------- PERFORATION (ie sprocket has to fit into the perforation hole) --------------------
  ??WHICH IS IT?????
  Sprocket-pitch 1	7.605
  Sprocket-pitch 2	7.62

*** ACTUALLY AT LEAST THREE DIF SPROCKET HOLE SHAPES: 16mm, Kodak, B&H
  16mm
	  spkt_W = 1.27;
	  spkt_L = 1.829;
	  spktCorner_R = 0.25;

  Kodak
	  spkt_W = 1.981;
	  spkt_L = 2.794;
	  spktCorner_R = 0.51;

  B&H
	  spkt_W = 1.854;
	  spkt_L = 2.794;		// note this is DIAMETER of cyl/cone!!
	  spktCorner_R = 0;		// there is no corner, but is cylinder above!
---------------------------------------------------------------------------------------------------------------------------------

--------- FRAME size: std 16mm - super or ultra 16mm sizes are different --------------------
  	  frame width		10.26
	  frame height		7.49
---------------------------------------------------------------------------------------------------------------------------------
*/

numSprockets = 8;
SprocketPitch = 7.605;
sprocketEmbed = 0.3;	// because a flat cone base on a cylinder surface would leave a gap,
					// need to 'embed' sprocket cone into surface to ensure fully mates - no gaps!
spkt_W = 1.829;
spkt_L = 1.829;
spktCorner_R = 0.25;
spkt_H = 1.27 + sprocketEmbed;		// <<< embedding will reduce actual base size!!!!!
								// hopefully this will give just enough slop for good fit :)


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

///////////////////////////////////////////////////////////////////////////////////////////
// now draw the parts
///////////////////////////////////////////////////////////////////////////////////////////

$fn = fragResolution;


//film drive sprockets
	// by default dir of cyl is "up Z axis" ... 3rd param
	for ( i = [0 : 1 : numSprockets-1 ] )
	{
	   //rotate( [90, 0, i * 360 / numSprockets])
	  // translate([0, -0.5*RunnerCyl_H, RunnerCyl_R-sprocketEmbed ])
	   //cylinder(r1 = spktBase_R, r2 = spktTop_R, h = spkt_H, $fn = fragResolution);
	}

minkowski()
{
	   cube(size=[spktBase_R, spktTop_R, spkt_H], $fn = fragResolution);
	   cylinder(r=spktBase_R , h=spkt_H);
}