extends RigidBody2D

const  SPEED: float = 750  # Pixels por segunda
var direction: Vector2 = Vector2.RIGHT

func _ready():
	position = Vector2(20, 360)
	apply_force(direction * SPEED)
