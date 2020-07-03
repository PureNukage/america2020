selection = -1

mouseLeftPress = mouse_check_button_pressed(mb_left)

mouseRightPress = mouse_check_button_pressed(mb_right)

mouseMiddle = mouse_check_button(mb_middle)
mouseMiddlePress = mouse_check_button_pressed(mb_middle)
mouseMiddleRelease = mouse_check_button_released(mb_middle)

states = states.free

path = path_add()

function select(cellX, cellY) {
	var Object = grid.objectGrid[# cellX, cellY]
	if Object > -1 {
		selection = Object
		Object.selected = true
		//debug.log("Selecting "+string_upper(object_get_name(selection.object_index)) + " id: "+string(selection))
	}	
}

function deselect() {
	if selection > -1 {
		//debug.log("Deselecting "+string_upper(object_get_name(selection.object_index)) + " id: "+string(selection))
		selection.selected = false	
	}
	selection = -1
}