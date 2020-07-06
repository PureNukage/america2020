//	create unit cell highlight
if game.turnPlayer == object_index {
	if turnCell == -1 and (input.selection == -1 or input.selection != game.playerTurnOrder[| 0].instanceID) {
		var _cellX = game.playerTurnOrder[| 0].instanceID.cellX
		var _cellY = game.playerTurnOrder[| 0].instanceID.cellY
		var _cell = new grid.createCell(_cellX,_cellY,c_yellow,.5,cellRange.ping)
		ds_list_add(grid.cells, _cell)
		turnCell = ds_list_find_index(grid.cells, _cell)
	
		debug.log("Creating turnCell!")
	} 
	//	destroy cell unit highlight
	else if turnCell > -1 and input.selection == game.playerTurnOrder[| 0].instanceID {
		grid.destroyCell(turnCell)
		turnCell = -1
		debug.log("Destroying turnCell!")
	}
}