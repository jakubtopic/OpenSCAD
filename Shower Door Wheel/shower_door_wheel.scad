module toroid(radius, distance) {
    rotate_extrude(convexity = 10)
        difference() {
            translate([distance, 0, 0])
                circle(r=radius);
            translate([-radius/2,0])
                square([radius,2*radius], center=true);
        }
}

module wheel(height, d1, d2 = 0, holeDiameter) {
    difference() {
        if(d2 == 0) {
            cylinder(d=d1, h=height, center=false);
        } else {
            h = (d1 - d2)/2;
            r = (pow(height,2))/(8*h) + h/2;

            difference() {
                translate([0,0,height/2])
                    union() {
                        toroid(r, d1/2 - r);
                        cylinder(d=d2, height=height, center=true);
                    }

                translate([0, 0, height])
                    cylinder(h=r - (height/2), d=d2, center=false);

                translate([0, 0, -r + height/2])
                    cylinder(h=r - (height/2), d=d2, center=false);
            }
        }

        // Hole
        cylinder(d=holeDiameter, h=height);
    }
}

wheel(5, 21, 20, 8.5, $fn=1000);

translate([0,0,4])
    wheel(height=3.5, d1=8.5, holeDiameter=4.5, $fn=100);
