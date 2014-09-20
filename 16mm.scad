//Sprocket corner radius MUST be less than sprocket width/2, cannot be >=!
// if not sprocket does not get drawn!

/*TO DO
    - review filmSlop - make sure done so that film still fits capstan spokes AND guide wall
    - capstan pos on rollers ... assumed in middle BUT see next
    - roller - film fit - trimmed to keep away from frame => capstan pos!!!!
    - roller radius/circumference/sprockets/film fit
    - sprocket - height, taper, edges.... fit into film perforations!!!!!
*/

//Select ONE of below to set the film size:
Standard_16 = true;
Kodak_16 = true;
BellHowell_16 = true;


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

numSprockets = 8;
SprocketPitch = 7.605;
sprocketEmbed = 0.08;	// because a flat cone base on a cylinder surface would leave a gap,
                        // need to 'embed' sprocket cone into surface to ensure fully mates - no gaps!
                        // ** ADJUST FOR DIF NUMBER OF SPROCKETS .. ie dif roller radius!

//spkt_W = Standard_16? 11.829 : 0;
//else if (filmSize == "Kodak"){
//else if (filmSize == "Bell & Howell"){
// force warnings .. filmSize not set or incorrect value

spkt_W = 1.829;
spkt_L = 1.27;
spktCorner_R = 0.25;
/*
*/

/* Kodak sprocket-perforations
	  spkt_W = 1.981;
	  spkt_L = 2.794;
	  spktCorner_R = 0.51;
*/

spkt_H = 2.2 + sprocketEmbed;		// <<< embedding will reduce actual base size!!!!!
								// hopefully this will give just enough slop for good fit :)

filmWidth = 16;		 // from 16mm standards
frameWidth = 10.26;   // from 16mm standards
filmSlop = 0.2;		 // a little bit of slop - so film does not grab/stick/rub on sides
					 // reduce or REMOVE if add sloping outer walls

RunnerCyl_H = (filmWidth - frameWidth - 0.6)/2;		// -0.6 => film **frame** area NOT touching roller ... so less change of damaging actual picture area in the frame!!!
//RunnerCyl_R = 6;
RunnerCyl_R = (numSprockets*SprocketPitch)/(2*PI);   //3.14159);		//circumfrance = 2*pi*radius

OuterCyl_H = 2;

spktShaft_H_fr = (-0.5*RunnerCyl_H);
spktShaft_H_2D = (OuterCyl_H + 0.5*RunnerCyl_H);
spktShaft_H = (OuterCyl_H + 0.5*RunnerCyl_H);
//spktShaft_H = 0;    //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< all this not yet worked out. just settign to 0 so is obvious ATM!

CoreCyl_H = filmWidth + filmSlop - 2*RunnerCyl_H ;
CoreCyl_R = 4;

OuterCyl_R = RunnerCyl_R + 3;
outerWallSlopeGap = 0.5;        // only used by 2D_extruded_roller code, not by film_roller.scad


shaft_R = 6.5/2;        // motor/stepper shaft radius

fragResolution = 500;   // resolution of individual parts in the 3D model

//just for testing if this file compiles standalone!, .. and it does compile OK!
// add/remove '*' before minkowski() below to skip/run this bit of test code
    *minkowski()
    {
       square([10, 20], center = true, $fn = fragResolution);
       circle(r=3, center = true, $fn = fragResolution);
    }

*import("ruler.stl");    // a ruler so can measure sizes of things ... this one looks imperial!
