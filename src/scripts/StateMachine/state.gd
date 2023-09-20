extends Node

class_name State

@export var can_move: bool = true

var character: CharacterBody2D
var playback: AnimationNodeStateMachinePlayback
var next_state: State

signal interrupt_state(new_state: State)

func on_enter() -> void:
	pass
	
func on_input(_event: InputEvent) -> void:
	pass

func on_exit() -> void:
	pass

func on_process(_delta: float) -> void:
	pass

func on_physics_process(_delta: float) -> void:
	pass
