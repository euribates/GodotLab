extends PathFollow3D

@export var speed : float = 3.2

@onready var base = get_tree().get_first_node_in_group("base")


func _process(delta: float) -> void:
	self.progress += speed * delta
	if self.progress_ratio > 0.9:
		print(self.progress_ratio)
	if self.progress_ratio == 1.0:
		base.take_damage()
	
