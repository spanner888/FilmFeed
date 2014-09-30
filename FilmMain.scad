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

//Select which parts to display
addSprockets = true;
addOuterGuideEdges = true;

// Pick ONE of these to match film-SMD size you require
include <16mm_vars.scad>
//include <16mmKodak_vars.scad>
// ... more to come eg 8mm, 35mm

// these files draw the dif parts
include <sprocket.scad>
include <film_roller.scad>
include <2D_extruded_roller.scad>

// Add one 2D_extrude_roller at offset to the "right"
if (addSprockets) {
    color("orange")
    translate([0,28,0])
    TwoDExtrudeRoller(addOuterGuideEdges);
    translate([0,28,0])
    color("green")
    if (addOuterGuideEdges) {
        sprocketRing(OuterCyl_H + RunnerCyl_H/2, spkt_H, spkt_W, spktCorner_R, spkt_L);
    }
    else{
        sprocketRing(RunnerCyl_H/2, spkt_H, spkt_W, spktCorner_R, spkt_L);
    }
}
else {
    color("brown")
    translate([0,55,0])
    TwoDExtrudeRoller(addOuterGuideEdges);
}

// Add ONE film_roller - created from cylinders
if (addSprockets) {
    if (addOuterGuideEdges) {
        sprocketRing(OuterCyl_H + RunnerCyl_H/2, spkt_H, spkt_W, spktCorner_R, spkt_L);
    }
    else{
        sprocketRing(RunnerCyl_H/2, spkt_H, spkt_W, spktCorner_R, spkt_L);
    }
}
color("silver")
film_roller(addOuterGuideEdges);

