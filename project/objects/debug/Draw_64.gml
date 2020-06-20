if on {
	var xx = 15
	var yy = 15

	with grid {
		draw_text(xx,yy, string(mouseX))	yy += 15
		draw_text(xx,yy, string(mouseY))	yy += 15
	}
}