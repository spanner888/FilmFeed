//motor shaft hole

// hopefully sizes are mm!!
shaft_R = 6.5/2;

CoreCyl_H = 10;
CoreCyl_R = 4;

RunnerCyl_H = 3;
RunnerCyl_R = 5;

OuterCyl_H = 2;
OuterCyl_R = 6;

numSprockets = 8;

	union()
{
		cylinder(h = CoreCyl_H, r = CoreCyl_R, $fn=100);

       	  	// step up .. film runs on these two cylinders
              translate ([0,0,CoreCyl_H]) cylinder(h = RunnerCyl_H, r = RunnerCyl_R, $fn=100);
              translate ([0,0,-RunnerCyl_H]) cylinder(h = RunnerCyl_H, r = RunnerCyl_R, $fn=100);
       
              //Outer edges - contain film 
              //... should these have slight slope - ie thinner at top edges?
              translate ([0,0,CoreCyl_H + RunnerCyl_H]) cylinder(h = OuterCyl_H, r = OuterCyl_R, $fn=100);
              translate ([0,0,-(RunnerCyl_H + OuterCyl_H)]) cylinder(h = OuterCyl_H, r = OuterCyl_R, $fn=100);
      	}

//Central core cylinder - shaft hole
//difference() 
{
//     cylinder (h = CoreCyl_H, r = shaftD, center = true, $fn=100);
}



for ( i = [0 : 1 : numSprockets-1 ] )
{
//    rotate( i * 360 / numSprockets, [1, 1, 0])
//   translate([0, 10, 0])
//   cylinder(r1 = 1.5, r2 = 0.7, h = 5);
}
