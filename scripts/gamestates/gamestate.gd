class_name Gamestate extends Node2D

var controller: GamestateController
var hud: Control
var entities: Array[Entity]

signal finished(next_state: Gamestate)

func setup() -> void:
	controller = get_parent()
	hud = controller.hud
	entities = controller.entities
	finished.connect(controller.change_state)

	init()
	
func init() -> void:
	pass

func enter() -> void:
	pass

func cleanup() -> void:
	pass

func entity_finished(entity: Entity) -> void:
	pass

func handle_action(action: Action) -> void:
	pass
