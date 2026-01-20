class_name PlayerTurn extends Gamestate

@export var next_state: Gamestate

var remaining_players = 0
var actions: Array[Action] 

func enter() -> void:
	controller.canvas.hover_enabled = true
	for entity in entities:
		if entity is Player:
			remaining_players += 1
			entity.start()

func cleanup() -> void:
	controller.canvas.hover_enabled = false
	actions.clear()
	for entity in entities:
		if entity is Player:
			entity.end()

func entity_finished(entity: Entity) -> void:
	remaining_players -= 1
	if remaining_players == 0:
		finished.emit(next_state)

func handle_action(action: Action) -> void:
	actions.push_front(action)

func undo_action() -> void:
	if actions.size() > 0:
		actions.pop_front().undo()
