team = left //	left = 0; right = 1

units = ds_list_create()

function createUnit(_objectIndex, _instanceID, _hp, _hpTotal, _cellX, _cellY) constructor {
	objectIndex= _objectIndex
	instanceID = _instanceID
	hp = _hp
	hpTotal = _hpTotal
	cellX = _cellX
	cellY = _cellY
	
	function spawn() {
		var XX = grid.iso_to_scr_x(cellX, cellY)
		var YY = grid.iso_to_scr_y(cellX, cellY) + grid.cellHeight/2
		instanceID = instance_create_layer(XX,YY,"Instances",objectIndex)
		instanceID.cellX = cellX
		instanceID.cellY = cellY
		grid.objectGrid[# cellX, cellY] = instanceID
		mp_grid_add_cell(grid.mpGrid,instanceID.cellX,instanceID.cellY)
	}
}

units[| 0] = new createUnit(unitSJW, -1, 5, 5, 3, 3)
units[| 0].spawn()