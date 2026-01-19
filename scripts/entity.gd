class_name Entity extends Node2D

signal finished(entity: Entity)

var controller: GamestateController
var map: AStarGrid2D
var entities: Array[Entity]
var selected: bool = false

var path: Array[Vector2i]
var tween: Tween

@export_group("Sprite")
@export var sprite: Sprite2D
@export var select_shader: ShaderMaterial = preload("res://assets/materials/select.tres")

@export_group("Navigation")
var moves: int = 0

@export var map_position: Vector2i
@export var speed: float = 2.0

func setup() -> void:
	controller = get_parent()
	entities = controller.entities
	map = controller.map
	finished.connect(controller.entity_finished)

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

func map_clicked(map_pos: Vector2i) -> void:
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
			tween.tween_property(self, "position", get_parent().map_to_global(pos), (pos - prev_pos).length() / speed);
			tween.tween_callback(func():
				map_position = pos
				moves -= 1
			);
			prev_pos = pos
		tween.tween_callback(move_finished)

func teleport(dest: Vector2i) -> void:
	map.set_point_solid(map_position, false)

	var new_path = map.get_id_path(map_position, dest)
	global_position = controller.map_to_global(dest)
	map_position = dest
	moves -= new_path.size() - 1

	map.set_point_solid(dest)
	move_finished()
	
func move_finished() -> void:
	pass

func draw(canvas: Canvas) -> void:
	pass
