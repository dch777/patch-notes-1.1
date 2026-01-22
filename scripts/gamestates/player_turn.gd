class_name PlayerTurn extends Gamestate

@export var next_state: Gamestate

var actions: Array[Action] 
var active: bool = false

func enter() -> void:
	entities.assign(controller.find_children("*", "Entity"))

	controller.canvas.hover_enabled = true
	active = true
	for entity in entities:
		if entity is Player:
			entity.start()

func cleanup() -> void:
	controller.canvas.hover_enabled = false
	active = false
	actions.clear()
	for entity in entities:
		if entity and entity is Player:
			entity.end()

func handle_action(action: Action) -> void:
	actions.push_front(action)

func next_turn() -> void:
	finished.emit(next_state)

func undo_action() -> void:
	if actions.size() > 0:
		actions.pop_front().undo()

func next_weapon():
	var selected_entity = controller.selected_entity
	if active and selected_entity and !selected_entity.aiming and selected_entity is Player:
		controller.execute_action(Select.new(selected_entity, (selected_entity.selected_weapon + 1) % selected_entity.weapons.size()))

func prev_weapon():
	var selected_entity = controller.selected_entity
	if active and selected_entity and !selected_entity.aiming and selected_entity is Player:
		if selected_entity.selected_weapon == 0:
			controller.execute_action(Select.new(selected_entity, (selected_entity.weapons.size() - 1)))
		else:
			controller.execute_action(Select.new(selected_entity, (selected_entity.selected_weapon - 1)))

func fire():
	var selected_entity = controller.selected_entity
	if active and selected_entity is Player:
		selected_entity.fire()
