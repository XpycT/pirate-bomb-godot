extends Node2D

class_name Level

@export var player_scene: PackedScene
@export var door: Door

func _ready():
	
	var start_position = door.find_child("start_position")
	if start_position != null:
		var p = player_scene.instantiate()
		p.position = start_position.global_position
		add_child(p)
