extends PathFollow3D

@export var speed : float = 3.2

func _process(delta: float) -> void:
	self.progress += speed * delta
	
