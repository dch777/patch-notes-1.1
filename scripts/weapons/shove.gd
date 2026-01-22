class_name Shove extends Weapon

func draw_attack(canvas: Canvas):
	var shove_pos = entity.map_position + entity.facing_vector()
	canvas.draw_circle(canvas.convert_vec(shove_pos), 25, Color.RED)

func attack() -> Entity:
	var shove_pos = entity.map_position + entity.facing_vector()
	var target: Entity

	for e in entity.entities:
		if e.map_position == shove_pos:
			target = e
			target.teleport(target.map_position + entity.facing_vector(), false)

	return target

func undo(target: Entity):
	if target:
		target.teleport(target.map_position - entity.facing_vector(), false)
