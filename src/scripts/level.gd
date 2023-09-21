extends Node2D

class_name Level

@export var player_scene: PackedScene
@export var door: Door

func _ready():
	print("spawn player")
