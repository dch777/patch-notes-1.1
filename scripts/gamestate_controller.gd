class_name GamestateController extends Node2D

@export_group("Gamestates")
var current_state: Gamestate

@export var start_state: Gamestate

@export_group("TileMapLayers")
@export var background: TileMapLayer
@export var foreground: TileMapLayer

@export_group("Navigation")
var map: AStarGrid2D
@onready var hover_shader: ShaderMaterial = preload("res://assets/materials/hover.tres")

@export var diagonal_mode: AStarGrid2D.DiagonalMode = AStarGrid2D.DiagonalMode.DIAGONAL_MODE_NEVER
@export var hover_shader_enabled: bool = false

var turn: int = 0
var selected_entity: Entity
var entities: Array[Entity]
var hud: Control

func _ready():
	map = AStarGrid2D.new()
	map.set_diagonal_mode(diagonal_mode)
	map.set_region(background.get_used_rect())
	map.update()

	for cell in foreground.get_used_cells():
		map.set_point_solid(cell)

	entities.assign(find_children("*", "Entity"))
	hud = find_child("hud")
	for state in find_children("*", "Gamestate"):
		state.setup()
	for entity in entities:
		entity.setup()

	change_state(start_state)

func _process(delta: float):
	var hovered_cell = background.local_to_map(get_local_mouse_position())
	var hovered_cell_global_coords = map_to_global(hovered_cell)
	var reachable = map.is_in_boundsv(hovered_cell) && !map.is_point_solid(hovered_cell)
	hover_shader.set_shader_parameter("highlighted_cell", hovered_cell_global_coords)
	hover_shader.set_shader_parameter("reachable", reachable)

	if Input.is_action_just_released("select"):
		if selected_entity and reachable:
			selected_entity.map_clicked(hovered_cell)

func change_state(next_state: Gamestate):
	if current_state != null:
		entity_deselected()
		current_state.cleanup()
	current_state = next_state
	current_state.enter()

func entity_finished(entity: Entity):
	current_state.entity_finished(entity)

func entity_selected(entity: Entity):
	entity_deselected()
	selected_entity = entity

func entity_deselected():
	if selected_entity:
		selected_entity.selected = false
		selected_entity.deselect()
	selected_entity = null

func map_to_global(vec: Vector2) -> Vector2:
	return to_global(background.map_to_local(vec))
