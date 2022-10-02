MAXCOL = 6;
MAXROW = 3;
floors = [];

_acting = false;
_unit = undefined;
_unitTimeLeft = 0;
_innerTimeOver = true;
_inner = 0;

_has = false;
_itemR = 0;
_itemC = 0;

function init() {
	initFloors();
	initBigBattery();
	initPlayer();
	initEnemy();
}
function initFloors() {
	var width = sprite_get_width(spr_floor);
	var height = sprite_get_height(spr_floor);
	var wgap = 32, hgap = 48;
	var offset = 32;
	for(var i=0;i<MAXROW;i++) {
		var rows = [];
		for(var j=0;j<MAXCOL;j++) {
			var ins = instance_create_layer(x+j*(width+wgap)-offset*i,y+i*(height+hgap),"Floor",obj_floor);
			ins.row = i;
			ins.col = j;
			array_push(rows, ins);
		}
		array_push(floors, rows);
	}	
}
function initBigBattery() {
	var ins = instance_create_layer(getX(floor(MAXROW/2),0),getY(floor(MAXROW/2),0),"Item",obj_big_battery);
	ins.setRowCol(floor(MAXROW/2),0);
}
function initPlayer() {
	var ins = instance_create_layer(getX(floor(MAXROW/2),1),getY(floor(MAXROW/2),1),"Unit",obj_player);
	ins.setRowCol(floor(MAXROW/2),1);
}
function initEnemy() {
	var ins = instance_create_layer(getX(floor(MAXROW/2),5),getY(floor(MAXROW/2),5),"Unit",obj_enemy);
	ins.setRowCol(floor(MAXROW/2),5);
}
function createEnemy(diff) {
	for(var i=0;i<MAXROW;i++) {
		_has = false;
		_itemR = i;
		with(obj_enemy) {
			if(row==other._itemR&&col==5) other._has=true;
		}
		if(!_has) {
			var ins = instance_create_layer(getX(i,5),getY(i,5),"Unit",obj_enemy);
			ins.setRowCol(i,5);
			ins.difficulty = diff;
			break;
		}
	}
}
function outOfBound(row,col) {
	if(row<0||row>=MAXROW||col<0||col>=MAXCOL) return true;
	return false;
}
function getX(row,col) { return floors[row][col].x; }
function getY(row,col) { return floors[row][col].y; }
function actBegin() {
	_acting = true;
}
function ableNextAct() {
	with(obj_baseunit) {
		if(_acting) {
			other._inner = 0.5*room_speed;
			return false;
		}
	}
	return true;
}
function subAbleNextAct(time) {
	if((time>obj_time.endTime&&_inner==0)||_innerTimeOver) return true;
	else return false;
}
function findUnitToAct() {
	_unit = undefined;
	_unitTimeLeft = -1;
	with(obj_baseunit) {
		if(getAction()!=undefined&&timeLeft>=getAction().cost)
		{
			if(timeLeft>other._unitTimeLeft || (timeLeft==other._unitTimeLeft&&actSpeed>other._unit.actSpeed))
			{
				other._unit = id;
				other._unitTimeLeft = timeLeft;
			}
		}
	}
	if(_unit!=undefined) {
		if(subAbleNextAct(_unitTimeLeft)) unitAct(_unit);
	} else if(_innerTimeOver) {
		_acting = false;
		obj_game_manager.gameStateChange(GameState.SEND);
	}	
}
function unitAct(unit)
{
	var action = unit.outAction();
	unit.act(action);
	_inner = 0.5*room_speed;
	_innerTimeOver = false;
	obj_time.setEndTime(unit.timeLeft);
	obj_time.setTime(action.cost, function(){
		obj_battle_manager._innerTimeOver = true;	
	});
}
function createItem()
{
	var items = [obj_item_stone, obj_item_battery];
	_itemR = -1;
	_itemC = -1;
	_has = true;
	while(_has==true) {
		_has = false;
		_itemR = irandom(MAXROW-1);
		_itemC = irandom(MAXCOL-1);
		with(obj_baseitem) {
			if(row==other._itemR&&col==other._itemC) other._has=true;	
		}
	}
	var ins = instance_create_layer(getX(_itemR,_itemC),getY(_itemR,_itemC),"Item",items[irandom(array_length(items)-1)]);
	ins.setRowCol(_itemR,_itemC);
}



init();