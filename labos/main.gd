extends Node2D

const PARTICLES := preload("res://particles.tscn")
const ACC := preload("res://acc.tscn")

func _on_acc_button_pressed() -> void:
	get_tree().change_scene_to_packed(ACC)


func _on_pb_particles_pressed() -> void:
	get_tree().change_scene_to_packed(PARTICLES)
	
