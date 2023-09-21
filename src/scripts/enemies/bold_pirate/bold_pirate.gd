extends CharacterBody2D

@export var speed : float = 120.0
@export var jump_velocity: float = -400.0
@export var attack_range: float = 40
@export var damage: int = 1

@onready var pivot: Marker2D = $pivot
@onready var animation_tree: AnimationTree = $AnimTree
@onready var state_machine: StateMachine = $StateMachine
@onready var detect_area: Area2D = $DetectArea

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var player
var direction: Vector2
var detect_range: float

func _ready():
	animation_tree.active = true
	detect_range = detect_area.get_node("CollisionShape2D").shape.radius

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if(player == null):
		player = get_node_or_null("/root/player")
	else:
		move_towards_player()
	
	move_and_slide()
	update_animation_parameters()
	update_facing_direction()
	
func update_animation_parameters() -> void:
	if player and not player.dead and state_machine.check_if_can_move():
		animation_tree.set("parameters/move/blend_position", direction.x)
	else:
		animation_tree.set("parameters/move/blend_position",0)

func update_facing_direction() -> void:
	if direction.x > 0:
		pivot.scale.x = 1
	elif direction.x < 0:
		pivot.scale.x = -1

func move_towards_player():
	if player and not player.dead and is_in_range(player, detect_range) and not is_in_range(player, attack_range):
		direction = (player.global_position - global_position).normalized()
		velocity.x = direction.x * speed
	else:
		velocity.x = 0

func is_in_range(target, target_range):
	for body in detect_area.get_overlapping_bodies():
		if body is Player:
			return global_position.distance_to(target.global_position) < target_range
	return false
