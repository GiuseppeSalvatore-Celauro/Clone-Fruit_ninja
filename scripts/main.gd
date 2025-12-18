extends Node2D

signal emit_player_points_to_ui
signal emit_player_hp_to_ui
signal emit_particels_input
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var timer: Timer = $Timer
@onready var min_range_value: int = 10
@onready var player: Area2D = $Player
@onready var points_ui: Panel = $PlayerPoints
@onready var main_music: AudioStreamPlayer2D = $MainMusic

@export var fruit_scenes: Array[PackedScene]
@export var fruit_particles: PackedScene
@export var player_life: int = 3

func _ready():
	main_music.play()
	timer.start()
	player.connect("player_points", recive_player_points)

func random() -> float:
	var viewport_size: Vector2 = get_tree().root.get_visible_rect().size
	var number: float = randf_range(min_range_value, viewport_size.x - 10)
	return number

func _on_timer_timeout() -> void:
	var new_fruit: Fruit = fruit_scenes.pick_random().instantiate()
	new_fruit_handler(new_fruit)
	new_fruit.connect("emit_fruit_dmg", recive_fruit_dmg)
	new_fruit.connect("emit_fruit_recive_hit", recive_fruit_recived_hit)
	
func new_fruit_handler(new_fruit: Fruit)->void:
	var x_position: float = random() / 2
	new_fruit.position.x = x_position 
	new_fruit.position.y = 0
	add_child(new_fruit)

func recive_player_points(points: int) -> void:
	emit_signal("emit_player_points_to_ui", points)

func recive_fruit_dmg(dmg: int) ->void:
	player_life -= dmg
	if player_life == 0:
		get_tree().paused = true
	emit_signal("emit_player_hp_to_ui",	player_life)


func _on_main_music_finished() -> void:
	main_music.play()

func recive_fruit_recived_hit(color: String, _position: Vector2)-> void:
	var new_fruit_particles: FruitParticles = fruit_particles.instantiate()
	add_child(new_fruit_particles)
	emit_signal("emit_particels_input", color, _position)
