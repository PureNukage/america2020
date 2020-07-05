enum states {
	free,
	walk,
	
	move,
	combat,
}

enum cellRange {
	attackDistance,
	ping,
}

#macro ability_pointTarget 0 
#macro ability_instantUse 1

#macro gui_mouse_x device_mouse_x_to_gui(0)
#macro gui_mouse_y device_mouse_y_to_gui(0)

#macro animation_end (image_index > image_number - 1)

#macro left 0
#macro right 1

#macro c_health make_color_rgb(131,0,0)
#macro c_stamina make_color_rgb(45,77,161)