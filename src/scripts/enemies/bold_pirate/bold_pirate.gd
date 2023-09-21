extends CharacterBody2D

@export var speed : float = 120.0
@export var jump_velocity: float = -400.0

@onready var sprite: Sprite2D = $pivot/Sprite
@onready var animation_tree: AnimationTree = $AnimTree
@onready var state_machine: StateMachine = $StateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction: float = 0;

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
