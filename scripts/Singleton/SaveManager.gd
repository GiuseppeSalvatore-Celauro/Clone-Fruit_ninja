extends Node
class_name SaveManager

const PATH: String = "user://save.json"

var data:Dictionary = {}

func _ready() -> void:
	load_game()

func get_default_data()-> Dictionary:
	return{
		"version": 1,
		"score": 0,
		"upgrades": {},
		"stats": {}
	}

func load_game()-> void:
	if not FileAccess.file_exists(PATH):
		data = get_default_data()
		save_game()
	else:
		var file: FileAccess = FileAccess.open(PATH, FileAccess.READ)
		data = JSON.parse_string(file.get_as_text())
		file.close()
		
func save_game() -> void:
	var file: FileAccess = FileAccess.open(PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()