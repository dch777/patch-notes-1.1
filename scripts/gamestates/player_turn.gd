class_name PlayerTurn extends Gamestate

@export var next_state: Gamestate

var remaining_players = 0
var actions: Array[Action] 
var active: bool = false

func enter() -> void:
	controller.canvas.hover_enabled = true
	active = true
	for entity in entities:
		if entity is Player:
			remaining_players += 1
			entity.start()

func cleanup() -> void:
	controller.canvas.hover_enabled = false
	active = false
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

func next_weapon():
	var selected_entity = controller.selected_entity
	if active and !selected_entity.aiming and selected_entity is Player:
		handle_action(Select.new(selected_entity, (selected_entity.selected_weapon + 1) % selected_entity.weapons.size()))

func prev_weapon():
	var selected_entity = controller.selected_entity
	if active and !selected_entity.aiming and selected_entity is Player:
		handle_action(Select.new(selected_entity, (selected_entity.selected_weapon - 1)))

func fire():
	var selected_entity = controller.selected_entity
	if active and selected_entity is Player:
		selected_entity.fire()
