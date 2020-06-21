switch(states) 
{
	case states.free:
		if selected and input.mouseLeftPress and (grid.mouseX > -1 and grid.mouseY > -1) 
		and (grid.mouseX != cellX or grid.mouseY != cellY) {
			
			if instance_exists(debugBeacon) with debugBeacon {
				instance_destroy()
			}
	
			goalCellX = grid.mouseX
			goalCellY = grid.mouseY
	
			var x1 = grid.sX + (cellX * grid.cellWidth) + (grid.cellWidth/2)
			var y1 = grid.sY + (cellY * grid.cellHeight) + (grid.cellHeight/2)
	
			var x2 = grid.sX + (goalCellX * grid.cellWidth) + (grid.cellWidth/2)
			var y2 = grid.sY + (goalCellY * grid.cellHeight) + (grid.cellHeight/2)
			
			mp_grid_clear_cell(grid.mpGrid,cellX,cellY)
	
			//	We CANNOT path to the goal
			if !mp_grid_path(grid.mpGrid,path,x1,y1,x2,y2,false) {
				debug.log("Can't find path to this goal!")
				mp_grid_add_cell(grid.mpGrid,cellX,cellY)
			} 
			//	We can path to the goal!
			else {
				//	Try and convert the path to isometric coordinates
				for(var p=0;p<path_get_number(path);p++) {
					var pX = path_get_point_x(path, p)
					var pY = path_get_point_y(path, p)
			
					mp_grid_get_cell(grid.mpGrid,pX,pY)
			
					var _cellX = floor( (pX - grid.sX)/grid.cellWidth )
					var _cellY = floor( (pY - grid.sY)/grid.cellHeight )
			
					var newX = grid.iso_to_scr_x(_cellX, _cellY)
					var newY = grid.iso_to_scr_y(_cellX, _cellY) + (grid.cellHeight/2)
					
					//instance_create_layer(newX,newY,"Instances",debugBeacon)
					
					path_change_point(path, p, newX, newY, path_get_speed(path, p))	
				}
				
				goalX = path_get_point_x(path,path_get_number(path)-1)
				goalY = path_get_point_y(path,path_get_number(path)-1)
				
				goalX = newX
				goalY = newY
				
				pos = 0
				
				x_goto = path_get_point_x(path,pos)
				y_goto = path_get_point_y(path,pos)
				
				states = states.walk
				
			}
		}	
	break
	case states.walk:
	
		if point_distance(x,y,x_goto,y_goto) < 2 {
			if ++pos == path_get_number(path) {
				states = states.free
				grid.objectGrid[# cellX, cellY] = -1
				mp_grid_clear_cell(grid.mpGrid,cellX,cellY)
				cellX = goalCellX
				cellY = goalCellY
				grid.objectGrid[# cellX, cellY] = id
				mp_grid_add_cell(grid.mpGrid,cellX,cellY)
				goalCellX = -1
				goalCellY = -1
				speed = 0
			} else {
				x_goto = path_get_point_x(path,pos)
				y_goto = path_get_point_y(path,pos)
				move_towards_point(x_goto,y_goto,4)
				
				var iso_x = grid.scr_x_to_iso(x_goto,y_goto)
				var iso_y = grid.scr_y_to_iso(x_goto,y_goto)
				
				grid.objectGrid[# cellX, cellY] = -1
				mp_grid_clear_cell(grid.mpGrid,cellX,cellY)
				
				cellX = iso_x
				cellY = iso_y
				
				grid.objectGrid[# cellX, cellY] = id
				mp_grid_add_cell(grid.mpGrid,cellX,cellY)

			}	
		}
		
	break
}