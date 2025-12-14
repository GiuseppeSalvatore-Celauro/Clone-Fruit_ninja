extends Node2D
class_name Fruit

signal emit_fruit_dmg

@onready var fruit: Fruit = $"."
@onready var left_side: Sprite2D = $LeftSide
@onready var full_fruit_collision: CollisionShape2D = $CollisionShape2D
@onready var right_side: Sprite2D = $RightSide
@onready var speed_multiplayer:int  = 1
@onready var full_rotation:int  = 360
@onready var gravity:int  = randi_range(min_falling_speed, max_falling_speed)

@export var fruit_dmg: int = 1
@export var min_falling_speed: int = 400
@export var max_falling_speed: int = 500

var random_rotation: int = randi_range(0, 1)
var is_hitted: bool = false
@onready var random_postion_after_cut: int = randi_range(45, 105)

func _process(delta: float) -> void:
	fruit_rotation(delta, fruit)
	fruit_movement()
	
	if is_hitted:
		fruit.rotation = 0
		if random_rotation == 1:
			fruit_rotation(delta, right_side)
			fruit_rotation(-delta, left_side)
			left_side.position.x -= delta * random_postion_after_cut
			right_side.position.x += delta * random_postion_after_cut
		else:
			fruit_rotation(-delta, right_side)
			fruit_rotation(delta, left_side)
			left_side.position.x -= delta * random_postion_after_cut
			right_side.position.x += delta * random_postion_after_cut
		
func fruit_rotation(delta: float, item):
	if random_rotation == 1:
		item.rotate(delta * 2)
	else:
		item.rotate(delta * -2)

func fruit_movement():
	var viewport_y = (get_viewport().size.y / 2) + 10
	if fruit.position.y < viewport_y:
		fruit.position.y += speed_multiplayer * gravity / 100.00;
	else:
		emit_signal("emit_fruit_dmg", fruit_dmg)
		queue_free()
		
func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player":
		fruit_dmg = 0
		is_hitted = true
