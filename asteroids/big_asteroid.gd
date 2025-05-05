extends Area2D

signal exploded(asteroid)

enum SIZES {BIG, MEDIUM, SMALL}
@export var Size : SIZES

const SIZE = 64

var WIDTH : float = 1240
var HEIGHT : float = 720

var spin : float = 4.0
var direction :  Vector2 = Vector2.RIGHT
var speed : float = 25.0

func is_big() -> bool:
	return self.Size == SIZES.BIG
	
func is_medium() -> bool:
	return self.Size == SIZES.MEDIUM
	
func is_small() -> bool:
	return self.Size == SIZES.SMALL
	
func _ready() -> void:
	var viewport := get_viewport_rect()
	WIDTH = viewport.size.x
	HEIGHT = viewport.size.y
	direction = Vector2.RIGHT.rotated(randf_range(0.0, 2 * PI))
	speed = randf_range(12.40, 37.60)
	spin = randf_range(2.2, 7.3)
	
			
func _process(delta: float) -> void:
	self.rotate(spin * delta)
	self.position += direction * speed * delta
	if self.position.x < -SIZE:
		self.position.x = WIDTH
	elif self.position.x > WIDTH + SIZE:
		self.position.x = 0
	if self.position.y < -SIZE:
		self.position.y = HEIGHT
	elif self.position.y > HEIGHT + SIZE:
		self.position.y = 0


func _on_body_entered(body: Node2D) -> void:
	print("_on_body_entered")
	if body.is_in_group('Laser'):
		print('Is laser')
		exploded.emit(self)
		body.queue_free()
