extends State

class_name HitState

@export var damageable: Damageable
@export var ground_state: State
@export var dead_state: State
@export var hit_animation: String = "hit"
@export var dead_animation: String = "dead_hit"

func _ready():
	damageable.connect("on_hit", on_damageable_hit)

func on_damageable_hit(_node: Node, _damage_taken: int):
	if damageable.health > 0:
		emit_signal("interrupt_state", ground_state)
		playback.travel(hit_animation)
	else:
		emit_signal("interrupt_state", dead_state)
		playback.travel(dead_animation)
