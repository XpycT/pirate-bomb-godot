extends State

@export var ground_state: State
@export var hit_area: Area2D
@export var attack_animation: String = "attack"

func on_enter() -> void:
	hit_area.monitoring = true
	for body in hit_area.get_overlapping_bodies():
		for child in body.get_children():
			if child is Damageable:
				child.hit(character.damage)
				playback.travel(attack_animation)
				next_state = ground_state
