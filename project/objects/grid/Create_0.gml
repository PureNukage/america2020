cellWidth = 64
cellHeight = 64

gridWidth = room_width / cellWidth
gridHeight = room_height / cellHeight

gridWidth = 4
gridHeight = 4

sX = room_width/2
sY = room_height/3

mouseX = -1
mouseY = -1

function iso_to_scr_x(cellX, cellY) {
	return sX + (cellX - cellY) * cellWidth
}

function iso_to_scr_y(cellX, cellY) {
	return sY + (cellX + cellY) * cellHeight/2
}

function scr_x_to_iso(X, Y) {
	
}

mpGrid = mp_grid_create(sX,sY,gridWidth,gridHeight,cellWidth,cellHeight)