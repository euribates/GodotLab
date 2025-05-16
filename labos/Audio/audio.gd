extends Node2D

const DRUM = preload("res://Audio/snare-drum-341273.mp3")
const LASER = preload("res://Audio/laser-312360.mp3")

@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer


func _on_button_pressed() -> void:
	audio_player.stream = DRUM
	audio_player.autoplay = false
	audio_player.play()


func _on_pb_laser_pressed() -> void:
	audio_player.stream = LASER
	audio_player.autoplay = false
	audio_player.play()
