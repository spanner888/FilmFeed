// ASSUMPTION: embedding sprockets will reduce actual base size!!!!!
// hopefully this will give just enough slop for good fit :), else have to increase base size!

/*sprockets should be more oval shaped?
	 how to bevel or round edges of a cylinder????
	... actualy do NOT have to be round/oval
	B&H ones are made ffrom FLAT steel and FLAT beveled
	... so always have FLAT surfaces on contact with film!!!!!!

	?? so make as cube, then difference with TWO dif pyramids to set base & top bevels/slopes??
	simpler = just TWO dif pyramids to set base & top bevels/slopes??
.. MORE complete .. back to cube + ROUND the corners as have the sprocket corner radius
...then bevel with two pyramids!!!!

*/

/*sprockets
  *** ACTUALLY AT LEAST THREE DIF SPROCKET HOLE SHAPES: 16mm, Kodak, B&H
  .. need to determine for EACH FILM ... and even each clip on a film!!!!!
  ... see below in standards section

  Need to design sprocket type for each film ... or a generic type!!!!
*/

/**
*****************************************************************************
*** RunnerCyl_R IS CRITICAL - SETS SPROCKET SPACING = FRAME PERF SPACING!!!!
*** ?? CALC FROM DIAMETER = numSprockets*Sprocket-pitch, SO RADIUS = numSprockets*Sprocket-pitch/2&pi
***
******************************************************************************
*/

include <16mm.scad>	// all the variables for part sizes!
///////////////////////////////////////////////////////////////////////////////////////////
// now draw the parts
///////////////////////////////////////////////////////////////////////////////////////////
$fn = fragResolution;

module sprocket(s_height, s_W, sCorner_R, s_L){
	//need to do 2D shape - THEN extrude!!!!!
	rotate(a=[0,180,0]){			// rotate to get sprocket facing outwards!
		linear_extrude(height = s_height, center = true, convexity = 10, scale=1.5)
		minkowski()
		{
		   square([(s_W - 2*sCorner_R ), (s_L - 2*sCorner_R)], center = true, $fn = fragResolution);
		   circle(r=sCorner_R, center = true);
		}
	}
}

//!!!!!!Assignment is not allowed within either branch of an if statement. Consider using the ternary operator 'condition ? consequent: alternative'.
spktShaft_H = TwoDextrude1 ? (OuterCyl_H + 0.5*RunnerCyl_H) : (-0.5*RunnerCyl_H);
// ASSUMPTION: sprockets are centered on this area
// ** TODO Adjust as runner width reduced so does NOT touch film frame area!!!

//film drive sprockets, by default dir of cyl is "up Z axis" ... 3rd param
	color("red")
	for ( i = [0 : 1 : numSprockets-1 ] )
	{
	   rotate( [90, 0, i * 360 / numSprockets])
	   translate([0,
                    spktShaft_H,
                    RunnerCyl_R + spkt_H/2  // set sprockets at this radius. + spkt_H/2 as drawn with "center = true".
                    ])
        sprocket(spkt_H, spkt_W, spktCorner_R, spkt_L);	}

