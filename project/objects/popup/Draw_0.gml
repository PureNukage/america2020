draw_set_color(color)
draw_set_halign(fa_center)
draw_set_valign(fa_middle)
draw_text(x,y,String)

y--

draw_reset()

if time.stream >= spawnTime + duration {
	instance_destroy()
}