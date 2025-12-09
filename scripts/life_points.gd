extends Panel

@onready var life_points: Sprite2D = $LifePointsSprite
@onready var root: Node2D = $".."

func _ready() -> void:
	root.connect("emit_player_hp_to_ui", change_hp_shape)
	
func change_hp_shape(dmg: int) ->void:
	life_points.frame_coords.x -= dmg
