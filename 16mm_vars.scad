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
*/

// There are no checks to see if sizes make sense. eg you can make core roller smaller than the shaft hole etc.

//Sprocket corner radius MUST be less than sprocket width/2, cannot be >=!
// if not sprocket does not get drawn!

/*TO DO
    - review filmSlop - make sure done so that film still fits capstan spokes AND guide wall
    - capstan position on rollers ... assumed in middle BUT see next
    - roller radius/circumference/sprockets/film fit
    - sprocket - height, taper, edges.... fit into film perforations!!!!!
>>>** sprocket-pitch	7.605 OR 7.620
    - PRINT AND TEST!!!

    - work out how to do 8/16/35/.... sizes AND all the variations (eg 16/ultra etc & dif sprockets...)
    ... simplest is just sep include for each
       esp now only ONE include for this file!
       THIS IS **NOT** IDEAL WAY TO DO THIS
       as changes common vars/calculations need to be updated in each file....

       possibly simplify by
        - adding sep include files for dif sprockets
        - relying on openSCAD compile behaviour for vars - eg do not have to define in order, and declare order is OK!
        so then sprocket includes move easily to main code
        calcs also move easliy into sep file
        .... so ONLY vars that change with film size in THESE includes
        .... or if have to calc for a specific film size

    Until these are done, designs below might help you:
        Super 8 Transport roll - Fits on a 4mm axis 	http://www.thingiverse.com/thing:180151
        35mm film gear - intermittent sprocket	http://www.thingiverse.com/thing:6324
        35mm film spool (variable sprockets)	http://www.thingiverse.com/thing:28236
    .. or you could find relevant film specs and adjust variables here.
*/


///////////////////////////////////////////////////////////////////////////////////////////
// Variables for size of roller sub-parts
// hopefully sizes are mm!!
// http://forum.openscad.org/unit-of-measure-td1316.html
//  STL files are unit less, so all models transferred via STL only have implied units, regardless of the modelling package. Reprap generally assumes they are millimeters, but some hosts allow the object to be scaled for STLs in inches.
//       ... so .scad also unitless???
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

//CUSTOMIZER VARIABLES

// Number of sprockets
numSprockets = 8;

// Distance between sprockets
SprocketPitch = 7.605;

// Embed base of sprockets into roller - so no air gap
sprocketEmbed = 0.08;	// because a flat cone base on a cylinder surface would leave a gap,
                        // need to 'embed' sprocket cone into surface to ensure fully mates - no gaps!
                        // ** ADJUST FOR DIF NUMBER OF SPROCKETS .. ie dif roller radius!

// std 16mm sprocket-perforations
// Width
spkt_W = 1.829;
// Length
spkt_L = 1.27;
//Corner radius
spktCorner_R = 0.25;


spkt_H = 2.2 + sprocketEmbed;		// <<< embedding will reduce actual base size!!!!!
								// hopefully this will give just enough slop for good fit :)

//Film width
filmWidth = 16;		 // from 16mm standards

// Film frame width
frameWidth = 10.26;  // from 16mm standards

// bit of slop - so film does not grab/stick/rub on sides of roller walls
filmSlop = 0.2;		 // a little bit of slop - so film does not grab/stick/rub on sides
					 // reduce or REMOVE if add sloping outer walls

// film **frame** area NOT touching roller ... so less change of damaging actual picture area in the frame!!!
frameGap = 0.3;

// RunnerCyl_H is left at it's full nominal height
// frameGap is NOT subtracted here, relevant drawing methods adjust for filmGap as required.
// This way sprockets are easier to put in the nominal middle of the film roller area!
RunnerCyl_H = (filmWidth - frameWidth - frameGap)/2;		// -frameGap => film **frame** area NOT touching roller ... so less change of damaging actual picture area in the frame!!!
RunnerCyl_R = (numSprockets*SprocketPitch)/(2*PI);          //circumference = 2*pi*radius


// max outer wall thickness, excluding any inner tapering to stop film grabbing on walls
OuterCyl_H = 2;

// Set position along shaft according to in.exclusion of outGuideWalls
// addOuterGuideEdges is set true/false in FilmMain.scad.... or your code.
// Assume sprockets in center of roller area - DO NOT adjust for frameGap!!
spktShaft_H = addOuterGuideEdges ? (OuterCyl_H + RunnerCyl_H/2) : RunnerCyl_H/2;

CoreCyl_H = filmWidth + filmSlop - 2*RunnerCyl_H ;

// Core cylinder radius (includes motor shaft radius!)
CoreCyl_R = 4;

// motor/stepper shaft radius. Must be less than CoreCyl_R!
shaft_R = 6.5/2;        // motor/stepper shaft radius

OuterCyl_R = RunnerCyl_R + 3;

// Slope inner roller wall, avoid film edges grabbing. Only used by 2D_extruded_roller code, not by film_roller.scad
outerWallSlopeGap = 0.5;


// resolution of individual parts in the 3D model
fragResolution = 500;
