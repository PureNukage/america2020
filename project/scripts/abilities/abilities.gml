function melee() {
	
	switch(attackState)
	{
		//	First Frame
		case -1:
			attackCellX = grid.mouseX
			attackCellY = grid.mouseY
			move(attackCellX, attackCellY, true, false, false)
			attackState = 0
			debug.log("COMBAT - MELEE Moving to the attacked unit")
			return true
		break
		//	Moving to the attacked unit
		case 0:
			if point_distance(x,y,x_goto,y_goto) < 2 {
				if ++pos >= path_get_number(path) {
					attackState = 1
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
				attackState = 2
				
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
					attackState = -1
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
	sprite_index = s_explosion
	
	//	Apply the damage to exploded targets
	if attackState == -1 {
		var range = activeAbility.range
		var x1 = cellX-range
		var y1 = cellY-range
		var x2 = cellX+range
		var y2 = cellY+range
		for(var w=x1;w<=x2;w++) {
			for(var h=y1;h<=y2;h++) {
				if (w > -1 and w < grid.gridWidth) and (h > -1 and h < grid.gridHeight) {
					if grid.objectGrid[# w, h] > -1 and grid.objectGrid[# w, h] != id {
						var damagedUnit = grid.objectGrid[# w, h]
						damagedUnit.hp -= activeAbility.damage
						damagedUnit.damaged = true
						damagedUnit.damagedTime = time.stream
					}
				}
			}
		}
		attackState = 0
	}
	
	if animation_end {
		die()
	}
	//	Still exploding
	else {
		return true
	}
}