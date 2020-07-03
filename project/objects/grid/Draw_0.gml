////	Grid lines
if surface_exists(grid_surface) {
	draw_surface(grid_surface,0,0)
} else {
	draw_grid()	
}

////	Draw mouse cell highlight
if (mouseX > -1 and mouseY > -1) {
	if objectGrid[# mouseX, mouseY] > -1 {
		if input.selection == objectGrid[# mouseX, mouseY] {}
		else draw_set_color(c_yellow)
	}
	else draw_set_color(c_white)
	//	Check stamina vs points if moving a unit
	if input.states == states.move and input.selection > -1 and path_get_number(input.path)-1 > 0 {
		var points = path_get_number(input.path)-1 
		if input.selection.stamina >= points {
			draw_set_color(c_white)	
		} else {
			draw_set_color(c_gray)	
		}
	}
	var xx = iso_to_scr_x(mouseX,mouseY)
	var yy = iso_to_scr_y(mouseX,mouseY)
	draw_triangle(xx,yy,xx+cellWidth,yy+cellHeight/2,xx-cellWidth,yy+cellHeight/2,false)
	draw_triangle(xx,yy+cellHeight,xx+cellWidth,yy+cellHeight/2,xx-cellWidth,yy+cellHeight/2,false)
}

////	Draw selection cell highlight
if input.selection > -1 {
	draw_set_color(c_orange)
	var xx = iso_to_scr_x(input.selection.cellX,input.selection.cellY)
	var yy = iso_to_scr_y(input.selection.cellX,input.selection.cellY)
	draw_triangle(xx,yy,xx+cellWidth,yy+cellHeight/2,xx-cellWidth,yy+cellHeight/2,false)
	draw_triangle(xx,yy+cellHeight,xx+cellWidth,yy+cellHeight/2,xx-cellWidth,yy+cellHeight/2,false)
}

////	Render units
for(var w=0;w<gridWidth;w++) {
	for(var h=0;h<gridHeight;h++) {
		////	Render sprite of unit inside cell
		if objectGrid[# w, h] > -1 {
			var Unit = objectGrid[# w, h]
			with Unit {
				draw_sprite(sprite_index, image_index, x, y)
			}
		}
	}
}

////	Calculate mouseX and mouseY
mouseX = scr_x_to_iso(mouse_x,mouse_y)
mouseY = scr_y_to_iso(mouse_x,mouse_y)
if mouseX != mouseXPrevious or mouseY != mouseYPrevious {
	mouseMoved = true
	mouseXPrevious = mouseX
	mouseYPrevious = mouseY
} else {
	mouseMoved = false	
}
if (mouseX < 0 or mouseX > gridWidth-1) or (mouseY < 0 or mouseY > gridHeight-1) {
	mouseX = -1
	mouseY = -1
}

////	TEMP Spawn unit in a cell
//if mouseX > -1 and mouseY > -1 and mouse_check_button_pressed(mb_right) {
//	var XX = iso_to_scr_x(mouseX,mouseY)
//	var YY = iso_to_scr_y(mouseX,mouseY) + (cellHeight/2)
//	var Unit = instance_create_layer(XX,YY,"Instances",unit)
//	Unit.cellX = mouseX
//	Unit.cellY = mouseY
//	objectGrid[# mouseX, mouseY] = Unit
//	mp_grid_add_cell(mpGrid,Unit.cellX,Unit.cellY)
//}