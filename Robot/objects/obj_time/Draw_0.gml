if(_show) {
	draw_set_color(c_white);
	draw_set_font(Font_B48);
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(x,y,string(time));
}