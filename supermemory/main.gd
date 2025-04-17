extends Node3D

var slot: Sprite3D
var texture: ImageTexture

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	slot = get_node('Sprite3D')
	var image = Image.load_from_file("res://Images/Olrik.png")
	texture = ImageTexture.create_from_image(image)

func switch():
	print("switch")
	slot.texture = texture
	
func _process(delta: float) -> void:
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		switch()
		
	if Input.is_action_just_pressed('ui_accept'):
		var rotation_a = Vector3(0, PI/2.0, 0)
		var rotation_b = Vector3(0, 0, 0)		
		var tween = get_tree().create_tween()
		# tween.tween_property(slot, "modulate", Color(1, 0.75, 0.75, 1.0), 0.3).set_trans(Tween.TRANS_SINE)
		# tween.tween_property(slot, "scale", Vector3(2.4, 2.4, 1), 0.7).set_trans(Tween.TRANS_BOUNCE)
		var t : Transform3D = Transform3D(self.basis, Vector3(0, 0, 12))
		tween.tween_property(slot, "transform", t, 2).set_trans(Tween.TRANS_ELASTIC)
		tween.tween_property(slot, "rotation", rotation_a, 1).set_ease(Tween.EASE_OUT)
		
		tween.tween_callback(print.bind(self.transform))
		tween.tween_callback(switch)
		tween.tween_property(slot, "rotation", rotation_b, 1).set_ease(Tween.EASE_IN)
		tween.tween_property(slot, "transform", Transform3D(), 1).set_trans(Tween.TRANS_ELASTIC)
		# tween.tween_property(slot, "scale", Vector3(1, 1, 1), 0.7)
		# tween.tween_property(slot, "modulate", Color(1.0, 1.0, 1.0, 1.0), 0.3)
		tween.tween_callback(print.bind(self.transform))

		# tween.tween_property(slot, "rotation.y", PI, 2.5)
		
	# print(slot.rotation.y)
	
