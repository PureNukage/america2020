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

myAbilities = ds_list_create()
activeAbility = -1
activeAbilityIndex = -1

meleeState = -1
attackCellX = -1
attackCellY = -1

damaged = false
damagedTime = -1
damageDuration = 20

moveGridData = false

states = states.free

depth = -1

function createAbility(_function, _name, _range, _sprite) constructor {
	Function = _function
	name = _name
	range = _range
	sprite = _sprite
}

function move(_cellX, _cellY, freemove, staminaUse, __gridData, __altCellX, __altCellY) {
	goalCellX = _cellX
	goalCellY = _cellY
	
	var x1 = grid.sX + (cellX * grid.cellWidth) + (grid.cellWidth/2)
	var y1 = grid.sY + (cellY * grid.cellHeight) + (grid.cellHeight/2)
	
	if !is_undefined(__gridData) moveGridData = __gridData
	
	//	Alt cellX,Y
	debug.log("Argument Count: "+string(argument_count))
	if !is_undefined(__altCellX) {
		var x1 = grid.sX + (__altCellX * grid.cellWidth) + (grid.cellWidth/2)	
	}
	if !is_undefined(__altCellY) {
		var y1 = grid.sY + (__altCellY * grid.cellHeight) + (grid.cellHeight/2)	
	}
		
	
	var x2 = grid.sX + (goalCellX * grid.cellWidth) + (grid.cellWidth/2)
	var y2 = grid.sY + (goalCellY * grid.cellHeight) + (grid.cellHeight/2)
	
	if freemove {
		var Grid = mp_grid_create(grid.sX,grid.sY,grid.gridWidth,grid.gridHeight,grid.cellWidth,grid.cellHeight)
	} else {
		var Grid = grid.mpGrid	
	}
			
	if !freemove mp_grid_clear_cell(Grid,cellX,cellY)
	
	//	We CANNOT path to the goal
	if !mp_grid_path(Grid,path,x1,y1,x2,y2,false) {
		debug.log("Can't find path to this goal!")
		if !freemove mp_grid_add_cell(Grid,cellX,cellY)
	} 
	//	We can path to the goal!
	else {
		
		grid.path_to_iso(path)	//	Convert path into iso coordinates
		
		//	Remove stamina
		if staminaUse stamina -= path_get_number(path)-1
				
		goalX = path_get_point_x(path,path_get_number(path)-1)
		goalY = path_get_point_y(path,path_get_number(path)-1)
				
		pos = 0
				
		x_goto = path_get_point_x(path,pos)
		y_goto = path_get_point_y(path,pos)
				
		states = states.walk
				
	}
	
	if freemove mp_grid_destroy(Grid)
}