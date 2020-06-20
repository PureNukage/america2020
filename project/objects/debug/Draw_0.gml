if on {
	
	if instance_exists(unit) with unit {
		
		////	Draw Path
		if path_exists(path) {
			draw_set_color(c_yellow)
			//draw_path(path,x+63,y+49,true)
			draw_path(path,x,y,true)
		}
		
		////	Draw variables
		var xx = x + sprite_get_width(sprite_index) + 16
		var yy = y
		
		//draw_text(xx,yy, )
	}
	
	
	if instance_exists(grid) with grid {
		draw_set_alpha(.5)
		mp_grid_draw(mpGrid)	
		draw_set_alpha(1)
	}
	
}