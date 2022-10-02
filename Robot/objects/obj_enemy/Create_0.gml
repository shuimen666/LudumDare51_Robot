event_inherited();
unitFactor = "enemy";
actions = [];
difficulty = 0;
actSpeed = irandom(9);

function initActions() {
	var table = [
		//0
		[ActionConf[$ "moveL1"],ActionConf[$ "moveU1"],ActionConf[$ "moveD1"]],
		//1
		[ActionConf[$ "rock1"],ActionConf[$ "heal1"],ActionConf[$ "moveL1"]],
		//2
		[ActionConf[$ "gun1"]],
		//3
		[ActionConf[$ "heal2"],ActionConf[$ "moveL1"],ActionConf[$ "moveR1"]],
		//4
		[ActionConf[$ "rock3"]],
		//5
		[ActionConf[$ "gun1"],ActionConf[$ "rock1"],ActionConf[$ "moveD1"],ActionConf[$ "moveU1"]],
	];
	for(var i=0;i<=difficulty&&i<array_length(table);i++) {
		for(var j=0;j<array_length(table[i]);j++)
			array_push(actions, table[i][j]);
	}
}
function createAction(conf_) {
	var ins = instance_create_layer(x,y,"Action",obj_action);
	ins.updateConf(conf_);
	ins.show(false);
	return ins;
}
function setEnemyActions()
{
	var time = 10;
	while(time>0)
	{
		var conf_ = actions[irandom(array_length(actions)-1)];
		var ins = createAction(conf_);
		time -= conf_[$ "cost"];
		addAction(ins);
	}
}
function getNewAction(conf_)
{
	var ins = createAction(conf_);
	addAction(ins);	
}
function die() {
	for(var i=0;i<array_length(queue);i++) {
		instance_destroy(queue[i]);
	}
	var ins = instance_create_layer(obj_battle_manager.getX(row,col),obj_battle_manager.getY(row,col),"Item",obj_item_new);
	ins.setRowCol(row,col);
	instance_destroy();
}

initActions();