time = 0;
_show = false;
_callback = undefined;
endTime = 0;

function setTime(num, callback)
{
	time = num;
	_show = true;
	if(callback!=undefined) _callback = callback;
	alarm[0] = room_speed;
}
function setEndTime(num)
{
	endTime = num;	
}