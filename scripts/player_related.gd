extends Node

@onready var player: Area2D = $"."
@onready var animation: AnimatedSprite2D = $PlayerSlice
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var points: int = 0

@export var player_hp: int = 3 

signal player_points

func _process(delta: float) -> void:
	slice_animation()

func slice_animation():
	if Input.is_action_pressed("click"):
		collision.disabled = false
		timer.start()
		var cursor_position = get_viewport().get_camera_2d().get_global_mouse_position()
		player.global_position = cursor_position
		animation.play()
		

func _on_timer_timeout() -> void:
	collision.disabled = true

func _on_area_entered(area: Area2D) -> void:
	points += 1
	emit_signal("player_points", points)
