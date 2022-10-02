if(_moving)
{
	if(point_distance(x,y,_targetX,_targetY)<=speed) {
		_moving = false;
		speed = 0;
		x = _targetX;
		y = _targetY;
		if(_callback!=undefined) {
			_callback();
			_callback = undefined;
		}
	}
}
if(_hurting>0) {
	if(_hurting%2==1) image_alpha -= 0.1;
	else image_alpha += 0.1;
}