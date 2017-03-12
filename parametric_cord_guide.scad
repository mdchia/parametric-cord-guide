// Parametric Cord Guide
// by Ming-Dao Chia

// Use with double sided tape or other sticking mechanism.
// Adjust base width and length, if using with pre-cut
// wall mounting strips.

// *Settings*

// Base width (perpendicular to cord)
// Must be wider than cord
base_width = 10; // in mm

// Base length (parallel to cord)
base_length = 10; // in mm

// Cord diameter (make a bit bigger than the actual cord)
cord_diameter = 5; // in mm

// *Advanced settings*

// Cable holding fraction
// e.g. at 50%, half the cable will be in the slot
cable_holding = 0.15; // fraction (0.5 = 50%)

// Circle resolution (if round bits aren't round enough, increase this)
circle_res = 20; // number of sides of cylinder

// Top rounding offset (more=rounder, must be greater than 0)
top_round_dist = 0.1; // in mm

// end settings

// cube core
module PCG_core(){
    cube([cord_diameter*1.2, base_width, base_length]);
}

// center bit to hold cable
module PCG_center(){
    cylinder(h=base_length+2,r=cord_diameter/2, $fn=circle_res);
}

// rounds off corners
module PCG_corner_smooth(){
    difference(){
        cube([cord_diameter,cord_diameter,base_length+2]);
        translate([cord_diameter/2,cord_diameter/2,-1])
        cylinder(h=base_length+4,r=cord_diameter/2, $fn=circle_res);
        translate([-1,cord_diameter/2,-1])
        cube([cord_diameter+2,cord_diameter,base_length+4]);
        translate([cord_diameter/2,-1,-1])
        cube([cord_diameter,cord_diameter+2,base_length+4]);
    }
}

// bring everything together
module PCordGuide(){
    difference(){
        PCG_core();
        translate([cord_diameter/2-cord_diameter*cable_holding,base_width/2,-1])
        PCG_center();
        translate([-top_round_dist,-top_round_dist,-1])
        PCG_corner_smooth();
        mirror([0,1,0])
        translate([-top_round_dist,-(base_width+top_round_dist),-1])
        PCG_corner_smooth();
    }
}

PCordGuide();