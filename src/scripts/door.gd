extends Node2D

class_name Door

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

enum DoorStates { CLOSED, OPENED, OPENING, CLOSING }
var current_state = DoorStates.CLOSED

func open() -> void:
	if current_state != DoorStates.CLOSED: return
	
	current_state = DoorStates.OPENING
	sprite.play("opening")

func close() -> void:
	if current_state != DoorStates.OPENED: return
	
	current_state = DoorStates.CLOSING
	sprite.play("closing")

func _on_animated_sprite_2d_animation_finished() -> void:
	match current_state:
		DoorStates.OPENING:
			current_state = DoorStates.OPENED
		DoorStates.CLOSING:
			current_state = DoorStates.CLOSED
