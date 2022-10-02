function TranslationSet(){
	Translation = {
		START_GAME: ["开始游戏","Start Game"],
		RESTART: ["重新开始","Restart Game"],
		NOT_FULL: ["本次发送动作时长未满","The total time of actions is less than enough"],
		FULL: ["本次发送动作时长已满","The total time of actions is enough"],
		OVERLOAD: ["本次发送动作时长超出，动作会自动延后执行","The total time of actions is too much, some actions may perform in next round"],
		TYPE_MOVE: ["移动类型","Type of Move"],
		TYPE_OTHER: ["其他类型","Type of Others"],
		HELP1: ["未来世界你可以指挥你的机器人执行任务，\n但为了保证安全，你只能每隔10s发送\n给机器人下10s的动作指令！",
				"You can remote control your robot for task\nin the future,but you can only send\ncommands of 10s actions each 10s for safety!"],
		HELP2: ["你需要保护电池不被敌人偷走，\n并且保证机器人存活","You need to protect the battery from\ntheft and keep robot alive!"],
		HELP3: ["如果移动到了有机器人的方格，\n将会眩晕[下一个动作会失效]","Stun [next action lose effect] \nwhen moving to a robot cell."],
		HELP4: ["捡起地上的道具，获得更多动作！","Pick up items to have more actions!"],
		STEAL: ["你的后备电池被偷啦！","The backup batterys have been stolen!"],
		DIE: ["你的机器人死掉啦！","Your robot is dead!"],
		NONE: ["",""],
		
		moveR1: ["向右移动1格","move 1 cell right"],
		moveL1: ["向左移动1格","move 1 cell left"],
		moveU1: ["向上移动1格","move 1 cell up"],
		moveD1: ["向下移动1格","move 1 cell down"],
		rock1: ["对1个相邻敌人造成1点伤害","deal 1 damage to a nearby enemy"],
		gun1: ["对1个同行敌人造成1点伤害","deal 1 damage to a enemy in same line"],
		heal1: ["恢复1点生命值","heal 1 health"],
		stone1: ["对1个同行敌人造成1点伤害，一次性","deal 1 damage to a enemy in same line, use once"],
		heal2: ["增加1点最大生命，恢复1点生命值，一次性","add 1 max health, heal 1 health, use once"],
		rock2: ["对相邻敌人造成1点伤害","deal 1 damage to nearby enemies"],
		rock3: ["对1个相邻敌人造成2点伤害","deal 2 damages to a nearby enemy"],
	};
}