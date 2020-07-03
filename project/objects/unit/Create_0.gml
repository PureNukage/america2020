path = path_add()
pos = 0
x_goto = -1
y_goto = -1

goalCellX = -1
goalCellY = -1
goalX = -1
goalY = -1

cellX = 1
cellY = 1

selected = false

states = states.free

depth = -1

function move(_cellX, _cellY) {
	goalCellX = _cellX
	goalCellY = _cellY
	
	var x1 = grid.sX + (cellX * grid.cellWidth) + (grid.cellWidth/2)
	var y1 = grid.sY + (cellY * grid.cellHeight) + (grid.cellHeight/2)
	
	var x2 = grid.sX + (goalCellX * grid.cellWidth) + (grid.cellWidth/2)
	var y2 = grid.sY + (goalCellY * grid.cellHeight) + (grid.cellHeight/2)
			
	mp_grid_clear_cell(grid.mpGrid,cellX,cellY)
	
	//	We CANNOT path to the goal
	if !mp_grid_path(grid.mpGrid,path,x1,y1,x2,y2,false) {
		debug.log("Can't find path to this goal!")
		mp_grid_add_cell(grid.mpGrid,cellX,cellY)
	} 
	//	We can path to the goal!
	else {
		
		grid.path_to_iso(path)	//	Convert path into iso coordinates
		
		//	Remove stamina
		stamina -= path_get_number(path)-1
				
		goalX = path_get_point_x(path,path_get_number(path)-1)
		goalY = path_get_point_y(path,path_get_number(path)-1)
				
		pos = 0
				
		x_goto = path_get_point_x(path,pos)
		y_goto = path_get_point_y(path,pos)
				
		states = states.walk
				
	}
}