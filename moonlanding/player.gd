extends RigidBody3D

## How much force to apply to rocket (newtons)
@export_range(250.0, 5500.0) var speed: float = 850.0

## Howm uch force applied to turn orientation of rocket (newtons x m)
@export var torque: float = 150.0

var is_transicion: bool = false

@onready var explosion_sound: AudioStreamPlayer = $ExplosionPlayer
@onready var success_sound: AudioStreamPlayer = $SuccessPlayer
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var left_booster: GPUParticles3D = $LeftBooster
@onready var right_booster: GPUParticles3D = $RightBooster

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("boost"):
		apply_central_force(basis.y * delta * speed)
		booster_particles.emitting = true
		
		if not audio_stream_player_3d.playing:
			audio_stream_player_3d.play()
	else:
		booster_particles.emitting = false
		audio_stream_player_3d.stop()
	if Input.is_action_pressed("rotateLeft"):
		apply_torque(Vector3(0, 0, delta * torque))
		right_booster.emitting = true
	else:
		right_booster.emitting = false
		
	if Input.is_action_pressed("rotateRight"):
		apply_torque(Vector3(0, 0, delta * -torque))
		left_booster.emitting = true
	else:
		left_booster.emitting = false

		
func _on_body_entered(body: Node) -> void:
	if not is_transicion:
		if body.is_in_group("SafeLand"):
			complete_level(body.next_level)
		if body.is_in_group("Hazard"):
			crash_sequence()

func crash_sequence() -> void:
	explosion_sound.play()
	is_transicion = true
	set_process(false)
	print("Kaboom!")
	var tween = create_tween()
	tween.tween_interval(2.6)
	tween.tween_callback(get_tree().reload_current_scene)
	
func complete_level(new_level) -> void:
	success_sound.play()
	is_transicion = true
	set_process(false)
	print("You win!")
	var tween = create_tween()
	tween.tween_interval(1.8)
	tween.tween_callback(get_tree().change_scene_to_file.bind(new_level))
