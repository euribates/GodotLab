extends CharacterBody2D

const  SPEED: float = 750  # Pixels por segunda
var direction: Vector2 = Vector2.RIGHT
	
func _process(delta: float) -> void:
	position += direction * SPEED * delta
