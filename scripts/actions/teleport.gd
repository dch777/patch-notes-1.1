class_name Teleport extends Action

@export var start: Vector2i
@export var destination: Vector2i

var moves: int

func _init(e: Entity = null, s: Vector2i = Vector2i(0, 0), d: Vector2i = Vector2i(0, 0)):
	entity = e
	start = s
	destination = d

	moves = entity.moves

func execute():
	entity.teleport(destination)
	entity.move_finished()

func undo():
	entity.teleport(start)
	entity.moves = moves
