class_name Canvas extends Node2D

@export var controller: GamestateController
@export var canvas_viewport: SubViewport

@export var background: TileMapLayer
@export var foreground: TileMapLayer

func get_texture():
	return canvas_viewport.get_texture()

func _ready():
	canvas_viewport.size = background.get_used_rect().size

func _process(delta: float):
	queue_redraw()

func _draw():
	var hovered_cell = Vector2(background.local_to_map(controller.get_local_mouse_position()))
	var reachable = controller.map.is_in_boundsv(hovered_cell) && !controller.map.is_point_solid(hovered_cell)
	var offset = -Vector2(background.get_used_rect().position) + Vector2(0.5, 0.5)

	if controller.selected_entity:
		controller.selected_entity.draw(self, offset)

	if reachable:
		draw_circle(hovered_cell + offset, 0.5, Color.BLACK)
	
