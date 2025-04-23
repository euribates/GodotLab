extends Control

@onready var sprite_one : Sprite2D = $SpriteOne
@onready var sprite_two : Sprite2D = $SpriteTwo
@onready var sprite_three : Sprite2D = $SpriteThree


func start_sequence():
	var tween_3 := get_tree().create_tween()
	tween_3.tween_callback(print.bind("3"))
	tween_3.tween_property(sprite_three, "visible", true, 0)
	tween_3.set_parallel(true)
	tween_3.tween_property(sprite_three, "modulate", Color(255, 255, 255, 0), 1)
	tween_3.tween_property(sprite_three, "scale", Vector2(4, 4), 1)
	tween_3.chain().tween_property(sprite_three, "visible", false, 1)
	
	var tween_2 := get_tree().create_tween()
	tween_2.tween_interval(1)
	tween_2.tween_callback(print.bind("2"))
	tween_2.tween_property(sprite_two, "visible", true, 0)
	tween_2.set_parallel()
	tween_2.tween_property(sprite_two, "scale", Vector2(4, 4), 1)
	tween_2.tween_property(sprite_two, "modulate", Color(55, 255, 255, 0), 1)
	tween_2.chain()
	tween_2.tween_property(sprite_two, "visible", false, 0)
	

	var tween_1 := get_tree().create_tween()
	tween_1.tween_interval(2)
	tween_1.tween_callback(print.bind("1"))
	tween_1.tween_property(sprite_one, "visible", true, 0)
	tween_1.set_parallel()
	tween_1.tween_property(sprite_one, "scale", Vector2(4, 4), 1)
	tween_1.tween_property(sprite_one, "modulate", Color(55, 255, 255, 0), 1)
	tween_1.chain()
	tween_1.tween_property(sprite_one, "visible", false, 0)
	tween_1.tween_callback(start_game)

func start_game():
	get_tree().change_scene_to_file("res://Main.tscn")
	

func _on_button_pressed() -> void:
	start_sequence()
