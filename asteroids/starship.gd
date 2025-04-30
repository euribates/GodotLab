extends CharacterBody2D

@export var Bullets: PackedScene

@onready var sight: Node2D = $Sight

const BIG_ASTEROID_A = preload("res://BigAsteroidA.tscn")
const BIG_ASTEROID_B = preload("res://BigAsteroidB.tscn")
const BIG_ASTEROID_C = preload("res://BigAsteroidC.tscn")

const MAX_FORCE : int = 225
const MAX_LATERAL_ROTATION = 720.0

var WIDTH : int
var HEIGHT : int

var lateral_rotation : float = 0.0
var force: float = 0.0
var speed: Vector2 = Vector2.ZERO

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
		lateral_rotation = MAX_LATERAL_ROTATION
	elif Input.is_action_pressed("rotateLeft"):
		lateral_rotation = -MAX_LATERAL_ROTATION
	else:
		lateral_rotation = 0.0
	if Input.is_action_pressed("powerOn"):	
		$Sprite2D.frame = 1
		speed = Vector2(MAX_FORCE, 0).rotated(self.rotation)
	else:
		$Sprite2D.frame = 0
		speed = Vector2.ZERO


func _physics_process(delta: float) -> void:
	self.position += speed * delta
	self.rotate(lateral_rotation * delta)
	if self.position.x < 0:
		self.position.x = WIDTH
	elif self.position.x > WIDTH:
		self.position.x = 0
	if self.position.y < 0:
		self.position.y = HEIGHT
	elif self.position.y > HEIGHT:
		self.position.y = 0
	self.visible = true
