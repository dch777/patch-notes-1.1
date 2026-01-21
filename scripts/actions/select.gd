class_name Select extends Action

var old_weapon: int
var new_weapon: int

func _init(e: Entity = null, w: int = 0):
	entity = e
	old_weapon = entity.selected_weapon
	new_weapon = w

func execute():
	entity.selected_weapon = new_weapon

func undo():
	entity.selected_weapon = old_weapon
