extends State

@export var jump_velocity: float = -400.0
@export var air_state: State
@export var attack_state: State
@export var jump_animation: String = "jump_start"
@export var detect_area: Area2D
@export var attack_timer: Timer

var player

func on_physics_process(_delta: float) -> void:
	if player == null:
		player = get_node_or_null("/root/player")
	
	if not character.is_on_floor():
		next_state = air_state
	
	if player and not player.dead and attack_timer.is_stopped() and is_in_range(player, character.attack_range):
		attack_timer.start()
		next_state = attack_state

func is_in_range(target, target_range):
	for body in detect_area.get_overlapping_bodies():
		if body is Player:
			return character.global_position.distance_to(target.global_position) < target_range
	return false
