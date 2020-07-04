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
	var stillGoing = script_execute(activeAbility)
	if !stillGoing {
		activeAbility = -1	
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