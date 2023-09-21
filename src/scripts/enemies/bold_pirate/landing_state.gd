extends State

@export var ground_state: State
@export var ground_animation: String = "ground"

func on_enter():
	playback.travel(ground_animation)
	next_state = ground_state
