extends VBoxContainer

class_name MarketPanel
signal money_changed
@onready var btn_sound: AudioStreamPlayer2D = $BtnSounds
@onready var price_nmb: Label = $BottomSide/PricePanel/PriceNumb
@onready var buff_panel: MarketPanel = $"."
@onready var lvls: Array[Sprite2D] = [
	$TopSide/MainPanelSprite/BackGroundPanel/LevelUpContainer/LevelUp1Panel/LevelUp1Sprite,
	$TopSide/MainPanelSprite/BackGroundPanel/LevelUpContainer/LevelUp2Panel/LevelUp2Sprite,
	$TopSide/MainPanelSprite/BackGroundPanel/LevelUpContainer/LevelUp3Panel/LevelUp3Sprite
]
@onready var buy_btn: Button = $BottomSide/Button

@export var upgrade_value: int = 0

var how_many_lvl:int
const done_png: String = "res://assets/ui/market/comprato.png"
var how_many_possibile_lvls: int
var panel_name: String
var first: bool = true

func _ready() -> void:
	price_nmb.text = str(upgrade_value)
	
	panel_name = buff_panel.name.trim_suffix("Panel")
	
	if not save_manager.data.upgrades.has(panel_name):
		save_manager.data.upgrades[panel_name] = 0
	
	how_many_lvl = save_manager.data.upgrades[panel_name]
	
	how_many_possibile_lvls = len(lvls)
	buff_settings_handler()

func _process(delta: float) -> void:
	btn_handler()

func buff_settings_handler() -> void:
	if how_many_lvl + 1 > how_many_possibile_lvls:
		buy_btn.disabled = true
	
	var lvls_count:int = 0
	while how_many_lvl > lvls_count:
		lvls[lvls_count].texture = load(done_png)
		lvls_count += 1
	

func _on_button_pressed() -> void:
	btn_sound.play()
	how_many_lvl += 1
	buff_settings_handler()
	
	if not buy_handler():
		return
	
func buff_change_price(price: int)->void:
	upgrade_value = price + price/4
	price_nmb.text = str(upgrade_value)
	
func buy_handler() -> bool:
	if save_manager.data.score < upgrade_value:
		return false

	save_manager.data.upgrades[panel_name] = how_many_lvl
	save_manager.data.score -= upgrade_value
	save_manager.save_game()
	
	buff_change_price(upgrade_value)
	buff_settings_handler()
	emit_signal("money_changed")

	return true

func btn_handler()->void:
	if save_manager.data.score < upgrade_value:
		buy_btn.disabled = true
