class_name Fire extends Action

var target: Entity
var start_facing: Entity.Direction

func _init(e: Entity = null, d: Entity.Direction = 0):
	entity = e
	start_facing = d

func execute():
	target = entity.weapons[entity.selected_weapon].attack()

func undo():
	entity.weapons[entity.selected_weapon].undo(target)
	entity.facing = start_facing
