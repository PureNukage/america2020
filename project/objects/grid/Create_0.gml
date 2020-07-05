cellWidth = 64
cellHeight = 64

gridWidth = room_width / cellWidth
gridHeight = room_height / cellHeight

gridWidth = 5
gridHeight = 5

sX = room_width/2
sY = room_height/3

mouseInGrid = false
mouseX = -1
mouseY = -1
mouseMoved = false
mouseXPrevious = -1
mouseYPrevious = -1

mpGrid = mp_grid_create(sX,sY,gridWidth,gridHeight,cellWidth,cellHeight)

objectGrid = ds_grid_create(gridWidth,gridHeight)
ds_grid_set_region(objectGrid,0,0,gridWidth-1,gridHeight-1,-1)

grid_surface = -1

cellRanges = ds_list_create()
cells = ds_list_create()

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
		
			//draw_line(xx,yy,xx+cellWidth,yy+(cellHeight/2))
			//draw_line(xx+cellWidth,yy+(cellHeight/2),xx,yy+cellHeight)
			//draw_line(xx,yy+cellHeight,xx-cellWidth,yy+(cellHeight/2))
			//draw_line(xx-cellWidth,yy+(cellHeight/2),xx,yy)
			
			draw_sprite(s_tile_grass,0,xx,yy+cellHeight/2)
		
			if debug.on draw_text(xx,yy,string(w)+","+string(h))
		
		}
	}	
	surface_reset_target()
}
	
function draw_cell(_cellX, _cellY, _color, _alpha) {
	draw_set_color(_color)
	draw_set_alpha(_alpha)
	
	var xx = iso_to_scr_x(_cellX,_cellY)
	var yy = iso_to_scr_y(_cellX,_cellY)
	draw_triangle(xx,yy,xx+cellWidth,yy+cellHeight/2,xx-cellWidth,yy+cellHeight/2,false)
	draw_triangle(xx,yy+cellHeight,xx+cellWidth,yy+cellHeight/2,xx-cellWidth,yy+cellHeight/2,false)
}
	
function draw_cell_range(_x1, _y1, _x2, _y2, _color, _alpha) {
	
	for(var w=_x1;w<=_x2;w++) {
		for(var h=_y1;h<=_y2;h++) {
			if (w > -1 and w < gridWidth) and (h > -1 and h < gridHeight) {
				draw_cell(w, h, _color, _alpha)
			}
		}
	}
	
	draw_reset()
	
}

function createCell(_x, _y, _color, _alpha, _type) constructor {
	color = _color
	alpha = _alpha
	cellX = _x
	cellY = _y
	cellRange = _type
}

function destroyCell(_index) {
	ds_list_delete(cells, _index)
}
	
function createCellRange(_color, _alpha, _x1, _y1, _x2, _y2, _type) constructor {
	color = _color
	alpha = _alpha
	x1 = _x1
	y1 = _y1
	x2 = _x2
	y2 = _y2
	cellRange = _type
	
	pulseX = -1
	pulseY = -1
}
	
function destroyCellRange(_index) {
	ds_list_delete(cellRanges, _index)
}

//	This function will convert a path into an isometric path
function path_to_iso(path) {
	
	for(var p=0;p<path_get_number(path);p++) {
		var pX = path_get_point_x(path, p)
		var pY = path_get_point_y(path, p)
			
		mp_grid_get_cell(grid.mpGrid,pX,pY)
			
		var __cellX = floor( (pX - grid.sX)/grid.cellWidth )
		var __cellY = floor( (pY - grid.sY)/grid.cellHeight )
			
		var newX = grid.iso_to_scr_x(__cellX, __cellY)
		var newY = grid.iso_to_scr_y(__cellX, __cellY) + (grid.cellHeight/2)
					
		path_change_point(path, p, newX, newY, path_get_speed(path, p))	
	}	
}