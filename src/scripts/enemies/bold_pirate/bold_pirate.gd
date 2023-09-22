extends CharacterBody2D

@export var speed : float = 100.0
@export var jump_velocity: float = -400.0
@export var attack_range: float = 40
@export var damage: int = 1

@onready var pivot: Marker2D = $pivot
@onready var animation_tree: AnimationTree = $AnimTree
@onready var state_machine: StateMachine = $StateMachine

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction: Vector2 = Vector2.ZERO
var target: Node2D = null

func _ready():
	animation_tree.active = true

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_towards_player()
	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	
func update_animation_parameters() -> void:
	if target and state_machine.check_if_can_move():
		animation_tree.set("parameters/move/blend_position", direction.x)
	else:
		animation_tree.set("parameters/move/blend_position",0)

func update_facing_direction() -> void:
	if direction.x > 0:
		pivot.scale.x = 1
	elif direction.x < 0:
		pivot.scale.x = -1

func move_towards_player():
	if target and not is_in_attack_range():
		direction = (target.global_position - global_position).normalized()
		direction.x = sign(direction.x)
		velocity.x = direction.x * speed
	else:
		velocity.x = 0

func is_in_attack_range():
	if target:
		return global_position.distance_to(target.global_position) < attack_range
	return false

func set_target(node: Node2D):
	target = node
