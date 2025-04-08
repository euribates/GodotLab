extends Node2D

const INITIAL_SPEED_AMPLITUDE: float = 400.0
var debug: bool = true

var score_player_one: int = 0
var score_player_two: int = 0
var speed_amplitude: float = INITIAL_SPEED_AMPLITUDE
var ball_speed: Vector2
var pad_speed: int = 160

@onready var ball = $Ball

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_play()
	
func start_play():
	ball.position = Vector2(620, 350)
	speed_amplitude = INITIAL_SPEED_AMPLITUDE
	ball_speed = Vector2(620, randf_range(-350, 350)).normalized() * speed_amplitude
	$Timer.start(1)

func update_scores(to_player_one: int = 0, to_player_two: int = 0):
	if to_player_one > 0:
		score_player_one += to_player_one
		$Scores/ScorePlayerOne.text = str(score_player_one)
	if to_player_two > 0:
		score_player_two += to_player_two
		$Scores/ScorePlayerTwo.text = str(score_player_two)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	ball.position += ball_speed * delta
	if Input.is_action_pressed("player_one_up"):
		$PlayerOne.position.y -= pad_speed * delta
	elif Input.is_action_pressed("player_one_down"):
		$PlayerOne.position.y += pad_speed * delta
	if Input.is_action_pressed("player_two_up"):
		$PlayerTwo.position.y -= pad_speed * delta
	elif Input.is_action_pressed("player_two_down"):
		$PlayerTwo.position.y += pad_speed * delta
	if debug:
		$GUI/ball_speed_x.text = 'ball_speed.x: ' + str(ball_speed.x)
		$GUI/ball_speed_y.text = 'ball_speed.y: ' + str(ball_speed.y)
		$GUI/lbl_speed_amplitude.text = 'Speed: ' + str(speed_amplitude)

	if Input.is_action_pressed('debug'):
		debug = not debug
		$GUI.set_visible(debug)
		
	queue_redraw()
	
func _draw():
	if debug: 
		draw_circle($PlayerTwo.position + Vector2(100, 0), 2, Color(.1, 1, .1))
		draw_circle($PlayerOne.position + Vector2(-100, 0), 2, Color(1, .1, .1))
		var arrow: Vector2 = ball.position + ball_speed
		var orientation = ball_speed.normalized() * 22;
		var head = [
			ball.position + ball_speed,
			ball.position + ball_speed - orientation.rotated(0.7854),
			ball.position + ball_speed + orientation.rotated(2.562),
			]
		var godot_blue : Color = Color("478cbf")
		# We pass the PackedVector2Array to draw the shape.1,5708
		draw_polygon(head, [godot_blue])
		draw_line(ball.position, arrow, godot_blue, 1)
	
func _on_right_pad_collision(area: Area2D) -> void:
	$AudioPlayer.play()
	ball_bounce()
	var origin: Vector2 =  $PlayerTwo.position + Vector2(100, 0)
	ball_speed = origin.direction_to(ball.position) * speed_amplitude
	

func _on_left_pad_collision(area: Area2D) -> void:
	$AudioPlayer.play()
	ball_bounce()
	var origin: Vector2 =  $PlayerOne.position + Vector2(-100, 0)
	ball_speed = origin.direction_to(ball.position) * speed_amplitude
	
	
func _on_vertical_exit(area: Area2D) -> void:
	ball_speed.y = -ball_speed.y
	ball_speed.rotated(randf_range(-0.3, 0.3))


func _on_right_out_area_entered(area: Area2D) -> void:
	update_scores(1, 0)
	start_play()


func _on_left_out_area_entered(area: Area2D) -> void:
	update_scores(0, 1)
	start_play()


func ball_bounce() -> void:
	ball_speed.x = -ball_speed.x


func inc_speed() -> void:
	speed_amplitude *= 1.01
	$GUI/lbl_speed_amplitude.text = 'Speed amplitud: ' + str(speed_amplitude)
