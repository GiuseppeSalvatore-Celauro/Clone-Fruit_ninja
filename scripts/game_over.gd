extends Panel

@onready var pop_sfx: AudioStreamPlayer2D = $Grid/PopSfx
@onready var root: Node2D = $".."

var main_menu: bool
var restart_game: bool
var quit: bool

func _ready() -> void:
	main_menu = false
	restart_game = false
	quit = false

func _on_main_menu_btn_pressed() -> void:
	pop_sfx.play()
	main_menu = true
	
func _on_restart_btn_pressed() -> void:
	pop_sfx.play()
	restart_game = true

func _on_quit_btn_pressed() -> void:
	pop_sfx.play()
	quit = true

func event_handler()-> void:
	save_manager.data.score += root.get_player_points()
	save_manager.save_game()

	if main_menu:
		get_tree().change_scene_to_file("res://scene/starting_menu.tscn")
		return
		
	if restart_game:
		get_tree().change_scene_to_file("res://scene/main.tscn")
		return
	
	if quit:
		get_tree().quit()
		return
	
	return
	
func _on_pop_sfx_finished() -> void:
	event_handler()
