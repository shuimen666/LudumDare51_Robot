draw_self();
draw_set_color(c_black);
draw_set_font(Font_B16);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
switch(type)
{
	case ActionType.MOVE:
		draw_text(x+91,y+32,__("TYPE_MOVE"));
	break;
	case ActionType.OTHER:
		draw_text(x+91,y+32,__("TYPE_OTHER"));
	break;
}