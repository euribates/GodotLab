extends RigidBody2D

var lateral_rotation : float = 24000
var impulse: float = 1250.0

func _physics_process(delta):
	if Input.is_action_pressed("rotataRight"):
		apply_torque(lateral_rotation * delta)
	elif Input.is_action_pressed("rotateLeft"):
		apply_torque(-lateral_rotation * delta)
	if Input.is_action_pressed("powerOn"):	
		$FireSprite.visible = true
		var arrow = Vector2.UP.rotated(self.rotation)
		apply_central_force(arrow * impulse * delta)
	else:
		$FireSprite.visible = false
		
func _integrate_forces(state):
	if self.position.x < 0:
		self.position.x = 1240
	elif self.position.x > 1240:
		self.position.x = 0
	if self.position.y < 0:
		self.position.y = 720
	elif self.position.y > 720:
		self.position.y = 0
