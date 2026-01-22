extends Control

signal next_turn()
signal undo()
signal shoot()
signal next_weapon()
signal prev_weapon()

var skill_texture: Texture2D

func _process(delta: float):
	$SkillIcon/SkillTexture.texture = skill_texture

func undo_button_pressed():
	undo.emit()

func next_button_pressed():
	next_turn.emit()

func shoot_button_pressed():
	shoot.emit()

func right_button_pressed():
	next_weapon.emit()

func left_button_pressed():
	prev_weapon.emit()
