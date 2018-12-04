include <arduino.scad>
//include <flexbatt/flexbatter.scad>

$fa=1;  //set 1 degree per arc-segment. smaller means more accurate cylinders and circles
$fs=0.1; // minimum size of a fragment. Makes small circles and cylinders more accurate

module screen_mount(outer_D = 6, inner_D = 2.5, height = 5) {    
  linear_extrude(height = height, center = true) difference () {
    circle(r=outer_D/2);
    circle(r=inner_D/2);
  }
}

//Arduino boards
//You can create a boxed out version of a variety of boards by calling the arduino() module
//The default board for all functions is the Uno
split = 20;
mountingHoleRadius = 1.6 / 2;
myboardoffset = 40;
wall = 3;
arduino_posx = 20;
arduino_posy = -myboardoffset+wall;
screen_h = 40;
screen_l = 97;

screen_screw_posz = - wall -1;
screen_screw_h = 55;
screen_screw_l = 93;
screen_screw_H = 5;
screen_screw_ID= 2.5;
screen_screw_D = 6;
screen_pos_x = 0;
screen_pos_y = 21;
rotate_screen = 0;

//battery_hold_posx = myboardoffset/2-10; 
//battery_hold_posy = -myboardoffset/2+40;
rotate_hold = -90;

hole_lid_pos_x = 40;
hole_lid_pos_y = -25;
hole_lid_n = 4;
hole_lid_space = 30;
hole_lid_d = 7.5;

/* front enclosure hole */
hole_enc_front_posx = -30;
hole_enc_front_posz = 10;
hole_enc_front_n = 2;
hole_enc_front_space = 45;
hole_enc_front_H = 8;
hole_enc_front_L = 29;

/* back enclosure hole */
hole_enc_back_posx = -30;
hole_enc_back_n = 1;
hole_enc_back_space = 30;
hole_enc_back_H = 10;
hole_enc_back_L = 15;

dueDimensions = boardDimensions( DUE );
unoDimensions = boardDimensions( UNO );

top = true;
bottom = true;

//Board mockups
//arduino(NANO, posx = myboardoffset-wall, posy = -myboardoffset+1);

if (bottom == true) {

translate([0, 0, -1*split]) {
    union () {
      //translate([battery_hold_posx,battery_hold_posy,wall]) rotate([0,0,rotate_hold]) customizer();
      difference() {
	    enclosure(boardType = NANO, wall = wall, offset = myboardoffset, heightExtension = 10, mountType = TAPHOLE, assembly=ASSEMBLY_SCREW, posx = arduino_posx, posy = arduino_posy);
        union () {
            for( i = [0:hole_enc_front_n - 1] ){
              translate ([hole_enc_front_posx + i *hole_enc_front_space,myboardoffset*2,hole_enc_front_posz]) cube([hole_enc_front_L, 10, hole_enc_front_H]);
            }
            for( i = [0:hole_enc_back_n - 1] ){
              translate ([hole_enc_back_posx + i *hole_enc_back_space,-myboardoffset-2*wall,hole_enc_front_posz]) cube([hole_enc_back_L, 10, hole_enc_back_H]);
            }
        }
     }
  }
}
}

if (top == true) {

translate([0, 0, 1*split]) rotate([0,0,0]) union() {
    
    difference() {
		enclosureLid(NANO, offset = myboardoffset, mountType=TAPHOLE, assembly=ASSEMBLY_SCREW);
        // Screen Hole
        translate([screen_pos_x,screen_pos_y,0]) rotate([0,0,rotate_screen]) linear_extrude(height = 10, center = true, convexity = 10, twist = 0) polygon(points=[[-screen_h/2,-screen_l/2],[-screen_h/2,screen_l/2],[screen_h/2,screen_l/2],[screen_h/2,-screen_l/2]]);
        // Connector holes on LID
        for( i = [0:hole_lid_n - 1] ){
          translate([hole_lid_pos_x,hole_lid_pos_y + i * hole_lid_space,0]) rotate([0,0,rotate_screen]) linear_extrude(height = 10, center = true, convexity = 10, twist = 0) circle (r = hole_lid_d/2);
        }
    };
    
    // Screen screws
    translate ([0,0,screen_screw_posz]) union () {
    translate([screen_pos_x - screen_screw_h/2,screen_pos_y - screen_screw_l/2,0]) rotate([0,0,rotate_screen]) 
      screen_mount(outer_D = screen_screw_D, inner_D=screen_screw_ID, height= screen_screw_H);
    translate([screen_pos_x - screen_screw_h/2,screen_pos_y + screen_screw_l/2,0]) rotate([0,0,rotate_screen]) 
      screen_mount(outer_D = screen_screw_D, inner_D=screen_screw_ID, height= screen_screw_H);
    translate([screen_pos_x + screen_screw_h/2,screen_pos_y - screen_screw_l/2,0]) rotate([0,0,rotate_screen]) 
      screen_mount(outer_D = screen_screw_D, inner_D=screen_screw_ID, height= screen_screw_H);
    translate([screen_pos_x + screen_screw_h/2,screen_pos_y + screen_screw_l/2,0]) rotate([0,0,rotate_screen]) 
      screen_mount(outer_D = screen_screw_D, inner_D=screen_screw_ID, height= screen_screw_H);
    }
    
}

}





