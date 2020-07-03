event_inherited()

team = right

units[| 0] = new createUnit(unitScooter, -1, 5, 5, -1, -1, "Scooter", 5, 5, 2, s_scooter_head)
units[| 1] = new createUnit(unitKaren, -1, 5, 5, -1, -1, "Karen", 5, 5, 3, s_karen_head)
units[| 2] = new createUnit(unitTrumper, -1, 5, 5, -1, -1, "Trumper", 5, 5, 4, s_trumper_head)
units[| 0].spawn(0,0)
units[| 1].spawn(0,2)
units[| 2].spawn(0,4)