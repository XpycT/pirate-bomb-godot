extends State

@export var chase_state: State
@export var hit_area: Area2D
@export var attack_timer: Timer
@export var attack_animation: String = "attack"

func on_enter() -> void:
	if not attack_timer.is_stopped():
		next_state = chase_state
	hit_area.monitoring = true

func on_process(_delta: float) -> void:
	attack()
	pass

func attack() -> void :
	for body in hit_area.get_overlapping_bodies():
		for child in body.get_children():
			if child is Damageable:
				child.hit(character.damage)
				playback.travel(attack_animation)
		if body is Bomb:
				body.pull_away(character.global_position)
				playback.travel(attack_animation)
	next_state = chase_state

