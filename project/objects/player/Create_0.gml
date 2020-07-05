event_inherited()

team = left

units[| 0] = new createUnit(unitSJW, -1, 5, 5, -1, -1, "Social Justice\nWarrior", 5, 5, 2, s_bigred_head, s_bigred)
units[| 1] = new createUnit(unitFbi, -1, 5, 5, -1, -1, "FBI Agent", 5, 5, 3, s_fbi_head, s_fbi)
units[| 2] = new createUnit(unitAntifa, -1, 5, 5, -1, -1, "Antifa", 5, 5, 4, s_antifa_head, s_antifa)
units[| 0].spawn(4,0)
units[| 1].spawn(4,2)
units[| 2].spawn(4,4)

turnCell = -1