extends Node

# Create all gamestates
var startState: Gamestate
var playerState: Gamestate
var enemyState: Gamestate
var cleanupState: Gamestate
var finishState: Gamestate

var currentState: Gamestate	# Track current gamestate

# Signals, most are echoed from gamestate
signal reset

func _ready():
	# Init
	finishState = FinishState.new()
	cleanupState = CleanupState.new()
	enemyState = EnemyState.new(cleanupState)
	playerState = PlayerState.new(enemyState)
	startState = StartState.new(playerState)	
	cleanupState.next = playerState
	
	# Connect signals
	startState.connect("reset", Callable(self, "_echo_reset"))
	
	# Start FSM
	currentState = startState
	currentState.on_entered_state()

func next_gamestate():
	assert(currentState and currentState.next)
	currentState.on_exited_state()
	currentState = currentState.next
	currentState.on_entered_state()

# TODO change to allow list compatibility
func player_finished():
	currentState.finishedPlayers += 1
	if (currentState.finishedPlayers == currentState.availablePlayers):
		next_gamestate()

# TODO change to allow list compatibility
func enemy_finished():
	currentState.finishedEnemies += 1
	if (currentState.finishedEnemies == currentState.availableEnemies):
		next_gamestate()

# Echoing signals
func _echo_reset() -> void:
	emit_signal("reset")
