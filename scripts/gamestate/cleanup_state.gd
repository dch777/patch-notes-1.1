extends Gamestate
class_name CleanupState

func on_entered_state() -> void:
	# Reset
	finishedPlayers = 0
	finishedEnemies = 0
	
	# Update
	turnNum += 1
