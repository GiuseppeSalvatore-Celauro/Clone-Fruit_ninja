extends Panel


@onready var root: Node2D = $".."
@onready var points_counter: Label = $PointsCounter

@export var tens_counter:int = 0

func _ready() -> void:
	root.connect("emit_player_points_to_ui", change_point_shape)

func change_point_shape(player_points: int) -> void:
	points_counter.text = str(player_points)
	if player_points == 99: 
		save_manager.data.score += player_points
		save_manager.save_game()
		get_tree().change_scene_to_file('res://scene/starting_menu.tscn')
