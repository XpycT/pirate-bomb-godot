extends Node

class_name Damageable

signal health_changed(old_value: float, new_value: float)
signal on_hit(node: Node, damage_taken: int)
signal dead

@export var health: float = 3 :
	get:
		return health
	set(value):
		var old_health = health
		health_changed.emit(old_health, health)
		health = value

func hit(damage: int) -> void:
	health -= damage
	if health <= 0:
		emit_signal("dead")
	
	emit_signal("on_hit", get_parent(), damage)

