extends Node2D

var speed : Vector2 = Vector2(0.707106781186547, 0.707106781186547)
var acc : Vector2 = Vector2(0.707106781186547, 0.707106781186547) * 80

@onready var player: Sprite2D = $Player
@onready var lbl_speed: Label = $lblSpeed

func _ready() -> void:
	player.position = Vector2(1240/2.0, 720/2.0)

func _process(delta: float) -> void:
	player.position += speed * delta
	if player.position.y > 656 or player.position.y < 64:
		speed.y = - speed.y
		acc.y = - acc.y
	if player.position.x > 1176 or player.position.x < 64:
		speed.x = - speed.x
		acc.x = - acc.x
	speed += acc * delta
	lbl_speed.text = str(speed)
	
	
	
