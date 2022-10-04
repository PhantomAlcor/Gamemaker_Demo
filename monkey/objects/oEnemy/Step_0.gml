// Enemy Movement //
hsp = dir * movespeed; // Determines which direction to move enemy
vsp += grv; // Acceleration of enemy when they fall

// Enemy Collision to Walls //
//Horizontal Collision
if (place_meeting(x+hsp,y,oWall))
{
	while (!place_meeting(x+sign(hsp),y,oWall))
	{
		x = x + sign(hsp);
	}
	hsp = 0;
	
	dir *= -1; // Makes enemy move the opposite direction when hitting a wall
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

