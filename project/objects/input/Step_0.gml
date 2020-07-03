mouseLeftPress = mouse_check_button_pressed(mb_left)

mouseRightPress = mouse_check_button_pressed(mb_right)

mouseMiddle = mouse_check_button(mb_middle)
mouseMiddlePress = mouse_check_button_pressed(mb_middle)
mouseMiddleRelease = mouse_check_button_released(mb_middle)

switch(states)
{
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
	case states.move:
		
		//	Return to free state
		if selection > -1 and mouseRightPress {
			states = states.free	
		}
	
		if selection > -1 and (grid.mouseX > -1 and grid.mouseY > -1)
		and (selection.cellX != grid.mouseX or selection.cellY != grid.mouseY) {
			//	If mouseMoved, lets calculate a path
			if grid.mouseMoved {
				var x1 = grid.sX + (selection.cellX * grid.cellWidth) + (grid.cellWidth/2)
				var y1 = grid.sY + (selection.cellY * grid.cellHeight) + (grid.cellHeight/2)
	
				var x2 = grid.sX + (grid.mouseX * grid.cellWidth) + (grid.cellWidth/2)
				var y2 = grid.sY + (grid.mouseY * grid.cellHeight) + (grid.cellHeight/2)
				
				mp_grid_clear_cell(grid.mpGrid,selection.cellX,selection.cellY)
				
				if !mp_grid_path(grid.mpGrid,path,x1,y1,x2,y2,false) {
					debug.log("Cannot form a path to the goal")
					mp_grid_add_cell(grid.mpGrid,selection.cellX,selection.cellY)
				} else {
					//	How many points in this path
					var points = path_get_number(path)-1
					//debug.log("This path has ["+ string(points) +"] points")
					mp_grid_add_cell(grid.mpGrid,selection.cellX,selection.cellY)
					
				}	
			}
			
			//	If we have a path and enough stamina to cover it 
			var points = path_get_number(path)-1
			if selection.stamina >= points {
				if mouseLeftPress {
					selection.move(grid.mouseX,grid.mouseY)	
				}
			}
			
		}
	break
	case states.combat:
		
	break
}