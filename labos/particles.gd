extends Node2D

@onready var particles: CPUParticles2D = $Emitter/CPUParticles2D
@onready var gravity_y_slider: HSlider = $Panel/GravityYSlider
@onready var gravity_x_slider: HSlider = $Panel/GravityXSlider
@onready var explosivenes_slider: HSlider = $Panel/ExplosivenesSlider
@onready var randomness_slider: HSlider = $Panel/RandomnessSlider

var XGravity: float = 0
var YGravity: float = 0



func _ready() -> void:
	particles.gravity = Vector2(XGravity, YGravity)
	$Panel/txt_amount.text = str(particles.amount)
	$Panel/txt_speed_scale.text = str(particles.speed_scale)


func _on_gravity_x_slder_drag_ended(value_changed: bool) -> void:
	print(particles)
	if value_changed:
		particles.gravity.x = gravity_x_slider.value
		gravity_x_slider.tooltip_text = str(gravity_x_slider.value)


func _on_gravity_y_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		particles.gravity.y = gravity_y_slider.value
		gravity_y_slider.tooltip_text = str(gravity_y_slider.value)


func _on_txt_lifetime_text_changed(new_text: String) -> void:
	if new_text.is_valid_float():
		particles.lifetime = float(new_text)


func _on_explosivenes_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		var value: float = explosivenes_slider.value
		particles.explosiveness = value
		explosivenes_slider.tooltip_text = str(value)


func _on_txt_amount_text_changed(new_text: String) -> void:
	if new_text.is_valid_int():
		var value : int = int(new_text)
		particles.amount = value
		

func _on_randomnes_slider_drag_ended(value_changed: bool) -> void:
	if value_changed:
		var value: float = randomness_slider.value
		print("value:", value)
		particles.randomness = value
		randomness_slider.tooltip_text = str(value)


func _on_pb_restart_pressed() -> void:
	particles.restart()
