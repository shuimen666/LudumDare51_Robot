if(global.choosingObject!=undefined)
{
	if(inRange(global.choosingObject.y))
	{
		if(global.choosingObject.notMuchMove()) giveBack(global.choosingObject);
		else elementChange(global.choosingObject);	
	} else {
		if(global.choosingObject.notMuchMove()) elementChange(global.choosingObject);
		else giveBack(global.choosingObject);
	}
}