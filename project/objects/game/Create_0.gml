turn = 0
turnPlayer = -1
turnUnit = -1
turnList = -1
playerTurnOrder = ds_list_create()
enemyTurnOrder = ds_list_create()

function calculateTurnOrder() {
	
	ds_list_clear(playerTurnOrder)

	var tempWeight = ds_list_create()
	var tempList = ds_list_create()
	
	with player {
		for(var i=0;i<ds_list_size(units);i++) {
			ds_list_add(tempWeight, units[| i].weight)	
		}
	}
	ds_list_sort(tempWeight, false)
	for(var i=0;i<ds_list_size(player.units);i++) {
		var Unit = player.units[| i]
		var index = ds_list_find_index(tempWeight, Unit.weight)
		tempList[| index] = player.units[| i]
	}
	ds_list_copy(playerTurnOrder, tempList)
	ds_list_clear(tempList)
	ds_list_clear(tempWeight)
	
	with enemy {
		for(var i=0;i<ds_list_size(units);i++) {
			ds_list_add(tempWeight, units[| i].weight)
		}
	}
	ds_list_sort(tempWeight, false)
	for(var i=0;i<ds_list_size(enemy.units);i++) {
		var Unit = enemy.units[| i]
		var index = ds_list_find_index(tempWeight, Unit.weight)
		tempList[| index] = enemy.units[| i]
	}
	ds_list_copy(enemyTurnOrder, tempList)
	

	ds_list_destroy(tempWeight)
	ds_list_destroy(tempList)
	
	
}
	
function endTurn() {
	
	//	move unit to end of turn list
	ds_list_add(turnList, turnUnit)
	ds_list_delete(turnList, 0)
	
	//	Change players turns
	if turnPlayer == player {
		turnPlayer = enemy
		turnList = enemyTurnOrder
	}
	else {
		turnPlayer = player
		turnList = playerTurnOrder	
	}
	turnUnit = turnList[| 0]
	
}

calculateTurnOrder()

turnPlayer = player
turnList = playerTurnOrder
turnUnit = turnList[| 0].instanceID