extends Control
@onready var start_btn: Button = $StartBtn
@onready var quit_btn: Button = $QuitBtn
@onready var btn_sound: AudioStreamPlayer2D = $BtnSounds


var is_game_closed: bool = false
var is_game_started: bool = false
var is_marked_opened: bool = false

func _on_quit_btn_pressed() -> void:
	is_game_closed = true
	btn_sound.play()

func _on_start_btn_pressed() -> void:
	is_game_started = true
	btn_sound.play()

func _on_market_btn_pressed() -> void:
	is_marked_opened = true
	btn_sound.play()

func _on_btn_sounds_finished() -> void:
	if is_game_started:
		get_tree().change_scene_to_file('res://scene/main.tscn')
		return

	if is_marked_opened:
		get_tree().change_scene_to_file("res://scene/market.tscn")
		return

	if is_game_closed:
		get_tree().quit()
		return
