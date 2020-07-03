if on {
	draw_set_color(c_white)
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
		draw_text(xx,yy, "selection: "+string(selection))		yy += 15
		if selection > -1 {
			with selection {
				if grid.mouseX > -1 and grid.mouseY > -1 {
					draw_text(xx,yy, "distance: "+string(path_get_number(input.path)-1)) 
					yy += 15
				}
				draw_text(xx,yy, "owner: " + object_get_name(owner)) yy += 15
				
			}
		}
	}
	
	with app {
		draw_text(xx,yy, "zoom level: "+string(zoom_level)) 	yy += 15 
		draw_text(xx,yy, "camera_border_x: "+string(camera_get_view_border_x(camera)))		yy += 15
		draw_text(xx,yy, "camera_border_y: "+string(camera_get_view_border_y(camera)))	yy += 15
		draw_text(xx,yy, "camera_view_x: "+string(camera_get_view_x(camera)))	yy += 15
		draw_text(xx,yy, "camera_view_y: "+string(camera_get_view_y(camera)))	yy += 15
	}
}