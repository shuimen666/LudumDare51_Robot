if(!global.choosing&&global.gameState==GameState.SEND)
{
	choosing = true;
	global.choosing = true;
	global.choosingObject = id;
	_deltaX = mouse_x - x;
	_deltaY = mouse_y - y;
	_choosingTime = 0;
	_lastX = x;
	_lastY = y;
}
if(sprite_index!=noone) {
	obj_show_desc.set(conf[$"image"], conf[$"desc"]);
}