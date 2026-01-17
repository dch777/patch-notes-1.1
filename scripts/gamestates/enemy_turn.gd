class_name EnemyTurn extends Gamestate

@export var next_state: Gamestate

var remaining_enemies = 0

func enter() -> void:
	print("enemy turn")
	for entity in entities:
		if entity is Enemy:
			remaining_enemies += 1
			entity.start()

func cleanup() -> void:
	for entity in entities:
		if entity is Enemy:
			entity.end()

func entity_finished(entity: Entity) -> void:
	remaining_enemies -= 1
	if remaining_enemies == 0:
		finished.emit(next_state)
