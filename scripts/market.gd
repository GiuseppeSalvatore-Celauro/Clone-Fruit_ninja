extends Control
@onready var nmb_points: Label = $NmbPoints
@onready var btn_sounds: AudioStreamPlayer2D = $BtnSounds
@onready var market_controls: Array[MarketPanel] = [
	$Control/DifficultyPanel,
	$Control/HpPanel,
	$Control/PointsPanel,
	$Control/TimePanel
]
var is_going_back: bool = false

func _ready() -> void:
	for control in market_controls:
		control.connect("money_changed", total_points_handler)
	nmb_points.text = str(int(save_manager.data.score))

func _on_back_btn_pressed() -> void:
	btn_sounds.play()
	is_going_back = true

func _on_btn_sounds_finished() -> void:
	if is_going_back:
		get_tree().change_scene_to_file("res://scene/starting_menu.tscn")

func total_points_handler()->void:
	nmb_points.text = str(int(save_manager.data.score))