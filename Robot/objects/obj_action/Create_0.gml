conf = undefined;
effect = [];
type = ActionType.NUM;
cost = 0;
once = false;
choosing = false;
inGroup = false;
_deltaX = 0;
_deltaY = 0;
_targetX = 0;
_targetY = 0;
_moving = false;
_choosingTime = 0;
_lastX = 0;
_lastY = 0;
_destorying = false;

function init() {
	image_speed = 0;
	updateConf(ActionConf[$ "move1"]);
}
function updateConf(conf_) {
	if(conf_==undefined) return;
	conf = conf_;
	type = conf[$ "type"];
	effect = conf[$ "effect"];
	cost = conf[$ "cost"];
	once = conf[$ "once"];
	setImage();
}
function setImage() {
	image_index = conf[$ "image"];	
}
function moveTo(tx,ty,sp=4) {
	if(point_distance(x,y,tx,ty)<=sp) {
		x = tx;
		y = ty;
		return;
	}
	_targetX = tx;
	_targetY = ty;
	_moving = true;
	speed = sp;
	direction = point_direction(x,y,tx,ty);
}
function notMuchMove() {
	if(_choosingTime>0.5*room_speed) return false;
	if(point_distance(x,y,_lastX,_lastY)>24*1.5) return false;
	return true;
}
function show(enable) {
	if(enable) {
		sprite_index = spr_actions;
		setImage();
	} else {
		sprite_index = noone;	
	}
}
function destroy() {
	_destorying = true;
	moveTo(x,y-80,2);
}

init();