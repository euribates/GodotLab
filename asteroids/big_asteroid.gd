extends RigidBody2D

const SIZE = 64
var WIDTH : float
var HEIGHT : float

var spin : float = 800.0
var direction :  Vector2 = Vector2.RIGHT
var speed : float = 2450.0

func _ready() -> void:
	print("_ready starts")
	var viewport := get_viewport_rect()
	WIDTH = viewport.size.x
	HEIGHT = viewport.size.y
	self.position.x = randi_range(0, WIDTH)
	self.position.y = randi_range(0, HEIGHT)
	direction = Vector2.RIGHT.rotated(randf_range(0.0, 2 * PI))
	speed = randf_range(1240, 3760)
	spin = randf_range(7200.0, 12000.0)
	self.apply_torque(spin)
	self.apply_central_force(direction * speed)
	print("_ready ends")

func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if self.position.x < -SIZE:
		self.position.x = WIDTH
	elif self.position.x > WIDTH + SIZE:
		self.position.x = 0
	if self.position.y < -SIZE:
		self.position.y = HEIGHT
	elif self.position.y > HEIGHT + SIZE:
		self.position.y = 0
