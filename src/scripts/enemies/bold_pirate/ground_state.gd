extends State

@export var jump_velocity: float = -400.0
@export var air_state: State
@export var attack_state: State
@export var jump_animation: String = "jump_start"

func on_physics_process(_delta: float) -> void:
	if not character.is_on_floor():
		next_state = air_state
