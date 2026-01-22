class_name Player extends Entity

@export var weapons: Array[Weapon] = []
var selected_weapon: int
var active: bool = false
var start_facing: Direction

func _ready():
	weapons = weapons.duplicate(true)
	for i in range(weapons.size()):
		weapons[i] = weapons[i].duplicate()
		weapons[i].entity = self

func _process(delta: float):
	super._process(delta)
	if active and aiming:
		var hovered_cell = controller.background.local_to_map(controller.get_local_mouse_position())
		if map.is_in_boundsv(hovered_cell):
			var diff = hovered_cell - map_position
			var axis = diff.abs().max_axis_index()
			facing = axis * 2 + int(diff[axis] < 0.0)

func start() -> void:
	entities.assign(controller.find_children("*", "Entity"))
	if health <= 0:
		queue_free()

	moves = 5
	active = true

func end() -> void:
	active = false

func map_clicked(click_position: Vector2i) -> void:
	if active:
		if aiming:
			execute_action.emit(Fire.new(self, start_facing))
			aiming = false
		else:
			var new_path = map.get_id_path(map_position, click_position)
			if (new_path.size() > 0 and new_path.size() - 1 <= moves) and (path.size() == 0 or click_position != path[-1]):
				execute_action.emit(Teleport.new(self, map_position, click_position))

func fire() -> void:
	start_facing = facing
	aiming = true

func move_finished() -> void:
	if moves == 0:
		finished.emit(self)

func draw(canvas: Canvas) -> void:
	canvas.draw_circle(canvas.convert_vec(map_position), 25, Color.BLACK)

func draw_target(canvas: Canvas) -> void:
	if aiming:
		weapons[selected_weapon].draw_attack(canvas)

func draw_selected(canvas: Canvas) -> void:
	canvas.draw_reachable(moves + 1, map_position, Color.DIM_GRAY)
