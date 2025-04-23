extends Control

@onready var etiqueta : Sprite2D = $Sprite2D


func start_sequence():
	etiqueta.visible = true
	var tween := get_tree().create_tween()
	
	tween.tween_property(etiqueta, "scale", Vector2(4, 4), 1)
	tween.parallel()
	tween.tween_callback(print.bind("3"))
	tween.parallel()
	tween.tween_property(etiqueta, "modulate", Color(255, 255, 255, 0), 1)
	tween.tween_property(etiqueta, "frame", 1, 0)
	tween.tween_property(etiqueta, "scale", Vector2(1, 1), 0)
	tween.tween_property(etiqueta, "modulate", Color(255, 255, 255, 255), 0)
		
	tween.tween_property(etiqueta, "frame", 2, 0)
	tween.tween_property(etiqueta, "scale", Vector2(1, 1), 0)
	tween.parallel()
	tween.tween_property(etiqueta, "modulate", Color(255, 255, 255, 255), 0)

	tween.tween_property(etiqueta, "frame", 1, 0)
	tween.tween_property(etiqueta, "scale", Vector2(1, 1), 0)
	tween.tween_property(etiqueta, "modulate", Color(255, 255, 255, 255), 0)

	tween.tween_property(etiqueta, "frame", 3, 0)
	tween.tween_property(etiqueta, "scale", Vector2(4, 4), 1)
	tween.tween_property(etiqueta, "modulate", Color(255, 255, 255, 0), 1)
	tween.set_parallel(false)

	
	tween.tween_interval(1)
	tween.tween_callback(print.bind("2"))
	tween.tween_interval(1)
	tween.tween_callback(print.bind("1"))
	tween.tween_interval(1)
	tween.tween_callback(print.bind("Start!"))
	

func _on_button_pressed() -> void:
	print("OK")
	start_sequence()
