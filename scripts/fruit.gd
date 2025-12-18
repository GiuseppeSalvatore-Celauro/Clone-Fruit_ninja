extends Node2D
class_name Fruit

signal emit_fruit_dmg
signal emit_fruit_recive_hit

@onready var fruit: Fruit = $"."
@onready var container: CanvasGroup = $Container
@onready var left_side: Sprite2D = $Container/LeftSide
@onready var right_side: Sprite2D = $Container/RightSide
@onready var full_fruit_collision: CollisionShape2D = $CollisionShape2D
@onready var fruit_slicing: AudioStreamPlayer2D = $FruitSlice


@export var fruit_dmg: int = 1
@export var min_falling_speed: int = 400
@export var max_falling_speed: int = 500
@export var color: String = '#fff'

var random_rotation: int
var is_hitted: bool
var speed_multiplayer:int
var full_rotation:int
var gravity:int
var random_postion_after_cut: int
var viewport_y: int

func _ready() -> void:
	random_rotation =  randi_range(0, 1)
	is_hitted = false
	speed_multiplayer = 1
	full_rotation = 360
	gravity = randi_range(min_falling_speed, max_falling_speed)
	random_postion_after_cut = randi_range(45, 105)
	viewport_y = (get_viewport().size.y / 2) + 10

func _process(delta: float) -> void:
	fruit_rotation(delta, container)
	
	if fruit.position.y < viewport_y:
		fruit.position.y += speed_multiplayer * gravity / 100.00
	else:
		emit_signal("emit_fruit_dmg", fruit_dmg)
		queue_free()

	if is_hitted:
		if fruit.rotation != 0: 
			if random_rotation == 0:
				#funzioni che permetto di modificare sia la rotazione del singolo lato che la loro direzione dopo il taglio
				positive_side_fruit_handler(right_side, delta, 1.7)
				negative_side_fruit_handler(left_side, delta, 1.7)
				
			elif random_rotation == 1:
				positive_side_fruit_handler(left_side, delta, 2.5)
				negative_side_fruit_handler(right_side, delta, 1.7)
				
		else:
			# nel puro caro che la rotazione è 0 allora la tratta come basica
			fruit_rotation(delta, right_side)
			fruit_rotation(-delta, left_side)
			left_side.position.x -= delta * random_postion_after_cut
			right_side.position.x += delta * random_postion_after_cut
		
		
func positive_side_fruit_handler(fruit_side: Sprite2D, delta: float, i: float)-> void:
	fruit_side.rotate(delta * -1)
	fruit_side.position.x  += speed_multiplayer / i
	
func negative_side_fruit_handler(fruit_side: Sprite2D, delta: float, i: float)-> void:
	fruit_side.rotate(delta)
	fruit_side.position.x  -= speed_multiplayer / i
		
func fruit_rotation(delta: float, item):
	if random_rotation == 1:
		item.rotate(delta * 2)
	else:
		item.rotate(delta * -2)
		
func _on_area_entered(area: Area2D) -> void:
	if area.name == "Player" and not is_hitted:
		fruit_slicing.play()
		emit_signal('emit_fruit_recive_hit', color, fruit.position)
		fruit_dmg = 0
		is_hitted = true

func _on_fruit_slicing_finished() -> void:
	if fruit.position.y > viewport_y:
		queue_free()
