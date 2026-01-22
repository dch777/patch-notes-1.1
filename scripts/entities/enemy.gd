class_name Enemy extends Entity

@export var max_moves: int = 5

var active: bool = false
var target: Vector2i
var players: Array[Player]
var enemies: Array[Enemy]
var current_attack: Action

func start() -> void:
	entities.assign(controller.find_children("*", "Entity"))

	if health <= 0:
		finished.emit(null)
		queue_free()

	active = true
	moves = max_moves
	players.assign(controller.find_children("*", "Player"))
	players.sort_custom(func (a, b):
		return (a.map_position - map_position).length() > (b.map_position - map_position).length()
	)
	players = players.filter(func(player): return player.health > 0)
	enemies.assign(controller.find_children("*", "Enemy"))

func start_move() -> void:
	target = Vector2i.MAX
	find_target(moves, map_position)
	move(target)

func end() -> void:
	active = false

func move_finished() -> void:
	set_attack()
	finished.emit(self)

func draw(canvas: Canvas) -> void:
	canvas.draw_circle(canvas.convert_vec(map_position), 25, Color.BLACK)

# func draw_selected(canvas: Canvas) -> void:
# 	canvas.draw_reachable(moves + 1, map_position, Color.RED)

func map_clicked(click_position: Vector2i) -> void:
	print(heuristic(click_position))

func find_target(remaining_moves: int, pos: Vector2i):
	if controller.map.is_in_boundsv(pos) and (pos == map_position or !controller.map.is_point_solid(pos)) and remaining_moves > 0:
		if target == Vector2i.MAX or heuristic(target) < heuristic(pos):
			target = pos
		find_target(remaining_moves - 1, pos + Vector2i(1 , 0))
		find_target(remaining_moves - 1, pos + Vector2i(-1, 0))
		find_target(remaining_moves - 1, pos + Vector2i(0 , 1))
		find_target(remaining_moves - 1, pos + Vector2i(0 ,-1))

func draw_target(canvas: Canvas) -> void:
	pass

func heuristic(pos: Vector2i) -> float:
	var h = -999
	for player in players:
		map.set_point_solid(player.map_position, false)
		h = max(h, -map.get_id_path(pos, player.map_position).size())
		map.set_point_solid(player.map_position)
	return h

func set_attack() -> void:
	pass
