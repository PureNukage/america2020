if on {
	var xx = 15
	var yy = 15

	with grid {
		draw_text(xx,yy, "mouseX: "+string(mouseX))	yy += 15
		draw_text(xx,yy, "mouseY: "+string(mouseY))	yy += 15
		draw_text(xx,yy, "pixelX: "+string(mouse_x)) yy += 15
		draw_text(xx,yy, "pixelY: "+string(mouse_y)) yy += 15
		var XX = grid.scr_x_to_iso(mouse_x,mouse_y)
		var YY = grid.scr_y_to_iso(mouse_x,mouse_y)
		draw_text(xx,yy, "isoX: "+string(XX)) yy += 15
		draw_text(xx,yy, "isoY: "+string(YY)) yy += 15
	}
	
	with input {
		draw_text(xx,yy, "selection: "+string(selection))	
	}
}