class_name Enemy extends Entity

var active: bool = false

func start() -> void:
	active = true
	moves = 5
	move(Vector2i((randi() % 10) - 5, (randi() % 10) - 5))

func end() -> void:
	active = false

func map_clicked(map_pos: Vector2i) -> void:
	controller.entity_deselected()
	selected = false
	deselect()

func move_finished() -> void:
	finished.emit(self)

func draw(canvas: Canvas) -> void:
	canvas.draw_reachable(moves + 1, map_position, Color.RED)
