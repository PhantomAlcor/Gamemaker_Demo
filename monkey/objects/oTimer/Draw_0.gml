draw_set_font(fComicSans);
draw_set_color(c_black);
cam = camera_get_active()
camx = camera_get_view_x(cam)
camy = camera_get_view_y(cam)
timer =ceil((oPlayer.allottime - oPlayer.timer)/60);
draw_text(camx,camy,timer);

