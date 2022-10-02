if(choosing)
{
	x = mouse_x - _deltaX;
	y = mouse_y - _deltaY;
	_choosingTime++;
}
if(_moving)
{
	if(point_distance(x,y,_targetX,_targetY)<=speed) {
		_moving = false;
		speed = 0;
		x = _targetX;
		y = _targetY;
	}
}
if(_destorying)
{
	image_alpha -= 0.025;
	if(image_alpha<=0) instance_destroy();
}