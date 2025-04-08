extends RigidBody3D

var speed: float = 10000.0
var torque: float = 500.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * speed)
	if Input.is_action_pressed("rotateLeft"):
		apply_torque(Vector3(0, 0, delta * torque))
	if Input.is_action_pressed("rotateRight"):
		apply_torque(Vector3(0, 0, delta * -torque))
 


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("SafeLand"):
		print("Wins")
