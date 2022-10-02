event_inherited();
draw_self();
for(var i=0;i<maxHp;i++) {
	if(i<hp) draw_sprite_ext(spr_health,1,x-48+32*0.5*i,y-24,0.5,0.5,0,c_white,1);
	else draw_sprite_ext(spr_health,0,x-48+32*0.5*i,y-24,0.5,0.5,0,c_white,1);
}