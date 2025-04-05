extends Node2D

var speed_amplitude: float = 300.0
var ball_speed: Vector2
var pad_speed: int = 160

@onready var ball = $Ball

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ball.position = Vector2(620, 350)
	ball_speed = Vector2(620, randf_range(-350, 350)).normalized() * speed_amplitude

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ball.position += ball_speed * delta
	if Input.is_action_pressed("player_one_up"):
		$PlayerOne.position.y -= pad_speed * delta
	elif Input.is_action_pressed("player_one_down"):
		$PlayerOne.position.y += pad_speed * delta
	if Input.is_action_pressed("player_two_up"):
		$PlayerTwo.position.y -= pad_speed * delta
	elif Input.is_action_pressed("player_two_down"):
		$PlayerTwo.position.y += pad_speed * delta

func _on_horizontal_exit(area: Area2D) -> void:
	print("Se ha saido?")
	ball_speed.x = -ball_speed.x

func _on_vertical_exit(area: Area2D) -> void:
	ball_speed.y = -ball_speed.y
