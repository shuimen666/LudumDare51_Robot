enum LANGUAGE
{
	CHS,
	ENG,
	NUM
}
enum ActionType
{
	MOVE,
	OTHER,
	NUM
}
globalvar ActionConf;
ActionConf = {
	moveR1:{
		image: 1,
		effect:[["move","right",1]],
		type: ActionType.MOVE,
		cost: 2,
		once: false,
		desc: "moveR1",
	},
	moveL1:{
		image: 3,
		effect:[["move","left",1]],
		type: ActionType.MOVE,
		cost: 2,
		once: false,
		desc: "moveL1",
	},
	moveU1:{
		image: 2,
		effect:[["move","up",1]],
		type: ActionType.MOVE,
		cost: 2,
		once: false,
		desc: "moveU1",
	},
	moveD1:{
		image: 4,
		effect:[["move","down",1]],
		type: ActionType.MOVE,
		cost: 2,
		once: false,
		desc: "moveD1",
	},
	rock1:{
		image: 5,
		effect:[["attack",1,"near",1]],
		type: ActionType.OTHER,
		cost: 3,
		once: false,
		desc: "rock1",
	},
	gun1:{
		image:6,
		effect:[["attack",1,"line",1]],
		type: ActionType.OTHER,
		cost: 3,
		once: false,
		desc: "gun1",
	},
	heal1:{
		image: 7,
		effect:[["heal",1]],
		type: ActionType.OTHER,
		cost: 5,
		once: false,
		desc: "heal1",
	},
	stone1:{
		image: 8,
		effect:[["attack",1,"line",1]],
		type: ActionType.OTHER,
		cost: 1,
		once: true,
		desc: "stone1",
	},
	heal2:{
		image: 9,
		effect:[["maxHeal",1],["heal",1]],
		type: ActionType.OTHER,
		cost: 6,
		once: true,
		desc: "heal2",
	},
	rock2:{
		image: 10,
		effect:[["attack",1,"near",4]],
		type: ActionType.OTHER,
		cost: 4,
		once: false,
		desc: "rock2",
	},
	rock3:{
		image: 11,
		effect:[["attack",2,"near",1]],
		type: ActionType.OTHER,
		cost: 4,
		once: false,
		desc: "rock3",
	},
};

globalvar Language,Translation,__,gameResult;
Language = LANGUAGE.ENG;
TranslationSet();
__ = function(key) {
	var arr = Translation[$ key];
	if(arr==undefined) return ""; 
	return arr[Language];
}


global.choosing = false;
global.choosingObject = undefined;
