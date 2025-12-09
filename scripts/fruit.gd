extends Node2D
class_name Fruit

signal emit_fruit_dmg

@onready var fruit: Fruit = $"."
@onready var full_fruit: Sprite2D = $Sprite2D
@onready var full_fruit_collision: CollisionShape2D = $CollisionShape2D
@onready var half_fruit: Sprite2D = $Sprite2D2
@onready var speed_multiplayer = 1
@onready var full_rotation = 360
@onready var gravity = randi_range(min_falling_speed, max_falling_speed)

@export var fruit_dmg = 1
@export var min_falling_speed = 400
@export var max_falling_speed = 1000

func _process(delta: float) -> void:
	var _rotation = fruit_rotation(delta)
	fruit.rotate(_rotation)
	fruit_movement()


func fruit_rotation(delta):
	var _rotation = 0
	if _rotation < full_rotation:
		_rotation += delta * 2
	else:
		_rotation = 0
	
	return _rotation


func fruit_movement():
	var viewport_y = (get_viewport().size.y / 2) + 10
	if fruit.position.y < viewport_y:
		fruit.position.y += speed_multiplayer * gravity / 100;
	else:
		emit_signal("emit_fruit_dmg", fruit_dmg)
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	full_fruit.queue_free()
	full_fruit_collision.queue_free()
	fruit_dmg = 0
	half_fruit.visible = true
	speed_multiplayer = 1.5
