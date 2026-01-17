extends Gamestate
class_name StartState

signal reset

func on_entered_state() -> void:
	# Reset
	turnNum = 0
	availablePlayers = 0
	finishedPlayers = 0
	
	emit_signal("reset")
