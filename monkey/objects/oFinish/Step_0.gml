// Collision for Finish Object (when you hit the finish, takes you to new room) 
if(place_meeting(x,y, oPlayer))
{
	room_goto(rm_Level2);	
}
