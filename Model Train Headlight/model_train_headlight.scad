difference() {
    cylinder(d=30,h=20);
    translate([0,0,12])
        cylinder(d=26,h=25);
}
translate([-15,17,0])
    cube([30,2,15]);


rotate(45)
    translate([-15,2,0])
        cube([20,2,15]);