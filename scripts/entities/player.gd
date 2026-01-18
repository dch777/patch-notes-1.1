class_name Player extends Entity

var active: bool = false

func start() -> void:
	moves = 5
	active = true

func end() -> void:
	active = false

func map_clicked(map_pos: Vector2i) -> void:
	if active and (path.size() == 0 or map_pos != path[-1]):
		move(map_pos)

func move_finished() -> void:
	if moves == 0:
		finished.emit(self)

func draw(canvas: Canvas) -> void:
	canvas.draw_reachable(moves + 1, map_position, Color.BLACK)
