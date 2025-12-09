extends Panel

@onready var points_counter_unit: Sprite2D = $PointsCounterUnit
@onready var points_counter_tens: Sprite2D = $PointsCounterTens
@onready var root: Node2D = $".."

@onready var tens_counter = 0

func _ready() -> void:
	root.connect("emit_player_points_to_ui", change_shape)

func change_shape(player_points: int) -> void:
	
	if player_points % 10 == 0:
		tens_counter += 1
		
	points_counter_unit.frame_coords.x = player_points % 10
	points_counter_tens.frame_coords.x = tens_counter
		
