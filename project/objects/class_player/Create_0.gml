//team = left = 0; right = 1

units = ds_list_create()

function createUnit(_objectIndex, _instanceID, _hp, _hpMax, _cellX, _cellY, _name, _stamina, _staminaMax, _weight, _portrait, _sprite) constructor {
	objectIndex= _objectIndex
	instanceID = _instanceID
	hp = _hp
	hpMax = _hpMax
	cellX = _cellX
	cellY = _cellY
	name = _name
	stamina = _stamina
	staminaMax = _staminaMax
	weight = _weight
	portrait = _portrait
	sprite = _sprite
	
	owner = other.object_index
	
	function spawn(_cellX, _cellY) {
		cellX = _cellX
		cellY = _cellY
		var XX = grid.iso_to_scr_x(cellX, cellY)
		var YY = grid.iso_to_scr_y(cellX, cellY) + grid.cellHeight/2
		instanceID = instance_create_layer(XX,YY,"Instances",objectIndex)
		instanceID.cellX = cellX
		instanceID.cellY = cellY
		instanceID.hp = hp
		instanceID.hpMax = hpMax
		instanceID.stamina = stamina
		instanceID.staminaMax = staminaMax
		instanceID.name = name
		instanceID.portrait = portrait
		instanceID.sprite = sprite
		instanceID.owner = owner
		grid.objectGrid[# cellX, cellY] = instanceID
		mp_grid_add_cell(grid.mpGrid,instanceID.cellX,instanceID.cellY)
	}
}