extends State

class_name DeadState

func on_enter() -> void:
	character.set_physics_process(false)
