class_name EnemyTurn extends Gamestate

@export var next_state: Gamestate

var remaining_enemies = 0
var enemies: Array[Enemy] = []

func enter() -> void:
	entities.assign(controller.find_children("*", "Entity"))
	enemies.assign(controller.find_children("*", "Enemy"))
	remaining_enemies = enemies.size()

	for enemy in enemies:
		if enemy.current_attack:
			enemy.execute_action.emit(enemy.current_attack)
			enemy.current_attack = null
	for enemy in enemies:
		enemy.start()

	enemies[0].start_move()

func cleanup() -> void:
	for enemy in enemies:
		if enemy:
			enemy.end()

func entity_finished(entity: Entity) -> void:
	if entity == null or entity is Enemy:
		remaining_enemies -= 1
		if remaining_enemies == 0:
			finished.emit(next_state)
		else:
			enemies[enemies.size() - remaining_enemies].start_move()
