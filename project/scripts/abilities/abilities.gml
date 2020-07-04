function melee() {
	
	switch(meleeState)
	{
		//	First Frame
		case -1:
			attackCellX = grid.mouseX
			attackCellY = grid.mouseY
			move(attackCellX, attackCellY, true, false, false)
			meleeState = 0
			debug.log("COMBAT - MELEE Moving to the attacked unit")
			return true
		break
		//	Moving to the attacked unit
		case 0:
			if point_distance(x,y,x_goto,y_goto) < 2 {
				if ++pos >= path_get_number(path) {
					meleeState = 1
					states = states.free
					speed = 0
					sprite_index = myAbilities[| activeAbilityIndex].sprite
					debug.log("COMBAT - MELEE Attacking!")
				}
			}
			return true
		break
		//	Attacking
		case 1:
			if animation_end {
				move(cellX, cellY, true, false, false, attackCellX, attackCellY)
				meleeState = 2
				
				//	Apply damage to attacked unit
				var attackedUnit = grid.objectGrid[# attackCellX, attackCellY]
				if attackedUnit > -1 and attackedUnit != id {
					attackedUnit.hp -= 1
					attackedUnit.damaged = true
					attackedUnit.damagedTime = time.stream
				}
				
				sprite_index = sprite
				
				debug.log("COMBAT - MELEE Returning to the home cell")
			}
			return true
		break
		//	Return to the home cell
		case 2:
			if point_distance(x,y,x_goto,y_goto) < 2 {
				if ++pos >= path_get_number(path) {
					meleeState = -1
					states = states.free
					speed = 0
					attackCellX = -1
					attackCellY = -1
					debug.log("COMBAT - MELEE Finished")
					return false
				}
			}
			return true
		break
	}
	
}

function shoot() {
	
}	

function explode() {
		
}