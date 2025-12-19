extends Panel

@onready var root: Node2D = $".."
@onready var ui_panel: Panel = $"."
@onready var dmg_taken: AudioStreamPlayer2D = $DmgTakenSound
@onready var points_counter: Label = $PointsCounter

func _ready() -> void:
	points_counter.text = str(root.player_life)
	root.connect("emit_player_hp_to_ui", change_hp_value)
	
func change_hp_value(dmg: int) ->void:
	if points_counter.text not in str(dmg):
		dmg_taken.play()
		points_counter.text = str(dmg)
