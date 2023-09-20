extends RigidBody2D

@onready var bomb_timer: Timer = $BombTimer
@onready var sprite: AnimatedSprite2D = $Sprite
@onready var area: Area2D = $Area

enum BombState {ON, OFF, EXPLODE}
var current_state: BombState = BombState.ON

func _ready():
	bomb_timer.start()

func _on_bomb_timer_timeout():
	change_state(BombState.EXPLODE)
	apply_damage()
	
	
func change_state(new_state: BombState) -> void:
	if current_state != BombState.EXPLODE:
		match new_state:
			BombState.ON:
				sprite.play("bomb_on")
			BombState.OFF:
				sprite.play("bomb_off")
			BombState.EXPLODE:
				sprite.play("explotion")
		
		current_state = new_state

func apply_damage() -> void:
	for body in area.get_overlapping_bodies():
		print(body.name)
		# appy forces to props
		# apply damage for Damageable
		for child in body.get_children():
			if child is Damageable:
				child.hit(1)



func _on_sprite_animation_finished():
	if current_state == BombState.EXPLODE:
		queue_free()
