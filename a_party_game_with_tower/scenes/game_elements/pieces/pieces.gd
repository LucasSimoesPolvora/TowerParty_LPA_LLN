extends Node2D

const FALLINGSPEED = 100
const PIECEMOVEMENT = 50

var pos = 1
var piece_body: RigidBody2D
var left_node: Node2D = null
var right_node: Node2D = null

@export var pos1 = 0.0
@export var pos2 = 0.0
@export var pos3 = 0.0
@export var pos4 = 0.0

func _ready() -> void:
	piece_body = $RigidBody2D

func _process(_delta):
	manageUserInput()
	getPosition()

func manageUserInput():
	if not get_meta("isFalling"):
		return
	if Input.is_action_just_pressed("rotate") or Input.is_action_just_pressed("rotate_right"):
		piece_body.rotation = lerp_angle(piece_body.rotation, piece_body.rotation+(PI/2), 1)
		pos += 1
		if pos > 4:
			pos = 1
	if Input.is_action_just_pressed("rotate_left"):
		piece_body.rotation = lerp_angle(piece_body.rotation, piece_body.rotation-(PI/2), 1)
		pos += 1
		if pos > 4:
			pos = 1
	if Input.is_action_just_pressed("right"):
		piece_body.move_and_collide(Vector2(PIECEMOVEMENT, 0))
	if Input.is_action_just_pressed("left"):
		piece_body.move_and_collide(Vector2(-PIECEMOVEMENT, 0))
	if Input.is_action_pressed("down"):
		piece_body.linear_velocity.y = 1000
	else:
		piece_body.linear_velocity.y = 100

func getPosition():
	if get_meta("isFalling"):
		return
	var width = (pos2+pos4)/2.0
	var length = (pos1+pos3)/2.0
	var angle = piece_body.rotation
	var height_max = abs(width * sin(angle)) + abs(length * cos(angle))
	Global.pieces_pos_y.append(piece_body.position.y-(height_max*50))

func _on_piece_area_entered(area):
	match area.name:
		"piece": #if piece touch another piece
			if not get_meta("isFalling"):
				return
			set_meta("isFalling", false)
			Global.nbrPiece += 1
			Global.spawnBloc = true
		"destroy": #if piece fall too low
			if get_meta("isFalling"):
				Global.spawnBloc = true
			queue_free()
