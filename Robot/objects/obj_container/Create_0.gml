group = [];
type_container = [];

function init()
{
	group = [];
	createTypeTag();
	initActionDeck();
	refreshTagPos();
}
function initActionDeck() {
	createAction(ActionConf[$ "moveR1"]);
	createAction(ActionConf[$ "moveL1"]);
	createAction(ActionConf[$ "moveU1"]);
	createAction(ActionConf[$ "moveD1"]);
	createAction(ActionConf[$ "rock1"]);
	createAction(ActionConf[$ "heal1"]);
}
function createTypeTag() {
	for(var i=0;i<ActionType.NUM;i++) {
		var array = [];
		array_push(group, array);
		var ins = instance_create_layer(x,y,"ActionType",obj_container_type);
		ins.type = i;
		array_push(type_container,ins);
	}
}
function createAction(conf_,ox,oy) {
	if(ox==undefined) ox = x;
	if(oy==undefined) oy = y;
	var ins = instance_create_layer(ox,oy,"Action",obj_action);
	ins.updateConf(conf_);
	addToGroup(ins, conf_[$ "type"], true);
}
function addToGroup(object_, type, force) {
	if(!object_.inGroup) {
		array_push(group[type],object_);
		object_.inGroup = true;
	}
	updateType(type, force);
}
function refreshTagPos() {
	var height = sprite_get_height(spr_action_type) + 8;
	var actionHeight = sprite_get_height(spr_actions);
	var gap = 24;
	var oy = y;
	for(var i=0;i<array_length(type_container);i++) {
		var type = type_container[i].type;
		type_container[i].x = x;
		type_container[i].y = oy;
		oy += height+actionHeight*(array_length(group[type])>0?1:0)+gap;
	}
}
function inList(object_)
{
	for(var i=0;i<array_length(group[object_.type]);i++) {
		if(group[object_.type][i]==object_) return i;	
	}
	return -1;
}
function deleteFromGroup(object_)
{
	array_delete(group[object_.type],inList(object_),1);
	object_.inGroup = false;
	updateType(object_.type);
}
function updateType(type, force) {
	refreshTagPos();
	for(var i=0;i<array_length(group[type]);i++) {
		updateAction(group[type][i], force);
	}	
}
function updateAction(object_, force)
{
	var height = sprite_get_height(spr_action_type) + 8;
	var actionWidth = sprite_get_width(spr_actions);
	var actionHeight = sprite_get_height(spr_actions);
	var gap = 24;
	var actionGap = 24;
	var ox = x+actionWidth/2+(inList(object_))*(actionWidth+actionGap);
	var oy = y;
	for(var i=0;i<object_.type;i++) {
		oy += height+actionHeight*(array_length(group[object_.type])>0?1:0)+gap;	
	}
	oy += height + actionHeight*0.5;
	if(force!=undefined&&force) {
		object_.x = ox;
		object_.y = oy;
	} else {
		var sp = point_distance(object_.x,object_.y,ox,oy)/(0.2*room_speed);
		object_.moveTo(ox,oy,max(sp,4));
	}
}

init();