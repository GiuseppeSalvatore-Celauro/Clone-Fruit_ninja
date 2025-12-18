extends Node2D

signal emit_player_points_to_ui
signal emit_player_hp_to_ui
signal emit_particels_input

@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var timer: Timer = $Timer
@onready var player: Area2D = $Player
@onready var points_ui: Panel = $PlayerPoints
@onready var life_ui: Panel = $LifePoints
@onready var main_music: AudioStreamPlayer2D = $MainMusic
@onready var root: Node = $"."
@onready var game_over: Panel = $GameOver

@export var fruit_scenes: Array[PackedScene]
@export var fruit_particles: PackedScene
@export var player_life: int = 3
@export var player_points: int = 0

@onready var min_range_value: int = 10
var new_fruit: Fruit

func _ready():
	main_music.play()
	timer.start()
	player.connect("player_points", recive_player_points)

func random() -> float:
	var viewport_size: Vector2 = get_tree().root.get_visible_rect().size
	var number: float = randf_range(min_range_value, viewport_size.x - 10)
	return number

func _on_timer_timeout() -> void:
	if not is_inside_tree():
		return
	
	var scene: PackedScene = fruit_scenes.pick_random()
	if scene == null:
		return
	
	new_fruit = scene.instantiate()
	new_fruit_handler(new_fruit)
	
	new_fruit.connect("emit_fruit_dmg", recive_fruit_dmg)
	new_fruit.connect("emit_fruit_recive_hit", recive_fruit_recived_hit)
	
func new_fruit_handler(_new_fruit: Fruit)->void:
	var x_position: float = random() / 2
	_new_fruit.position.x = x_position 
	_new_fruit.position.y = 0
	add_child(_new_fruit)

func recive_player_points(points: int) -> void:
	player_points += points
	if not player_points == 99:
		emit_signal("emit_player_points_to_ui", player_points)
		return
	
	stop_timer()
	
	save_manager.data.score += player_points
	save_manager.save_game()
		
	if is_instance_valid(new_fruit):
		new_fruit.call_deferred("queue_free")
		
	get_tree().call_deferred(
		"change_scene_to_file",
		"res://scene/starting_menu.tscn"
	)

func recive_fruit_dmg(dmg: int) ->void:
	player_life -= dmg
	if player_life == 0:
		stop_timer()
		points_ui.visible = false
		life_ui.visible = false
		game_over.visible = true
	emit_signal("emit_player_hp_to_ui",	player_life)

func _on_main_music_finished() -> void:
	main_music.play()

func recive_fruit_recived_hit(color: String, _position: Vector2)-> void:
	if new_fruit: 
		new_fruit = null
		var new_fruit_particles: FruitParticles = fruit_particles.instantiate()
		add_child(new_fruit_particles)
		emit_signal("emit_particels_input", color, _position)
	
func stop_timer()-> void:
	if is_instance_valid(timer):
		timer.stop()

func get_player_points() -> int:
	return player_points
