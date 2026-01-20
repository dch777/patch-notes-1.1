class_name Ranged extends Enemy

func draw_target(canvas: Canvas) -> void:
	if current_attack:
		var target_pos = map_position + current_attack.direction
		canvas.draw_circle(canvas.convert_vec(target_pos), 25, Color.RED)
		canvas.attacked.set(target_pos, true)
		while map.is_in_boundsv(target_pos) and !map.is_point_solid(target_pos):
			target_pos += current_attack.direction
			canvas.draw_circle(canvas.convert_vec(target_pos), 25, Color.RED)
			canvas.attacked.set(target_pos, true)

func heuristic(pos: Vector2i) -> float:
	var h = 0
	var attackable = false
	for player in players:
		map.set_point_solid(player.map_position, false)
		var d = map.get_id_path(pos, player.map_position).size()
		h -= d
		if (player.map_position.x == pos.x or player.map_position.y == pos.y) and d - 1 == (player.map_position - pos).length() and !attackable:
			h += 10
			attackable = true
		if (player.map_position - pos).length() <= 5:
			h -= 4 * (5 - (player.map_position - pos).length())
		if controller.canvas.attacked.has(pos):
			h -= 40
		map.set_point_solid(player.map_position)
	for enemy in enemies:
		if enemy is Ranged:
			if (enemy.map_position.x == pos.x or enemy.map_position.y == pos.y):
				h -= 7
	return h

func set_attack() -> void:
	for player in players:
		map.set_point_solid(player.map_position, false)
		var d = map.get_id_path(map_position, player.map_position).size()
		if (player.map_position.x == map_position.x or player.map_position.y == map_position.y) and d - 1 == (player.map_position - map_position).length():
			current_attack = Shoot.new(self, (player.map_position - map_position).clampi(-1, 1), 3)
		map.set_point_solid(player.map_position)
