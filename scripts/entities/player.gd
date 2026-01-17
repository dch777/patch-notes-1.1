class_name Player extends Entity

var active: bool = false

func start() -> void:
	active = true

func end() -> void:
	active = false

func map_clicked(map_pos: Vector2i) -> void:
	if active and (path.size() == 0 or map_pos != path[-1]):
		move(map_pos)

func move_finished() -> void:
	finished.emit(self)
