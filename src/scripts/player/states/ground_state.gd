extends State

class_name GroundState

@export var jump_velocity: float = -400.0
@export var air_state: State
@export var attack_state: State
@export var jump_animation: String = "jump_start"
@export var bomb_timer: Timer

func on_physics_process(_delta: float) -> void:
	if not character.is_on_floor():
		next_state = air_state

func on_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump") and character.is_on_floor():
		jump()
	
	if event.is_action_pressed("throw") and bomb_timer.is_stopped():
		attack();

func jump() -> void:
	character.velocity.y = jump_velocity
	next_state = air_state
	playback.travel(jump_animation)

func attack():
	next_state = attack_state
