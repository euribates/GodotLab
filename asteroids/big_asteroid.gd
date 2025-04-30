extends Area2D

const SIZE = 64

var WIDTH : float
var HEIGHT : float

var spin : float = 4.0
var direction :  Vector2 = Vector2.RIGHT
var speed : float = 25.0


func _on_body_entered(body: Node):
	print("_on_body_entered starts")
	print("Body:", body)
	if body.is_in_group("Rocks"):
		print("BOOOM")
		body.queue_free()
	print("_on_body_entered ends")

	
func _ready() -> void:
	print("_ready starts")
	var viewport := get_viewport_rect()
	WIDTH = viewport.size.x
	HEIGHT = viewport.size.y
	self.position.x = randi_range(0, WIDTH)
	self.position.y = randi_range(0, HEIGHT)
	direction = Vector2.RIGHT.rotated(randf_range(0.0, 2 * PI))
	speed = randf_range(12.40, 37.60)
	spin = randf_range(2.2, 7.3)
	print("_ready ends")

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
