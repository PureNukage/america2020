if game.turnPlayer == object_index {
	
	var myUnit = game.turnUnit
	var ability = myUnit.myAbilities[| 0]
	//var unitAttackType = ability.Function
	var unitAttackRange = ability.range
	
	//// gather data on this unit
	var listEnemiesAttack = ds_list_create()
	var listEnemiesAttackMove = ds_list_create()
	var listTargetsAttack = ds_list_create()
	var listTargetsAttackMove = ds_list_create()
	
	//	loop through enemy units and put data into lists
	for(var i=0;i<ds_list_size(game.playerTurnOrder);i++) {
		var Unit = game.playerTurnOrder[| i].instanceID
		var enemyAbilityRange = Unit.myAbilities[| 0].range
		
		var pointDistance = floor(abs(point_distance(Unit.cellX,Unit.cellY, myUnit.cellX,myUnit.cellY)))
		var _path = path_add()
		if pathfind(grid.mpGrid,_path,Unit.cellX,Unit.cellY, myUnit.cellX,myUnit.cellY, false) {
			var pointPath = path_get_number(_path) - 1
			
			if pointPath < 0 {
				pointPath = 0	
			}
		
			//	Enemy unit not within attack range
			if pointDistance < enemyAbilityRange {
			
			} 
			//	Enemy unit is within attack range
			else {
				ds_list_add(listEnemiesAttack, Unit)
			}
		
			//	todo:	Enemy unit not within attack+move range
		
		
		
			//	target is NOT within attack range
			if unitAttackRange < pointDistance {
				
			}
			//	target is within attack range
			else {
				ds_list_add(listTargetsAttack, Unit)
			}
		
			//	target is NOT within move+attack range
			if  unitAttackRange >= pointDistance + pointPath {
			
			} 
			//	target is within move+attack range
			else {
				ds_list_add(listTargetsAttackMove, Unit)
			}
		
			if path_exists(_path) path_delete(_path)
		}
		
	}
	
	
	//	lets attack a target without moving
	if !ds_list_empty(listTargetsAttack) {
		var target = listTargetsAttack[| 0]
		
		myUnit.attackCellX = target.cellX
		myUnit.attackCellY = target.cellY
		myUnit.useAbility(ability)
		
		game.endTurn()
	} 
	//	lets attack a target by moving and then attacking
	else if !ds_list_empty(listTargetsAttackMove) {
			
	}
	
	
	
	//	cleanup data structures
	ds_list_destroy(listEnemiesAttack)
	ds_list_destroy(listEnemiesAttackMove)
	ds_list_destroy(listTargetsAttack)
	ds_list_destroy(listTargetsAttackMove)
	
	
	
}