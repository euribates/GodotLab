extends CharacterBody2D

@export var Bullets: PackedScene

@onready var sight: Node2D = $Sight

const BIG_ASTEROID_A = preload("res://BigAsteroidA.tscn")
const BIG_ASTEROID_B = preload("res://BigAsteroidB.tscn")
const BIG_ASTEROID_C = preload("res://BigAsteroidC.tscn")

const MAX_FORCE : int = 225
const MAX_LATERAL_ROTATION = 60 * PI / 180.0

var WIDTH : int = 1240
var HEIGHT : int = 720

var direction: Vector2 = Vector2.RIGHT
var speed : float = 0.0
var acc : float = 1.0
var force: Vector2 = Vector2.ZERO

func _draw() -> void  :
	var pos := self.position
	self.draw_line(
		Vector2(-5, 0),
		Vector2(-5, 0),
		Color.CORAL, 1.5, true
		)
	self.draw_line(
		Vector2(0, -5),
		Vector2(0, 5),
		Color.CORAL, 1.5, true
		)
	self.draw_line(sight.position, direction * 100.0, Color.AQUA, 3.0, true)
	self.queue_redraw()

func _ready():
	print("_ready starts")
	var viewport := get_viewport_rect()
	WIDTH = viewport.size.x
	HEIGHT = viewport.size.y
	var a1 := BIG_ASTEROID_A.instantiate()
	get_parent().add_child.call_deferred(a1)
	
	var a2 := BIG_ASTEROID_B.instantiate()
	get_parent().add_child.call_deferred(a2)
	
	var a3 := BIG_ASTEROID_C.instantiate()
	get_parent().add_child.call_deferred(a3)
	
		
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select"):
		var bullet = Bullets.instantiate()
		bullet.position = sight.global_position
		bullet.rotate(self.rotation)
		bullet.direction = Vector2.RIGHT.rotated(self.rotation)
		get_parent().add_child(bullet)
	if Input.is_action_pressed("rotataRight"):
		self.rotate(MAX_LATERAL_ROTATION * delta)
		direction = direction.rotated(MAX_LATERAL_ROTATION * delta)
	elif Input.is_action_pressed("rotateLeft"):
		self.rotate(-MAX_LATERAL_ROTATION * delta)
		direction = direction.rotated(-MAX_LATERAL_ROTATION * delta)
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
		self.visible = false
		self.position.x = WIDTH
	elif self.position.x > WIDTH:
		self.visible = false
		self.position.x = 0
	if self.position.y < 0:
		self.visible = false
		self.position.y = HEIGHT
	elif self.position.y > HEIGHT:
		self.visible = false
		self.position.y = 0
	self.visible = true
