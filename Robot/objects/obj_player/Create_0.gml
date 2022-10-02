event_inherited();
unitFactor = "player";


function inList(object_)
{
	for(var i=0;i<array_length(queue);i++) {
		if(queue[i]==object_) return i;	
	}
	return -1;
}
function getListPos(index) {
	var gap = 24;
	var size = array_length(queue);
	var width = sprite_get_width(spr_actions)
	if(size%2==1) {
		var middle = (size-1)/2;
		return obj_sendbar.x+(index-middle)*(gap+width);
	} else {
		var middle = size/2;
		return obj_sendbar.x+(width+gap)/2+(index-middle)*(gap+width);
	}
}