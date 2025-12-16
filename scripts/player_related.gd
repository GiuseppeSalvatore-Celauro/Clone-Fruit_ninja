extends Node2D

@onready var player: Area2D = $"."
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var slicing_line: Line2D = $slicing_line
@onready var starting_mouse_position: Vector2 = Vector2()

@export var player_hp: int = 999

var start_point : Vector2
var points: int = 0
var max_amount_of_point: int = 8
var is_sound_plaing:bool = false

signal player_points

func _process(delta: float) -> void:	
	var current_mouse_postion: Vector2 = get_global_mouse_position()
	collision.global_position = current_mouse_postion
	
	if Input.is_action_pressed("click"):
		starting_mouse_position = get_global_mouse_position()
		slicing_line.add_point(current_mouse_postion)
		collision.disabled = false
		
		if current_mouse_postion.distance_to(starting_mouse_position) > 0.1:
			slicing_line.add_point(current_mouse_postion)
		
		if slicing_line.get_point_count() > max_amount_of_point:
			slicing_line.remove_point(0)
		
		
	if Input.is_action_just_released("click"):
		while (slicing_line.get_point_count() > 0):
			slicing_line.remove_point(0)
		
		if slicing_line.get_point_count() == 0:
			collision.disabled = true
		

func _on_area_entered(area: Area2D) -> void:
	points += 1
	emit_signal("player_points", points)
