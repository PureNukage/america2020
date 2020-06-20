draw_set_color(c_white)

var cell_mouseover = false
for(var h=0;h<gridHeight;h++) {
	for(var w=0;w<gridWidth;w++) {
		
		var xx = iso_to_scr_x(w, h)
		var yy = iso_to_scr_y(w, h)
		
		var top_pointX = xx
		var top_pointY = yy
		
		var right_pointX = xx+cellWidth
		var right_pointY = yy+(cellHeight/2)
		
		var bottom_pointX = xx
		var bottom_pointY = yy+cellHeight
		
		var left_pointX = xx-cellWidth
		var left_pointY = yy+(cellHeight/2)
		
		if point_in_triangle(mouse_x,mouse_y,top_pointX,top_pointY,right_pointX,right_pointY+1,left_pointX,left_pointY+1)
		or point_in_triangle(mouse_x,mouse_y,bottom_pointX,bottom_pointY,right_pointX,right_pointY-1,left_pointX,left_pointY-1) {
			mouseX = w
			mouseY = h
			cell_mouseover = true
		}
		
		////	DEBUG
		if debug.on {
			//draw_set_color(c_red)
			//draw_triangle(top_pointX,top_pointY,right_pointX,right_pointY,left_pointX,left_pointY,false)
			//draw_triangle(bottom_pointX,bottom_pointY,right_pointX,right_pointY,left_pointX,left_pointY,false)
		}	
		
		draw_set_color(c_white)
		
		draw_line(xx,yy,xx+cellWidth,yy+(cellHeight/2))
		draw_line(xx+cellWidth,yy+(cellHeight/2),xx,yy+cellHeight)
		draw_line(xx,yy+cellHeight,xx-cellWidth,yy+(cellHeight/2))
		draw_line(xx-cellWidth,yy+(cellHeight/2),xx,yy)
		
		if debug.on draw_text(xx,yy,string(w)+","+string(h))
		
	}
}

if !cell_mouseover and (mouseX > -1 or mouseY > -1) {
	mouseX = -1
	mouseY = -1
}

if mouseX > -1 and mouseY > -1 and mouse_check_button_pressed(mb_right) {
	var XX = iso_to_scr_x(mouseX,mouseY)
	var YY = iso_to_scr_y(mouseX,mouseY) + (cellHeight/2)
	var Unit = instance_create_layer(XX,YY,"Instances",unit)
	Unit.cellX = mouseX
	Unit.cellY = mouseY
}