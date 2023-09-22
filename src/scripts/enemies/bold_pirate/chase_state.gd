extends State

@export var detect_area: Area2D
@export var ground_state: State
@export var attack_state: State
@export var attack_timer: Timer

func _ready() -> void:
	detect_area.connect("body_exited", on_detect_area_body_exited)

func on_process(_delta: float) -> void:
	update_target_status()
		
	if character.target and attack_timer.is_stopped() and character.is_in_attack_range():
		if (character.target is Player and not character.target.dead) or character.target is Bomb:
			attack_timer.start()
			next_state = attack_state

func on_detect_area_body_exited(body: Node2D) -> void:
	if (body == character.target):
		character.set_target(null)
		next_state = ground_state

func update_target_status() -> void:
	if character.target and (character.target is Player and character.target.dead):
		character.target == null
		next_state = ground_state
		
	if character.target == null:
		next_state = ground_state
	
