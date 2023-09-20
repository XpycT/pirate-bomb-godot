extends State

@export var ground_state: State

func on_enter():
	print("attack state")
	next_state = ground_state
