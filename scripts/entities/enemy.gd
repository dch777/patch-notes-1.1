class_name Enemy extends Entity

var active: bool = false

func start() -> void:
	active = true
	move(Vector2i((randi() % 10) - 5, (randi() % 10) - 5))

func end() -> void:
	active = false

func move_finished() -> void:
	finished.emit(self)

func draw(canvas: Canvas, offset: Vector2) -> void:
	canvas.draw_circle(Vector2(map_position) + offset, 2, Color.RED)
