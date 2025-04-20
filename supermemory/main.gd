extends Node3D
	
@export var character : Texture

var t_fordward : Transform3D = Transform3D(self.basis, Vector3(0, 0, 12))
var t_backward : Transform3D = Transform3D(self.basis, Vector3(0, 0, 0))
	
var chareacter_background : Image
var chareacter_foreground : Image

var texture: ImageTexture
@onready var slot: Sprite3D = $Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chareacter_background = Image.load_from_file("res://Images/fondo-personaje.png")
	chareacter_foreground = Image.load_from_file("res://Images/BlakeAndMortimer.png")
	slot.texture = ImageTexture.create_from_image(chareacter_background)

func switch():
	print("switch on")
	var image = Image.load_from_file("res://Images/DoctorInfierno.png")
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.tween_property(slot, "transform", t_fordward, 0.4)
	tween.tween_property(slot, 'quaternion', Quaternion(0, -0.7071068, 0, 0.7071068), 0.4)
	tween.tween_property(slot, 'texture', ImageTexture.create_from_image(chareacter_foreground), 0)	
	tween.tween_property(slot, 'quaternion', Quaternion(0, -1, 0, 0), 0.4)
	tween.tween_interval(2.2)	
	tween.tween_property(slot, 'quaternion', Quaternion(0, 0.7071068, 0, 0.7071068), 0.4)
	tween.tween_property(slot, 'texture', ImageTexture.create_from_image(chareacter_background), 0)	
	tween.tween_property(slot, 'quaternion', Quaternion(0, 0, 0, 1), 0.4)
	tween.tween_property(slot, "transform", t_backward, 0.4)
			
func switch_on():
	print("switch on")
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.tween_property(slot, "transform", t_fordward, 0.5)
	tween.tween_property(slot, 'quaternion', Quaternion(0, -0.7071068, 0, 0.7071068), 0.25)
	tween.tween_property(slot, 'texture', ImageTexture.create_from_image(chareacter_foreground), 0)	
	tween.tween_property(slot, 'quaternion', Quaternion(0, -1, 0, 0), 0.25)		

func switch_off():
	var tween = get_tree().create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	print("switch off")
	tween.tween_property(slot, 'quaternion', Quaternion(0, -0.7071068, 0, -0.7071068), 0.25)
	tween.tween_property(slot, 'texture', ImageTexture.create_from_image(chareacter_background), 0)	
	tween.tween_property(slot, 'quaternion', Quaternion(0, 0, 0, 1), 0.25)
	tween.tween_property(slot, "transform", t_backward, 0.5)
	
func _process(delta: float) -> void:
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		print("right")
		switch_off()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		print("left")
		switch_on()
		
	if Input.is_action_just_pressed('ui_accept'):
		switch()
		
