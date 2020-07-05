////	Draw turn order
var centerX = display_get_gui_width()/2
var centerY = 32
var tileWidth = 64
var tileHeight = 64
var tileSpacer = 16
var playerUnits = ds_list_size(game.playerTurnOrder)
var enemyUnits = ds_list_size(game.enemyTurnOrder)
var totalUnits = playerUnits + enemyUnits
	
var tileX = centerX - (totalUnits/2 * (tileWidth+tileSpacer))
var tileY = centerY
	
var first = 0	//	0 = player, 1 = enemy
var playerOrder = 0
var enemyOrder = 0
var Portrait = 0
var Color = 0
for(var t=0;t<totalUnits;t++) {
	//	Players unit
	if first == 0 {
		if !ds_list_empty(game.playerTurnOrder) {
			Portrait = game.playerTurnOrder[| playerOrder].portrait
			if player.team == left Color = c_stamina else Color = c_health
		}
	} 
	//	Enemy unit
	else {
		if !ds_list_empty(game.enemyTurnOrder) {
			Portrait = game.enemyTurnOrder[| enemyOrder].portrait
			if enemy.team == left Color = c_stamina else Color = c_health
		}
	}
	draw_set_color(c_white)
	draw_rectangle(tileX,tileY,tileX+tileWidth,tileY+tileHeight,false)
	draw_set_alpha(.6)
	draw_set_color(Color)
	draw_rectangle(tileX,tileY,tileX+tileWidth,tileY+tileHeight,false)
	draw_set_alpha(1)
	var Scale = 3
	var spriteWidth = tileWidth - (sprite_get_width(Portrait)*Scale)
	var spriteHeight = tileHeight - (sprite_get_height(Portrait)*Scale)
	var spriteX = tileX + spriteWidth/2
	var spriteY = tileY + spriteHeight/2
	draw_sprite_ext(Portrait,0,spriteX,spriteY,Scale,Scale,0,c_white,1)
		
	tileX += tileWidth + tileSpacer
		
	if first == 0 playerOrder++
	else enemyOrder++
	first = !first
	if playerOrder >= ds_list_size(game.playerTurnOrder) playerOrder = 0
	if enemyOrder >= ds_list_size(game.enemyTurnOrder) enemyOrder = 0
}

if input.selection > -1 and instance_exists(input.selection) {
	
	draw_set_color(c_white)
	var X = 1565
	var Y = 27
	var width = 256
	var height = 256
	draw_rectangle(X,Y,X+width,Y+height,false)

	var scale = 11
	var sprite = input.selection.portrait
	var image_width = sprite_get_width(sprite)*scale
	var image_height = sprite_get_height(sprite)*scale
	var difference_in_width = width - image_width
	var difference_in_height = height - image_height
	draw_sprite_ext(sprite,0,X+(difference_in_width/2),Y+(difference_in_height/2),scale,scale,0,c_white,1)

	draw_set_color(c_black)
	draw_set_font(fnt_ui_unitName)
	draw_set_halign(fa_center)
	var String = input.selection.name
	draw_text(X+width/2,Y+height+16,String)

	draw_set_color(c_gray)
	var healthX = X - width - 16
	var healthY = Y
	draw_rectangle(healthX,healthY,healthX+width,healthY+64,false)
	draw_set_color(c_health)
	var healthWidth = (input.selection.hp / input.selection.hpMax) * width
	draw_rectangle(healthX,healthY,healthX+healthWidth,healthY+64,false)
	draw_set_color(c_white)
	draw_text(healthX+width/2,healthY+6,string(input.selection.hp) + " / " + string(input.selection.hpMax))
	
	draw_set_color(c_gray)
	var staminaX = healthX
	var staminaY = healthY + 64 + 16
	draw_rectangle(staminaX,staminaY,staminaX+width,staminaY+64,false)
	draw_set_color(c_stamina)
	var staminaWidth = (input.selection.stamina / input.selection.staminaMax) * width
	draw_rectangle(staminaX,staminaY,staminaX+staminaWidth,staminaY+64,false)
	draw_set_color(c_white)
	draw_text(staminaX+width/2,staminaY+6,string(input.selection.stamina) + " / " + string(input.selection.staminaMax))

	var optionBuffer = 64
	var optionX = X+width/2
	var optionY = Y+height+16+64+64+32


	var String = "Move"
	var XX = optionX - string_width(String)/2
	var YY = optionY
	if point_in_rectangle(gui_mouse_x,gui_mouse_y,XX,YY,XX+string_width(String),YY+string_height(String)-8) {
		draw_set_color(c_white)
		if input.mouseLeftPress {
			if input.states == states.move {
				input.states = states.free	
			} else {
				input.states = states.move
			}
		}
	} else {
		draw_set_color(c_black)
	}
	if input.states == states.move draw_set_color(c_yellow)
	draw_text(optionX,optionY,String)

	////	Debug
	//draw_set_alpha(.5)
	//draw_set_color(c_red)
	//draw_rectangle(XX,YY,XX+string_width(String),YY+string_height(String),false)
	//draw_set_alpha(1)

	optionY += optionBuffer

	var String = "Combat"
	var XX = optionX - string_width(String)/2
	var YY = optionY
	draw_set_color(c_dkgray)
	draw_text(optionX,optionY,String)

	optionY += optionBuffer
	
	//	Draw abilities if they exist for this unit
	var abilityCount = ds_list_size(input.selection.myAbilities)
	for(var a=0;a<abilityCount;a++) {
		var Ability = input.selection.myAbilities[| a]
		var abilityName = Ability.name	
		
		var XX = optionX - string_width(String)/2
		var YY = optionY
		if point_in_rectangle(gui_mouse_x,gui_mouse_y,XX,YY,XX+string_width(abilityName),YY+string_height(abilityName)-1) {
			if input.mouseLeftPress {
				if input.states == states.combat {
					input.states = states.free	
					ability = -1
				} else {
					//	Instant Use ability
					if Ability.type == ability_instantUse {
						ability = a
						input.selection.useAbility(input.selection.myAbilities[| a])
						ability = -1
						input.states = states.free
					} 
					//	Point Target ability
					else if Ability.type == ability_pointTarget {
						input.states = states.combat
						ability = a
					}
				}
			}
			draw_set_color(c_white)
		} else {
			draw_set_color(c_black)
		}
		if ability == a draw_set_color(c_yellow)
		
		draw_text(optionX,optionY,abilityName)
		optionY += optionBuffer
	}
	
	if point_in_rectangle(gui_mouse_x,gui_mouse_y,X,Y,X+width,optionY) {
		mouseover = true
	} else mouseover = false
}

draw_set_font(-1)
draw_set_halign(fa_left)