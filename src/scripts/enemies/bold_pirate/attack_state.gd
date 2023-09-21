extends State

@export var ground_state: State
@export var hit_area: Area2D
@export var attack_animation: String = "attack"

func on_enter() -> void:
	playback.travel(attack_animation)
	next_state = ground_state
