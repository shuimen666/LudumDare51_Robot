row = -1;
col = -1;
actSpeed = 5;
timeLeft = 0;
hp = 3;
maxHp = 3;

stun = false;

queue = [];
_acting = false;
_targetRow = 0;
_targetCol = 0;
_moving = false;
_targetX = 0;
_targetY = 0;
_callback = undefined;
_res = [];
_findRow = 0;
_findCol = 0;
_hurting = 0;

function setRowCol(row_,col_) {
	row = row_;
	col = col_;
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
function queueSize() {
	return array_length(queue);	
}
function getAction() {
	if(queueSize()==0) return undefined;
	return queue[0];
}
function outAction() {
	if(queueSize()==0) return undefined;
	var action = queue[0];
	array_delete(queue,0,1);
	return action;
}
function addAction(action) {
	array_push(queue,action);
}
function tryMoveTo(row_,col_) {
	if(obj_battle_manager.outOfBound(row_,col_)) return;
	_acting = true;
	_targetRow = row_;
	_targetCol = col_;
	moveTo(obj_battle_manager.getX(row_,col_),obj_battle_manager.getY(row_,col_));
	_callback = function() {
		checkPos();
		finishAct();
	}
}
function checkPos() {
	with(obj_baseunit) {
		if(id!=other.id&&row==other._targetRow&&col==other._targetCol) {
			other.moveTo(obj_battle_manager.getX(other.row,other.col),obj_battle_manager.getY(other.row,other.col));
			other.stun = true;
		}
	}
	with(obj_baseitem) {
		if(row==other._targetRow&&col==other._targetCol) {
			other.getItem(id);
		}
	}
	if(!stun) {
		setRowCol(_targetRow,_targetCol);
	}
}
function getItem(object_)
{
	if(object_.name=="bigBattery") {
		if(unitFactor=="enemy") {
			global.gameResult="STEAL";
			alarm[1] = 1*room_speed;
		}
	}else if(object_.name=="newAction") {
		if(unitFactor=="player") {
			var arr = variable_struct_get_names(ActionConf);
			obj_container.createAction(ActionConf[$ arr[irandom(array_length(arr)-1)]]);
			instance_destroy(object_);
		}
	}else if(object_.name=="stone") {
		if(unitFactor=="enemy") {
			getNewAction(ActionConf[$ "stone1"]);
		}
		else obj_container.createAction(ActionConf[$ "stone1"],x,y);
		instance_destroy(object_);
	}else if(object_.name=="battery") {
		heal(1);
		instance_destroy(object_);
	}
}
function findEnemy(type, num) {
	_res = [];
	if(type=="near") {
		var dir = [[0,1],[-1,0],[0,-1],[1,0]];
		for(var i=0;i<array_length(dir);i++) {
			_findRow = row + dir[i][0];
			_findCol = col + dir[i][1];
			with(obj_baseunit) {
				if(row==other._findRow&&col==other._findCol&&unitFactor!=other.unitFactor)
					array_push(other._res, id);
			}
		}
	} else if(type=="line") {
		_findRow = row;
		with(obj_baseunit) {
			if(row==other._findRow&&unitFactor!=other.unitFactor)
				array_push(other._res, id);
		}
	}
	for(var i=array_length(_res);i<num;i++) {
		if(array_length(_res)==0) break;
		array_delete(_res,irandom(array_length(_res)-1),1);
	}
	return _res;
}
function beRocked(damage) {
	var ins = instance_create_layer(x+64,y-96,"Effect",obj_effect_rock);
	ins.speed = 5;
	ins.direction = 225;
	ins.image_angle = 225;
	ins.lifeTime = 0.6*room_speed;
	hurt(damage);
	checkDead();
}
function hurt(damage) {
	hp -= damage;	
	_hurting = 1;
	alarm[0] = 10;
}
function heal(num) {
	hp = min(hp+num, maxHp);
	var ins = instance_create_layer(x,y,"Effect",obj_effect_heal);
	ins.image_speed = 0.6;
	ins.lifeTime = room_speed;
}
function checkDead() {
	if(hp<=0) {
		if(unitFactor=="enemy") {
			die();
		}else{
			global.gameResult="DIE";
			alarm[1] = 1*room_speed;
		}
	}
}
function unableAct() {
	return stun;	
}
function finishAct() { _acting=false; }
function act(action) {
	timeLeft -= action.cost;
	if(!unableAct()) {
		var effect = action.effect;
		for(var i=0;i<array_length(effect);i++) {
			var at = effect[i];
			var atype = at[0];
			if(atype=="move") {
				var dir = {
					right:[0,1],
					up:[-1,0],
					left:[0,-1],
					down:[1,0]
				};
				var tmp = dir[$ at[1]];
				tryMoveTo(row+tmp[0]*at[2],col+tmp[1]*at[2]);
			} else if(atype=="attack") {
				var enemies = findEnemy(at[2],at[3]);
				var damage = at[1];
				for(var i=0;i<array_length(enemies);i++) {
					enemies[i].beRocked(damage);
				}
			} else if(atype=="heal") {
				var num = at[1];
				heal(num);
			} else if(atype=="maxHeal") {
				var num = at[1];
				maxHp+=num;
				heal(num);
			}
		}
	} else {
		if(stun) stun = false;	
	}
	
	action.x = x;
	action.y = y;
	action.show(true);
	if(action.once||unitFactor=="enemy") {
		action.destroy();
	} else {
		obj_container.addToGroup(action, action.type);
	}
}