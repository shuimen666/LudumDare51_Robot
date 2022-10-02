if(sprite_index!=noone) {
	draw_self();
	draw_set_color(c_white);
	draw_set_font(Font_B16);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(x+sprite_width/2,y+sprite_height/2,cost);
	if(once) draw_sprite(spr_once,0,x,y);
}