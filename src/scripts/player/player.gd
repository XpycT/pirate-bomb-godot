extends CharacterBody2D

class_name Player

@export var speed: float = 120.0

@onready var sprite: Sprite2D = $pivot/Sprite
@onready var animation_tree: AnimationTree = $AnimTree
@onready var state_machine: StateMachine = $StateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.ZERO

func _ready():
	animation_tree.active = true

func _physics_process(delta) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("move_left", "move_right", "ui_up","ui_down")
	if direction.x != 0 and state_machine.check_if_can_move():
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	
	move_and_slide()
	update_animation_parameters()
	update_facing_direction()

func update_animation_parameters() -> void:
	animation_tree.set("parameters/move/blend_position", direction.x)

func update_facing_direction() -> void:
	if direction.x > 0:
		sprite.flip_h = false
	elif direction.x < 0:
		sprite.flip_h = true
