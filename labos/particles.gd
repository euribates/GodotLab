extends Node2D

@onready var particles: CPUParticles2D = $Emitter/CPUParticles2D
@onready var gravity_y_slider: HSlider = $Panel/GravityYSlider
@onready var gravity_x_slider: HSlider = $Panel/GravityXSlider

var XGravity: float = 0
var YGravity: float = 0



func _ready() -> void:
	particles.gravity = Vector2(XGravity, YGravity)


func _on_gravity_x_slder_drag_ended(value_changed: bool) -> void:
	print(particles)
	if value_changed:
		particles.gravity.x = gravity_x_slider.value


func _on_gravity_y_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		particles.gravity.y = gravity_y_slider.value
