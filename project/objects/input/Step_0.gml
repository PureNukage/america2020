mouseLeftPress = mouse_check_button_pressed(mb_left)

mouseRightPress = mouse_check_button_pressed(mb_right)

mouseMiddle = mouse_check_button(mb_middle)
mouseMiddlePress = mouse_check_button_pressed(mb_middle)
mouseMiddleRelease = mouse_check_button_released(mb_middle)

switch(states)
{
	#region Free
		case states.free:
		
			//	Deselect unit
			if selection > -1 and mouseRightPress {
				deselect()	
			}
	
			if mouseLeftPress {
				if (grid.mouseX > -1 and grid.mouseY > -1) {
					if selection > -1 deselect()
					select(grid.mouseX, grid.mouseY)
				} else if (grid.mouseX == -1 or grid.mouseY == -1) and !gui.mouseover
				or (grid.mouseX > -1 and grid.mouseY > -1 and grid.objectGrid[# grid.mouseX, grid.mouseY] == -1 and input.states == states.free and !gui.mouseover) {
					deselect()
					if input.states != states.free input.states = states.free
				}
			}
		break
	#endregion
	#region Move
		case states.move:
		
			//	Return to free state
			if selection > -1 and mouseRightPress {
				states = states.free
			}
	
			if selection > -1 and (grid.mouseX > -1 and grid.mouseY > -1)
			and (selection.cellX != grid.mouseX or selection.cellY != grid.mouseY) {
				//	If mouseMoved, lets calculate a path
				if grid.mouseMoved {
					mp_grid_clear_cell(grid.mpGrid,selection.cellX,selection.cellY)
					if !pathfind(grid.mpGrid, path, selection.cellX, selection.cellY, grid.mouseX, grid.mouseY, true) {
						
					} else {
						
					}
					mp_grid_add_cell(grid.mpGrid,selection.cellX,selection.cellY)
				}
			
				//	If we have a path and enough stamina to cover it 
				var points = path_get_number(path)-1
				if selection.stamina >= points {
					if mouseLeftPress {
						selection.move(grid.mouseX,grid.mouseY, false, true, true)	
					}
				}
			
			}
		break
	#endregion
	#region Combat
		case states.combat:
		
			if mouseRightPress {
				states = states.free
				if gui.ability > -1 gui.ability = -1
			}
			
			if selection > -1 {
				
				//	The mouse is in a cell!
				if grid.mouseInGrid and (grid.mouseX != selection.cellX or grid.mouseY != selection.cellY) {
					if grid.mouseMoved {
						pathfind(grid.mpGrid, path, selection.cellX, selection.cellY, grid.mouseX, grid.mouseY, false)	
					}
					
					if gui.ability > -1 {
						var ability = selection.myAbilities[| gui.ability]
						var range = ability.range
						var cost = ability.cost
						
						if input.selection.stamina < cost {
							if grid.mouseMoved debug.log("Don't have enough stamina to use this ability")
						} else {
							//	This cell is not near us
							//var points = path_get_number(path)-1
							var points = floor(point_distance(selection.cellX,selection.cellY,grid.mouseX,grid.mouseY))
							if range < points {
								if grid.mouseMoved debug.log("Can't attack here!")		
							} else {
								if grid.mouseMoved debug.log("Can attack here!")
								if mouseLeftPress {
									selection.useAbility(ability)
									input.selection.stamina -= cost
								}
						
							}
						}
					}
				}
				
				
			}
			
		break
	#endregion
}