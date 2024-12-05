extends RigidBody2D

# preload sounds from library
var sounds = preload("res://library/sound.gd").new()

var FAST_FALLING_SPEED = Global.pieceSpeed * 10
const PIECE_MOVEMENT = 25
const ROTATION_ANGLE = PI/2

const AREA_TYPE_PIECE = "piece"
const AREA_TYPE_DESTROY = "destroy"

const INPUT_ROTATE_RIGHT = "rotateRight"
const INPUT_ROTATE_LEFT = "rotateLeft"
const INPUT_RIGHT = "right"
const INPUT_LEFT = "left"
const INPUT_DOWN = "down"
const INPUT_BIG_LEFT = "bigLeft"
const INPUT_BIG_RIGHT = "bigRight"

func _ready() -> void:
	#attach the sound instance to this node to use his function
	add_child(sounds)

func _process(_delta) -> void:
	if get_meta("isPreview", false):
		blockPiece()
	manageUserInput()

func blockPiece():
	#TODO - change the mode to freeze
	position = Vector2(0, 0)
	linear_velocity = Vector2.ZERO
	angular_velocity = 0

func manageUserInput() -> void:
	#ignore input if the piece is not falling
	if not is_piece_falling():
		return
	handle_movement_input()
	handle_rotation_input()
	handle_speed_input()

func handle_speed_input() -> void:
	update_falling_speed()

func handle_rotation_input() -> void:
	if Input.is_action_just_pressed(INPUT_ROTATE_RIGHT):
		rotate_piece(-1)
	if Input.is_action_just_pressed(INPUT_ROTATE_LEFT):
		rotate_piece(1)

func handle_movement_input() -> void:
	var a = 0
	
	if Input.is_action_just_pressed(INPUT_BIG_LEFT):
		a -= 2
	elif Input.is_action_just_pressed(INPUT_LEFT):
		a -= 1
	if Input.is_action_just_pressed(INPUT_BIG_RIGHT):
		a += 2
	elif Input.is_action_just_pressed(INPUT_RIGHT):
		a += 1
	if a != 0:
		move_piece(a)

func move_piece(direction: int) -> void:
	move_and_collide(Vector2(direction * PIECE_MOVEMENT, 0))
	sounds.moveSound()

func is_piece_falling():
	return get_meta("isFalling")

func rotate_piece(direction) -> void:
	rotation = lerp_angle(rotation, rotation+(ROTATION_ANGLE*direction), -1)
	sounds.rotationSound()

func update_falling_speed() -> void:
	if Input.is_action_pressed(INPUT_DOWN):
		linear_velocity.y = FAST_FALLING_SPEED
	else:
		linear_velocity.y = Global.pieceSpeed

func _on_piece_area_entered(area) -> void:
	match area.name:
		AREA_TYPE_PIECE: #if piece touch another piece
			handle_piece_collision()
		AREA_TYPE_DESTROY: #if piece fall too low
			handle_piece_destroy()

func handle_piece_destroy() -> void:
	if is_piece_falling(): #if the piece is the piece falling add a new one
		Global.spawnBloc = true
	queue_free()

func handle_piece_collision() -> void:
	if not is_piece_falling(): #if the piece is not falling return
		return
	
	sounds.touchFloorSound()
	linear_velocity.y = 0
	set_meta("isFalling", false) #set the piece as not falling to disable input
	
	Global.spawnBloc = true #enable to spawn a new piece
