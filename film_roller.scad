//mounting shaft hole ... Does it have to go ALL the way through??
//... should the INSIDE edges of the outer guide edges have slight slope ?
// - ie thinner at top edges to help film slot in easier.

///////////////////////////////////////////////////////////////////////////////////////////
// Set up thr variables for the size of the roller sub-parts
// hopefully sizes are mm!!
///////////////////////////////////////////////////////////////////////////////////////////
shaft_R = 6.5/2;

CoreCyl_H = 10;
CoreCyl_R = 4;

RunnerCyl_H = 3;
RunnerCyl_R = 5;

OuterCyl_H = 2;
OuterCyl_R = 8;

numSprockets = 8;

///////////////////////////////////////////////////////////////////////////////////////////
// now draw the parts
///////////////////////////////////////////////////////////////////////////////////////////

//Central core cylinder set - shaft hole
difference() {
	//First join all the cylinders into the roller shape
	union(){
		cylinder(h = CoreCyl_H, r = CoreCyl_R, $fn=100);

       	  	// step up .. film runs on these two cylinders
              translate ([0,0,CoreCyl_H]) cylinder(h = RunnerCyl_H, r = RunnerCyl_R, $fn=100);
              translate ([0,0,-RunnerCyl_H]) cylinder(h = RunnerCyl_H, r = RunnerCyl_R, $fn=100);
       
              //Outer edges - contain film 
              translate ([0,0,CoreCyl_H + RunnerCyl_H]) cylinder(h = OuterCyl_H, r = OuterCyl_R, $fn=100);
              translate ([0,0,-(RunnerCyl_H + OuterCyl_H)]) cylinder(h = OuterCyl_H, r = OuterCyl_R, $fn=100);
      	}
	// now difference (subtract) the mounting shaft hole
     translate ([0,0,-(RunnerCyl_H + OuterCyl_H)])
	cylinder (h = (CoreCyl_H + 2*RunnerCyl_H + 2*OuterCyl_H), r = shaft_R, $fn=100);
}



for ( i = [0 : 1 : numSprockets-1 ] )
{
//    rotate( i * 360 / numSprockets, [1, 1, 0])
//   translate([0, 10, 0])
//   cylinder(r1 = 1.5, r2 = 0.7, h = 5);
}
