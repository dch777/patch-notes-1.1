class_name PlayerTurn extends Gamestate

@export var next_state: Gamestate

var remaining_players = 0

func enter() -> void:
	print("player turn")
	for entity in entities:
		if entity is Player:
			remaining_players += 1
			entity.start()

func cleanup() -> void:
	for entity in entities:
		if entity is Player:
			entity.end()

func entity_finished(entity: Entity) -> void:
	remaining_players -= 1
	if remaining_players == 0:
		finished.emit(next_state)
