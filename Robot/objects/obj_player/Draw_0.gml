event_inherited();
draw_self();
var ox = camera_get_view_x(view_camera[0]), oy = camera_get_view_y(view_camera[0]);
for(var i=0;i<maxHp;i++) {
	if(i<hp) draw_sprite(spr_health,1,ox+12+40*i,oy+12);
	else draw_sprite(spr_health,0,ox+12+40*i,oy+12);
}
//draw_text(x,y,string(row)+","+string(col))