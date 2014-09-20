//Select which parts to display
addSprockets = true;
addOuterGuideEdges = true;

// Pick ONE of these to match film-SMD size you require
include <16mm_vars.scad>
//include <16mmK_vars.scad>
// ... more to come eg 8mm, 35mm

// these files draw the dif parts
include <sprocket.scad>
include <film_roller.scad>
include <2D_extruded_roller.scad>

// Add one 2D_extrude_roller at offset to the "right"
if (addSprockets) {
    color("orange")
    translate([0,20,0])
    TwoDExtrudeRoller(addOuterGuideEdges);
    translate([0,20,0])
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

// Add ONE film_roller
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


*import("ruler.stl");    // a ruler so can measure sizes of things ... this one looks imperial!
