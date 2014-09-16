
//corner radius MUST be less than sprocket width/2, cannot be >=!

// ???? do variable persist across files????
addSprockets = true;    //false;   //true;

/* TODO
sprckets seem OK... just get heigth OK.

normalise teh rollers - make modules.
display ALL variations in SAME display
then adjust heights......
*/


include <16mm.scad>
include <sprocket.scad>

module t1(s_Hh, s_Ww, sCorner_Rr, s_Ll){
    sprocket(s_Hh, s_Ww, sCorner_Rr, s_Ll);
}
module sRing(s_Hhh, s_Www, sCorner_Rrr, s_Lll){
    sprocketRing(s_Hhh, s_Www, sCorner_Rrr, s_Lll);
}


if (addSprockets) {
	color("blue")
    sRing(6, 4, 1, 3);
    }
else {
    color ("yellow")
    t1(4, 10, 2, 6);
}

	color("green")
   translate([0,
                10,
                0
                ])
    t1(30, 18, 2, 5);

    color ("purple")
   translate([0,
                30,
                0
                ])
    t1(4, 9, 0.2, 6);

	color("red")
   translate([0,
                10,
                0
                ])
    t1(22, 8, 1, 8);


