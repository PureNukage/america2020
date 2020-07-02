if input.selection > -1 {
	draw_set_color(c_white)
	var X = 1565
	var Y = 27
	var width = 256
	var height = 256
	draw_rectangle(X,Y,X+width,Y+height,false)

	var scale = 13
	var sprite = s_bigred_head
	var image_width = sprite_get_width(sprite)*scale
	var image_height = sprite_get_height(sprite)*scale
	var difference_in_width = width - image_width
	var difference_in_height = height - image_height
	draw_sprite_ext(sprite,0,X+(difference_in_width/2),Y+(difference_in_height/2),scale,scale,0,c_white,1)

	draw_set_color(c_black)
	draw_set_font(fnt_ui_unitName)
	draw_set_halign(fa_center)
	var String = "Social Justice\nWarrior"
	draw_text(X+width/2,Y+height+16,String)

	draw_set_color(c_white)
	var healthX = X
	var healthY = Y+height+16+string_height(String)+16
	draw_rectangle(healthX,healthY,healthX+width,healthY+64,false)

	var optionBuffer = 64
	var optionX = healthX+width/2
	var optionY = healthY+64+16


	var String = "Move"
	var XX = optionX - string_width(String)/2
	var YY = optionY
	if point_in_rectangle(gui_mouse_x,gui_mouse_y,XX,YY,XX+string_width(String),YY+string_height(String)-8) {
		draw_set_color(c_white)	
	} else {
		draw_set_color(c_black)
	}
	draw_text(optionX,optionY,String)

	////	Debug
	//draw_set_alpha(.5)
	//draw_set_color(c_red)
	//draw_rectangle(XX,YY,XX+string_width(String),YY+string_height(String),false)
	//draw_set_alpha(1)

	optionY += optionBuffer

	var String = "Abilities"
	var XX = optionX - string_width(String)/2
	var YY = optionY
	if point_in_rectangle(gui_mouse_x,gui_mouse_y,XX,YY,XX+string_width(String),YY+string_height(String)-8) {
		draw_set_color(c_white)	
	} else {
		draw_set_color(c_black)
	}
	draw_text(optionX,optionY,String)

	optionY += optionBuffer
}

draw_set_font(-1)
draw_set_halign(fa_left)