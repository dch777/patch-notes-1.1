class_name Player extends Entity

var active: bool = false

func start() -> void:
	moves = 5
	active = true

func end() -> void:
	active = false

func map_clicked(click_position: Vector2i) -> void:
	var new_path = map.get_id_path(map_position, click_position)
	if active and (new_path.size() > 0 and new_path.size() - 1 <= moves) and (path.size() == 0 or click_position != path[-1]):
		execute_action.emit(Teleport.new(self, map_position, click_position))
	# elif active:
	# 	controller.entity_deselected()
	# 	selected = false
	# 	deselect()

func move_finished() -> void:
	if moves == 0:
		finished.emit(self)

func draw(canvas: Canvas) -> void:
	canvas.draw_circle(canvas.convert_vec(map_position), 25, Color.BLACK)

func draw_selected(canvas: Canvas) -> void:
	canvas.draw_reachable(moves + 1, map_position, Color.DIM_GRAY)
