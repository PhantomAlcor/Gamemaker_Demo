/// Happens every frame ///
speed = 0;
//Resets speed so move_towards_point doesn't send player to the shadow realm. 
//Try removing this and see what happens.
image_index = 0;
key_left = keyboard_check(vk_left); //Checks if left key is being pressed
key_right = keyboard_check(vk_right); //Checks if right  key is being pressed
key_jump = keyboard_check_pressed(vk_space); //Checks if space is being pressed
key_jump_held = keyboard_check(vk_space); //Keeps checking for how long space bar is being pressed
key_run = keyboard_check(vk_shift); // Checks if shift key is being pressed
allottime = 900; //Time between each checkpoint. Divide by 60 for "seconds"

vsp = vsp + grv;

if (stop <= 40) { //Causes player to freeze if they hit an enemy.

// Calculate movement
	var move = key_right - key_left; // Shows if left or right key is being pressed
	hsp = move * walksp;

	// Running
	if (key_run) 
	{
		hsp = move * runvsp;
		image_index = 2;
	}

	// Jumping //
	if (place_meeting(x,y+1,oWall)) and (key_jump) // Checks if oPlayer is on the floor
	{
		vsp = -6;
		jumpspr = 1; //Activates the jump sprite
	}
	
	if (jumpspr == 1)
	{
		if (place_meeting(x,y+vsp,oWall))
		{
			jumpspr = 0; //When the player isnt jumping, turn off jumping sprite.	
		} else {
			show_debug_message("Jump")
			image_index = 1; //Otherwise, make the player have jumping sprite
		}
	}
	
	
	// Variable Jumping
	if (vsp < 0) and (!key_jump_held)
	{
		vsp = max(vsp, -2); //Stops vertical motion if space key isnt being held
	}
	
} else {
	hsp = 0;
	
}

if (stop > 0) {
	stop -= 1;
	if (invframe > 0) {
		invframe -= 1;	
	} else {
		if (visible) {
			visible = false;	
		} else {
			visible = true;	
		}
	}
}

//Horizontal Collision
if (place_meeting(x+hsp,y,oWall))
{
	while (!place_meeting(x+sign(hsp),y,oWall))
	{
		x = x + sign(hsp);
	}
	hsp = 0;
}
x = x + hsp; 

//Vertical Collision
if (place_meeting(x,y+vsp,oWall))
{
	while (!place_meeting(x,y+sign(vsp),oWall))
	{
		y = y + sign(vsp);
	}
	vsp = 0;
}
y = y + vsp; 
 
// Timer  
if (keyboard_check(ord("R"))) { //If the player presses r
	timer = allottime;
	move_towards_point(startcheckx,startchecky,point_distance(x,y,startcheckx,startchecky));
	//Move the player back to the start
}
if (keyboard_check(ord("C"))) { //If the player presses c
	timer = allottime;
	//Makes the timer run out so the player moves to the previous checkpoint
}

if (timer < allottime)  //Acts as timer in between checkpoints
{
	timer += 1; //Increments the timer by 1
} else {
	move_towards_point(checkx,checky,point_distance(x,y,checkx,checky));
	//If the timer runs out, move the player to the previous checkpoint.
	timer = 0;
	//Then resets the timer
}

if(place_meeting(x,y,oCheckpoint)) { //If player is touching a checkpoint
	timer = 0; //Resets timee at checkpoint
	checkx = x; //Sets x checkpoint position
	checky = y; //Sets y checkpoint position
}

if(place_meeting(x,y,oEnemy)) and (stop == 0) { //Detects when player touches enemy, with invincibility frames.
	stop = 240;	
}

