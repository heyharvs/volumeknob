$fn = 30;

stick_diameter = 6;
stick_flat_height = 1.5;
stick_height = 4.5;
stick_buffer = 1;

height = 12.6;
top = 7;
bottom = 9;
ridges = 7;
flatten = 4;
round = 5;

ridge_height = 6;
ridge_size = .25;
ridge_roundness = .25;
ridge_top_offset = 2;

module knob_cutout() {
difference() {
translate([0, 0, stick_height / 2]) {
cylinder(stick_height, stick_diameter / 2, stick_diameter / 2, true);
}

translate([0, -stick_diameter + stick_flat_height, stick_height / 2]) {

    cube([stick_diameter, stick_diameter, stick_height + stick_buffer * 2], true);
}
}
}
module knob() {
    difference() {
        minkowski() {
            translate([0, 0, (height + round / 2) / 2 - round / 2]) {
                cylinder(height - round / 2, bottom / 2 - round / 2, top / 2 - round / 2, true);
            }
            sphere(round / 2, true);
        }

        translate([0, 0, -(height / 2)]) {
            cube([height, height, height], true);
        }
        knob_cutout();
    }
}

module ridge() {
    translate([3.5, 0, stick_height + 2]) {
        rotate([0, -6, 0]) {
            minkowski() {
                cylinder(ridge_height, ridge_size, ridge_size, true);
                sphere(ridge_roundness, true);
            }
        }
    }
}


knob();

// add ridges and rotate
for (a = [0: ridges - 1]) {
    rotate([0, 0, 360 / ridges * a]) {
        ridge();
    }
}

