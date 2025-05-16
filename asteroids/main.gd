extends Node2D

@onready var lbl_score = $FlowContainer/MarginContainer/lblScore

var score : int:
	set(new_value):
		score = new_value
	get():
		return score


func _on_starship_asteroid_explosion(points: int) -> void:
	score += points
	lbl_score.text = str(score)
