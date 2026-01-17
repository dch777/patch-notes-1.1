extends Gamestate
class_name EnemyState

# TODO change to allow list compatibility
func on_entered_state() -> void:
	# Reset finished enemies
	finishedEnemies = 0

# TODO change to allow list compatibility
func on_exited_state() -> void:
	# Set all enemies finished
	finishedEnemies = availableEnemies

	emit_signal("all_enemies_finished")
