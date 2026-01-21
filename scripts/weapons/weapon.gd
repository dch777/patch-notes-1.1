class_name Weapon extends Resource

var entity: Entity
@export var icon: Texture2D

func _init(e: Entity = null):
	entity = e

func draw_attack(canvas: Canvas):
	pass

func attack() -> Entity:
	return null

func undo(target: Entity):
	pass
