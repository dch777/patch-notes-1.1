class_name Laser extends Weapon

@export var damage: int = 5

func draw_attack(canvas: Canvas):
	var target_pos = entity.map_position + entity.facing_vector()
	canvas.draw_circle(canvas.convert_vec(target_pos), 25, Color.RED)

	canvas.attacked.set(target_pos, true)
	while entity.map.is_in_boundsv(target_pos) and !entity.map.is_point_solid(target_pos):
		target_pos += entity.facing_vector()
		canvas.draw_circle(canvas.convert_vec(target_pos), 25, Color.RED)
		canvas.attacked.set(target_pos, true)

func attack() -> Entity:
	var target_pos = entity.map_position + entity.facing_vector()
	var target: Entity

	while entity.map.is_in_boundsv(target_pos) and !entity.map.is_point_solid(target_pos):
		target_pos += entity.facing_vector()

	for e in entity.entities:
		if e.map_position == target_pos:
			target = e
			target.hurt(damage)

	return target

func undo(target: Entity):
	if target:
		target.heal(damage)
