extends Node2D

signal emit_player_points_to_ui

@onready var fruit: Node2D = $Fruit
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var timer: Timer = $Timer
@onready var min_range_value = 10
@onready var player: Area2D = $Player
@onready var points_ui: Panel = $points_ui

@export var fruit_scenes: PackedScene


func _ready():
	timer.start()
	player.connect("player_points", recive_player_points)

func random():
	var viewport_size = get_tree().root.get_visible_rect().size
	var number = randf_range(min_range_value, viewport_size.x - 10)
	return number

func _on_timer_timeout() -> void:
	var x_position = random() / 2
	var new_fruit = fruit_scenes.instantiate()
	new_fruit.position.x = x_position 
	new_fruit.position.y = 0
	add_child(new_fruit)
	

func recive_player_points(points: int) -> void:
	emit_signal("emit_player_points_to_ui", points)
