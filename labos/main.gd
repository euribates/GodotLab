extends Node2D

const PARTICLES := preload("res://particles.tscn")
const ACC := preload("res://acc.tscn")
const ANIMACIONES := preload("res://animaciones.tscn")
const AUDIO = preload("res://Audio/audio.tscn")

func _on_acc_button_pressed() -> void:
	get_tree().change_scene_to_packed(ACC)


func _on_pb_particles_pressed() -> void:
	get_tree().change_scene_to_packed(PARTICLES)


func _on_pb_animaciones_pressed() -> void:
	get_tree().change_scene_to_packed(ANIMACIONES)


func _on_pb_audio_pressed() -> void:
	get_tree().change_scene_to_packed(AUDIO)
