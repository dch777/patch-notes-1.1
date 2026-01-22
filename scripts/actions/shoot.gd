class_name Shoot extends Action

@export var direction: Vector2i
@export var damage: int

var target: Entity

func _init(e: Entity = null, d: Vector2i = Vector2i(0, 0), dmg: int = 0):
	entity = e
	direction = d
	damage = dmg

func execute():
	var target_pos = entity.map_position + direction
	while entity.map.is_in_boundsv(target_pos) and !entity.map.is_point_solid(target_pos):
		target_pos += direction

	for e in entity.entities:
		if e and e.map_position == target_pos:
			target = e
			target.hurt(damage)

func undo():
	if target:
		target.heal(damage)
