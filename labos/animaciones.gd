extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_pb_idle_pressed() -> void:
	animation_player.play('idle')

func _hola() -> void:
	print("Hola")
