// changes here are NOT automatically compiled/reloaded. Need to press F5 in main app!

//*** ASSUMPTION: SPROCKETS ARE IN CENTER OF RUNNER!!!!!!!!

//?? XCJ/dif 3D printer resolution => on design/capability!!!!!


/* mounting shaft hole
	... Does it have to go ALL the way through??
 	... add a flat spot to mate with shaft?
	?? adjust hole size for tightish fit on shaft?????????
*/

//... should the INSIDE edges of the outer guide edges have slight slope ?
// - ie thinner at top edges to help film slot in easier.
// ... or at LEAST a rounded top edge?
/* see Extruding a Polygon

Extrusion can also be performed on polygons with points chosen by the user.

Here is a simple polygon and its (fine-grained: $fn=200) rotational extrusion (profile and lathe). (Note it has been rotated 90 degrees to show how the rotation will look, the rotate_extrude() needs it flat).

rotate([90,0,0])        polygon( points=[[0,0],[2,1],[1,2],[1,3],[3,4],[0,5]] );
// --------------------------------------------------------------------------- ;
rotate_extrude($fn=200) polygon( points=[[0,0],[2,1],[1,2],[1,3],[3,4],[0,5]] );
*/


// ** b&h - non-sprocket side RunnerCyl film surface slopes INWARDS!!!

/* how to MEASURE/VALIDATE sizes before creating/printing?
Getting input

  Now we have variables, it would be nice to be able to get input into them instead of setting the values from code.
  There are a few functions to read data from DXF files, or you can set a variable with the -D switch on the command line.
  Getting a point from a drawing
  Getting a point is useful for reading an origin point in a 2D view in a technical drawing.
  The function dxf_cross will read the intersection of two lines on a layer you specify and return the intersection point.
  This means that the point must be given with two lines in the DXF file, and not a point entity.
  OriginPoint = dxf_cross(file="drawing.dxf", layer="SCAD.Origin",
			  origin=[0, 0], scale=1);
  Getting a dimension value
  You can read dimensions from a technical drawing. This can be useful to read a rotation angle, an extrusion height, or spacing between parts. In the drawing, create a dimension that does not show the dimension value, but an identifier. To read the value, you specify this identifier from your script:
  TotalWidth = dxf_dim(file="drawing.dxf", name="TotalWidth",
			  layer="SCAD.Origin", origin=[0, 0], scale=1);

  For a nice example of both functions, see Example009 and the image on the homepage of OpenSCAD.
*/
/*******************************************************************************
*** RunnerCyl_R IS CRITICAL - SETS SPROCKET SPACING = FRAME PERF SPACING!!!!
?? CALC FROM DIAMETER = numSprockets*Sprocket-pitch, SO RADIUS = numSprockets*Sprocket-pitch/2&pi

*******************************************************************************/


// draws the film roller based on pre-selected film standard size, #sprockets...
// OuterGuideEdges are optional
// sprockets are controlled in same file/drawing that also uses this module.
module film_roller(includeOuterGuideEdges = true){
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
}


