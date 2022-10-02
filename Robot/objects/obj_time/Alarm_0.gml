if(time>0) {
	time--;
	alarm[0] = room_speed;
} else {
	if(_callback!=undefined) {
		_callback();
		_callback = undefined;
	}
	_show = false;	
}