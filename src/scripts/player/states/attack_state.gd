extends State

class_name AttackState

@export var ground_state: State
@export var bomb_scene: PackedScene
@export var power_bar: TextureProgressBar

@export var bomb_timer: Timer

var throw_power_max: float = 30
var throw_power_current: float = 0

func on_enter() -> void:
	power_bar.max_value = throw_power_max
	power_bar.show()

func on_physics_process(delta: float) -> void:	
	if Input.is_action_just_pressed("throw"):
		throw_power_current = 0
	if Input.is_action_pressed("throw"):
		throw_power_current = clamp(throw_power_current + throw_power_max * delta, 0.0, throw_power_max)
		update_power_bar()
	if Input.is_action_just_released("throw"):
		throw_bomb()
		
func update_power_bar() -> void:
	power_bar.value = throw_power_current

func throw_bomb() -> void:
	var b = bomb_scene.instantiate()
	b.position = character.position
	get_tree().root.add_child(b)
	
	var direction = 1
	if character.get_node("pivot/Sprite").flip_h:
		direction = -1
	
	var impulse = Vector2(250 * direction, -10 * throw_power_current)
	if(throw_power_current < 5):
		impulse = Vector2.ZERO
#	print("power ", throw_power_current, " impulse ", impulse)
	b.apply_impulse(impulse, character.position)
	
	bomb_timer.start()
	next_state = ground_state

func on_exit() -> void:
	power_bar.hide()
