extends Node2D

signal emit_player_points_to_ui
signal emit_player_hp_to_ui
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var timer: Timer = $Timer
@onready var min_range_value: int = 10
@onready var player: Area2D = $Player
@onready var points_ui: Panel = $points_ui
@onready var main_music: AudioStreamPlayer2D = $MainMusic


@export var fruit_scenes: Array[PackedScene]


func _ready():
	main_music.play()
	timer.start()
	player.connect("player_points", recive_player_points)

func random() -> float:
	var viewport_size: Vector2 = get_tree().root.get_visible_rect().size
	var number: float = randf_range(min_range_value, viewport_size.x - 10)
	return number

func _on_timer_timeout() -> void:
	var x_position: float = random() / 2
	var new_fruit: Node = fruit_scenes.pick_random().instantiate()
	new_fruit.position.x = x_position 
	new_fruit.position.y = 0
	add_child(new_fruit)
	new_fruit.connect("emit_fruit_dmg", recive_fruit_dmg)
	

func recive_player_points(points: int) -> void:
	emit_signal("emit_player_points_to_ui", points)

func recive_fruit_dmg(dmg: int) ->void:
	player.player_hp -= dmg
	if player.player_hp == 0:
		get_tree().paused = true
	emit_signal("emit_player_hp_to_ui", dmg)


func _on_main_music_finished() -> void:
	main_music.play()
