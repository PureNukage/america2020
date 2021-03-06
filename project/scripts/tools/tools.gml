function pathfind(_grid, _path, _cellX, _cellY, _goalCellX, _goalCellY, obstacles_) {
	var x1 = grid.sX + (_cellX * grid.cellWidth) + (grid.cellWidth/2)
	var y1 = grid.sY + (_cellY * grid.cellHeight) + (grid.cellHeight/2)
	
	var x2 = grid.sX + (_goalCellX * grid.cellWidth) + (grid.cellWidth/2)
	var y2 = grid.sY + (_goalCellY * grid.cellHeight) + (grid.cellHeight/2)
	
	if !obstacles_ {
		var Grid = mp_grid_create(grid.sX,grid.sY,grid.gridWidth,grid.gridHeight,grid.cellWidth,grid.cellHeight)	
	} else {
		var Grid = _grid
	}
	
	if !mp_grid_path(Grid,_path,x1,y1,x2,y2,false) {
		debug.log("Cannot form a path to the goal")
		
		if !obstacles_ mp_grid_destroy(Grid)
		return false
	} else {
		//	How many points in this path
		var points = path_get_number(_path)-1
		debug.log("This path has ["+ string(points) +"] points")
		
		if !obstacles_ mp_grid_destroy(Grid)
		return true
	}
}
	
function createPopup(_x, _y, _string, _color, _duration) {
	var Popup = instance_create_layer(_x,_y,"Instances",popup)
	Popup.String = _string
	Popup.duration = _duration
	Popup.color = _color

	debug.log("Creating POPUP with the string: "+string(Popup.String))
}

function draw_reset() {
	draw_set_color(c_black)
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
	draw_set_alpha(1)
	draw_set_font(-1)
}