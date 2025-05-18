extends Node3D

const MAX_HEALTH : int = 5

@onready var health_label: Label3D = $HealthLabel
	
var current_health : int = MAX_HEALTH:
	set(new_value):
		current_health = new_value
		health_label.text = str(current_health) + "/"  + str(MAX_HEALTH)
		health_label.modulate = lerp(Color.RED, Color.WHITE, float(current_health) / MAX_HEALTH)
	get():
		return current_health


func _ready() -> void:
	current_health = MAX_HEALTH
	

func take_damage() -> void:
	print(""" Base attacked! """)
	current_health -= 1
