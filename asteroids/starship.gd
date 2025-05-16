extends CharacterBody2D

enum SIZES {BIG, MEDIUM, SMALL}

signal asteroid_explosion(points: int)

@export var Bullets: PackedScene
@onready var sight: Node2D = $Sight

@onready var audio_player: AudioStreamPlayer2D = $AudioPlayer

const  BIG_ASTEROID_A = preload("res://BigAsteroidA.tscn")
const BIG_ASTEROID_B = preload("res://BigAsteroidB.tscn")
const BIG_ASTEROID_C = preload("res://BigAsteroidC.tscn")

const MEDIUM_ASTEROID_A = preload("res://MediumAsteroidA.tscn")
const MEDIUM_ASTEROID_B = preload("res://MediumAsteroidB.tscn")
const MEDIUM_ASTEROID_C = preload("res://MediumAsteroidC.tscn")

const SMALL_ASTEROID_A = preload("res://SmallAsteroidA.tscn")
const SMALL_ASTEROID_B = preload("res://SmallAsteroidB.tscn")
const SMALL_ASTEROID_C = preload("res://SmallAsteroidC.tscn")

const MAX_FORCE : int = 225
const MAX_LATERAL_ROTATION = 90 * PI / 180.0

var WIDTH : int = 1240
var HEIGHT : int = 720

var direction: Vector2 = Vector2.RIGHT
var speed : float = 0.0
var acc : float = 1.0
var force: Vector2 = Vector2.ZERO

var asteroids = []

func get_random_position() -> Vector2:
	var x := randf_range(0, WIDTH)
	var y := randf_range(0, HEIGHT)
	return Vector2(x, y)

func _draw() -> void:
	var pos := self.position
	self.draw_line(
		Vector2(-25, 0),
		Vector2(25, 0),
		Color.CHARTREUSE, 1.5, true
		)
	self.draw_line(
		Vector2(0, 25),
		Vector2(0, -25),
		Color.CHARTREUSE, 1.5, true
		)
	self.draw_line(Vector2(0, 0), direction * 60.0, Color.AQUA, 3.0, true)
	

func create_asteroid(pos: Vector2, klass: String, size: SIZES):
	var ast: Variant
	match klass:
		'A': 
			match size:
				SIZES.BIG:
					ast = BIG_ASTEROID_A.instantiate()
				SIZES.MEDIUM:
					ast = MEDIUM_ASTEROID_A.instantiate()
				SIZES.SMALL:
					ast = SMALL_ASTEROID_A.instantiate()
		'B':
			match size:
				SIZES.BIG:
					ast = BIG_ASTEROID_B.instantiate() 
				SIZES.MEDIUM:
					ast = MEDIUM_ASTEROID_B.instantiate() 
				SIZES.SMALL:
					ast = SMALL_ASTEROID_B.instantiate()
		'C':
			match size:
				SIZES.BIG:
					ast = BIG_ASTEROID_C.instantiate() 
				SIZES.MEDIUM:
					ast = MEDIUM_ASTEROID_C.instantiate() 
				SIZES.SMALL:
					ast = SMALL_ASTEROID_C.instantiate()
	ast.global_position = pos
	ast.exploded.connect(_on_exploded)
	get_parent().add_child.call_deferred(ast)
	asteroids.append(ast)
	return ast
	

func _ready():
	print("_ready starts")
	var viewport := get_viewport_rect()
	WIDTH = viewport.size.x
	HEIGHT = viewport.size.y
	create_asteroid(get_random_position(), 'A', SIZES.BIG)
	create_asteroid(get_random_position(), 'B', SIZES.BIG)
	create_asteroid(get_random_position(), 'C', SIZES.BIG)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		var bullet = Bullets.instantiate()
		bullet.position = sight.global_position
		bullet.rotate(self.rotation)
		bullet.direction = Vector2.RIGHT.rotated(self.rotation)
		get_parent().add_child(bullet)
	if Input.is_action_pressed("rotataRight"):
		self.rotate(MAX_LATERAL_ROTATION * delta)
		direction = Vector2.RIGHT.rotated(self.rotation)
	elif Input.is_action_pressed("rotateLeft"):
		self.rotate(-MAX_LATERAL_ROTATION * delta)
		direction = Vector2.RIGHT.rotated(self.rotation)
	if Input.is_action_pressed("powerOn"):	
		$Sprite2D.frame = 1
		acc = 0.25 * delta
	else:
		$Sprite2D.frame = 0
		acc = 0.0
		speed = 0.0
	speed = speed + acc
	force = force + (direction * speed)
	self.position += force	
	if self.position.x < 0:
		self.position.x = WIDTH
	elif self.position.x > WIDTH:
		self.position.x = 0
	if self.position.y < 0:
		self.position.y = HEIGHT
	elif self.position.y > HEIGHT:
		self.position.y = 0
	self.queue_redraw()

func _on_exploded(body: Area2D) -> void:
	audio_player.play()
	if body.is_big():
		emit_signal("asteroid_explosion", 40)
		for klass in ['A', 'B', 'C']:
			create_asteroid(body.position, klass, SIZES.MEDIUM)
	elif body.is_medium():
		emit_signal("asteroid_explosion", 12)
		for klass in ['A', 'B', 'C']:
			create_asteroid(body.position, klass, SIZES.SMALL)
	else:
		emit_signal("asteroid_explosion", 4)
	body.queue_free()
