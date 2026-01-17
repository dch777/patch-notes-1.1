extends Gamestate
class_name PlayerState

# TODO change to allow list compatibility
func on_entered_state() -> void:
	# Reset finished players
	finishedPlayers = 0

# TODO change to allow list compatibility
func on_exited_state() -> void:
	# Set all players finished
	finishedPlayers = availablePlayers
