extends VBoxContainer

class_name MarketPanel

@onready var btn_sound: AudioStreamPlayer2D = $BtnSounds
@onready var price_nmb: Label = $BottomSide/PricePanel/PriceNumb
@onready var buff_panel: MarketPanel = $"."
@onready var lvls: Array[Sprite2D] = [
	$TopSide/MainPanelSprite/BackGroundPanel/LevelUpContainer/LevelUp1Panel/LevelUp1Sprite,
	$TopSide/MainPanelSprite/BackGroundPanel/LevelUpContainer/LevelUp2Panel/LevelUp2Sprite,
	$TopSide/MainPanelSprite/BackGroundPanel/LevelUpContainer/LevelUp3Panel/LevelUp3Sprite
]

@export var upgrade_value: int = 0

var how_many_lvl:int
const done_png: String = "res://assets/ui/market/comprato.png"
var how_many_possibile_lvls: int
var panel_name: String

func _ready() -> void:
	panel_name = buff_panel.name.trim_suffix("Panel")
	
	if not save_manager.data.upgrades.has(panel_name):
		save_manager.data.upgrades[panel_name] = 0
	
	how_many_lvl = save_manager.data.upgrades[panel_name]
	
	how_many_possibile_lvls = len(lvls)
	
	change_price(upgrade_value)
	
	buff_settings_handler()

func buff_settings_handler() -> void:
	var lvls_count:int = 0
	if how_many_lvl > how_many_possibile_lvls:
		return
	
	while how_many_lvl > lvls_count:
		lvls[lvls_count].texture = load(done_png)
		lvls_count += 1

func _on_button_pressed() -> void:
	btn_sound.play()
	how_many_lvl += 1
	buff_settings_handler()
	
	if not buy_handler():
		return
	
	change_price(upgrade_value)
	

func change_price(price: int)->void:
	price_nmb.text = ""
	var current_price: int = price * (1 + int(save_manager.data.upgrades[panel_name]))
	price_nmb.text += str(current_price)
	
func buy_handler() -> bool:
	if save_manager.data.score < upgrade_value:
		return false

	save_manager.data.upgrades[panel_name] = how_many_lvl
	save_manager.data.score -= upgrade_value
	save_manager.save_game()
	
	change_price(upgrade_value)
	buff_settings_handler()
	
	return true

	