class_name Canvas extends Node2D

@export var controller: GamestateController
@export var canvas_viewport: SubViewport

@export var background: TileMapLayer
@export var foreground: TileMapLayer

func get_texture():
	return canvas_viewport.get_texture()

func _process(delta: float):
	queue_redraw()

func _draw():
	var hovered_cell = Vector2(background.local_to_map(controller.get_local_mouse_position()))
	var reachable = controller.map.is_in_boundsv(hovered_cell) && !controller.map.is_point_solid(hovered_cell)

	if controller.selected_entity:
		controller.selected_entity.draw(self)

	if reachable:
		draw_circle(convert_vec(hovered_cell), 25, Color.BLACK)

func convert_vec(vec: Vector2):
	var rect = background.get_used_rect()
	vec += -Vector2(rect.position) + Vector2(0.5, 0.5)
	return Vector2(canvas_viewport.size.x * vec.x / rect.size.x, canvas_viewport.size.y * vec.y / rect.size.y)

func draw_reachable(remaining_moves: int, pos: Vector2i, color: Color):
	draw_reachable_helper(remaining_moves - 1, pos + Vector2i(1 , 0), color)
	draw_reachable_helper(remaining_moves - 1, pos + Vector2i(-1, 0), color)
	draw_reachable_helper(remaining_moves - 1, pos + Vector2i(0 , 1), color)
	draw_reachable_helper(remaining_moves - 1, pos + Vector2i(0 ,-1), color)

func draw_reachable_helper(remaining_moves: int, pos: Vector2i, color: Color):
	if !controller.map.is_point_solid(pos) and remaining_moves > 0:
		draw_circle(convert_vec(pos), 25, color)
		draw_reachable_helper(remaining_moves - 1, pos + Vector2i(1 , 0), color)
		draw_reachable_helper(remaining_moves - 1, pos + Vector2i(-1, 0), color)
		draw_reachable_helper(remaining_moves - 1, pos + Vector2i(0 , 1), color)
		draw_reachable_helper(remaining_moves - 1, pos + Vector2i(0 ,-1), color)
