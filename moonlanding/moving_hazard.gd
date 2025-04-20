extends AnimatableBody3D

@export var distance : Vector3 = Vector3(0, 0, 3)
@export var duration : float = 3.0

func _ready() -> void:
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(self, "global_position", global_position + distance, duration)
	tween.tween_property(self, "quaternion", Quaternion(0,0, 1, 0), 0.32)
	tween.tween_interval(1)
	tween.tween_property(self, "global_position", global_position - distance, duration)
	tween.tween_property(self, "quaternion", Quaternion(0, 0, 0, -1), 0.32)
	
	tween.tween_interval(1)
	tween.set_loops()
	
