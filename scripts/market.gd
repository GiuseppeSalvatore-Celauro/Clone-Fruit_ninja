extends Control
@onready var total_points: Label = $Points
@onready var btn_sounds: AudioStreamPlayer2D = $BtnSounds

var is_going_back: bool = false

func _ready() -> void:
	total_points.text += str(int(save_manager.data.score))

func _on_back_btn_pressed() -> void:
	btn_sounds.play()
	is_going_back = true

func _on_btn_sounds_finished() -> void:
	if is_going_back:
		get_tree().change_scene_to_file("res://scene/starting_menu.tscn")
