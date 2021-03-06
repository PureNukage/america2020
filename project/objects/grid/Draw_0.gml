////	Grid lines
if surface_exists(grid_surface) {
	draw_surface(grid_surface,0,0)
} else {
	draw_grid()	
}

////	Draw mouse cell highlight
if (mouseX > -1 and mouseY > -1) {
	mouseInGrid = true
	var color = -1
	if objectGrid[# mouseX, mouseY] > -1 {
		if input.selection == objectGrid[# mouseX, mouseY] {}
		else color = c_yellow
	}
	else color = c_white
	//	Check stamina vs points if moving a unit
	if input.states == states.move and input.selection > -1 and path_get_number(input.path)-1 > 0 {
		var points = path_get_number(input.path)-1 
		if input.selection.stamina >= points {
			color = c_white
		} else {
			color = c_gray
		}
	}
	draw_cell(mouseX, mouseY, color, 1)
	
} else {
	mouseInGrid = false	
}

////	Draw selection cell highlight
if input.selection > -1 {
	draw_set_color(c_orange)
	var xx = iso_to_scr_x(input.selection.cellX,input.selection.cellY)
	var yy = iso_to_scr_y(input.selection.cellX,input.selection.cellY)
	draw_triangle(xx,yy,xx+cellWidth,yy+cellHeight/2,xx-cellWidth,yy+cellHeight/2,false)
	draw_triangle(xx,yy+cellHeight,xx+cellWidth,yy+cellHeight/2,xx-cellWidth,yy+cellHeight/2,false)
}

////	Draw cellRanges 
if !ds_list_empty(cellRanges) {
	for(var c=0;c<ds_list_size(cellRanges);c++) {
		var cell = cellRanges[| c]
		draw_cell_range(cell.x1,cell.y1,cell.x2,cell.y2,cell.color,cell.alpha)
	}
}

////	Draw cells
if !ds_list_empty(cells) {
	for(var c=0;c<ds_list_size(cells);c++) {
		var cell = cells[| 0]
		draw_cell(cell.cellX,cell.cellY, c_yellow, .5)
	}
	draw_reset()
}

////	Render units
for(var w=0;w<gridWidth;w++) {
	for(var h=0;h<gridHeight;h++) {
		////	Render sprite of unit inside cell
		if objectGrid[# w, h] > -1 {
			var Unit = objectGrid[# w, h]
			with Unit {
				if damaged {
					shader_set(sdr_flash)	
				}
				draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, 0, c_white, image_alpha)
				shader_reset()
			}
		}
	}
}

////	Calculate mouseX and mouseY
mouseX = scr_x_to_iso(mouse_x,mouse_y)
mouseY = scr_y_to_iso(mouse_x,mouse_y)
if mouseX != mouseXPrevious or mouseY != mouseYPrevious {
	mouseMoved = true
	//	Check if we're inside the grid (solves one frame of 'lag')
	if (mouseX > -1 and mouseX <= gridWidth-1 and mouseY > -1 and mouseY <= gridWidth-1) mouseInGrid = true
	mouseXPrevious = mouseX
	mouseYPrevious = mouseY
} else {
	mouseMoved = false	
}
if (mouseX < 0 or mouseX > gridWidth-1) or (mouseY < 0 or mouseY > gridHeight-1) {
	mouseX = -1
	mouseY = -1
}