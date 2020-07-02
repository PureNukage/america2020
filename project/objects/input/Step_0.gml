mouseLeftPress = mouse_check_button_pressed(mb_left)

mouseMiddle = mouse_check_button(mb_middle)
mouseMiddlePress = mouse_check_button_pressed(mb_middle)
mouseMiddleRelease = mouse_check_button_released(mb_middle)

if mouseLeftPress {
	if grid.mouseX > -1 and grid.mouseY > -1 and selection == -1 {
		var Object = grid.objectGrid[# grid.mouseX, grid.mouseY]
		if Object > -1 {
			selection = Object
			Object.selected = true
		}	
	} else if grid.mouseX == -1 or grid.mouseY == -1 {
		if selection > -1 selection.selected = false
		selection = -1
	}
}