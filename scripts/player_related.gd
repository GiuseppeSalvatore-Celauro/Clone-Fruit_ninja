extends Node2D

@onready var player: Area2D = $"."
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var slicing_line: Line2D = $SlicingLine
@onready var starting_mouse_position: Vector2 = Vector2()

var start_point : Vector2
var max_amount_of_point: int = 8
var is_sound_plaing:bool = false
var old_fruit: Area2D = null

signal player_points

func _process(_delta: float) -> void:	
	var current_mouse_postion: Vector2 = get_global_mouse_position()
	collision.global_position = current_mouse_postion
	
	if Input.is_action_pressed("click"):
		starting_mouse_position = get_global_mouse_position()
		slicing_line.add_point(current_mouse_postion)
		collision.disabled = false
		
		if current_mouse_postion.distance_to(starting_mouse_position) > 0.1:
			slicing_line.add_point(current_mouse_postion)
		
		while(slicing_line.get_point_count() > max_amount_of_point):
			slicing_line.remove_point(0)
		
	if Input.is_action_just_released("click"):
		while (slicing_line.get_point_count() > 0):
			slicing_line.remove_point(0)
		
		if slicing_line.get_point_count() == 0:
			collision.disabled = true
		

func _on_area_entered(area: Area2D) -> void:
	if not old_fruit == area:
		old_fruit = area
		emit_signal("player_points", 1 + int(save_manager.data.upgrades["Points"]))
	
