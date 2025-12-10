extends Node2D

@onready var player: Area2D = $"."
@onready var animation: AnimatedSprite2D = $PlayerSlice
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var points: int = 0
@onready var starting_mouse_position: Vector2 = Vector2()
@onready var slicing_line: Line2D = $slicing_line

@export var player_hp: int = 999

var start_point : Vector2
var is_game_started = false

signal player_points

func _process(delta: float) -> void:	
	var current_mouse_postion = get_global_mouse_position()
	animation.global_position = current_mouse_postion
	
	if Input.is_action_pressed("click") and not is_game_started:
		is_game_started = true
		starting_mouse_position = get_global_mouse_position()
		collision.shape.a = current_mouse_postion
		collision.shape.b = current_mouse_postion
	
	if Input.is_action_just_released("click"):
		if current_mouse_postion.distance_to(starting_mouse_position) > 0.1:
			collision.shape.b = current_mouse_postion
		is_game_started = false

		
func _on_area_entered(area: Area2D) -> void:
	points += 1
	emit_signal("player_points", points)
