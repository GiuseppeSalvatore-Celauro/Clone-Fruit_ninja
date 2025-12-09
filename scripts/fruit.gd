extends Node2D
class_name Fruit

@onready var fruit: Fruit = $"."
@onready var full_fruit: Sprite2D = $Sprite2D
@onready var full_fruit_collision: CollisionShape2D = $CollisionShape2D
@onready var half_fruit: Sprite2D = $Sprite2D2
@onready var speed_multiplayer = 1
@onready var full_rotation = 360

@export var gravity = 200
	

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
		queue_free()


func _on_area_entered(area: Area2D) -> void:
	full_fruit.queue_free()
	full_fruit_collision.queue_free()
	half_fruit.visible = true
	speed_multiplayer = 2.5
