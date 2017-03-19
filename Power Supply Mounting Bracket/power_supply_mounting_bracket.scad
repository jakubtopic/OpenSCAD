/**
 * Power Supply Mounting Bracket
 * Default values are intended for a 65W Thinkpad (T420) AC adapter
 * @param  {Number} height           X dimension of the power supply.
 * @param  {Number} width            Z dimension of the power supply.
 * @param  {Number} length           Y dimension of the power supply.
 *                                   to be covered by brackets.
 * @param  {Number} baseHeight       Height of the base.
 * @param  {Number} baseOffset       Padding of the base.
 * @param  {Number} bracketThickness Thickness of brackets.
 * @param  {Number} screwDiameter    Diameter of screw holes.
 * @param  {Number} rounded          Radius of the rounded edges.
 * @author Jakub Topič
 */
module powerSupplyBracket (
		height = 30,
		width = 45,
		length = 105,
		baseHeight = 6,
		baseOffset = 10,
		bracketThickness = 5,
		screwDiameter = 2.5,
		rounded = 1.5) {
	module bracket(w, r, h, b, e) {
		w = w + r;
		cube([b,4*b,w+2*b]);
		if(!e)cube([2*b,b,w+2*b]);
		cube([h/2+b,b,b+r]);
		translate([0,0,w+b])
			cube([2*b,4*b,b]);
	}

	module base(x, y, z, offset, thickness, r=1.5) {
		difference() {
			minkowski() {
				translate([r,r,0])
					cube(size=[x+2*(thickness+offset-r),y-3,z-r], center=false);
				sphere(r=r, $fn=PI*r*20);

			}
			translate([0,0,-1.5])
				cube([height+2*(offset+thickness),3+length,r]);
		}
	}

	module screwHole(h, d, angle=35, offset=.5) {
		r = d/2;
		cylinder(h=h, d=d, center=false, $fn=PI*d*10);
		translate([0,0,h-offset])
			cylinder(h=offset, r1=r, r2=r+offset/tan(angle), center=false,
				$fn=PI*d*10);
	}


	//length = length * 0.85;

	offset = ((length-bracketThickness) % (4*bracketThickness))/
		floor((length - bracketThickness)/(4*bracketThickness));

	difference() {
		base(height, length, baseHeight, baseOffset, bracketThickness, rounded);
		// Inner holes	

		iterator = 1;
		for(x = [bracketThickness:4*bracketThickness:length-4*bracketThickness]) {
			translate([
					baseOffset + bracketThickness,
					x+iterator * offset + 0.2 * bracketThickness,
					0])
				cube(size=[height,2.6*bracketThickness,baseHeight], center=false);
			iterator = iterator + 1;
		}


		// Screw holes
		for(i = [0:1], j = [1:3:4]){
			translate([
					i*(height+baseOffset+2*bracketThickness)+baseOffset/2,
					j*length/5,0])
				screwHole(baseHeight, screwDiameter);
		}
	}

	iterator = 1;
	for(x = [offset + 4.0 * bracketThickness:4*bracketThickness:length-4*bracketThickness]) {
		translate([height/4+baseOffset+bracketThickness,x,baseHeight])
			cube(size=[height/2,bracketThickness,bracketThickness]);
		iterator = iterator + 1;
	}
		

	// bracket
	for(i = [0:1], j = [0:1])
		translate([
				baseOffset + i*(height+2*bracketThickness),
				j*length,
				baseHeight - rounded])
			mirror([0,j,0])
			mirror([i,0,0])
				bracket(width, rounded, height, bracketThickness, j);
}

powerSupplyBracket (
	height = 30,
	width = 45, 
	length = 85, //105
	baseHeight = 6,
	baseOffset = 10,
	bracketThickness = 5,
	screwDiameter = 2.5,
	rounded = 1.5);