extends Control

signal next_turn()
signal shoot()
signal next_weapon()
signal prev_weapon()

@onready var viewport := $SubViewport

func next_button_pressed():
	next_turn.emit()

func shoot_button_pressed():
	shoot.emit()

func right_button_pressed():
	next_weapon.emit()

func left_button_pressed():
	prev_weapon.emit()
