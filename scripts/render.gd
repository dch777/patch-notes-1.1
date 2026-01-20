extends Control

signal next_turn()

@onready var viewport := $SubViewport

func _ready() -> void:
	polygon_to_png()
	pass

func polygon_to_png():
	await RenderingServer.frame_post_draw

	var image: Image = viewport.get_texture().get_image()

	image.save_png("res://reticle_2.png")

func next_button_pressed():
	next_turn.emit()
