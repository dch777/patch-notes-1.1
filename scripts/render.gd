extends Control

@onready var viewport := $SubViewport

 #Script for taking PNGs, place everything you want underneath the subviewport
func _ready() -> void:
	polygon_to_png()
	pass

func polygon_to_png():
	await RenderingServer.frame_post_draw

	var image: Image = viewport.get_texture().get_image()

	image.save_png("res://chassis_icon.png")
