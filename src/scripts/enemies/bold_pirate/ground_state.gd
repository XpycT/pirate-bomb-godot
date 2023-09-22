extends State

@export var detect_area: Area2D
@export var air_state: State
@export var chase_state: State

func _ready() -> void:
	detect_area.connect("body_entered", on_detect_area_body_entered)

func on_enter() -> void:
	if character.target:
		if (character.target is Player and not character.target.dead) or character.target is Bomb:
			next_state = chase_state
	
func on_physics_process(_delta: float) -> void:
	if not character.is_on_floor():
		next_state = air_state
	if character.target:
		chase_target()

func chase_target() -> void:
	for body in detect_area.get_overlapping_bodies():
		if (body is Player and not body.dead) or body is Bomb:
			# priority bomb
			if (body is Player and not body.dead) and character.target is Bomb:
				pass
			else:
				character.set_target(body)
	if character.target and ((character.target is Player and not character.target.dead) or character.target is Bomb):
		next_state = chase_state

func on_detect_area_body_entered(body: Node2D) -> void:
	chase_target()
