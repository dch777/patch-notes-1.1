extends Node
class_name Gamestate

static var turnNum: int = 0

# TODO change this to a list of Player objects
static var availablePlayers: int = 0
static var finishedPlayers: int = 0

# TODO change this to a list of Enemy objects
static var availableEnemies: int = 0
static var finishedEnemies: int = 0

var next: Gamestate = null

func _init(next: Gamestate = null) -> void:
	self.next = next
	
func on_entered_state() -> void:
	pass

func on_exited_state() -> void:
	pass
