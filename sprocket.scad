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

///////////////////////////////////////////////////////////////////////////////////////////
// now draw the parts
///////////////////////////////////////////////////////////////////////////////////////////
$fn = fragResolution;

// Module to draw ONE sprocket
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


// Now draw Aa ring of ALL the sprockets in final position
//film drive sprockets, by default dir of cyl is "up Z axis" ... 3rd param
module sprocketRing(shaft_H, s_height, s_W, sCorner_R, s_L){
	color("red")
	for ( i = [0 : 1 : numSprockets-1 ] )
	{
	   rotate( [90, 0, i * 360 / numSprockets])
	   translate([0,
                    shaft_H,
                    RunnerCyl_R + spkt_H/2 - sprocketEmbed // set sprockets at this radius. + spkt_H/2 as drawn with "center = true".
                    ])
        sprocket(s_height, s_W, sCorner_R, s_L);
    }
}


