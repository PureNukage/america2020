cellWidth = 64
cellHeight = 64

gridWidth = room_width / cellWidth
gridHeight = room_height / cellHeight

gridWidth = 4
gridHeight = 4

sX = room_width/2
sY = room_height/3

mouseX = -1
mouseY = -1

mpGrid = mp_grid_create(sX,sY,gridWidth,gridHeight,cellWidth,cellHeight)

objectGrid = ds_grid_create(gridWidth,gridHeight)
ds_grid_set_region(objectGrid,0,0,gridWidth-1,gridHeight-1,-1)

grid_surface = -1

//	This function takes the isometric cell coordinate and returns the screen pixel X
function iso_to_scr_x(cellX, cellY) {
	return sX + (cellX - cellY) * cellWidth
}

//	This function takes the isometric cell coordinate and returns the screen pixel Y
function iso_to_scr_y(cellX, cellY) {
	return sY + (cellX + cellY) * cellHeight/2
}

//	This function takes a screen pixel x,y coordinate and returns the isometric X-cell
function scr_x_to_iso(X, Y) {
	var XX = X - sX
	var YY = Y - sY
	return floor((XX / grid.cellWidth + YY / (grid.cellHeight/2)) /2)
}

//	This function takes a screen pixel x,y coordinate and returns the isometric Y-cell
function scr_y_to_iso(X, Y) {
	var XX = X - sX
	var YY = Y - sY
	return floor((YY / (grid.cellHeight/2) - XX / (grid.cellWidth)) /2)
}

//	This function will free the grid_surface and then redraw the grid lines onto it
function draw_grid() {
	if surface_exists(grid_surface) surface_free(grid_surface)
	grid_surface = surface_create(room_width,room_height)
	surface_set_target(grid_surface)
	
	draw_set_color(c_white)

	for(var h=0;h<gridHeight;h++) {
		for(var w=0;w<gridWidth;w++) {
		
			var xx = iso_to_scr_x(w, h)
			var yy = iso_to_scr_y(w, h)
		
			draw_line(xx,yy,xx+cellWidth,yy+(cellHeight/2))
			draw_line(xx+cellWidth,yy+(cellHeight/2),xx,yy+cellHeight)
			draw_line(xx,yy+cellHeight,xx-cellWidth,yy+(cellHeight/2))
			draw_line(xx-cellWidth,yy+(cellHeight/2),xx,yy)
		
			if debug.on draw_text(xx,yy,string(w)+","+string(h))
		
		}
	}	
	surface_reset_target()
}