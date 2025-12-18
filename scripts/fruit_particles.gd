extends Node2D

class_name FruitParticles

@onready var root: Node = $".."
@onready var fruit_explosion: CPUParticles2D = $FruitExplosion
@onready var fruit_sketch: CPUParticles2D = $FruitSketch

func _ready() -> void:
	root.connect("emit_particels_input", particles_handler)
	
func particles_handler(color, _position) -> void:
	particles_settings(fruit_explosion, color, _position)
	particles_settings(fruit_sketch, color + 'd4', _position)
	
func particles_settings(node, color, _position)-> void: 
	node.color = color
	node.global_position = _position
	node.emitting = true
