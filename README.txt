What is this thing?
    Guide roller for common film formats and also for SMD component tape feed.
    Optional outer guide walls and sprocket teeth.
    Adjustable features: guide wall slopes, number of sprockets, sprocket slopes & height....

Ultimate goal:
    Create generic design to suit all the different 8, 16, 35, .... film formats
    AND even SMD tape (16mm seems fit as is, but is likely to need tweaking for more reliable feeding!)

Current status:
    2014-09-14. Untested work in progress for 16mm film.
    Can already simply adjust features. Structure in place to easily switch to other formats.
    Just need data entry & testing for the other formats.

    -------------------------------------------------------------------------------------------------
USAGE:
	To select your desired film size:
		include your desired XXX_vars.scad file in "FilmMain.scad" or your own code.
        AND  make sure that NO other include remain for other film sizes!
 		to match your desired film size (see "Current Status" for available sizes)
		For example for 16mm "standard" film:
			include <16mm_vars.scad>	// all the variables for part sizes!
		For example for 16mm "Kodak" film:
			include <16mmK_vars.scad>	// all the variables for part sizes!

	To add/remove outer guide walls or sprockets, in "2D_extruded_roller.scad" or "film_roller.scad":
        //Select which parts to display
        addSprockets = true;
        addOuterGuideEdges = false;

	To adjust individual features - edit the configuration file matching your chosen film size, eg "16mm.scad".
	Many features are calculated from basic parameters.
	For example the number of sprockets and the frame height combine to set the roller circumference and thus the radius.

	All the openSCAD source files must all be in same directory.
	Open "FilmMain.scad" in openSCAD then compile as usual.
	"FilmMain.scad" shows how to display one of each type of roller/capstan and in/exclude outer guide edges and sprockets.
    -------------------------------------------------------------------------------------------------

Other notes:
    - If sprockets are floating unattached out of position, refer to USAGE notes above on selecting roller drawing type.
    - Also zoom in a LOT to check sprockets are properly embedded in roller and do not have edge gaps, or conversely embedded to deep.
        If they do, adjust sprocketEmbed parameter.
	- film_roller.scad - does not have sloping inner edge on outer guide walls.

TO DO:
    - finish parameters for all formats 8, 16, 35, .... film formats & SMD
    - add option to make one/both outer edges a cog - expect this will help driving stack of multiple SMD rollers
        ... or 'down' on the shaft - ie add extra cylinder that is also cog.  (Less preferred as would make each roller fatter  - takes more space!)
    - Sprockets - Currently 2 per frame, at frame edges. Cater for more/less per frame and different positions.
        ... sprockets on one/both sides.....
    - create the physical objects and test
    - plus more TO DO in code

License:


