extends Node2D

var score_player_one: int = 0
var score_player_two: int = 0

var speed_amplitude: float = 400.0
var ball_speed: Vector2
var pad_speed: int = 160

@onready var ball = $Ball

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_play()
	
func start_play():
	print('start_play')
	ball.position = Vector2(620, 350)
	ball_speed = Vector2(620, randf_range(-350, 350)).normalized() * speed_amplitude
	$Timer.start(1)

func update_scores(to_player_one: int = 0, to_player_two: int = 0):
	if to_player_one > 0:
		score_player_one += to_player_one
		$GUI/lbl_score_player_one.text = 'Score player one: ' + str(score_player_one)
	if to_player_two > 0:
		score_player_two += to_player_two
		$GUI/lbl_score_player_two.text = 'Score player two: ' + str(score_player_two)
	
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
		
	$GUI/ball_speed_x.text = 'ball_speed.x:' + str(ball_speed.x)
	$GUI/ball_speed_y.text = 'ball_speed.y:' + str(ball_speed.y)
	if Input.is_action_pressed('pause'):
		get_tree().paused = not get_tree().paused
	queue_redraw()
	
func _draw():
	draw_line(
		ball.position,
		ball.position + ball_speed,
		Color('#ffCCCC'), 
		2,
		)
	
func _on_pad_collision(area: Area2D) -> void:
	$AudioPlayer.play()
	ball_speed.x = -ball_speed.x
	print("Antes:", ball_speed)
	ball_speed = ball_speed.rotated(randf_range(-0.3, 0.3))
	print("Después:", ball_speed)

func _on_vertical_exit(area: Area2D) -> void:
	print("_on_vertical_exit", area)
	print(area, area.name)
	print("Colisión con la banda horizontal. Velocidad en y:", ball_speed.y)
	ball_speed.y = -ball_speed.y
	ball_speed.rotated(randf_range(-0.3, 0.3))


func _on_right_out_area_entered(area: Area2D) -> void:
	update_scores(1, 0)
	start_play()


func _on_left_out_area_entered(area: Area2D) -> void:
	update_scores(0, 1)
	start_play()


func ball_bounce(node: Node) -> void:
	ball_speed.x = -ball_speed.x


func inc_speed() -> void:
	speed_amplitude += 1
	$GUI/lbl_speed_amplitude.text = 'Speed amplitud: ' + str(speed_amplitude)
