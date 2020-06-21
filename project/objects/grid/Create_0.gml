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
	var XX = X - sX
	var YY = Y - sY
	return floor((XX / grid.cellWidth + YY / (grid.cellHeight/2)) /2)
}

function scr_y_to_iso(X, Y) {
	var XX = X - sX
	var YY = Y - sY
	return floor((YY / (grid.cellHeight/2) - XX / (grid.cellWidth)) /2)
}

mpGrid = mp_grid_create(sX,sY,gridWidth,gridHeight,cellWidth,cellHeight)

objectGrid = ds_grid_create(gridWidth,gridHeight)
ds_grid_set_region(objectGrid,0,0,gridWidth-1,gridHeight-1,-1)