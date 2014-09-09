//motor shaft hole

// hopefully sizes are mm!!
shaftD = 3;//6.5;

CoreCylH = 18;
CoreCylD = 8;

RunnerCylH = 3;
RunnerCylD = 13;

OuterCylH = 2;
OuterCylD = 12;

numSprockets = 8;

		cylinder(h = CoreCylH, d=CoreCylD, center = true, $fn=100);

       	  	// step up .. film runs on these two cylinders
              translate ([0,0,CoreCylH/2]){cylinder(h = RunnerCylH, d = RunnerCylD};

	union(){
       
              //Outer edges - contain film 
              //... should these have slight slope - ie thinner at top edges?
             // translate ([0,0,CoreCylH + RunnerCylH]){cylinder(h = OuterCylH, d=OuterCylD)};
              //translate ([0,0,-(RunnerCylH + OuterCylH)]){cylinder(h = OuterCylH, d=OuterCylD)};
      	}

//Central core cylinder - shaft hole
difference() {
//     cylinder (h = CoreCylH, d=shaftD, center = true, $fn=100);
}



for ( i = [0 : 1 : numSprockets-1 ] )
{
//    rotate( i * 360 / numSprockets, [1, 1, 0])
   translate([0, 10, 0])
   cylinder(r1 = 1.5, r2 = 0.7, h = 5);
}
