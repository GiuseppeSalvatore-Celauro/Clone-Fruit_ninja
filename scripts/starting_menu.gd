extends Control
@onready var start_btn: Button = $StartBtn
@onready var quit_btn: Button = $QuitBtn
@onready var btn_sound: AudioStreamPlayer2D = $BtnSounds

var is_game_closed: bool = false

func _on_quit_btn_pressed() -> void:
	is_game_closed = true
	btn_sound.play()

func _on_start_btn_pressed() -> void:
	btn_sound.play()


func _on_btn_sounds_finished() -> void:
	if is_game_closed:
		get_tree().quit()
	get_tree().change_scene_to_file('res://scene/main.tscn')
