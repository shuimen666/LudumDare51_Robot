enum GameState {
	READY,
	SEND,
	ACT,
	NUM
}
global.gameState = GameState.NUM;
randomize();
gameDiff = 0;

_camera = view_camera[0];
_viewUpX = camera_get_view_x(_camera);
_viewUpY = camera_get_view_y(_camera);
_viewDownX = _viewUpX;
_viewDownY = _viewUpY + 120;
_moving = false;
_targetX = 0;
_targetY = 0;
_speed = 0;
_callback = undefined;
_nowDown = false;

function gameStateChange(state)
{
	global.gameState = state;
	switch(state)
	{
		case GameState.READY:
			alarm[0] = room_speed;
		break;
		case GameState.SEND:
			createItems();
			createEnemies();
			obj_clock.totalTime = 0;
			cameraMove(true,
				function(){
					obj_time.setTime(10, function() {
						obj_sendbar.sendActions();
						obj_game_manager.gameStateChange(GameState.ACT);
					});
				}
			);
		break;
		case GameState.ACT:
			obj_time.setEndTime(20);
			with(obj_baseunit) { 
				timeLeft = 10; 
				if(unitFactor=="enemy") setEnemyActions();
			}
			cameraMove(false,
				function(){
					obj_battle_manager.actBegin();
				}
			);
		break;
	}
}
function cameraMove(down, callback, sp=10)
{
	if(callback!=undefined) _callback = callback;
	if(_nowDown==down) {
		if(_callback!=undefined) {
			_callback();
			_callback = undefined;
		}
		return;
	}
	_nowDown = down;
	var tx,ty;
	if(down) { tx = _viewDownX; ty = _viewDownY; }
	else { tx = _viewUpX; ty = _viewUpY; }
	if(point_distance(camera_get_view_x(_camera),camera_get_view_y(_camera),tx,ty)<=sp) {
		camera_set_view_pos(_camera, tx, ty);
		return;
	}
	_targetX = tx;
	_targetY = ty;
	_moving = true;
	_speed = sp*(down?1:-1);
}
function createEnemies()
{
	if(instance_number(obj_enemy)<2) {
		gameDiff += random(0.6)+0.3;
		obj_battle_manager.createEnemy(round(gameDiff));
	}
}
function createItems() {
	if(instance_number(obj_baseitem)<3) {
		obj_battle_manager.createItem();
	}
}

gameStateChange(GameState.READY);