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
activeAbilityFunction = -1
activeAbilityIndex = -1

attackState = -1
attackCellX = -1
attackCellY = -1
attackCellRange = -1

damaged = false
damagedTime = -1
damageDuration = 20
damageAmount = -1
damagedPreviously = false

highlightCellRange = -1

moveGridData = false

states = states.free

depth = -1

function createAbility(_function, _name, _damage, _range, _sprite, _type) constructor {
	Function = _function
	name = _name
	damage = _damage
	range = _range
	sprite = _sprite
	type = _type
}

function useAbility(_ability) {
	activeAbility = _ability
	activeAbilityFunction = _ability.Function
	activeAbilityIndex = gui.ability
	debug.log("Unit "+string_upper(object_get_name(object_index))+" is using ability "+string_upper(script_get_name(_ability.Function)))
}
	
function damage(_damage) {
	hp -= _damage
	damaged = true
	damagedTime = time.stream
	damageAmount = _damage
}

function die() {
	
	//	Deselect ourselves
	if input.selection == id {
		input.deselect()
	}
	
	//	Remove our grid data
	grid.objectGrid[# cellX, cellY] = -1
	mp_grid_clear_cell(grid.mpGrid, cellX, cellY)
	
	//	Remove ourselves from turn list
	if owner == player var list = game.playerTurnOrder
	else var list = game.enemyTurnOrder
	var index = -1
	for(var i=0;i<ds_list_size(list);i++) {
		if list[| i].instanceID = id {
			index = i	
		}
	}
	ds_list_delete(list, index)
	
	
	//	...and finally destroy this object
	instance_destroy()
	
	
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
	
function drawHealthbar() {
		
		draw_set_color(c_white)
		var width = 32
		var height = 8
		var X = x - width/2
		var Y = y - 70
		draw_rectangle(X,Y,X+width,Y+height,false)
		
		if hp > 0 {
			if owner == player draw_set_color(c_aqua)
			else draw_set_color(c_health)
			var healthWidth = (hp / hpMax) * width
			draw_rectangle(X,Y,X+healthWidth,Y+height,false)
		}
		
		draw_reset()
		
}