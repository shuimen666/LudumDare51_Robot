height = 128;
list = [];

function inList(object_)
{
	for(var i=0;i<array_length(list);i++) {
		if(list[i]==object_) return i;	
	}
	return -1;
}
function inRange(oy) {
	return oy>=y-height/2 && oy<=y+height/2;
}
function elementChange(object_)
{
	if(object_.inGroup) obj_container.deleteFromGroup(object_);
	if(inList(object_)>-1) array_delete(list,inList(object_),1);
	var ox = object_.x;
	var pos = inRange(object_.y) ? 0 : array_length(list);
	for(var i=pos;i<array_length(list);i++) {
		if(ox>list[i].x)
			pos = i+1;
		else
			break;
	}
	array_insert(list,pos,object_);
	var sum = 0;
	//moveto
	for(var i=0;i<array_length(list);i++) {
		var sp = point_distance(list[i].x,list[i].y,getListPos(i),y)/(0.2*room_speed);
		list[i].moveTo(getListPos(i),y,max(sp,4));
		sum += list[i].cost;
	}
	obj_clock.totalTime = sum;
}
function getListPos(index) {
	var gap = 24;
	var size = array_length(list);
	var width = sprite_get_width(spr_actions)
	if(size%2==1) {
		var middle = (size-1)/2;
		return x+(index-middle)*(gap+width);
	} else {
		var middle = size/2;
		return x+(width+gap)/2+(index-middle)*(gap+width);
	}
}
function giveBack(object_) {
	if(inList(object_)>-1) {
		array_delete(list,inList(object_),1);
		//moveto
		for(var i=0;i<array_length(list);i++) {
			var sp = abs(list[i].x-getListPos(i))/(0.2*room_speed);
			list[i].moveTo(getListPos(i),y,max(sp,4));
		}
	}
	obj_container.addToGroup(object_, object_.type);
	
	var sum = 0;
	for(var i=0;i<array_length(list);i++) {
		sum += list[i].cost;
	}
	obj_clock.totalTime = sum;
}
function sendActions() {
	for(var i=0;i<array_length(list);i++) {
		obj_player.addAction(list[i]);
		//list[i].x = 0;
		list[i].y = 150;
		//list[i].show(true);
		list[i]._moving = false;
	}
	list = [];
	for(var i=0;i<array_length(obj_player.queue);i++) {
		obj_player.queue[i].x = obj_player.getListPos(i);	
	}
}