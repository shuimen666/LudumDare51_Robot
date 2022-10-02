if(_moving)
{
	if(abs(camera_get_view_y(_camera)-_targetY)<=abs(_speed)) {
		_moving = false;
		_speed = 0;
		if(_callback!=undefined) {
			_callback();
			_callback = undefined;
		}
		camera_set_view_pos(_camera,_targetX,_targetY);
	}
	else {
		camera_set_view_pos(_camera,camera_get_view_x(_camera),camera_get_view_y(_camera)+_speed);	
	}
}