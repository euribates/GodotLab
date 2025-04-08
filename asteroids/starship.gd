extends RigidBody2D

var impulse: float = 12500.0
var speed: Vector2 = Vector2.ZERO * impulse
var engines: bool = false

func _physics_process(delta):
	get_input(delta)
	# self.add_constant_central_force(speed)
	# move_and_collide(speed * impulse / mass)

func get_input(delta):
	if Input.is_action_pressed("rotataRight"):
		angular_velocity = 180.0 * delta
	elif Input.is_action_pressed("rotateLeft"):
		angular_velocity = -180.0 * delta
	else:
		angular_velocity = 0.0
	if Input.is_action_pressed("powerOn"):	
		$FireSprite.visible = true
		var angle: float = self.global_rotation
		var arrow: Vector2 = (Vector2.UP * impulse).rotated(angle)
		self.apply_central_impulse(arrow * delta)
	else:
		$FireSprite.visible = false
