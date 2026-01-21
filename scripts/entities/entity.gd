class_name Entity extends Node2D

signal finished(entity: Entity)
signal execute_action(action: Action)

var controller: GamestateController
var map: AStarGrid2D
var entities: Array[Entity]
var selected: bool = false

var path: Array[Vector2i]
var tween: Tween

@export_group("Sprite")
@export var sprite: Sprite2D
@export var select_shader: ShaderMaterial = preload("res://assets/materials/select.tres")

@export_group("Gameplay")
var moves: int = 0
enum Direction { EAST, WEST, SOUTH, NORTH }
@onready var health = max_health

@export var map_position: Vector2i
@export var facing: Direction
@export var speed: float = 2.0
@export var max_health: int = 5

func setup() -> void:
	controller = get_parent()
	entities = controller.entities
	map = controller.map
	finished.connect(controller.entity_finished)
	execute_action.connect(controller.execute_action)

	global_position = controller.map_to_global(map_position)
	map.set_point_solid(map_position)

	sprite.material = select_shader.duplicate()

	init()
	
func init() -> void:
	pass

func start() -> void:
	pass

func end() -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_released("select") and sprite.get_rect().has_point(get_local_mouse_position()):
		if !selected:
			controller.entity_selected(self)
			selected = true
			select()
		else:
			controller.entity_deselected()
			selected = false
			deselect()

func _process(delta: float) -> void:
	material.set_shader_parameter("selected", float(selected))

func select() -> void:
	pass

func deselect() -> void:
	pass

func map_clicked(click_position: Vector2i) -> void:
	pass

func move(dest: Vector2i) -> void:
	var new_path = map.get_id_path(map_position, dest, true)
	if new_path.size() > 1:
		path = new_path
		map.set_point_solid(map_position, false)
		map.set_point_solid(path[min(path.size() - 1, moves)])

		if tween and tween.is_running():
			tween.kill();

		if has_node("Line2D"):
			$Line2D.clear_points()
			$Line2D.add_point(controller.map_to_global(path[0]))

		tween = create_tween();
		var prev_pos = path[0]
		for pos in path.slice(1, moves + 1):
			if has_node("Line2D"):
				$Line2D.add_point(controller.map_to_global(pos))
			tween.tween_property(self, "position", get_parent().map_to_global(pos), (pos - prev_pos).length() / speed)
			tween.parallel().tween_property(self, "map_position", pos, (pos - prev_pos).length() / speed)
			tween.parallel().tween_property(self, "moves", -1, (pos - prev_pos).length() / speed).as_relative()
			prev_pos = pos
		tween.tween_callback(move_finished)
	else:
		move_finished()

func teleport(dest: Vector2i, voluntary: bool = true) -> void:
	map.set_point_solid(map_position, false)

	var new_path = map.get_id_path(map_position, dest)
	global_position = controller.map_to_global(dest)
	map_position = dest
	if voluntary:
		moves -= new_path.size() - 1

	map.set_point_solid(dest)
	
func move_finished() -> void:
	pass

func draw(canvas: Canvas) -> void:
	pass

func draw_selected(canvas: Canvas) -> void:
	pass

func facing_vector() -> Vector2i:
	var option = [Vector2i(1, 0), Vector2i(-1, 0), Vector2i(0, 1), Vector2i(0, -1)]
	return option[facing]
