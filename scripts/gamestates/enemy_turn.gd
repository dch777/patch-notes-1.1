class_name EnemyTurn extends Gamestate

@export var next_state: Gamestate

var remaining_enemies = 0
var enemies: Array[Enemy] = []

func enter() -> void:
	enemies.assign(controller.find_children("*", "Enemy"))
	remaining_enemies = enemies.size()

	for enemy in enemies:
		if enemy.current_attack:
			enemy.execute_action.emit(enemy.current_attack)
			enemy.current_attack = null

	enemies[0].start()

func cleanup() -> void:
	for entity in entities:
		if entity is Enemy:
			entity.end()

func entity_finished(entity: Entity) -> void:
	if entity is Enemy:
		remaining_enemies -= 1
		if remaining_enemies == 0:
			finished.emit(next_state)
		else:
			enemies[enemies.size() - remaining_enemies].start()
