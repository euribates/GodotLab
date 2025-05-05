extends CharacterBody2D

const MARGIN : int = 100

var MIN_WIDTH: int = -MARGIN
var MIN_HEIGHT: int = -MARGIN
var MAX_WIDTH: int = 1240 + MARGIN
var MAX_HEIGHT: int = 740 + MARGIN

const  SPEED: float = 820  # Pixels por segunda
var direction: Vector2 = Vector2.RIGHT

func _ready() -> void:
	var viewport := get_viewport_rect()
	MAX_WIDTH = viewport.size.x + MARGIN
	MAX_HEIGHT = viewport.size.y + MARGIN
		
func _process(delta: float) -> void:
	position += direction * SPEED * delta
	if position.x < MIN_WIDTH or position.x > MAX_WIDTH:
		self.queue_free()
	if position.y < MIN_HEIGHT or position.y > MAX_HEIGHT:
		self.queue_free()
		
