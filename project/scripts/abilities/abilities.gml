function melee() {
	
	var cellAttackX = -1
	var cellAttackY = -1
	
	//var meleeState = 0	//	-1 == first frame; 0 == moving to; 1 == attacking; 2 == returning to
	
	switch(meleeState)
	{
		//	First Frame
		case -1:
			attackCellX = grid.mouseX
			attackCellY = grid.mouseY
			move(attackCellX, attackCellY, true, false, false)
			meleeState = 0
			debug.log("COMBAT - MELEE First Frame")
			return true
		break
		//	Moving to the attacked unit
		case 0:
			if point_distance(x,y,x_goto,y_goto) < 2 {
				if ++pos >= path_get_number(path) {
					meleeState = 1
					states = states.free
					speed = 0
				}
			}
			debug.log("COMBAT - MELEE Moving to the attacked unit")
			return true
		break
		//	Attacking
		case 1:
			if animation_end {
				move(cellX, cellY, true, false, false, attackCellX, attackCellY)
				meleeState = 2	
			}
			debug.log("COMBAT - MELEE Attacking")
			return true
		break
		//	Return to the home cell
		case 2:
			if point_distance(x,y,x_goto,y_goto) < 2 {
				if ++pos >= path_get_number(path) {
					meleeState = -1
					states = states.free
					speed = 0
					return false
				}
			}
			debug.log("COMBAT - MELEE Returning to the home cell")
			return true
		break
	}
}

function shoot() {
	
}	

function explode() {
		
}