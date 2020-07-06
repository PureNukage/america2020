switch(states) 
{
	case states.free:
		
	break
	case states.walk:
	
		if point_distance(x,y,x_goto,y_goto) < 2 {
			if ++pos == path_get_number(path) {
				states = states.free
				
				if moveGridData { 
					grid.objectGrid[# cellX, cellY] = -1
					mp_grid_clear_cell(grid.mpGrid,cellX,cellY)
					cellX = goalCellX
					cellY = goalCellY
					grid.objectGrid[# cellX, cellY] = id
					mp_grid_add_cell(grid.mpGrid,cellX,cellY)
					goalCellX = -1
					goalCellY = -1
					
					moveGridData = false
				}
				
				if activeAbility == -1 and stamina <= 0 game.endTurn()
				
				speed = 0
			} else {
				x_goto = path_get_point_x(path,pos)
				y_goto = path_get_point_y(path,pos)
				move_towards_point(x_goto,y_goto,4)
				
				if moveGridData { 
					var iso_x = grid.scr_x_to_iso(x_goto,y_goto)
					var iso_y = grid.scr_y_to_iso(x_goto,y_goto)
				
					grid.objectGrid[# cellX, cellY] = -1
					mp_grid_clear_cell(grid.mpGrid,cellX,cellY)
				
					cellX = iso_x
					cellY = iso_y
					
					grid.objectGrid[# cellX, cellY] = id
					mp_grid_add_cell(grid.mpGrid,cellX,cellY)
				}

			}
		}
		
	break
}

//	Abilities
if activeAbility > -1 {
	var stillGoing = script_execute(activeAbilityFunction)
	if !stillGoing {
		attackState = -1
		activeAbility = -1
		activeAbilityFunction = -1
		activeAbilityIndex = -1
		
		if stamina <= 0 game.endTurn()
	}
}

//	Damage
if damaged {
	//	First frame of being damaged
	if damagedPreviously != damaged {
		damagedPreviously = true
		
		createPopup(x,y-92,string(damageAmount),c_red,60)
	}
	
	//	Done being damaged
	if (time.stream - damagedTime) >= damageDuration {
		damaged = false
		damagedTime = -1
		damageAmount = -1
		damagedPreviously = false
		
		//	I am dead
		if hp <= 0 {
			die()
		}
	}
}

//	Determine direction to face
if speed != 0 {
	//	Left
	if direction < 270 and direction > 90 {
		image_xscale = -1
	}
	//	Right
	else if direction >= 270 or direction <= 90 {
		image_xscale = 1
	}
}
	
//	Cleanup cellRange
if attackCellRange > -1 and (input.selection != id or input.states != states.combat) {
	grid.destroyCellRange(attackCellRange)
	attackCellRange = -1
}

//	Cleanup highlight cellRange
if highlightCellRange > -1 and (object_index == unitKaren or object_index == unitSJW)
and input.selection == id and gui.menuMouseover != 2 {
	grid.destroyCellRange(highlightCellRange)
	highlightCellRange = -1
	debug.log("Destroying cellRange!")
}