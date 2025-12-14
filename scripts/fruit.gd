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

var random_rotation: int =  randi_range(0, 1)
var is_hitted: bool = false
@onready var random_postion_after_cut: int = randi_range(45, 105)

func _process(delta: float) -> void:
	fruit_rotation(delta, fruit)
	fruit_movement()
	
	if is_hitted:
		if fruit.rotation != 0: 
			if random_rotation == 0:
				#funzioni che permetto di modificare sia la rotazione del singolo lato che la loro direzione dopo il taglio
				right_side.rotate(delta * -1)
				right_side.position.x += speed_multiplayer / 1.7
				
				left_side.rotate(delta)
				left_side.position.x -= speed_multiplayer / 1.7
	
			elif random_rotation == 1:
				right_side.rotate(delta * -1)
				right_side.position.x += speed_multiplayer / 1.7
			
				left_side.rotate(delta)
				left_side.position.x -= speed_multiplayer / 2.5
				
		else:
			# nel puro caro che la rotazione è 0 allora la tratta come basica
			fruit_rotation(delta, right_side)
			fruit_rotation(-delta, left_side)
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
