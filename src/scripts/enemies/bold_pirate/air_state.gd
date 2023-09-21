extends State

@export var landing_state: State
@export var fall_animation: String = "fall"

func on_physics_process(_delta: float) -> void:
	if character.velocity.y > 0 and not character.is_on_floor():
		playback.travel(fall_animation)
	
	if(character.is_on_floor()):
		next_state = landing_state
