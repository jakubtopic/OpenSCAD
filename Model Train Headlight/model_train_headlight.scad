/**
 * Headlight
 * Světlo k mašince
 * @param diameter Průměr světla
 * @param size Délka světla
 * @author Jakub Topič
 */
module headlight() {
    difference() {
        cylinder(d=3,h=2,$fn=100);
        translate([0,0,1.2])
            cylinder(d=2.2,h=2.5,$fn=100);
    }
    translate([-1.5,1.7,0])
        cube([3.0,0.4,1.5]);

    difference() {
        rotate(90)
            translate([.8,-1.5,.0])
                cube([1,.4,1.5]);
        rotate([0,-45,90])
            translate([.8,-1.6,0])
                #cube([1.5,.6,.5]);
    }
    
    difference() {
        rotate(90)
            translate([.8,1.1,0])
                cube([1,.4,1.5]);
        rotate([0,-45,90])
            translate([.8,1,0])
                #cube([1.5,.6,.5]);
    }
    translate([-1.5,0,0])
        cube([3.0,1.8,.5]);
}

headlight();